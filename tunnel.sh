#!/bin/sh

PATH=$PATH:/usr/local/bin

cfg=${HOME}/.ssh_remote
log=${HOME}/.log/tunnel.log
if ! [ -f $cfg ]; then
    echo "Missing $cfg"
    exit 1
fi
. $cfg
if [ -z $remote_port ]; then
    echo "Must setup $cfg file with 'remote_port'"
    exit 1
fi

mkdir -p $(dirname $log)
while true; do
    autossh -M 0 -i ${HOME}/.ssh/id_rsa_home -N -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -R ${remote_port}:localhost:22 remote@raincity.io >>$log 2>&1
    sleep 1
done