FROM debian:stretch
MAINTAINER Matteo Guglielmetti <matteo.guglielmetti@hotmail.it>

EXPOSE 3333 80

ENV DOCKERIZE_VERSION v0.6.1
ENV GOPHISH_VERSION 0.7.1


RUN apt-get update && \
apt-get install --no-install-recommends -y \
unzip \
ca-certificates \
wget && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN mkdir /opt/gophish && \
wget -nv https://github.com/gophish/gophish/releases/download/$GOPHISH_VERSION/gophish-v$GOPHISH_VERSION-linux-64bit.zip && \
unzip gophish-v$GOPHISH_VERSION-linux-64bit.zip -d /opt/gophish && \
rm -f gophish-v$GOPHISH_VERSION-linux-64bit.zip && \
chmod +x /opt/gophish/gophish

WORKDIR /opt/gophish/

ADD files/config.tmpl /opt/gophish/
ADD files/entrypoint.sh /opt/gophish/

ENTRYPOINT ["/opt/gophish/entrypoint.sh"]
