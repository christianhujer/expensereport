.PHONY: all
all: run

.PHONY: run
run: ExpenseReport
	./ExpenseReport

ExpenseReport: ExpenseReport.v
	v -o $@ $^

.PHONY: clean
clean::
	$(RM) ExpenseReport
