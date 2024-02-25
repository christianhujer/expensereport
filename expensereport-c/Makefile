CPPFLAGS:=-MMD
CFLAGS:=-W -Wall -pedantic -Werror -O3

.PHONY: all
all: test

.PHONY: test
test: ExpenseReportTest
	faketime -f '2022-05-20 10:24:09' ./ExpenseReportTest >actual.txt
	diff expected.txt actual.txt

ExpenseReportTest: ExpenseReportTest.o ExpenseReport.o ExpenseType.o Expense.o

.PHONY: clean
clean::
	$(RM) *.[adios] ExpenseReportTest

-include *.d
