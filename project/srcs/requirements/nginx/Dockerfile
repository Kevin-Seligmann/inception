FROM alpine:3.22.2

RUN \
	apk update --no-cache \
	&& apk upgrade --no-cache \
	&& apk add openssl --no-cache \
	&& apk add nginx --no-cache

COPY /conf/nginx.conf /etc/nginx/nginx.conf
COPY /conf/cert_config /etc/ssl/cert_config

RUN \
	openssl req -config /etc/ssl/cert_config -newkey rsa:2048 -nodes -x509 -days 365 -out /etc/ssl/certificate.pem \
	&& chmod -R +r /etc/ssl

RUN chown nginx:nginx /etc/nginx/nginx.conf \
	&& chmod +r /etc/nginx/nginx.conf

USER nginx

CMD ["nginx", "-g", "daemon off;"]