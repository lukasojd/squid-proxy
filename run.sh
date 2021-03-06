#!/bin/bash

/etc/init.d/squid3 start

/etc/init.d/dnsmasq stop
/etc/init.d/dnsmasq start

docker-gen -watch -notify "/etc/init.d/dnsmasq restart"  /app/containers.conf.tmpl /etc/dnsmasq.d/containers.conf
