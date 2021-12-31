SHELL:=/bin/bash

export PATH:=${HOME}/Software/zig-linux-x86_64-0.9.0/:${PATH}

.PHONY: all
all: run

.PHONY: run
run: ExpenseReport
	./ExpenseReport

%: %.zig
	zig build-exe $^

.PHONY: clean
clean::
	$(RM) *.[adios] ExpenseReport
