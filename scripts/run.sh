#!/bin/bash
set -e

# Make Configurations
${SCRIPTSDIR}/make_configurations.sh

# Run uwsgi
/usr/sbin/nginx -g "daemon off;"
