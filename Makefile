
VERSION9x = 9.2.0-7

push: push-9.x

push-9.x: build-9.x
	docker tag jbfavre/vertica:$(VERSION9x)_debian-8 jbfavre/vertica:9.x
	docker tag jbfavre/vertica:$(VERSION9x)_debian-8 jbfavre/vertica:latest
	docker push jbfavre/vertica:$(VERSION9x)_debian-8
	docker push jbfavre/vertica:$(VERSION9x)_ubuntu-16.04
	docker push jbfavre/vertica:$(VERSION9x)_centos-7
	docker push jbfavre/vertica:9.x
	docker push jbfavre/vertica:latest

build: build-9.x

build-9.x:
	docker build --rm=true -f Dockerfile.debian.8_9.x \
	             --build-arg VERTICA_PACKAGE=vertica_$(VERSION9x)_amd64.deb \
	             -t jbfavre/vertica:$(VERSION9x)_debian-8 .
	docker build --rm=true -f Dockerfile.ubuntu.16.04_9.x \
	             --build-arg VERTICA_PACKAGE=vertica_$(VERSION9x)_amd64.deb \
	             -t jbfavre/vertica:$(VERSION9x)_ubuntu-16.04 .
	docker build --rm=true -f Dockerfile.centos.7_9.x \
	             --build-arg VERTICA_PACKAGE=vertica-$(VERSION9x).x86_64.RHEL6.rpm \
	             -t jbfavre/vertica:$(VERSION9x)_centos-7 .

clean:
	docker rm -v $(docker ps -a -q -f status=exited)
	docker rmi $(docker images -f "dangling=true" -q)
