IMAGE ?= ayufan/dokku-alt-buildstep
TAG ?= $(shell git rev-parse --abbrev-ref HEAD)

build:
	docker build -t "$(IMAGE):$(TAG)" .
	docker build -t progrium/buildstep .

test: build-test run-test

build-test:
	docker build -t progrium/buildstep-test ./test

run-test:
	docker run -v /var/run/docker.sock:/run/docker.sock -ti progrium/buildstep-test

test-old:
	bundle install --deployment
	docker build -t progrium/buildstep .
	bundle exec cucumber --exclude features/apps
