FROM bref/extra-pcov-php-74 as pcov
FROM bref/php-74
COPY --from=pcov /opt /opt
RUN yum install -y vim
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
