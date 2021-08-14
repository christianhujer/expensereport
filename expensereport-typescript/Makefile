.PHONY: all
all: test

.PHONY: test
test: node_modules/
	npm test

node_modules/: package.json
	npm ci
