#!/usr/bin/env groovy

import java.util.Date;

enum ExpenseType {
    DINNER("Dinner", 5000, true),
    BREAKFAST("Breakfast", 1000, true),
    CAR_RENTAL("Car Rental", Integer.MAX_VALUE, false),
    LUNCH("Lunch", 2000, true),
    ;
    final String name;
    final int limit;
    final boolean isMeal;
    ExpenseType(String name, int limit, boolean isMeal) {
        this.name = name;
        this.limit = limit;
        this.isMeal = isMeal;
    }
}

class Expense {
    ExpenseType type;
    int amount;
    Expense(ExpenseType type, int amount) {
        this.type = type;
        this.amount = amount;
    }
    boolean isOverLimit() {
        amount > type.limit;
    }
    String getName() {
        type.name;
    }
    boolean isMeal() {
        type.isMeal;
    }
}

def printReport(Expense... expenses) {
    printHeader();
    printDetails(expenses);
    printSummary(expenses);
}

def printHeader() {
    println "Expenses: ${new Date()}";
}

def printDetails(Expense... expenses) {
    expenses.each { printDetail(it) }
}

def printDetail(Expense expense) {
    String overLimitMarker = expense.isOverLimit() ? "X" : " ";
    println "$expense.name\t$expense.amount\t$overLimitMarker";
}

def printSummary(Expense... expenses) {
    println "Meal Expenses: ${sumMeals(expenses)}";
    println "Total Expenses: ${sumTotal(expenses)}";
}

def sumMeals(Expense... expenses) {
    expenses.findAll { it.isMeal() }.amount.sum();
}

def sumTotal(Expense... expenses) {
    expenses.amount.sum();
}

printReport(
    new Expense(ExpenseType.DINNER, 5000),
    new Expense(ExpenseType.DINNER, 5001),
    new Expense(ExpenseType.BREAKFAST, 1000),
    new Expense(ExpenseType.BREAKFAST, 1001),
    new Expense(ExpenseType.CAR_RENTAL, 4),
    new Expense(ExpenseType.LUNCH, 2000),
    new Expense(ExpenseType.LUNCH, 2001),
);
