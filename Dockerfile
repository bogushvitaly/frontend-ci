FROM node:alpine

LABEL description "CI Image"
LABEL version="1.0.0"

RUN echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories \
  && echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories \
  && apk add --no-cache \
  chromium@edge \
  harfbuzz@edge \
  nss@edge \
  freetype@edge \
  ttf-freefont@edge \
  && rm -rf /var/cache/* \
  /var/lib/apt/lists/* \
  /var/cache/apk/* \
  /usr/share/man \
  /tmp/*

ENV CHROME_BIN=/usr/bin/chromium-browser \
  CHROME_PATH=/usr/lib/chromium/ \
  CHROMIUM_FLAGS="--headless --no-sandbox" \
  LIGHTHOUSE_CHROMIUM_PATH=/usr/bin/chromium-browser \
  PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser \
  PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

CMD ["/bin/bash"]
