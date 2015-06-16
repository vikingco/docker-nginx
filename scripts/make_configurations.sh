#!/bin/bash
set -e

source "${SCRIPTSDIR}/config.sh"

make_config() {
    echo "Generating nginx config file..."
    cat ${NGINX_CONF_TEMPLATE} \
      | python -c "${PYTHON_JINJA2}" \
      > ${NGINX_CONF}
}

# generate config files
make_config

exit 0

