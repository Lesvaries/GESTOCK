#base image
FROM php:8.2-apache

#Install dependencies
RUN docker-php-ext-install mysqli pdo_mysql
RUN a2enmod rewrite

#copy files 
COPY . /var/www/html

EXPOSE 80