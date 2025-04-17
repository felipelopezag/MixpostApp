# Usar una imagen base de PHP
FROM php:8.0-fpm

# Instalar las dependencias necesarias para Laravel
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip git

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Establecer el directorio de trabajo
WORKDIR /var/www

# Copiar el archivo composer.json y composer.lock
COPY composer.json composer.lock /var/www/

# Ejecutar composer install
RUN composer install

# Copiar el resto de los archivos del proyecto
COPY . /var/www

# Establecer los permisos adecuados para Laravel
RUN chown -R www-data:www-data /var/www

# Exponer el puerto 80 para acceder al servidor
EXPOSE 80

# Comando para iniciar el servidor
CMD ["php-fpm"]
