SHELL:=bash

.PHONY: all
all:
	diff expected.txt <(faketime -f '2022-06-05 17:08:23' rexx ExpenseReport.rexx)
