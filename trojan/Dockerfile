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
        build-base \
        cmake \
        boost-dev \
        openssl-dev \
        mariadb-connector-c-dev \
        git \
    && git clone https://github.com/trojan-gfw/trojan.git \
    && (cd trojan && cmake . && make -j $(nproc) && strip -s trojan \
    && mv trojan /usr/local/bin) \
    && rm -rf trojan \
    && apk del .build-deps \
    && apk add --no-cache --virtual .trojan-rundeps \
        libstdc++ \
        boost-system \
        boost-program_options \
        mariadb-connector-c

WORKDIR /config

CMD ["/bin/sh", "/configure.sh", "trojan", "config.json"]