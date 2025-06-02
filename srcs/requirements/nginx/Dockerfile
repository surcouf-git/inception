FROM	debian:bullseye

RUN	apt update -y && apt upgrade -y && apt install nginx openssl -y

COPY	conf/default /etc/nginx/sites-available/.

RUN	mkdir -p /etc/nginx/ssl
RUN	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=NOR/L=LEHAVRE/O=42/OU=42/CN=mvannest.42.fr/UID=mvannest"
RUN	mkdir -p /var/run/nginx

EXPOSE	443

CMD ["nginx", "-g", "daemon off;"]
