FROM php:8.1-fpm

WORKDIR /var/www/html

COPY composer.json composer.lock .
RUN composer install

COPY . .

EXPOSE 80

RUN apt-get update && apt-get install -y \
    libpq-dev \
    mysql-client \
    pdo-mysql \
    zip \
    unzip

RUN docker-php-ext-install pdo_pgsql

# Generate the application key
RUN php artisan key:generate

# Run database migrations
RUN php artisan migrate

CMD ["php-fpm"]
