package com.nelkinda.training;

public class SimpleExpenseFormatter implements ExpenseFormatter {

    @Override
    public String format(Expense expense) {
        String mealOverExpensesMarker = expense.exceedsLimit() ? "X" : " ";
        return String.format("%s %d %s", expense.getName(), expense.amount(), mealOverExpensesMarker);
    }

    @Override
    public String formatHeader() {
        return "Expenses " + new java.util.Date();
    }

    @Override
    public String formatFooter(int mealExpenses, int totalExpenses) {
        return String.format("Meal expenses: %d\nTotal expenses: %d", mealExpenses, totalExpenses);
    }
}
