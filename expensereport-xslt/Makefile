SHELL:=bash

.PHONY: all
all:
	diff expected.txt <(xsltproc ExpenseReport.xslt expenses.xml)
