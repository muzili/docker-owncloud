FROM muzili/centos-php

MAINTAINER Joshua Lee <muzili@gmail.com>

RUN yum -y update --enablerepo=remi,remi-php55 && \
    yum -y install --enablerepo=remi,remi-php55 \
    cronie nginx wget tar bzip2 unzip msmtp pcre-devel mysql \
    php-fpm php-gd php-mysqlnd php-mbstring php-xml php-ldap

RUN wget http://download.owncloud.org/community/owncloud-latest.tar.bz2 -O /tmp/oc.tar.bz2 && \
    tar -jxf /tmp/oc.tar.bz2 -C /usr/share/nginx && \
    chown -R nginx:nginx /usr/share/nginx/owncloud

ADD scripts /scripts
RUN chmod +x /scripts/*.sh && \
    touch /first_run

# Expose our web root and log directories log.
VOLUME ["/data", "/var/log"]

# Expose the port
EXPOSE 80 443

# Kicking in
CMD ["/scripts/start.sh"]

