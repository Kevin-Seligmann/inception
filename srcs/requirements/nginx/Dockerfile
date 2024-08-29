FROM alpine:3.19.3

RUN apk update --no-cache && apk upgrade --no-cache
RUN apk add openssl nginx --no-cache

COPY /conf/nginx.conf /etc/nginx/nginx.conf
COPY /conf/cert_config /etc/ssl/cert_config

RUN openssl req -config /etc/ssl/cert_config -newkey rsa:2048 -nodes -x509 -days 365 -out /etc/ssl/certificate.pem

CMD ["nginx", "-g", "daemon off;"]
