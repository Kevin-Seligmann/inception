FROM alpine:3.19.3

RUN \
	   apk update --no-cache \
	&& apk upgrade --no-cache \
	&& apk add php php-session php-mysqli --no-cache \
	&& wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php

CMD ["php", "-S", "0.0.0.0:8080", "adminer-4.8.1-en.php"]
