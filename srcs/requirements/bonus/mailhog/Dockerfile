FROM alpine:3.19.3

RUN \
	apk update --no-cache \
	&& apk upgrade --no-cache \
	&& apk add go \
	&& adduser -D -u 1001 mailhog \
	&& go install github.com/mailhog/MailHog@v1.0.1 \
	&& mv /root/go/bin/MailHog /usr/local/bin/

USER mailhog

WORKDIR /home/mailhog

CMD ["MailHog"]
