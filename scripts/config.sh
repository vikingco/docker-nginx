#!/usr/bin/env bash

readonly NGINX_CONF_TEMPLATE="${CONF_DIR}/nginx.template.conf"
readonly NGINX_CONF="/etc/nginx/conf.d/default.conf"

readonly PYTHON_JINJA2="import os;
import sys;
import jinja2;
sys.stdout.write(
    jinja2.Template
        (sys.stdin.read()
    ).render(env=os.environ))"
