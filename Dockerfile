FROM node:18

# Set working directory
WORKDIR /srv/image-service

# Install build tools and libimagequant
RUN apt-get update && apt-get install -y \
  build-essential \
  git \
  autoconf \
  automake \
  libtool \
  nasm \
  curl \
  libpng-dev \
  libimagequant-dev \
  && rm -rf /var/lib/apt/lists/*

# Copy and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the app
COPY . .

# Run the app
CMD make start PORT=$PORT DEBUG=$DEBUG ENV=$SYMFONY_ENV
