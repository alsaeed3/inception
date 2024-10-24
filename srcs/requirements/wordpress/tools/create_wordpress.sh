#!/bin/sh

wp core download --allow-root --locale=en_US

# Check if wp-config.php exists
if [ ! -f "/var/www/wp-config.php" ]; then

	wp config create --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb --dbcharset="utf8" 
fi

####### MANDATORY PART ##########

# Install WordPress
wp core install --url="$DOMAIN_NAME" \
	--title="Ali Saeed's WordPress" \
	--admin_user="$MYSQL_USER" \
	--admin_password="$MYSQL_PASSWORD" \
	--admin_email="$WP_ADMIN_EMAIL" \
	--path=/var/www/html/ \
	--allow-root

wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} \
--role=author \
--user_pass=${WP_USER_PASSWORD} \

wp option update blogname "Ali Saeed's WordPress" --allow-root
wp option update blogdescription "Inception" --allow-root
wp option update blog_public 0 --allow-root

wp plugin update --all --allow-root

chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/
exec "$@"