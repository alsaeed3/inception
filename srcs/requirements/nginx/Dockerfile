FROM alpine:3.19

ARG CERT_PATH
ARG KEY_PATH

# Install necessary packages
RUN apk update && apk add --no-cache openssl nginx

# Create directory for certificates
RUN mkdir -p /etc/nginx/certificates

# Generate SSL certificate and key
RUN openssl req -x509 -newkey rsa:2048 -nodes -keyout ${KEY_PATH} -out ${CERT_PATH} -subj "/CN=alsaeed.42.fr" -days 365

# Copy Nginx configuration file
COPY --chown=www-data:www-data ./conf/nginx.conf /etc/nginx/conf.d/default.conf

# Set permissions and create symbolic link for Nginx configuration
RUN chmod 755 /var/www/html && ln -s /etc/nginx/conf.d/default.conf /etc/nginx/sites-enabled/default.conf

# Expose HTTPS port
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]