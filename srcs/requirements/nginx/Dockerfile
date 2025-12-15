FROM debian:bookworm

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt install nginx -y && \
    apt install vim -y && \
    apt install openssl -y

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=NL/ST=NH/L=Amsterdam/O=42/OU=CODAM/CN=edribeir.42.fr/UID=edribeir"

COPY ./conf/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]