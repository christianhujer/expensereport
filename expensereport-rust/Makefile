SHELL:=/bin/bash

.PHONY: all
all: test

.PHONY: test
test: unittest acceptancetest

.PHONY: build
build: target/debug/expensereport-rust

target/debug/expensereport-rust: src/main.rs
	cargo build

.PHONY: acceptancetest
acceptancetest: ./target/debug/expensereport-rust
	diff <(tail -n +2 gold.txt) <(./target/debug/expensereport-rust | tail -n +2)

.PHONY: unittest
unittest:
	cargo test
