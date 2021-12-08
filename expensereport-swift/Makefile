SWIFT_HOME:=/home/christian.hujer/swift/swift-5.5.1-RELEASE-ubuntu20.04/
export PATH:=$(SWIFT_HOME)usr/bin:$(PATH)
SWIFT:=swift

.PHONY: all
all: test

.PHONY: test
test: build
	.build/debug/ExpenseReportPackageTests.xctest

.PHONY: build
build:
	$(SWIFT) build --skip-update --build-tests --build-path .build
