NS ?= bullshit
VERSION ?= latest

IMAGE_NAME ?= gophish


.PHONY: test build

test: run_tests.sh
	bash run_tests.sh

build: test Dockerfile
	docker build -t $(NS)/$(IMAGE_NAME):$(VERSION) -f Dockerfile .

default: build