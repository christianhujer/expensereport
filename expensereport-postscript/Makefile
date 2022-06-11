SHELL:=bash

.PHONY: all
all: test

.PHONY: run
run:
	gs -q -sDEVICE=nullpage -- ExpenseReport.ps

.PHONY: test
test:
	diff expected.txt <($(MAKE) -s run)
