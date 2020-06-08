SHELL=/bin/bash

BUILD_VERSION?=0.0.0
BUILD_TAG?=mconf-varnish
BUILD_REVISION?=`git rev-parse --short HEAD`

.PHONY: all image push clean

all: image

image:
	docker build -t $(BUILD_TAG) .
	docker tag $(BUILD_TAG) $(BUILD_TAG):$(BUILD_VERSION)
	docker tag $(BUILD_TAG) $(BUILD_TAG):$(BUILD_VERSION)-$(BUILD_REVISION)
	docker tag $(BUILD_TAG) $(BUILD_TAG):latest

push: image
	docker tag $(BUILD_TAG) mconf/mconf-varnish:$(BUILD_VERSION)
	docker tag $(BUILD_TAG) mconf/mconf-varnish:$(BUILD_VERSION)-$(BUILD_REVISION)
	docker tag $(BUILD_TAG) mconf/mconf-varnish:latest
	docker push mconf/mconf-varnish:$(BUILD_VERSION)
	docker push mconf/mconf-varnish:$(BUILD_VERSION)-$(BUILD_REVISION)
	docker push mconf/mconf-varnish:latest

clean:
	-docker images | grep 'mconf-varnish' | awk '{print $$3}' | xargs docker rmi -f
