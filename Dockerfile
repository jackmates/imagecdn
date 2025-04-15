FROM node:20-alpine

# Define application run directory
WORKDIR /srv/image-service

# Install system dependencies needed for native modules (mozjpeg, pngquant, etc.)
RUN apk add --no-cache \
    autoconf \
    automake \
    libtool \
    nasm \
    make \
    g++ \
    python3 \
    pkgconfig \
    file \
    bash

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy application files
COPY ./ ./

# Begin application
CMD make start PORT=$PORT DEBUG=$DEBUG ENV=$SYMFONY_ENV
