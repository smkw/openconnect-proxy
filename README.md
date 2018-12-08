# OpenConnect Proxy

## Overview

A container that runs sshd and OpenConnect. It is supposed to be used as a bastion server of SSH.

## Build

docker build -t openconnect-proxy ./

## Usage

```
docker run -itd \
  -v "home directory path":/root \
  --name "container name" \
  --hostname "VPN authentication login selection name" \
  --privileged \
  -e HOSTS_FILE="Path to hosts file" \
  -e PASSWORD_FILE="Path to Password file" \
  -e CONFIG_FILE="Path to OpenConnect CONFIGFILE" \
  -e VPN_SERVER="VPN Server Address and Server Port" \
  -e PING_SERVER="Ping destination IP address for Keep-alive VPN connection"
  openconnect-proxy
```

## Example

* Run

```
docker run -itd \
  -v ~/.docker-volume/home:/root \
  --name vpn_office \
  --hostname office \
  --privileged \
  -e HOSTS_FILE=~/hosts \
  -e PASSWORD_FILE=~/.vpn-password \
  -e CONFIG_FILE=~/.vpn-config \
  -e VPN_SERVER=anyconnect.example.jp \
  -e PING_SERVER=192.168.0.254
  openconnect-proxy
```

* Connect to server

```
ssh -o ProxyCommand='ssh -W %h:%p root@"container IP Address"' user@hostname
```

## Environment variables and Configuration

Configuration files must be under the local path specified by "-v" option.

### HOSTS_FILE
Describe the entries to be appended to /etc/hosts in container.

### PASSWORD_FILE
VPN Connect password. Password is passed to OpenConnect via STDIN.

### CONFIG_FILE
OpenConnect command-line options. (Long-format options required)

### VPN_SERVER
Hostname or IP address of destination VPN server

### PING_SERVER
Ping destination hostname or IP address for keep-alive VPN connection.
