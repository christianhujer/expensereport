SHELL:=bash

.PHONY: all
all:
	diff expected.txt <(faketime -f '2022-07-01 10:20:30' ./ExpenseReport.pl)
