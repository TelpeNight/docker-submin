FROM debian
MAINTAINER thaim <thaim24@gmail.com>

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       python2 \
       subversion \
       python2-subversion \
       apache2 \
       libapache2-mod-svn \
       sendmail \
       curl \
       sqlite3 \
	   unzip \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
	
RUN curl --insecure -fSL "https://github.com/TelpeNight/submin/archive/master.zip" -o master.zip \
    && unzip master.zip -d /opt \
    && rm master.zip \
    && cd /opt/submin-master \
    && python setup.py install \
    && cd / \
    && rm -rf /opt/submin-master

COPY ./docker-entrypoint.sh /

RUN usermod -u 1000 www-data

EXPOSE 80
ENTRYPOINT ["/docker-entrypoint.sh"]
#CMD ["submin"]
