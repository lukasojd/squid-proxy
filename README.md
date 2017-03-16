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
        image: lukasojd/squid-proxy:latest
        volumes:
          - /var/run/docker.sock:/tmp/docker.sock:ro
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

