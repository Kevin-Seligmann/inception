FROM alpine:3.19.3

RUN apk update --no-cache && apk upgrade --no-cache

RUN apk add curl php php-fpm php-phar php-openssl php-mysqli php-mbstring php-tokenizer --no-cache

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

COPY tools/wp_entry.sh /usr/local/bin/wp_entry.sh

COPY conf/www.conf /etc/php82/php-fpm.d/www.conf

RUN \
	   mkdir -p /run/php \
	&& chmod +x wp-cli.phar /run/php /usr/local/bin/wp_entry.sh \
	&& mv wp-cli.phar /usr/local/bin \
	&& adduser --system www-data www-data

ENTRYPOINT ["wp_entry.sh"]
