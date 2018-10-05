FROM php:7.2-apache

LABEL maintainer="Jorijn Schrijvershof <jorijn@jorijn.com>"

# run with eg `docker build --build-arg GULDEN_VERSION=2.0.0.15 --build-arg GDASH_VERSION=1.1`
ARG GULDEN_VERSION
ARG GDASH_VERSION

# install the necessary software packages
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y wget tar cron nano curl supervisor

# create the gulden server directory
RUN mkdir -p /opt/gulden/datadir \
    && mkdir -p /opt/gulden/gulden

# expose volumes and ports
VOLUME /opt/gulden/datadir
EXPOSE 80 9231

# download and configure the Gulden node software
RUN wget https://github.com/Gulden/gulden-official/releases/download/v${GULDEN_VERSION}/Gulden-${GULDEN_VERSION}-x86_64-linux.tar.gz -P /opt/gulden/ \
    && tar -xvf /opt/gulden/Gulden-${GULDEN_VERSION}-x86_64-linux.tar.gz -C /opt/gulden/gulden \
    && rm /opt/gulden/Gulden-${GULDEN_VERSION}-x86_64-linux.tar.gz

# download and configure the G-DASH software
RUN wget https://g-dash.nl/download/G-DASH-${GDASH_VERSION}.tar.gz -P /var/www \
    && tar -xvf /var/www/G-DASH-${GDASH_VERSION}.tar.gz --directory /var/www/html \
    && rm /var/www/G-DASH-${GDASH_VERSION}.tar.gz

# sorry :-(
RUN echo "php_value error_reporting Off" > /var/www/html/.htaccess

# set up the supervisor configuration
RUN mkdir -p /etc/supervisor/conf.d/
COPY supervisor/supervisor.conf /etc/supervisor.conf
COPY supervisor/conf.d/gulden.conf /etc/supervisor/conf.d/gulden.conf
COPY supervisor/conf.d/apache.conf /etc/supervisor/conf.d/apache.conf

# set up file permissions for g-dash
RUN chown -R www-data.www-data /var/www/html

ADD docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
