.PHONY: all
all: ExpenseReport
	./$^

%: %.cbl
	cobc -x -o ExpenseReport ExpenseReport.cbl
