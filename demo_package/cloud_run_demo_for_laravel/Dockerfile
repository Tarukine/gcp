FROM php:8.1-apache

RUN sed -i 's/80/${PORT}/g' /etc/apache2/ports.conf /etc/apache2/sites-available/000-default.conf \
    && sed -i 's!/var/www/html!/var/www/app/public!g' /etc/apache2/sites-available/000-default.conf
WORKDIR /var/www/app
COPY ./app .
RUN chmod -R 777 ./storage ./bootstrap/cache
RUN a2enmod rewrite