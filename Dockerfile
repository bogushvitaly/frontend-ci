FROM node:10-alpine

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk --no-cache update && apk upgrade && apk add --update --no-cache git tar curl vim python python-dev make gcc g++ automake autoconf linux-headers libgcc libstdc++ chromium chromium-chromedriver nss gifsicle pngquant optipng libjpeg-turbo-utils udev freetype ttf-freefont ttf-opensans fontconfig harfbuzz udev bash grep curl build-base openjdk8-jre-base \
    && mkdir -p /usr/share \
    && cd /usr/share \
    && curl -L https://github.com/Overbryd/docker-phantomjs-alpine/releases/download/2.11/phantomjs-alpine-x86_64.tar.bz2 | tar xj \
    && ln -s /usr/share/phantomjs/phantomjs /usr/bin/phantomjs \
    && phantomjs --version \
    && rm -rf /var/lib/apk/lists/* /var/cache/apk/* /usr/share/man /tmp/* /root/.cache

RUN npm config set unsafe-perm=true && npm install --global node-gyp node-sass @angular/cli puppeteer lighthouse-ci codeceptjs allure-commandline firebase-tools

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true CHROME_BIN=/usr/bin/chromium-browser CHROME_PATH=/usr/bin/chromium-browser CHROMIUM_FLAGS="--headless --no-sandbox"

CMD ["/bin/bash"]
