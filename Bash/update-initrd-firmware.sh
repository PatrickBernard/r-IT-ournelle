  #!/bin/bash
  if [ -z $1 ] || [ -z $2 ] ; then
    echo "Usage : $0 distrib tftp-location"
    echo "example $0 buster /srv/tftp-efi"
    exit 1
  fi
  DISTRIB=$1
  DIR=$2
  mkdir -p /tmp/$DISTRIB
  cd /tmp/$DISTRIB
  echo "===Récupération des netboot et firmware pour $DISTRIB==="
  wget http://ftp.fr.debian.org/debian/dists/$DISTRIB/main/installer-amd64/current/images/netboot/netboot.tar.gz
  [ -f firmware.cpio.gz ] || wget http://cdimage.debian.org/cdimage/unofficial/non-free/firmware/$DISTRIB/current/firmware.cpio.gz
  echo "===Extraction initrd==="
  mkdir netboot
  tar -C netboot -xzf netboot.tar.gz
  cp netboot/debian-installer/amd64/initrd.gz initrd.gz.orig
  echo "===Ajout des firmwares non-free dans l'initrd==="
  cat initrd.gz.orig firmware.cpio.gz > initrd.gz
  echo "===Copie des nouveau fichiers dans le tftp==="
  cp initrd.gz $DIR/boot/debian/installer/$DISTRIB/amd64/
  cp netboot/debian-installer/amd64/linux $DIR/boot/debian/installer/$DISTRIB/amd64/