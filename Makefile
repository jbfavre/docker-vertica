
VERSION70 = 7.0.2-13
VERSION71 = 7.1.2-21
VERSION72 = 7.2.3-18
VERSION80 = 8.0.1-3
VERSION81 = 8.1.0-1

push: push-8.1 push-8.0 push-7.2 push-7.1 push-7.0

push-8.1: build-8.1
	docker tag jbfavre/vertica:$(VERSION81)_debian-8 jbfavre/vertica:8.1
	docker push jbfavre/vertica:$(VERSION81)_debian-8
	docker push jbfavre/vertica:$(VERSION81)_ubuntu-14.04
	#docker push jbfavre/vertica:$(VERSION81)_centos-7
	docker push jbfavre/vertica:8.1

push-8.0: build-8.0
	docker tag jbfavre/vertica:$(VERSION80)_minidebian-8 jbfavre/vertica:experimental
	docker tag jbfavre/vertica:$(VERSION80)_debian-8 jbfavre/vertica:8.0
	docker tag jbfavre/vertica:$(VERSION80)_debian-8 jbfavre/vertica:latest
	docker push jbfavre/vertica:$(VERSION80)_minidebian-8
	docker push jbfavre/vertica:$(VERSION80)_debian-8
	docker push jbfavre/vertica:$(VERSION80)_ubuntu-14.04
	#docker push jbfavre/vertica:$(VERSION80)_centos-7
	docker push jbfavre/vertica:experimental
	docker push jbfavre/vertica:8.0
	docker push jbfavre/vertica:latest

push-7.2: build-7.2
	docker tag jbfavre/vertica:$(VERSION72)_debian-7 jbfavre/vertica:7.2
	docker push jbfavre/vertica:$(VERSION72)_debian-7
	docker push jbfavre/vertica:$(VERSION72)_ubuntu-14.04
	docker push jbfavre/vertica:$(VERSION72)_centos-7
	docker push jbfavre/vertica:7.2

push-7.1: build-7.1
	docker tag jbfavre/vertica:$(VERSION71)_debian-6 jbfavre/vertica:7.1
	docker push jbfavre/vertica:$(VERSION71)_debian-6
	docker push jbfavre/vertica:$(VERSION71)_ubuntu-14.04
	docker push jbfavre/vertica:$(VERSION71)_centos-5
	docker push jbfavre/vertica:7.1

push-7.0: build-7.0
	docker tag jbfavre/vertica:$(VERSION70)_debian-6 jbfavre/vertica:7.0
	docker push jbfavre/vertica:$(VERSION70)_debian-6
	docker push jbfavre/vertica:$(VERSION70)_ubuntu-12.04
	docker push jbfavre/vertica:7.0

build: build-8.1 build-8.0 build-7.2 build-7.1 build-7.0

build-8.1:
	docker build --rm=true -f Dockerfile.minidebian.8_8.1 \
                     -t jbfavre/vertica:$(VERSION81)_minidebian-8 .
	docker build --rm=true -f Dockerfile.debian.8_8.1 \
                     -t jbfavre/vertica:$(VERSION81)_debian-8 .
	docker build --rm=true -f Dockerfile.ubuntu.14.04_8.1 \
                     --build-arg VERTICA_PACKAGE=vertica_$(VERSION81)_amd64.deb \
	             -t jbfavre/vertica:$(VERSION81)_ubuntu-14.04 .
	#docker build --rm=true -f Dockerfile.centos.7_8.1 \
        #             --build-arg VERTICA_PACKAGE=vertica-$(VERSION81).x86_64.RHEL6.rpm \
        #             -t jbfavre/vertica:$(VERSION81)_centos7_8.1 .

build-8.0:
	docker build --rm=true -f Dockerfile.minidebian.8_8.0 \
                     -t jbfavre/vertica:$(VERSION80)_minidebian-8 .
	docker build --rm=true -f Dockerfile.debian.8_8.0 \
                     -t jbfavre/vertica:$(VERSION80)_debian-8 .
	docker build --rm=true -f Dockerfile.ubuntu.14.04_8.0 \
                     --build-arg VERTICA_PACKAGE=vertica_$(VERSION80)_amd64.deb \
                     -t jbfavre/vertica:$(VERSION80)_ubuntu-14.04 .
	#docker build --rm=true -f Dockerfile.centos.7_8.0 \
        #             --build-arg VERTICA_PACKAGE=vertica-$(VERSION80).x86_64.RHEL6.rpm \
        #             -t jbfavre/vertica:$(VERSION80)_centos7_8.0 .

build-7.2:
	docker build --rm=true -f Dockerfile.debian.7_7.2 \
	             -t jbfavre/vertica:$(VERSION72)_debian-7 .
	docker build --rm=true -f Dockerfile.ubuntu.14.04_7.2 \
	             -t jbfavre/vertica:$(VERSION72)_ubuntu-14.04 .
	docker build --rm=true -f Dockerfile.centos.7_7.2 \
	             --build-arg VERTICA_PACKAGE=vertica-$(VERSION72).x86_64.RHEL6.rpm \
	             -t jbfavre/vertica:$(VERSION72)_centos-7 .

build-7.1:
	docker build --rm=true -f Dockerfile.debian.6_7.1 \
	             -t jbfavre/vertica:$(VERSION71)_debian-6 .
	docker build --rm=true -f Dockerfile.ubuntu.14.04_7.1 \
	             -t jbfavre/vertica:$(VERSION71)_ubuntu-14.04 .

build-7.0:
	docker build --rm=true -f Dockerfile.debian.6_7.0 \
	             -t jbfavre/vertica:$(VERSION70)_debian-6 .
	docker build --rm=true -f Dockerfile.ubuntu.12.04_7.0 \
	             --build-arg VERTICA_PACKAGE=vertica_$(VERSION70)_amd64.deb \
	             -t jbfavre/vertica:$(VERSION70)_ubuntu-12.04 .

clean:
	docker rm -v $(docker ps -a -q -f status=exited)
	docker rmi $(docker images -f "dangling=true" -q)
