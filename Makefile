DOCKER = docker
IMAGE = reaver385/docker-aosp

docker-aosp: Dockerfile
	$(DOCKER) build -t $(IMAGE) .

all: docker-aosp

.PHONY: all
