.PHONY: all
all: ExpenseReport
	./ExpenseReport

.PHONY: clean
clean::
	$(RM) *.[aios] ExpenseReport

%: %.d
	gdc -o $@ $^
