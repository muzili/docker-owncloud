#!/bin/bash
# Starts up the owncloud stack within the container.

# Stop on error
#set -e
LOG_DIR=/var/log

FILE=autoconfig.php
OC_PATH=/usr/share/nginx/owncloud/config/
SSL_PROTOCOLS_DEFAULT='TLSv1 TLSv1.1 TLSv1.2'
SSL_CIPHERS_DEFAULT='AES256+EECDH:AES256+EDH'

if [[ -e /first_run ]]; then
  source /scripts/first_run.sh
else
  source /scripts/normal_run.sh
fi

pre_start_action
post_start_action

exec supervisord
