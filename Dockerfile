FROM node:20-alpine

# Define application run directory
WORKDIR /srv/image-service

# Install system dependencies needed for mozjpeg and other native builds
RUN apk add --no-cache \
    autoconf \
    automake \
    libtool \
    nasm \
    make \
    g++ \
    python3

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy application files
COPY ./ ./

# Begin application
CMD make start PORT=$PORT DEBUG=$DEBUG ENV=$SYMFONY_ENV
