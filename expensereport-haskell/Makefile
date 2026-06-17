SHELL:=/bin/bash

.PHONY: all
all: test

.PHONY: test
test: expensereport
	diff expected.txt <(./expensereport)

%: %.hs
	ghc $^

.PHONY: clean
clean::
	$(RM) expensereport *.hi *.[adios]
