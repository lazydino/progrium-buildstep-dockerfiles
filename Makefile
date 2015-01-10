IMAGE ?= ayufan/dokku-alt-buildstep
TAG ?= $(shell git rev-parse --abbrev-ref HEAD)

build:
	docker build -t "$(IMAGE):$(TAG)" .

test:
	bundle install --deployment
	docker build -t progrium/buildstep .
	bundle exec cucumber --exclude features/apps
