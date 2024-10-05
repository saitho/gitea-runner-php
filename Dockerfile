FROM gitea/runner-images:ubuntu-latest

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN apt update && apt install php php-phar php-iconv -y