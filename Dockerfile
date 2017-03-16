FROM debian:jessie

MAINTAINER Lukáš Kříž <lukasojd@gmail.com>

RUN apt-get update

RUN apt-get update
RUN apt-get install -y squid3 wget dnsmasq dnsutils

ENV DOCKER_GEN_VERSION 0.7.3

RUN wget https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
 && tar -C /usr/local/bin -xvzf docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz \
&& rm /docker-gen-linux-amd64-$DOCKER_GEN_VERSION.tar.gz

RUN echo "listen-address=127.0.0.1\nconf-dir=/etc/dnsmasq.d" > /etc/dnsmasq.conf
# slove "dnsmasq: setting capabilities failed: Operation not permitted"
# refs:https://github.com/nicolasff/docker-cassandra/issues/8
RUN echo "user=root" >> /etc/dnsmasq.conf

ENV DOCKER_HOST unix:///tmp/docker.sock

COPY . /app/
WORKDIR /app/

COPY docker-entrypoint.sh /entrypoint.sh
COPY squid.conf /etc/squid3/squid.conf

EXPOSE 3128

CMD ["/entrypoint.sh"]
