FROM node:18

# Set working directory
WORKDIR /srv/image-service

# Install required build tools and dependencies
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

# Pre-clone libimagequant into the path where pngquant-bin expects it
RUN mkdir -p node_modules/pngquant-bin/lib && \
    git clone --depth=1 https://github.com/ImageOptim/libimagequant.git node_modules/pngquant-bin/lib

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Start the app
CMD make start PORT=$PORT DEBUG=$DEBUG ENV=$SYMFONY_ENV
