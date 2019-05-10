FROM centos:centos7
MAINTAINER Jean Baptiste Favre <docker@jbfavre.org>

ARG VERTICA_PACKAGE="unknown"

ENV LANG en_US.utf8
ENV TZ UTC

ADD packages/${VERTICA_PACKAGE} /tmp/

RUN yum -q -y update \
 && yum -q -y install openssl curl \
 && /usr/bin/curl -o /usr/local/bin/gosu -SL 'https://github.com/tianon/gosu/releases/download/1.1/gosu' \
 && /bin/chmod +x /usr/local/bin/gosu \
 && /usr/sbin/groupadd -r verticadba \
 && /usr/sbin/useradd -r -m -s /bin/bash -g verticadba dbadmin \
 && /usr/local/bin/gosu dbadmin mkdir /tmp/.python-eggs \
 && yum install -y which mcelog gdb sysstat openssh-server openssh-clients iproute ntp \
 && yum localinstall -q -y /tmp/${VERTICA_PACKAGE} \
 && /bin/rm -f /tmp/vertica*

RUN /opt/vertica/sbin/install_vertica --debug --license CE --accept-eula --hosts 127.0.0.1 \
                                      --dba-user-password-disabled --failure-threshold NONE --no-system-configuration

ENV PYTHON_EGG_CACHE /tmp/.python-eggs
ENV VERTICADATA /home/dbadmin/docker
VOLUME /home/dbadmin/docker
ENTRYPOINT ["/opt/vertica/bin/docker-entrypoint.sh"]
ADD ./docker-entrypoint.sh /opt/vertica/bin/
RUN chmod a+x /opt/vertica/bin/docker-entrypoint.sh

EXPOSE 5433
