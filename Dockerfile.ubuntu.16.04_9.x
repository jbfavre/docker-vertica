FROM ubuntu:16.04
MAINTAINER Jean Baptiste Favre <docker@jbfavre.org>

ARG VERTICA_PACKAGE="unknown"

ENV SHELL "/bin/bash"
ENV DEBIAN_FRONTEND noninteractive
ENV TERM 1

ADD packages/${VERTICA_PACKAGE} /tmp/
ADD scripts/debian_cleaner.sh /tmp/

RUN /usr/bin/apt-get update -yqq \
 && /usr/bin/apt-get upgrade --no-install-recommends -yqq \
 && /usr/bin/apt-get install --no-install-recommends -yqq curl ca-certificates locales \
 && /usr/bin/chsh -s /bin/bash root \
 && /bin/rm /bin/sh && ln -s /bin/bash /bin/sh \
 && /usr/sbin/groupadd -r verticadba \
 && /usr/sbin/useradd -r -m -s /bin/bash -g verticadba dbadmin \
 && su - dbadmin -c 'mkdir /tmp/.python-eggs' \
 && /usr/sbin/locale-gen en_US en_US.UTF-8 \
 && /usr/sbin/dpkg-reconfigure locales \
 && /usr/bin/apt-get install --no-install-recommends -yqq openssh-server openssh-client mcelog sysstat dialog \
                             libexpat1 iproute2 ntp \
 && /usr/bin/dpkg -i /tmp/${VERTICA_PACKAGE} \
 && rm /tmp/${VERTICA_PACKAGE}

RUN /opt/vertica/sbin/install_vertica --license CE --accept-eula --hosts 127.0.0.1 \
                                      --dba-user-password-disabled --failure-threshold NONE # --no-system-configuration

RUN /usr/bin/apt-get remove --purge -y curl ca-certificates libpython2.7 \
 && /bin/bash /tmp/debian_cleaner.sh

ENV PYTHON_EGG_CACHE /tmp/.python-eggs
ENV VERTICADATA /home/dbadmin/docker
VOLUME /home/dbadmin/docker
ENTRYPOINT ["/opt/vertica/bin/docker-entrypoint.sh"]
ADD ./docker-entrypoint.sh /opt/vertica/bin/

EXPOSE 5433
