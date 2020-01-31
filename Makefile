
VERSION9x = 9.2.0-0

build: build-9.x

build-9.x:
	docker build --rm=true -f Dockerfile.centos.7_9.x \
	             --build-arg VERTICA_PACKAGE=vertica-$(VERSION9x).x86_64.RHEL6.rpm \
	             -t adgear/centos7-vertica92:$(VERSION9x)_centos-7 .

clean:
	docker rm -v $(docker ps -a -q -f status=exited)
	docker rmi $(docker images -f "dangling=true" -q)
