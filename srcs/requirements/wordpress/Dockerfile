FROM debian:bookworm

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y wget  curl && \
    apt-get install -y php8.2 php-fpm php-mysql mariadb-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d

COPY ./tools/wp-setup.sh /

RUN chmod +x /wp-setup.sh

EXPOSE 9000

CMD ["/wp-setup.sh"]