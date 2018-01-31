
VERSION80 = 8.0.1-6
VERSION81 = 8.1.1-11

push: push-8.1 push-8.0

push-8.1: build-8.1
	docker tag jbfavre/vertica:$(VERSION81)_debian-8 jbfavre/vertica:8.1
	docker tag jbfavre/vertica:$(VERSION81)_debian-8 jbfavre/vertica:latest
	docker push jbfavre/vertica:$(VERSION81)_debian-8
	docker push jbfavre/vertica:$(VERSION81)_ubuntu-14.04
	docker push jbfavre/vertica:$(VERSION81)_centos-7
	docker push jbfavre/vertica:8.1

push-8.0: build-8.0
	docker tag jbfavre/vertica:$(VERSION80)_minidebian-8 jbfavre/vertica:experimental
	docker tag jbfavre/vertica:$(VERSION80)_debian-8 jbfavre/vertica:8.0
	docker push jbfavre/vertica:$(VERSION80)_minidebian-8
	docker push jbfavre/vertica:$(VERSION80)_debian-8
	docker push jbfavre/vertica:$(VERSION80)_ubuntu-14.04
	docker push jbfavre/vertica:experimental
	docker push jbfavre/vertica:8.0
	docker push jbfavre/vertica:latest

build: build-8.1 build-8.0

build-8.1:
	docker build --rm=true -f Dockerfile.minidebian.8_8.1 \
                     -t jbfavre/vertica:$(VERSION81)_minidebian-8 .
	docker build --rm=true -f Dockerfile.debian.8_8.1 \
                     -t jbfavre/vertica:$(VERSION81)_debian-8 .
	docker build --rm=true -f Dockerfile.ubuntu.14.04_8.1 \
                     --build-arg VERTICA_PACKAGE=vertica_$(VERSION81)_amd64.deb \
	             -t jbfavre/vertica:$(VERSION81)_ubuntu-14.04 .
	docker build --rm=true -f Dockerfile.centos.7_8.1 \
                     --build-arg VERTICA_PACKAGE=vertica-$(VERSION81).x86_64.RHEL6.rpm \
                     -t jbfavre/vertica:$(VERSION81)_centos-7 .

build-8.0:
	docker build --rm=true -f Dockerfile.minidebian.8_8.0 \
                     -t jbfavre/vertica:$(VERSION80)_minidebian-8 .
	docker build --rm=true -f Dockerfile.debian.8_8.0 \
                     -t jbfavre/vertica:$(VERSION80)_debian-8 .
	docker build --rm=true -f Dockerfile.ubuntu.14.04_8.0 \
                     --build-arg VERTICA_PACKAGE=vertica_$(VERSION80)_amd64.deb \
                     -t jbfavre/vertica:$(VERSION80)_ubuntu-14.04 .

clean:
	docker rm -v $(docker ps -a -q -f status=exited)
	docker rmi $(docker images -f "dangling=true" -q)
