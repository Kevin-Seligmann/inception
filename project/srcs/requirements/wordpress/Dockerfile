FROM alpine:3.22.2

RUN \
	apk update --no-cache \
	&& apk upgrade --no-cache \
	&& apk add --no-cache \
	php82 \
	php82-fpm \
	php82-phar \
	php82-cli \
	php82-openssl \
	php82-mysqli \
	php82-mbstring \
	php82-tokenizer \
	&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin \
	&& adduser -g -D -S -G www-data -u 1001 www-data \
	&& mkdir -p /run/php \
	&& chown www-data:www-data /run/php /var/log/php82

COPY tools/wp_entry.sh /usr/local/bin/wp_entry.sh
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY conf/php-memory.ini /etc/php82/conf.d/99-memory.ini
COPY conf/php.ini /etc/php82/php.ini

RUN chown www-data:www-data /usr/local/bin/wp_entry.sh /etc/php82/php-fpm.d/www.conf /etc/php82/conf.d/99-memory.ini /etc/php82/php.ini \
    && chmod +rx /usr/local/bin/wp_entry.sh /etc/php82/php-fpm.d/www.conf /etc/php82/conf.d/99-memory.ini /etc/php82/php.ini
USER www-data

ENTRYPOINT ["wp_entry.sh"]
