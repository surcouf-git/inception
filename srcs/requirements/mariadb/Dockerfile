FROM debian:bullseye

RUN	apt-get update && apt-get install -y mariadb-server

COPY	conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE	3306

COPY	tools/db_init.sh .
RUN	chmod +x ./db_init.sh

CMD ["./db_init.sh"]
