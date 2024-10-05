FROM gitea/runner-images:ubuntu-latest AS base
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN sudo add-apt-repository ppa:ondrej/php && apt update

FROM base as php83
# Install PHP and required extensions for Composer
RUN apt install php8.3 php8.3-phar php8.3-iconv -y

FROM base as php82
# Install PHP and required extensions for Composer
RUN apt install php8.2 php8.2-phar php8.2-iconv -y

FROM base as php81
# Install PHP and required extensions for Composer
RUN apt install php8.1 php8.1-phar php8.1-iconv -y

FROM php83 as php83-pimcore
RUN apt install php8.3-pdo -y