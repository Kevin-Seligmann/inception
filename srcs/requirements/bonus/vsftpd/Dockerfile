FROM alpine:3.19.3

RUN \
	   apk update --no-cache \
	&& apk upgrade --no-cache \
	&& addgroup --g 1001 wpuser \
	&& adduser -D -G wpuser -u 1001 wpuser \
	&& echo "wpuser:test" | chpasswd \
	&& apk add vsftpd --no-cache

COPY /conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

CMD ["vsftpd", "/etc/vsftpd/vsftpd.conf"]
