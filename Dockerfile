FROM alpine:latest

ADD confd-0.11.0-linux-amd64 /usr/bin/confd
ADD go /opt/go
RUN set -xe;\
    apk add --update go; \
    cd /opt/go/gncat;    \
    go build;            \
    mv gncat /bin;       \
    cd /;                \ 
    rm -rf /opt/go;      \
    chmod +x /usr/bin/confd
CMD confd
