FROM phusion/baseimage

ARG TROJAN_PASSWORD
ENV TROJAN_PASSWORD ${TROJAN_PASSWORD}

ARG TROJAN_DOMAIN
ENV TROJAN_DOMAIN ${TROJAN_DOMAIN}

# Create config file
RUN mkdir /config
COPY config.json /config/config.json
RUN sed -i -e "s#yourdomain#$TROJAN_DOMAIN#g" \
    -e "s#yourpassword#$TROJAN_PASSWORD#g" \
    /config/config.json

# Install base tools
RUN set -xe; \
    apt-get update -yqq && \
    apt-get install -yqq \
    curl \
    wget \
    xz-utils \
    && apt-get clean

# download and install latest trojan
RUN NAME=trojan; \
    VERSION=$(curl -fsSL https://api.github.com/repos/trojan-gfw/trojan/releases/latest | grep tag_name | sed -E 's/.*"v(.*)".*/\1/'); \
    TARBALL="$NAME-$VERSION-linux-amd64.tar.xz"; \
    DOWNLOADURL="https://github.com/trojan-gfw/$NAME/releases/download/v$VERSION/$TARBALL"; \
    TMPDIR="$(mktemp -d)"; \
    INSTALLPREFIX=/usr/local; \
    SYSTEMDPREFIX=/etc/systemd/system; \
    BINARYPATH="$INSTALLPREFIX/bin/$NAME"; \
    cd "$TMPDIR"; \
    echo Downloading $NAME $VERSION...; \
    curl -LO --progress-bar "$DOWNLOADURL" || wget -q --show-progress "$DOWNLOADURL"; \
    Unpacking $NAME $VERSION...; \
    tar xf "$TARBALL" && cd "$NAME"; \
    echo Installing $NAME $VERSION to $BINARYPATH...; \
    install -Dm755 "$NAME" "$BINARYPATH";

WORKDIR /config

ADD configure.sh /configure.sh
RUN chmod +x /configure.sh

ENTRYPOINT /configure.sh

