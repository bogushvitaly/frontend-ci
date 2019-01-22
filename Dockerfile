FROM node:alpine

RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
    && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
    && apk --no-cache update && apk upgrade && apk add --update --no-cache \
    chromium@edge \
    harfbuzz@edge \
    nss@edge \
    build-base \
    curl \
    git \
    python \
    openjdk8-jre-base \
    && mkdir -p /usr/share \
    && cd /usr/share \
    && curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj \
    && ln -s /usr/share/phantomjs/phantomjs /usr/bin/phantomjs \
    && phantomjs --version \
    && rm -rf /var/lib/apk/lists/* /var/cache/apk/* /usr/share/man /tmp/* /root/.cache

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

ENV CHROME_BIN=/usr/bin/chromium-browser \
    CHROME_PATH=/usr/lib/chromium/ \
    CHROMIUM_FLAGS="--headless --no-sandbox"

RUN npm config set unsafe-perm true && npm install --global node-gyp pnpm codeceptjs puppeteer lighthouse-ci allure-commandline

CMD ["/bin/bash"]
