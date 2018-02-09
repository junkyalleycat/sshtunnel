#!/bin/sh

setupd=${HOME}/tunnel
key=${HOME}/.ssh/id_rsa_home

if ! [ -d $setupd ]; then
    echo "Expected installation not found"
    exit 1
fi
if ! [ -f $key ]; then
    ssh-keygen -t rsa -f $key -N ''
fi
if ! which autossh >/dev/null 2>&1; then
    echo "Can not find autossh"
    exit 1
fi

if [ `uname -s` = 'Darwin' ]; then
    sudo cp tunnel.plist /Library/LaunchDaemons
    sudo launchctl load /Library/LaunchDaemons/tunnel.plist
else
    echo "Unknown system: $(uname -s)"
    exit 1
fi
