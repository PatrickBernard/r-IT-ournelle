#!/bin/bash

NAME="$1"
COMMAND="$2"

. lib-easy-lxc.sh

if [ -z "$COMMAND" ]; then
    echo "Il faut préciser une commande"
    easy_lxc_help
    exit 2
fi

if [ ! -x "/usr/bin/lxc-create" ]; then
    echo "lxc n'est pas installé"
    exit 4
fi

commandes=("attach" "cgroup" "checkconfig" "checkpoint" "console" "execute" \
           "freeze" "info" "kill" "ls" "monitor" "netstat" "ps" "restart" \
           "setcap" "setuid" "start" "stop" "unfreeze" "version" "wait")

for ix in ${!commandes[*]}
do
    if [ "$COMMAND" == "${commandes[$ix]}" ]
    then
        lxc-$COMMAND -n $NAME "$@"
        exit 0
    fi
done

if [ "$COMMAND" = "create" ]
then
    easy_lxc_lvm_create "$@"
    exit 0
fi

if [ "$COMMAND" = "rename" ]
then
    easy_lxc_rename "$@"
    exit 0
fi

if [ "$COMMAND" = "destroy" ]
then
    easy_lxc_lvm_destroy "$@"
    exit 0
fi

if [ "$COMMAND" = "setnet" ]
then
    easy_lxc_setnet "$@"
    exit 0
fi

if [ "$COMMAND" = "setinterface" ]
then
    easy_lxc_setinterface "$@"
    exit 0
fi

easy_lxc_help
