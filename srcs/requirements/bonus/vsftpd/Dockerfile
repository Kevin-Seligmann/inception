FROM alpine:3.19.3

RUN \
	   apk update --no-cache \
	&& apk upgrade --no-cache \
	&& apk add vsftpd --no-cache

COPY /conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

CMD ["vsftpd"]
