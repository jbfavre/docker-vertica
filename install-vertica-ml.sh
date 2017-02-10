#!/bin/bash
echo "deb http://httpredir.debian.org/debian wheezy contrib" >> /etc/apt/sources.list
apt-get update && apt-get install -y libgfortran3
su -- dbadmin
/opt/vertica/bin/adminTools -t install_package -d docker -p password -P AdvancedAnalytics
exit # back to root
chmod u+s /home/dbadmin/docker/catalog/docker/procedures/AdvancedAnalytics/*.py

# docker run --name docker-vertica -d -p 15433:5433 jbfavre/vertica
# /opt/vertica/bin/admintools -t start_db -d docker