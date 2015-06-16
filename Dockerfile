###########################################################
# VikingCo: Nginx Server
###########################################################
FROM nginx:1.9.1
MAINTAINER Dirk Moors

ENV CONFDIR /tmp/conf

ENV ROOT /srv/www

ENV CONFSRC ./conf
ENV SCRIPTSSRC ./scripts

ENV PORT 80
ENV SERVER_NAME localhost

ENV MEDIADIR ${ROOT}/media
ENV STATICDIR ${ROOT}/static
ENV LOGDIR ${ROOT}/logs
ENV SCRIPTSDIR ${ROOT}/scripts

# install and configure packages
RUN set -x \
	&& buildDeps=' \
		python-pip \
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

# make directories
#RUN mkdir -p ${MEDIADIR} && \
#    mkdir -p ${STATICDIR} && \
#    mkdir -p ${LOGDIR} && \
#    mkdir -p ${SCRIPTSDIR}

# set correct permissions
#RUN chown -R www-data ${ROOT}

# add default files
ADD ${CONFSRC} ${CONFDIR}
ADD ${SCRIPTSSRC} ${SCRIPTSDIR}

# set run command
CMD ${SCRIPTSDIR}/run.sh
