#!/bin/sh

# Check if wp-config.php exists
if [ -f ./wp-config.php ]; then
    echo "WordPress already downloaded"
else

####### MANDATORY PART ##########

    # Download WordPress and all config files
    wget http://wordpress.org/latest.tar.gz
    tar xfz latest.tar.gz
    mv wordpress/* .
    rm -rf latest.tar.gz
    rm -rf wordpress

    # Import env variables in the config file
    sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
    sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
    cp wp-config-sample.php wp-config.php

    # Fetch and update the authentication keys and salts
    new_keys=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
    sed -i "/AUTH_KEY/c\\$new_keys" wp-config.php

    # Install WordPress
    wp core install --url="https://${DOMAIN_NAME}/" --title="Ali Saeed" --admin_user="${MYSQL_USER}" --admin_password="${MYSQL_PASSWORD}" --admin_email="${WP_EMAIL}" --path=/var/www/html/ --allow-root
    wp user create --allow-root ${WP_USER_LOGIN} ${WP_USER_EMAIL} --user_pass=${WP_USER_PASSWORD}
    if [ $? -eq 0 ]; then
        echo "WordPress installed successfully."
    else
        echo "Error installing WordPress."
        exit 1
    fi
fi

chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/
exec "$@"