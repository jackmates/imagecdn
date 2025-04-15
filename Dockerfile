FROM node:20-alpine

WORKDIR /srv/image-service

# Add required tools and build dependencies
RUN apk add --no-cache \
  bash \
  curl \
  git \
  make \
  gcc \
  g++ \
  autoconf \
  automake \
  libtool \
  nasm \
  zlib-dev \
  python3 \
  pkgconfig \
  file

# Clone libimagequant manually into expected location for pngquant-bin
RUN mkdir -p /srv/image-service/node_modules/pngquant-bin/lib && \
    git clone --depth=1 https://github.com/ImageOptim/libimagequant.git /srv/image-service/node_modules/pngquant-bin/lib

COPY package*.json ./
RUN npm install

COPY ./ ./

CMD make start PORT=$PORT DEBUG=$DEBUG ENV=$SYMFONY_ENV
