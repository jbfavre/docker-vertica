#!/bin/bash

for FILE in $(ls -1d /usr/share/locale/*|grep -v en);do rm -rf $FILE;done
for FILE in $(ls -1R /usr/share/i18n/locales/* | grep -v en_GB | grep -v en_US);do rm -rf $FILE;done
find /usr/share/doc -type f -exec rm -f {} \;
find /usr/share/man -type f -exec rm -f {} \;
/usr/bin/apt-get -y autoremove
/usr/bin/apt-get clean
/bin/rm -rf /var/lib/apt/lists/*
/bin/rm -f /var/lib/dpkg/info/*
/bin/rm -f /var/cache/debconf/*
/bin/rm -rf /tmp/*
