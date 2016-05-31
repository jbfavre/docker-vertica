build: debian ubuntu centos

debian:
	docker build --rm=true -f Dockerfile.debian.7_7.2 \
	             --build-arg VERTICA_PACKAGE=vertica_7.2.3-0_amd64.deb \
	             -t jbfavre/vertica:7.2.3-0_debian-7.10 .
	docker build --rm=true -f Dockerfile.debian.6_7.1 \
	             --build-arg VERTICA_PACKAGE=vertica_7.1.2-17_amd64.deb \
	             -t jbfavre/vertica:7.1.2-17_debian-6.0.10 .
	docker build --rm=true -f Dockerfile.debian.6_7.0 \
	             --build-arg VERTICA_PACKAGE=vertica_7.0.2-12_amd64.deb \
	             -t jbfavre/vertica:7.0.2-12_debian-6.0.10 .

ubuntu:
	docker build --rm=true -f Dockerfile.ubuntu.14.04_7.2 \
	             --build-arg VERTICA_PACKAGE=vertica_7.2.3-0_amd64.deb \
	             -t jbfavre/vertica:7.2.3-0_ubuntu-14.04 .
	docker build --rm=true -f Dockerfile.ubuntu.14.04_7.1 \
	             --build-arg VERTICA_PACKAGE=vertica_7.1.2-17_amd64.deb \
	             -t jbfavre/vertica:7.1.2-17_ubuntu-14.04 .
	#docker build --rm=true -f Dockerfile.ubuntu.12.04_7.0 \
	#             --build-arg VERTICA_PACKAGE=vertica_7.0.2-12_amd64.deb \
	#             -t jbfavre/vertica:7.0.2-12_ubuntu-12.04 .

centos:
	docker build --rm=true -f Dockerfile.centos.7_7.2 \
	             --build-arg VERTICA_PACKAGE=vertica-7.2.3-0.x86_64.RHEL6.rpm \
	             -t jbfavre/vertica:7.2.3-0_centos-7 .
	docker build --rm=true -f Dockerfile.centos.6_7.2 \
	             --build-arg VERTICA_PACKAGE=vertica-7.2.3-0.x86_64.RHEL6.rpm \
	             -t jbfavre/vertica:7.2.3-0_centos-6 .
	docker build --rm=true -f Dockerfile.centos.5_7.1 \
	             --build-arg VERTICA_PACKAGE=vertica-7.1.2-17.x86_64.RHEL5.rpm \
	             -t jbfavre/vertica:7.1.2-17_centos-5 .
	docker build --rm=true -f Dockerfile.centos.5_7.0 \
	             --build-arg VERTICA_PACKAGE=vertica-7.0.2-12.x86_64.RHEL5.rpm \
	             -t jbfavre/vertica:7.0.2-12_centos-5 .

clean:
	docker rm -v $(docker ps -a -q -f status=exited)
	docker rmi $(docker images -f "dangling=true" -q)
