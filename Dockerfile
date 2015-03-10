FROM muzili/centos-php

MAINTAINER Joshua Lee <muzili@gmail.com>

RUN yum -y install cronie nginx wget tar bzip2 unzip msmtp pcre-devel mysql && \
    yum -y install php-fpm php-gd php-mysqlnd php-pgsql php-mbstring php-xml php-ldap --enablerepo=remi && \
    sed -i 's/user = apache/user = nginx/' /etc/php-fpm.d/www.conf && \
    sed -i 's/group = apache/group = nginx/' /etc/php-fpm.d/www.conf && \
    yum -y update --enablerepo=remi && \
    chown nginx:nginx /var/lib/php/session/

RUN wget https://download.owncloud.org/download/community/owncloud-latest.tar.bz2 -O /tmp/oc.tar.bz2 && \
    tar -jxf /tmp/oc.tar.bz2 -C /usr/share/nginx && \
    chown -R nginx:nginx /usr/share/nginx/owncloud
ADD default.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /etc/nginx/sites-enabled/default.conf

ADD scripts /scripts
ADD my.cnf.d/ /etc/my.cnf.d/
RUN chmod +x /scripts/*.sh && \
    chmod 644 /etc/my.cnf.d/*.cnf && \
    touch /first_run

# Expose our web root and log directories log.
VOLUME ["/data", "/var/log"]

# Expose the port
EXPOSE 80 443

# Kicking in
CMD ["/scripts/start.sh"]

