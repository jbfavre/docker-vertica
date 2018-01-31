# docker images for HPE Vertica

Docker images collection for Vertica database

Vertica is a column oriented database from HPE.  
It's available with both a free community licence, and an entreprise one.

## Flavours

Following Vertica/Operating systems versions are provided:
- Vertica 8.1.0
  * on Ubuntu LTS 14.04
  * on Debian 8.0 Jessie
  * on CentOS 7 (Thanks to @pcerny for the work)
- Vertica 8.0.0
  * on Ubuntu LTS 14.04
  * on Debian 8.0 Jessie

Support of Vertica 7.x has been removed since this version has been EOL for quite a time.
Support of Vertica 9.x will be added as soon as possible.

## Usage

You can use theses images without persistent data store:

    docker run -p 5433:5433 jbfavre/vertica:8.1.1-11_debian-8

Or with persistent data store:

    docker run -p 5433:5433 -d \
               -v /path/to/vertica_data:/home/dbadmin/docker \
               jbfavre/vertica:8.1.1-11_debian-8

## How to fuild from Dockerfile

You have to get relevant Vertica package from my.vertica.com (registration mandatory).  
Save it in packages directory.

Then, use following command:

    docker build -f Dockerfile.<OS_codename>.<OS_version>_<Vertica_version> \
                 --build-arg VERTICA_PACKAGE=vertica_<Vertica_version>_amd64.deb \
                 -t jbfavre/vertica:<Vertica_version>_<OS_codename>-<OS_version> .

Or have a look into `Makefile`.

## Want to contribute ?

Fork, dev, make a PR :)
