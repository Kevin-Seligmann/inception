FROM alpine:3.19.3

RUN apk update --no-cache && apk upgrade --no-cache

RUN apk add redis --no-cache

COPY /tools/redis_entry.sh /usr/local/bin/
COPY /conf/redis.conf /etc/redis.conf

RUN chmod +x /usr/local/bin/redis_entry.sh

ENTRYPOINT ["redis_entry.sh"]
