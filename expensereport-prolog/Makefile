.PHONY: all
all: ExpenseReport
	./ExpenseReport

%: %.pl
	swipl -q -t main -o $@ -c $^
