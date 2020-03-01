FROM debian:jessie
MAINTAINER thaim <thaim24@gmail.com>

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       python \
       subversion \
       python-subversion \
       apache2 \
       libapache2-svn \
       sendmail \
       curl \
       sqlite3 \
	   unzip \
    && apt-get clean \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
	
RUN curl --insecure -fSL "https://github.com/mjholtkamp/submin/archive/master.zip" -o master.zip \
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
