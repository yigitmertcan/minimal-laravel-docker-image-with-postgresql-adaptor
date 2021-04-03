FROM php:7.4-fpm-alpine

WORKDIR /var/www/html

COPY . .


RUN apk update && apk add  nodejs && apk add  yarn 
 
RUN set -ex \
  && apk --no-cache add postgresql-libs postgresql-dev \
  && docker-php-ext-install pgsql pdo_pgsql \
  && apk del postgresql-dev

RUN apk add composer

RUN composer update && composer install

EXPOSE 8001

CMD [ "php", "artisan", "serve","--host","0.0.0.0","--port=8001"]