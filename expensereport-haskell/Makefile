SHELL:=/bin/bash

.PHONY: all
all: expensereport

%: %.hs
	ghc $^

.PHONY: clean
clean::
	$(RM) expensereport *.hi *.[adios]
