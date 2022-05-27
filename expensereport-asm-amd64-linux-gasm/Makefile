ASFLAGS:=-g

.PHONY: all
all: ExpenseReport

ExpenseReport: ExpenseReport.o
	ld -o $@ $^

.PHONY: debug
debug: ExpenseReport
	gdb -tui ExpenseReport

.PHONY: clean
clean::
	$(RM) *.[adios] ExpenseReport
