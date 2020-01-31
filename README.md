# docker images for Micro Focus Vertica

Docker images collection for Vertica database

Vertica is a column oriented database from Micro Focus.  
It's available with both a free community licence, and an enterprise one.

## Flavours

Following Vertica/Operating systems versions are provided:
- Vertica 9.x (currently 9.2)
  * on CentOS 7

## Usage

You can use the image without persistent data store:

    docker run -p 5433:5433 adgear/centos7-vertica92:9.2.0-0_centos-7

Or with persistent data store:

    docker run -p 5433:5433 -d \
               -v /path/to/vertica_data:/home/dbadmin/docker \
               adgear/centos7-vertica92:9.2.0_centos-7

Or with custom database name (default is "docker") or database password (default is no password):

    docker run -p 5433:5433 -e DATABASE_NAME='notdocker' -e DATABASE_PASSWORD='foo123' adgear/centos7-vertica92:9.2.0-0_centos-7

## How to build from Dockerfile

You have to get relevant Vertica package from my.vertica.com (registration mandatory).  
Save it in packages directory.

Then, use following command:

    docker build -f Dockerfile.<OS_codename>.<OS_version>_<Vertica_version> \
                 --build-arg VERTICA_PACKAGE=<vertica_package_name_matching_OS.rpm> \
                 -t adgear/centos7-vertica92:<Vertica_version>_<OS_codename>-<OS_version> .

Or have a look into `Makefile`

