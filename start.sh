#!/bin/sh

env

set -x

if [ -n "$ICECAST_SOURCE_PASSWORD" ]; then
    sed -i "s/<source-password>[^<]*<\/source-password>/<source-password>$ICECAST_SOURCE_PASSWORD<\/source-password>/g" /etc/icecast2/icecast.xml
fi

if [ -n "$ICECAST_RELAY_PASSWORD" ]; then
    sed -i "s/<relay-password>[^<]*<\/relay-password>/<relay-password>$ICECAST_RELAY_PASSWORD<\/relay-password>/g" /etc/icecast2/icecast.xml
fi

if [ -n "$ICECAST_ADMIN_PASSWORD" ]; then
    sed -i "s/<admin-password>[^<]*<\/admin-password>/<admin-password>$ICECAST_ADMIN_PASSWORD<\/admin-password>/g" /etc/icecast2/icecast.xml
fi

if [ -n "$ICECAST_PASSWORD" ]; then
    sed -i "s/<password>[^<]*<\/password>/<password>$ICECAST_PASSWORD<\/password>/g" /etc/icecast2/icecast.xml
fi

#cat /etc/icecast2/icecast.xml
 
/etc/init.d/icecast2 restart
/etc/init.d/mpd restart
mpc outputs
mpc update
mpc ls | mpc add
mpc repeat on
mpc random on
mpc play
tail -f /var/log/mpd/*
