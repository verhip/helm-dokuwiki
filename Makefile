# Makefile for releasing
# usage:
# TAG=x.y.z make version-set
# <<final check in>>
# make release

TAG?=latest
VERSION:=$(shell cat VERSION)

help:
	@echo "targets: version-set release delete-tag"
	@echo "Usage:"
	@echo "TAG=x.y.z make version-set"
	@echo "<<final check in>>"
	@echo "make release"

version-set:
	@next="$(TAG)" && \
	current="$(VERSION)" && \
	sed -i '' "s/$$current/$$next/g" VERSION && \
	# sed -i '' "s/tag: $$current/tag: $$next/g" charts/dokuwiki/values.yaml && \
	sed -i '' "s/appVersion: $$current/appVersion: $$next/g" charts/dokuwiki/Chart.yaml && \
	sed -i '' "s/version: $$current/version: $$next/g" charts/dokuwiki/Chart.yaml && \
	echo "Version $$next set"

release:
	git tag -s -m $(VERSION) $(VERSION)
	git push origin $(VERSION)

delete-tag:
	git tag -d $(VERSION)
	git push --delete origin $(VERSION)



