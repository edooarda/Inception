FROM debian:bookworm

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install mariadb-server -y

COPY ./conf/mariadb.cnf /etc/mysql/mariadb.conf.d
RUN chmod 644 /etc/mysql/mariadb.conf.d/mariadb.cnf

COPY ./tools/mariadb_init.sh /

RUN chmod +x /mariadb_init.sh

EXPOSE 3306

CMD ["/mariadb_init.sh"]