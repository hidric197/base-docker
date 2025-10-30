FROM php:8.3-fpm

# Install common PHP extensions for Laravel
RUN apt-get update && apt-get install -y \
    zip unzip git curl libpng-dev libjpeg-dev libfreetype6-dev libonig-dev libxml2-dev libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip

# Cài Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Copy custom php.ini
COPY php.ini /usr/local/etc/php/conf.d/custom.ini

WORKDIR /var/www/html

CMD ["php-fpm"]
