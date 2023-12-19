FROM alpine:3.17.3

ENV GRAV_USER  1000
ENV LOG_FORMAT main

COPY ./ng-default.conf      /etc/nginx/http.d/default.conf
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN apk add --no-cache \
  ca-certificates \
  composer \
  git \
  nginx \
  npm \
  php81 \
  php81-curl \
  php81-dom \
  php81-fileinfo \
  php81-fpm \
  php81-gd \
  php81-iconv \
  php81-json \
  php81-mbstring \
  php81-opcache \
  php81-openssl \
  php81-pdo \
  php81-pdo_dblib \
  php81-pdo_mysql \
  php81-pdo_odbc \
  php81-pdo_pgsql \
  php81-pdo_sqlite \
  php81-phar \
  php81-session \
  php81-simplexml \
  php81-tokenizer \
  php81-xml \
  php81-xmlwriter \
  php81-zip \
  php81-mysqlnd \
  shadow \
  && chmod 755 /usr/local/bin/docker-entrypoint.sh \
  && pass=$( N=16 ; cat /dev/urandom | tr -dc A-Za-z0-9 | head -c$N ) \
  && printf "%s\n%s\n" $pass $pass | adduser grav \
  && mkdir -p /srv/grav \
  && chown grav:grav /srv/grav

WORKDIR /srv/grav

EXPOSE 80

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;" ]
