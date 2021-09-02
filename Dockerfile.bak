FROM crazyquark/freeswitch
LABEL maintainer = Cristian Sandu <cristian.sandu@gmail.com>

ENV FUSION_PBX_BRANCH=master

RUN apt-get update && apt-get install -y nano

# Setup NGINX
RUN PHP_VERSION=$(php --version | head -1 | awk '{print $2}' | cut -d. -f 1-2) \
    && wget https://raw.githubusercontent.com/samael33/fusionpbx-install.sh/master/debian/resources/nginx/fusionpbx -O /etc/nginx/sites-available/fusionpbx \
    && find /etc/nginx/sites-available/fusionpbx -type f -exec sed -i 's/\/var\/run\/php\/php7.1-fpm.sock/\/run\/php\/php'"$PHP_VERSION"'-fpm.sock/g' {} \; \
    && ln -s /etc/nginx/sites-available/fusionpbx /etc/nginx/sites-enabled/fusionpbx \
    && ln -s /etc/ssl/private/ssl-cert-snakeoil.key /etc/ssl/private/nginx.key \
    && ln -s /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/ssl/certs/nginx.crt \
    && rm /etc/nginx/sites-enabled/default

# Add the cache directory
RUN mkdir -p /var/cache/fusionpbx && \
    chown -R www-data:www-data /var/cache/fusionpbx

# Get the source code
RUN git clone -b ${FUSION_PBX_BRANCH} https://github.com/fusionpbx/fusionpbx.git /var/www/fusionpbx
RUN chown -R www-data:www-data /var/www/fusionpbx

# Copy freeswitch conf
RUN cp -R /var/www/fusionpbx/resources/templates/conf/* /etc/freeswitch && chown -R www-data:www-data /etc/freeswitch

# Adjust RTP ports
RUN sed -i /etc/freeswitch/autoload_configs/switch.conf.xml -e 's/<!-- <param name="rtp-start-port" value="16384"\/> -->/<param name="rtp-start-port" value="16384"\/>/g' && \
    sed -i /etc/freeswitch/autoload_configs/switch.conf.xml -e 's/<!-- <param name="rtp-end-port" value="32768"\/> -->/<param name="rtp-end-port" value="16390"\/>/g'

# Copy the scripts
RUN cp -R /var/www/fusionpbx/app/scripts/resources/scripts /usr/share/freeswitch && chown -R www-data:www-data /usr/share/freeswitch


# Config dir and cleanup
RUN mkdir -p /etc/fusionpbx \
    && chown -R www-data:www-data /etc/fusionpbx \
    && mkdir -p /run/php/ \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN PHP_VERSION=$(php --version | head -1 | awk '{print $2}' | cut -d. -f 1-2) \
    && find /etc/supervisor/conf.d/supervisord.conf -type f -exec sed -i 's/php-fpm7.3/php-fpm'"$PHP_VERSION"'/g' {} \; \
    && find /etc/supervisor/conf.d/supervisord.conf -type f -exec sed -i 's/\/php\/7.3\//\/php\/'"$PHP_VERSION"'\//g' {} \;

EXPOSE 80
EXPOSE 443

VOLUME ["/etc/fusionpbx"]

CMD /usr/bin/supervisord -n
