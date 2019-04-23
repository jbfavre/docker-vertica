FROM debian:jessie
MAINTAINER Jean Baptiste Favre <docker@jbfavre.org>

ARG VERTICA_PACKAGE="unknown"

ENV SHELL "/bin/bash"
ENV DEBIAN_FRONTEND noninteractive
ENV TERM 1

ADD scripts/debian_cleaner.sh /tmp/
ADD packages/${VERTICA_PACKAGE} /tmp/

RUN /usr/bin/apt-get update -yqq \
 && /usr/bin/apt-get upgrade --no-install-recommends -yqq \
 && /usr/bin/apt-get install --no-install-recommends -yqq curl ca-certificates locales \
 && /usr/bin/chsh -s /bin/bash root \
 && /bin/rm /bin/sh && ln -s /bin/bash /bin/sh \
 && /usr/sbin/groupadd -r verticadba \
 && /usr/sbin/useradd -r -m -s /bin/bash -g verticadba dbadmin \
 && su - dbadmin -c 'mkdir /tmp/.python-eggs' \
 && /bin/echo "en_US ISO-8859-1" > /etc/locale.gen \
 && /bin/echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
 && /usr/sbin/locale-gen \
 && echo "dbadmin -       nice    0" >> /etc/security/limits.conf \
 && echo "dbadmin -       nofile  65536" >> /etc/security/limits.conf \
 && /usr/bin/apt-get install --no-install-recommends -yqq openssh-server openssh-client mcelog sysstat dialog libexpat1 ntp \
 && /usr/bin/dpkg -i /tmp/${VERTICA_PACKAGE} \
 && rm /tmp/${VERTICA_PACKAGE}

RUN /opt/vertica/sbin/install_vertica --license CE --accept-eula --hosts 127.0.0.1 \
                                      --dba-user-password-disabled --failure-threshold NONE --no-system-configuration

RUN /usr/bin/apt-get remove --purge -y curl ca-certificates libpython2.7 \
 && /bin/bash /tmp/debian_cleaner.sh

ENV PYTHON_EGG_CACHE /tmp/.python-eggs
ENV VERTICADATA /home/dbadmin/docker
VOLUME /home/dbadmin/docker
ENTRYPOINT ["/opt/vertica/bin/docker-entrypoint.sh"]
ADD ./docker-entrypoint.sh /opt/vertica/bin/

EXPOSE 5433
