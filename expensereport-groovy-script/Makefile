SHELL:=bash
.PHONY: all
all:
	diff expected.txt <(TZ=UTC faketime -f '2022-06-05 19:45:30' ./ExpenseReport.groovy)
