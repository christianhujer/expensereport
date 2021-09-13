.PHONY: all
all: ExpenseReport
	./ExpenseReport

.PHONY: clean
clean::
	$(RM) ExpenseReport *.[adios]

%: %.pas
	fpc $^
