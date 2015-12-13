NAME = mos_dev_react_tofu
VERSION = ruby2.2

.PHONY: all build

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .
