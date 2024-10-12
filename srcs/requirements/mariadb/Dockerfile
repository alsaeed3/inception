# Use Alpine 3.9 as the base image
FROM alpine:3.19

ARG DB_NAME
ARG DB_USER
ARG DB_PASS
ARG DB_ROOT_PASS

# Install MariaDB server and client
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client

# Copy custom MariaDB server configuration
COPY --chown=root:root ./conf/50-server.cnf /etc/mysql/my.cnf

# Initialize MariaDB data directory
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start MariaDB service and configure database and users
RUN /usr/bin/mysqld_safe --datadir='/var/lib/mysql' & \
    sleep 5 && \
    mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASS';" && \
    mysql -u root -p"$DB_ROOT_PASS" -e "FLUSH PRIVILEGES;" && \
    mysql -u root -p"$DB_ROOT_PASS" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;" && \
    mysql -u root -p"$DB_ROOT_PASS" -e "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '$DB_ROOT_PASS';" && \
    mysql -u root -p"$DB_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';" && \
    mysql -u root -p"$DB_ROOT_PASS" -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS';" && \
    mysql -u root -p"$DB_ROOT_PASS" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';" && \
    mysql -u root -p"$DB_ROOT_PASS" -e "FLUSH PRIVILEGES;" && \
    killall mysqld

# Expose the MySQL port
EXPOSE 3306

# Start MariaDB when the container runs
ENTRYPOINT ["/usr/bin/mysqld_safe", "--datadir=/var/lib/mysql"]