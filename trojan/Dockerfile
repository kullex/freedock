FROM alpine:3.9

ARG TROJAN_PASSWORD
ENV TROJAN_PASSWORD ${TROJAN_PASSWORD}

ARG TROJAN_DOMAIN
ENV TROJAN_DOMAIN ${TROJAN_DOMAIN}

RUN mkdir /config
COPY config.json /config/config.json
RUN sed -i -e "s#yourdomain#$TROJAN_DOMAIN#g" \
    -e "s#yourpassword#$TROJAN_PASSWORD#g" \
    /config/config.json

RUN apk add --no-cache --virtual .build-deps \
        curl \
        wget

WORKDIR /config

CMD ["/bin/sh", "/configure.sh", "/usr/local/bin/trojan", "config.json"]