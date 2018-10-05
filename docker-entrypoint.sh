#!/usr/bin/env bash

GULDEN_CONFIG="/opt/gulden/datadir/Gulden.conf"
MAX_CONNECTIONS=${GULDEN_MAXCONNECTIONS:-50}
RPCUSER=${GULDEN_RPCUSER:-"gulden"}
RPCPASSWORD=${GULDEN_RPCPASSWORD:-""}

if [ ! -e "$GULDEN_CONFIG" ]; then
    touch ${GULDEN_CONFIG}
    echo "maxconnections=$MAX_CONNECTIONS" >> ${GULDEN_CONFIG}
    echo "rpcuser=$RPCUSER" >> ${GULDEN_CONFIG}
    echo "rpcpassword=$RPCPASSWORD" >> ${GULDEN_CONFIG}
    echo "minimallogging=1" >> ${GULDEN_CONFIG}
fi

chown www-data.www-data ${GULDEN_CONFIG}

supervisord -c /etc/supervisor.conf
