SHELL:=/bin/bash
AS:=aarch64-linux-gnu-as
CC:=aarch64-linux-gnu-gcc-12
LD:=aarch64-linux-gnu-ld
ASFLAGS:=-g

.PHONY: all
all: ExpenseReport

ExpenseReport: ExpenseReport.o
	$(LD) -o $@ $^

.PHONY: debug
debug: ExpenseReport
	gdb -tui ExpenseReport

.PHONY: clean
clean::
	$(RM) *.[adios] ExpenseReport
