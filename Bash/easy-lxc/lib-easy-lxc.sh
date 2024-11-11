#!/bin/bash

function easy_lxc_verifiplibre {

    ping -c1 $1 &> /dev/null
    if [ $? -eq 0 ] ; then
        echo "$1 n'est pas libre. Utilisez une autre adresse IP"
        exit 1
    else
        echo "$1 est libre."
    fi
}

function hexa {
    NUMBERS=`echo $1 | sed -e 's/\./ /g'`

    hexa=("02" "00")

    i=0
    for j in $NUMBERS
    do
        k=$(($i+2))
        hexa[$k]=`printf '%02X' $j; echo`
        i=$(($i+1))
    done

    for i in 0 1 2 3 4
    do
        echo -n ${hexa[$i]}:
    done
    echo ${hexa[5]}
}

function easy_lxc_create_check {

    if [[ "$1" == "--help" || "$1" == "-h" ]]; then
        easy_lxc_help
        exit 1
    fi

    if [ ! "$1" ]; then
        echo "Il faut préciser un nom de machine"
        easy_lxc_help
        exit 2
    fi
    
    if [ ! "$2" ]; then
        echo "Il faut préciser une taille pour le conteneur"
        easy_lxc_help
        exit 1
    fi
    
    if [ ! "$3" ]; then
        echo "Il faut préciser une release"
        easy_lxc_help
        exit 3
    fi
    if [ ! "$4" ]; then
        echo "Il faut préciser une architecture"
        easy_lxc_help
        exit 4
    fi
    if [ ! "$5" ]; then
        echo "Il faut préciser si l'adressage IP est statique ou dynamique (actuellement seul static est supporté)"
        easy_lxc_help
        exit 5
    fi
    if [ ! "$6" ]; then
        echo "Il faut préciser le nom de l'interface"
        easy_lxc_help
        exit 6
    fi

    if [ ! -x /usr/sbin/debootstrap ]; then
        echo "debootstrap doit être installé"
        exit 4
    fi
    if [ ! -e /sys/class/net/$6 ]; then
        echo "L'interface $6 n'existe pas"
        exit 6
    fi
}

function recap_config {
        echo "-----------------"
        [ ${#1} -ge  15 ] && echo "!!! le nom du serveur est trop long (max 15), il faudra editer manuellement le nom de l'interface !!!"
        echo "Le lxc suivant va etre créer :"
        echo "Nom : $1"
        echo "Taille : $2 Go"
        echo "Release : Debian - $3"
        echo "Architecture : $4"
        echo "Adressage IP : $5"
        echo "interface : $6"
        if [ "$7" ]; then
                echo "IP  : $7"
                echo "masque : $8"
                echo "gateway : $9"
        fi
        echo "-----------------"
        read -r -p "Continuer ? (o/N)" reply
        [[ ! $reply =~ ^([oO]|[yY])$ ]] && exit 5

}

function easy_lxc_lvm_create {

    Default_release="buster"
    Default_arch="amd64"

    NAME=$1
    SIZE=$3
    RELEASE=$4
    ARCH=$5
    STATIC_OR_DYN=$6
    INTERFACE=$7
    IP=$8
    MASK=$9
    GW=${10}
    NI=${11}

    easy_lxc_create_check $NAME $SIZE $RELEASE $ARCH $STATIC_OR_DYN $INTERFACE $IP $MASK $GW
    if [ "$IP" ]; then
        easy_lxc_verifiplibre $IP
        #networkconf $IP
    fi
    if [ "$NI" != "non-interactive" ]; then
        recap_config $NAME $SIZE $RELEASE $ARCH $STATIC_OR_DYN $INTERFACE $IP $MASK $GW
    fi
    if [ "$IP" ]; then
        HWADDR=`hexa $IP`
    else
        HW1=`tr -dc A-F0-9 < /dev/urandom | head -c 2 | xargs`
        HW2=`tr -dc A-F0-9 < /dev/urandom | head -c 2 | xargs`
        HW3=`tr -dc A-F0-9 < /dev/urandom | head -c 2 | xargs`
        HW4=`tr -dc A-F0-9 < /dev/urandom | head -c 2 | xargs`
        HW5=`tr -dc A-F0-9 < /dev/urandom | head -c 2 | xargs`
        HW6=`tr -dc A-F0-9 < /dev/urandom | head -c 2 | xargs`
        HWADDR=i"$HW1:$HW2:$HW3:$HW4:$HW5:$HW6"
    fi
    LVNAME=`echo $NAME | sed -e 's/-/_/g'`
    VETHNAME=`cat /proc/sys/kernel/random/uuid | sed -e 's/.*\(.\{10\}\)/veth\1/'`

    #Create Volume
    lvcreate -W n --size "$SIZE"G --name $LVNAME system
    if [ -b "/dev/mapper/system-$LVNAME" ]; then
        mkfs.ext4 /dev/mapper/system-$LVNAME
        tune2fs -c0 -i0 /dev/mapper/system-$LVNAME
    fi

    #Write fstab + Mount Volume
    mkdir /vservers/$NAME
    if [ -d "/vservers/$NAME" ]; then
        echo "/dev/mapper/system-$LVNAME /vservers/$NAME ext4 defaults 0 2" >> /etc/fstab
        mount /vservers/$NAME
        touch /vservers/$NAME/autostart
    fi

    
    #Write Config for lxc-create
    LXCVERSION=`lxc-info --version | awk -F'.' {'print $1'}`

    #if lxc < 3.0
    if [ $LXCVERSION -lt "3" ]
    then
cat > /tmp/$NAME.conf <<EOF
lxc.utsname = $NAME

lxc.start.auto = 1

lxc.network.type = veth
lxc.network.flags = up
lxc.network.link = $INTERFACE
lxc.network.name = eth0
lxc.network.hwaddr = $HWADDR
lxc.network.veth.pair = $VETHNAME

EOF
 
    #if lxc >= 3.0
    else
cat > /tmp/$NAME.conf <<EOF
lxc.uts.name = $NAME

lxc.start.auto = 1

lxc.net.0.type = veth
lxc.net.0.flags = up
lxc.net.0.link = $INTERFACE
lxc.net.0.name = eth0
lxc.net.0.hwaddr = $HWADDR
lxc.net.0.veth.pair = $VETHNAME

lxc.apparmor.profile = unconfined

EOF

    fi

    #Create LXC
    MIRROR=http://ftp.fr.debian.org/debian /usr/bin/lxc-create -n $NAME -f /tmp/$NAME.conf --dir=/vservers/$NAME/rootfs -t debian -- --release $RELEASE --arch $ARCH

    #Write interfaces in LXC Context
    if [ "$IP" ]; then
        # configure the network using a static address
        cat <<EOF > /vservers/$NAME/rootfs/etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
        address $IP
        netmask $MASK
        gateway $GW
EOF
    fi

    #Reactivate root via ssh in LXC Context
    sed -i 's/PermitRootLogin\ without-password/PermitRootLogin\ yes/' /vservers/$NAME/rootfs/etc/ssh/sshd_config
    sed -i 's/#PermitRootLogin\ prohibit-password/PermitRootLogin\ yes/' /vservers/$NAME/rootfs/etc/ssh/sshd_config

    #Customize LXC
    echo "root:fai" | chroot /vservers/$NAME/rootfs chpasswd

    #Start LXC (daemon)
    lxc-start -d -n $NAME
    sleep 20
    if [ `lxc-info --name $NAME -s | grep -c "RUNNING"` -eq 1 ]; then
            lxc-attach -n $NAME -- apt-get update
            lxc-attach -n $NAME -- apt-get -y install vim wget less bash-completion apt-utils rsyslog tree dbus rsync
    else
            echo "========================"
            echo "Container LXC non lancé"
            echo "Il faudrat lancer manuellement les commandes suivantes: "
            echo "lxc-attach -n $NAME -- apt-get update"
            echo "lxc-attach -n $NAME -- apt-get -y install vim wget less bash-completion apt-utils rsyslog tree dbus rsync"
            echo "========================"
            if [ "$NI" != "non-interactive" ]; then
                read -p "Appuyer sur une touche pour continuer ..."
            fi
            exit 1
    fi

    echo "========================"
    echo "Lancer fusioninventory-agent pour mettre à jour l'inventaire"
    if [ "$NI" != "non-interactive" ]; then
        read -p "Appuyer sur une touche pour continuer ..."
    fi
    rm /tmp/$NAME.conf
}

function easy_lxc_lvm_destroy {

    NAME=$1

    lxc-stop -n $NAME -k
    umount /vservers/$NAME
    rm -rf /vservers/$NAME
    
    LVNAME=`echo $NAME | sed -e 's/-/_/g'`

    sed -i -e "s#^/dev/mapper/system-$LVNAME.*##" /etc/fstab
    lvremove -f /dev/mapper/system-$LVNAME
}

function easy_lxc_rename_check {

     OLDNAME=$1
     NEWNAME=$2

     if [ -z $OLDNAME ] || [ -z $NEWNAME ] ; then
        echo "Il faut préciser deux noms de machines"
        easy_lxc_help
        exit 1
     fi
}

function easy_lxc_rename {

     OLDNAME=$1
     NEWNAME=$3

     easy_lxc_rename_check $OLDNAME $NEWNAME

     lxc-stop -n $OLDNAME -k

     OLDETHNAME=${1:4}
     NEWETHNAME=${3:4}
     OLDLVMNAME=`echo $OLDNAME | sed -e 's/-/_/g'`
     NEWLVMNAME=`echo $NEWNAME | sed -e 's/-/_/g'`

     umount /vservers/$OLDNAME
     lvrename /dev/system/$OLDLVMNAME /dev/system/$NEWLVMNAME

     mv /vservers/$OLDNAME /vservers/$NEWNAME
     
     sed -i -e "s#/dev/mapper/system-$OLDLVMNAME#/dev/mapper/system-$NEWLVMNAME# ; \
                s#/vservers/$OLDNAME#/vservers/$NEWNAME#" /etc/fstab

     mount /vservers/$NEWNAME

     sed -i -e "s#$OLDNAME#$NEWNAME#g" /vservers/$NEWNAME/rootfs/etc/host*
     sed -i -e "s#$OLDETHNAME#$NEWETHNAME#g" /vservers/$NEWNAME/config

}

function easy_lxc_setinterface {
    NAME=$1
    INTERFACE=$3

    lxc-stop -n $NAME -k
    sed -i -e "s#lxc.network.link = .*#lxc.network.link = $INTERFACE#" /vservers/$NAME/config
}

function easy_lxc_setnet {
    NAME=$1
    IP=$3
    NETMASK=$4
    GATEWAY=$5

    lxc-stop -n $NAME -k
    sed -i -e "s#\(address\).*#\1 $IP#; s#\(netmask\).*#\1 $NETMASK#; s#\(gateway\).*#\1 $GATEWAY#" /vservers/$NAME/rootfs/etc/network/interfaces
}

function easy_lxc_help {
    echo ""
    echo "Utilisation : easy-lxc SERVER COMMANDE ARGUMENTS"
    echo "Exemple : easy-lxc lxc-toto create 5 stretch amd64 static br-320 192.168.1.11 255.255.255.0 192.168.1.1"
    echo "Exemple : easy-lxc lxc-toto rename lxc-monitor" 
    echo "Exemple : easy-lxc lxc-toto setnet 192.168.115.11 255.255.255.0 192.168.115.1" 
    echo "Exemple : easy-lxc lxc-toto setinterface br-230" 
    echo "Exemple : easy-lxc lxc-toto destroy"
    echo "non-interactive en dernier argument (11eme) pour ne pas avoir de recap" 
}
