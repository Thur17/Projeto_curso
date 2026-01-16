FROM php:8.3-fpm-alpine

RUN apk update && apk add --no-cache \
    libzip-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    imagemagick-dev \
    libtool \
    autoconf \
    g++ \
    make \
    git \
    bash \
    unzip \
    icu-dev \
    zlib-dev \
    oniguruma-dev \
    curl-dev

RUN docker-php-ext-install \
    mysqli \
    pdo \
    pdo_mysql \
    xml \
    zip \
    intl \
    opcache

COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

WORKDIR /usr/share/nginx/html
