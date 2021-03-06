# Squid proxy
Reverse squid proxy on container in docker-compose

Proxy is not prepare for production.

## Technology 
- squid3
- dnsmasq
- [docker-gen](https://github.com/jwilder/docker-gen)


## Example

```
version: '2'
services:
    squid-proxy:
        image: lukasojd/squid-proxy:1.2.0
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock:ro
          - /srv/docker/squid/cache:/var/spool/squid3
        ports:
          - "3128:3128"
    
    adminer_com:
      image: clue/adminer
      environment:
        - VIRTUAL_HOST=adminer.com
        
    adminer_eu:
        image: clue/adminer
        environment:
          - VIRTUAL_HOST=adminer.eu
```

You only add from your container VIRTUAL_HOST with domain and squid-proxy will be proxy on container...

**With pac file**

```
version: '2'
services:
    proxy-pac:
        image: lukasojd/proxy-pac:1.0.0
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock:ro
        ports:
          - "8080:80"
          
   squid-proxy:
        image: lukasojd/squid-proxy:1.2.0
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock:ro
          - /srv/docker/squid/cache:/var/spool/squid3
        ports:
          - "3128:3128"

    adminer_com:
      image: clue/adminer
      environment:
        - VIRTUAL_HOST=adminer.com

    adminer_eu:
        image: clue/adminer
        environment:
          - VIRTUAL_HOST=adminer.eu
```

You only set to your browser auto proxy with pac file 
```
http://your_ip_machine:8080/proxy.php
```

## Customize

For customize squid we can add own configs for dnsmasq (volume). We only can'n change containers.conf. Containers.conf is auto generate by docker-gen.

```
version: '2'
services:
    squid-proxy:
        image: lukasojd/squid-proxy:1.2.0
        volumes:
          - /var/run/docker.sock:/var/run/docker.sock:ro
          - /srv/docker/squid/cache:/var/spool/squid3
          - folder_with_my_configs/:/etc/dnsmasq.d/
        ports:
          - "3128:3128"
```
