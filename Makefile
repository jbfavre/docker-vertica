build: debian ubuntu centos

debian:
	docker build --rm=true -f Dockerfile.debian.7.10_7.2.3-0 \
	             --build-arg VERTICA_PACKAGE=vertica_7.2.3-0_amd64.deb \
	             -t jbfavre/vertica-debian:7.10_7.2.3-0 .
	docker build --rm=true -f Dockerfile.debian.6.0.10_7.1.2-0 \
	             --build-arg VERTICA_PACKAGE=vertica_7.1.2-0_amd64.deb \
	             -t jbfavre/vertica-debian:6.0.10_7.1.2-0 .
	docker build --rm=true -f Dockerfile.debian.6.0.10_7.0.2-1 \
	             --build-arg VERTICA_PACKAGE=vertica_7.0.2-1_amd64.deb \
	             -t jbfavre/vertica-debian:6.0.10_7.0.2-1 .

ubuntu:
	docker build --rm=true -f Dockerfile.ubuntu.14.04_7.2.3-0 \
	             --build-arg VERTICA_PACKAGE=vertica_7.2.3-0_amd64.deb \
	             -t jbfavre/vertica-ubuntu:14.04_7.2.3-0 .
	docker build --rm=true -f Dockerfile.ubuntu.14.04_7.1.2-0 \
	             --build-arg VERTICA_PACKAGE=vertica_7.1.2-0_amd64.deb \
	             -t jbfavre/vertica-ubuntu:14.04_7.1.2-0 .
	#docker build --rm=true -f Dockerfile.ubuntu.12.04_7.0.2-1 \
	#             --build-arg VERTICA_PACKAGE=vertica_7.0.2-1_amd64.deb \
	#             -t jbfavre/vertica-ubuntu:12.04_7.0.2-1 .

centos:
	docker build --rm=true -f Dockerfile.centos.7_7.2.3-0 \
	             --build-arg VERTICA_PACKAGE=vertica-7.2.3-0.x86_64.RHEL6.rpm \
	             -t jbfavre/vertica-centos:7_7.2.3-0 .
	docker build --rm=true -f Dockerfile.centos.6_7.2.3-0 \
	             --build-arg VERTICA_PACKAGE=vertica-7.2.3-0.x86_64.RHEL6.rpm \
	             -t jbfavre/vertica-centos:6_7.2.3-0 .
	docker build --rm=true -f Dockerfile.centos.5_7.1.2-0 \
	             --build-arg VERTICA_PACKAGE=vertica-7.1.2-0.x86_64.RHEL5.rpm \
	             -t jbfavre/vertica-centos:5_7.1.2-0 .
	docker build --rm=true -f Dockerfile.centos.5_7.0.2-1 \
	             --build-arg VERTICA_PACKAGE=vertica-7.0.2-1.x86_64.RHEL5.rpm \
	             -t jbfavre/vertica-centos:5_7.0.2-1 .

clean:
	docker rm -v $(docker ps -a -q -f status=exited)
	docker rmi $(docker images -f "dangling=true" -q)
