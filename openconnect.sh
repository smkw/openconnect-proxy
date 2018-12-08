#! /usr/bin/env sh

cat $HOSTS_FILE >> /etc/hosts
cat $PASSWORD_FILE | /usr/local/sbin/openconnect --config=$CONFIG_FILE -b $VPN_SERVER
rc-service sshd start
ping $PING_SERVER &> /dev/null
