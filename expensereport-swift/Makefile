SWIFT:=/home/christian.hujer/swift/swift-5.4.1-RELEASE-ubuntu20.04/usr/bin/swift

.PHONY: all
all: test

.PHONY: test
test: build
	.build/debug/expensereportPackageTests.xctest

.PHONY: build
build:
	$(SWIFT) build --skip-update --build-tests --build-path .build
