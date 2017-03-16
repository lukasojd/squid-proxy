FROM debian:jessie

MAINTAINER Lukáš Kříž <lukasojd@gmail.com>

RUN apt-get update

RUN apt-get update
RUN apt-get install -y squid3 wget dnsmasq

ENV DOCKER_GEN_VERSION 0.7.3

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
&& rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "listen-address=127.0.0.1\nconf-dir=/etc/dnsmasq.d\nuser=root" > /etc/dnsmasq.conf

COPY . /app/
WORKDIR /app/

COPY docker-entrypoint.sh /entrypoint.sh
COPY squid.conf /etc/squid3/squid.conf

EXPOSE 3128 53/tcp 53/udp

VOLUME ["/etc/dnsmasq.d/"]
CMD ["/entrypoint.sh"]
