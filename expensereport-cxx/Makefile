CPPFLAGS:=-MMD
CXXFLAGS:=-W -Wall -pedantic -Werror -std=c++20 -O3
LDLIBS:=-lstdc++

.PHONY: all
all: test

.PHONY: test
test: ExpenseReportTest
	faketime -f '2022-05-10 13:40:55' ./ExpenseReportTest >actual.txt
	diff expected.txt actual.txt

ExpenseReportTest: ExpenseReportTest.o ExpenseReport.o ExpenseType.o Expense.o

.PHONY: clean
clean::
	$(RM) *.[adios] ExpenseReportTest

-include *.d
