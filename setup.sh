#! /bin/sh

apk add --no-cache autoconf automake ca-certificates g++ gcc gnutls-dev intltool libgcrypt-dev libproxy-dev libtool libxml2-dev linux-headers lz4-dev make openssh-client python wget
mkdir -p /usr/local/src

cd /usr/local/src/
wget "https://www.unix-ag.uni-kl.de/~massar/vpnc/vpnc-0.5.3.tar.gz"
tar xf vpnc-0.5.3.tar.gz
cd vpnc-0.5.3
sed -i -e "/^#include <linux\/if_tun.h>/d" sysdep.c
sed -i -e "/^#include <error.h>/d" sysdep.h
sed -i -e "/^#define HAVE_ERROR     1/d" sysdep.h
make
make install

cd /usr/local/src/
wget "ftp://ftp.infradead.org/pub/openconnect/openconnect-7.08.tar.gz"
tar xf openconnect-7.08.tar.gz
cd openconnect-7.08
./configure --without-openssl-version-check
make
make install

apk del --no-cache autoconf automake ca-certificates g++ gcc git gnutls-dev intltool libgcrypt-dev libproxy-dev libtool libxml2-dev linux-headers make python wget
apk add --no-cache gnutls libxml2 libproxy openrc openssh-server
rm -fr /var/cache/apk/* /usr/local/src/*

rc-status
touch /run/openrc/softlevel
