#!/usr/bin/env groovy

import java.util.Date;

enum ExpenseType {
    DINNER,
    BREAKFAST,
    CAR_RENTAL,
}

class Expense {
    ExpenseType type;
    int amount;
}

def printReport(Expense... expenses) {
    int total = 0;
    int mealExpenses = 0;

    println "Expenses: ${new Date()}";

    for (Expense expense in expenses) {
        if (expense.type == ExpenseType.DINNER || expense.type == ExpenseType.BREAKFAST) {
            mealExpenses += expense.amount;
        }

        String expenseName = "";
        switch (expense.type) {
        case ExpenseType.DINNER:
            expenseName = "Dinner";
            break;
        case ExpenseType.BREAKFAST:
            expenseName = "Breakfast";
            break;
        case ExpenseType.CAR_RENTAL:
            expenseName = "Car Rental";
            break;
        }

        String mealOverExpensesMarker = expense.type == ExpenseType.DINNER && expense.amount > 5000 || expense.type == ExpenseType.BREAKFAST && expense.amount > 1000 ? "X" : " ";

        println "$expenseName\t$expense.amount\t$mealOverExpensesMarker";

        total += expense.amount;
    }

    println "Meal Expenses: $mealExpenses";
    println "Total Expenses: $total";
}
