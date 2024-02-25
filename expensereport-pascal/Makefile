SHELL:=bash

.PHONY: all
all: ExpenseReport
	diff -I '^Expenses: ' expected.txt <(./ExpenseReport)

.PHONY: clean
clean::
	$(RM) ExpenseReport *.[adios]

%: %.pas
	fpc $^
