#!/bin/bash
set -e

# Make Configurations
${SCRIPTS_DIR}/make_configurations.sh

# Run uwsgi
/usr/sbin/nginx -g "daemon off;"
