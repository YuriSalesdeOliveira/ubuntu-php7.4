FROM ubuntu:latest

# INSTALL PHP7.4

RUN apt update \
    && apt install -y software-properties-common \
    && add-apt-repository -y ppa:ondrej/php

RUN apt update \
    && DEBIAN_FRONTEND=noninteractive apt install -y php7.4 \
    && apt install -y php7.4-curl php7.4-mbstring php7.4-xml php7.4-gd php7.4-zip

# INSTALL COMPOSER

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');"

RUN mv composer.phar /usr/local/bin/composer

# INSTALL OTHER PACKAGES

RUN apt install -y sudo