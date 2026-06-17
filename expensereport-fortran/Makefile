FFLAGS:=--std=f2018 -ffree-form

.PHONY: all
all: ExpenseReport
	./ExpenseReport >actual.txt
	diff expected.txt actual.txt

.PHONY: clean
clean::
	$(RM) ExpenseReport *.[adios] *.mod
