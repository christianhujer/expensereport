package com.nelkinda.training;

import java.io.PrintStream;
import java.util.List;

public class ReportPrinter {
    private final ExpenseFormatter formatter;
    private final PrintStream output;

    public ReportPrinter(ExpenseFormatter formatter, PrintStream output) {
        this.formatter = formatter;
        this.output = output;
    }

    public void printReport(List<Expense> expenses) {
        int total = 0;
        int mealExpenses = 0;

        output.println(formatter.formatHeader());

        for (Expense expense : expenses) {
            if (expense.isMeal()) {
                mealExpenses += expense.amount();
            }

            output.println(formatter.format(expense));
            total += expense.amount();
        }

        output.println(formatter.formatFooter(mealExpenses, total));
    }
}
