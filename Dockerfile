FROM node:alpine

LABEL description "CI"
LABEL version="1.0.0"

RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories 

ENV CHROME_BIN=/usr/bin/chromium-browser
ENV CHROME_PATH=/usr/lib/chromium/
ENV CHROMIUM_FLAGS="--headless --no-sandbox"
ENV LIGHTHOUSE_CHROMIUM_PATH=/usr/bin/chromium-browser

RUN apk -U --no-cache update \ 
    && apk --no-cache upgrade

RUN apk -U --no-cache add \ 
    chromium@edge \
    chromium-chromedriver@edge \
    harfbuzz@edge \
    nss@edge \
    build-base \
    bash \
    grep \
    git \
    curl \
    python \
    openjdk8-jre-base \
    && mkdir -p /usr/share \
    && cd /usr/share \
    && curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj \
    && ln -s /usr/share/phantomjs/phantomjs /usr/bin/phantomjs \
    && phantomjs --version \
    && rm -rf /var/lib/apk/lists/* /var/cache/apk/* /usr/share/man /tmp/* /root/.cache

RUN npm config set unsafe-perm true && npm install --global \
    node-gyp \
    pnpm \ 
    firebase-tools \ 
    codeceptjs \ 
    puppeteer \ 
    lighthouse \ 
    lighthouse-ci \
    artillery \ 
    artillery-plugin-expect \ 
    artillery-plugin-publish-metrics \
    allure-commandline

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

CMD ["/bin/bash"]
