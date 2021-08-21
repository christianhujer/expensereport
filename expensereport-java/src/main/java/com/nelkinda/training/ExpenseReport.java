package com.nelkinda.training;

import java.util.Date;
import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import static java.lang.Integer.MAX_VALUE;

enum ExpenseType {
    DINNER("Dinner", 5000, true),
    BREAKFAST("Breakfast", 1000, true),
    CAR_RENTAL("Car Rental", MAX_VALUE, false),
    LUNCH("Lunch", 2000, true),
    ;
    final String name;
    final int limit;
    final boolean isMeal;

    ExpenseType(final String name, final int limit, final boolean isMeal) {
        this.name = name;
        this.limit = limit;
        this.isMeal = isMeal;
    }
}

class Expense {
    final ExpenseType type;
    final int amount;
    public Expense(final ExpenseType type, final int amount) {
        this.type = type;
        this.amount = amount;
    }

    String getName() { return type.name; }
    boolean isMeal() { return type.isMeal; }
    boolean isOverLimit() { return amount > type.limit; }
}

public class ExpenseReport {
    public void printReport(final List<Expense> expenses) {
        printReport(expenses, new Date());
    }

    public void printReport(final List<Expense> expenses, final Date date) {
        System.out.print(generateReport(expenses, date));
    }

    private String generateReport(final List<Expense> expenses, final Date date) {
        return header(date) + body(expenses) + summary(expenses);
    }

    private String header(final Date date) {
        return "Expenses " + date + "\n";
    }

    private String body(final List<Expense> expenses) {
        return expenses.stream()
                .map(this::detail)
                .collect(Collectors.joining());
    }

    private String detail(final Expense expense) {
        return expense.getName() + "\t" + expense.amount + "\t" + getOverLimitMarker(expense) + "\n";
    }

    private String getOverLimitMarker(final Expense expense) {
        return expense.isOverLimit() ? "X" : " ";
    }

    private String summary(final List<Expense> expenses) {
        return "Meal expenses: " + sumMeals(expenses) + "\n" +
                "Total expenses: " + sumTotal(expenses) + "\n";
    }

    private int sumMeals(final List<Expense> expenses) {
        return sumExpenses(expenses, Expense::isMeal);
    }

    private int sumTotal(final List<Expense> expenses) {
        return sumExpenses(expenses, e -> true);
    }

    private int sumExpenses(final List<Expense> expenses, final Predicate<Expense> predicate) {
        return expenses.stream()
                .filter(predicate)
                .mapToInt(it -> it.amount)
                .sum();
    }
}
