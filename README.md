# docker images for Micro Focus Vertica

Docker images collection for Vertica database

Vertica is a column oriented database from Micro Focus.  
It's available with both a free community licence, and an enterprise one.

## News

* __2019, Apr. 8th__:  
  Support of Vertica 8.x has been removed because I'm lacking time to manage it.
* __2018, Jan. 31th__:  
  Support of Vertica 7.x has been removed since this version has been EOL for quite a time.

## Flavours

Following Vertica/Operating systems versions are provided:
- Vertica 9.x (currently 9.2)
  * on Ubuntu LTS 16.04
  * on Debian 8.0 Jessie
  * on CentOS 7 (Thanks to @pcerny for the work)

__latest__ tag follows the Debian flavour of the image.

## Usage

You can use the image without persistent data store:

    docker run -p 5433:5433 jbfavre/vertica:9.2.0-7_debian-8

Or with persistent data store:

    docker run -p 5433:5433 -d \
               -v /path/to/vertica_data:/home/dbadmin/docker \
               jbfavre/vertica:9.2.0-7_debian-8

Or with custom database name (default is "docker") or database password (default is no password):

    docker run -p 5433:5433 -e DATABASE_NAME='notdocker' -e DATABASE_PASSWORD='foo123' jbfavre/vertica:9.2.0-7_debian-8

Default user is dbadmin

## How to build from Dockerfile

You have to get relevant Vertica package from my.vertica.com (registration mandatory).  
Save it in packages directory.

Then, use following command:

    docker build -f Dockerfile.<OS_codename>.<OS_version>_<Vertica_version> \
                 --build-arg VERTICA_PACKAGE=<vertica_package_name_matching_OS.deb/.rpm> \
                 -t jbfavre/vertica:<Vertica_version>_<OS_codename>-<OS_version> .

Or have a look into `Makefile`.

## Want to contribute ?

Fork, dev, make a PR :)
