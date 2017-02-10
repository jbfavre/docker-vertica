# docker images for HPE Vertica

Docker images collection for Vertica database

Vertica is a column oriented database from HPE.
It's available with both a free community licence, and an entreprise one.

## Flavours

Following Vertica/Operating systems versions are provided:

- Vertica 8.0.0
  * on Ubuntu LTS 14.04
  * on Centos 7
- Vertica 7.2.3
  * on Debian Wheezy 7.10
  * on Ubuntu LTS 14.04
  * on Centos 6 & 7
- Vertica 7.1.2
  * on Debian Squeeze 6.0.10
  * on Ubuntu LTS 12.04
  * on Centos 5
- Vertica 7.0.2
  * on Debian Squeeze 6.0.10
  * on Centos 5

## Usage

You can use theses images without persistent data store:

    docker run -p 5433:5433 jbfavre/vertica:7.2.3-0_debian-7.10

Or with persistent data store:

    docker run -p 5433:5433 -d \
               -v /path/to/vertica_data:/home/dbadmin/docker \
               jbfavre/vertica:7.2.3-0_debian-7.10

## How to fuild from Dockerfile

You have to get relevant Vertica package from my.vertica.com (registration mandatory).
Save it in packages directory.

Then, use following command:

    docker build -f Dockerfile.<OS_codename>.<OS_version>_<Vertica_version> \
                 --build-arg VERTICA_PACKAGE=vertica_<Vertica_version>_amd64.deb \
                 -t jbfavre/vertica:<Vertica_version>_<OS_codename>-<OS_version> .

## Want to contribute ?

Fork, dev, make a PR :)
