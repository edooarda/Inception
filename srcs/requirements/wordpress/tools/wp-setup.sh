#!/bin/bash

mkdir -p /var/www/wordpress
cd /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

if [ ! -f wp-config.php ]; then

    wp core download --allow-root

    echo "Waiting Database"
    until mysqladmin ping -h mariadb; do
        echo "Sleeping............. "
        sleep 2
    done

    echo "Creating wp-config.php"
    wp config create \
        --dbname=${MYSQL_DATABASE} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb \
        --allow-root

    echo "Installing WordPress"
    wp core install \
        --url=${DOMAIN_NAME} \
        --title="I-N-C-E-P-T-I-O-N" \
        --admin_user=${WP_ADMIN} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --allow-root

    wp theme install twentytwentytwo --activate --allow-root

    echo "Creating User not admin"
    wp user create \
        ${WP_USER} ${WP_USER_EMAIL} \
        --user_pass=${WP_USER_PASSWORD} \
        --role=author \
        --allow-root

    echo "WordPress setup complete."
else
    echo "WordPress is already setup."
fi

echo "...Starting PHP-FPM..."
exec php-fpm8.2 -F