###########################################################
# VikingCo: Nginx Server
###########################################################
FROM nginx:1.9.2
MAINTAINER Dirk Moors

ENV CONFDIR /tmp/conf

ENV ROOT /srv/www

ENV CONFSRC ./conf
ENV SCRIPTSSRC ./scripts

ENV PORT 80
ENV SERVER_NAME localhost

ENV MEDIADIR ${ROOT}/media
ENV STATICDIR ${ROOT}/static
ENV SCRIPTSDIR ${ROOT}/scripts

ENV LOGDIR /var/log
ENV NGINX_LOGDIR ${LOGDIR}/nginx/

# install and configure packages
RUN set -x \
	&& buildDeps=' \
		python-pip \
		build-essential \
	' \
	&& requiredAptPackages=' \
        python \
	' \
	&& requiredPipPackages=' \
        Jinja2 \
	' \
	&& apt-get update \
	&& apt-get install -y $buildDeps $requiredAptPackages --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && pip install $requiredPipPackages \
    && find /usr/local \
		\( -type d -a -name test -o -name tests \) \
		-o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		-exec rm -rf '{}' + \
	&& apt-get purge -y --auto-remove $buildDeps

# make log directory
RUN mkdir -p ${NGINX_LOGDIR} \
    && chown -R www-data ${NGINX_LOGDIR}

# add default files
ADD ${CONFSRC} ${CONFDIR}
ADD ${SCRIPTSSRC} ${SCRIPTSDIR}

# set run command
CMD ${SCRIPTSDIR}/run.sh
