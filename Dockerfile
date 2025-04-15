FROM node:20-alpine

# Define application run directory
WORKDIR /srv/image-service

# Install build dependencies
RUN apk add --no-cache \
  bash \
  build-base \
  autoconf \
  automake \
  libtool \
  nasm \
  python3 \
  pkgconfig \
  file \
  git \
  zlib-dev

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of your app
COPY ./ ./

# Start your app
CMD make start PORT=$PORT DEBUG=$DEBUG ENV=$SYMFONY_ENV
