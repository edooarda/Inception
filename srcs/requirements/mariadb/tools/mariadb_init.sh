#!/bin/bash

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then

    service mariadb start;

    sleep 5

    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

    mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"

    mysql -e "FLUSH PRIVILEGES;"

    # Stop temporary server
    mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown
	echo "Database created"
else
	echo "Database already exists"
fi

echo "...Starting MariaDB..."
exec mysqld_safe