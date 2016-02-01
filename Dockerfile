FROM alpine:latest

ADD confd-0.11.0-linux-amd64 /usr/bin/confd
ADD go /opt/go
RUN set -xe;\
    apk add --update go;     \
    cd /opt/go/gncat;        \
    go build;                \
    mv gncat /usr/bin/gncat; \
    cd /;                    \ 
    rm -rf /opt/go;          \
    apk del --purge go;      \
    rm -rf /var/cache/apk/*; \
    chmod +x /usr/bin/confd
CMD confd
