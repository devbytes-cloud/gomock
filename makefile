VERSION ?= 0.0.1
IMAGE_TAG_BASE ?= devbytescloud/gomock
IMG ?= $(IMAGE_TAG_BASE):$(VERSION)

.PHONY: docker-build
docker-build:
	@echo "building docker image to dockerhub ${IMG}"
	docker build -t ${IMG} .

.PHONY: docker-push
docker-push:
	docker push ${IMG}