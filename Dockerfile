FROM busybox:latest

ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/bin/confd
RUN chmod +x /usr/bin/confd
CMD confd
