
IMAGE_NAME = s2i-golang

ifeq ($(TARGET),rhel7)
	OS := .rhel7
else
	OS :=
endif

build:
	docker build -f Dockerfile$(OS) -t $(IMAGE_NAME) .

.PHONY: test
test:
	docker build -t $(IMAGE_NAME)-candidate .
	IMAGE_NAME=$(IMAGE_NAME)-candidate test/run
