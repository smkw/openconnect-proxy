FROM alpine
MAINTAINER sumikawa <sumikawa@purple-net.jp>

COPY ./setup.sh /setup.sh
RUN /setup.sh && rm /setup.sh
COPY openconnect.sh /usr/local/bin/

CMD ["/usr/local/bin/openconnect.sh"]
