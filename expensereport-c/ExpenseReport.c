#include "ExpenseReport.h"

#include <limits.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

int sumMealExpenses(const struct Expense expenses[], size_t numExpenses) {
    int mealExpenses = 0;
    for (size_t i = 0; i < numExpenses; i++)
        if (Expense_isMeal(&expenses[i]))
            mealExpenses += expenses[i].amount;
    return mealExpenses;
}

int sumTotal(const struct Expense expenses[], size_t numExpenses) {
    int total = 0;
    for (size_t i = 0; i < numExpenses; i++)
        total += expenses[i].amount;
    return total;
}

void printReportHeader() {
    time_t now;
    if (time(&now) == -1)
        return;
    printf("Expenses %s", ctime(&now));
}

void printReportDetail(const struct Expense *expense) {
    char *expenseOverLimitMarker = Expense_isOverLimit(expense) ? "X" : " ";
    printf("%s\t%d\t%s\n", Expense_getName(expense), expense->amount, expenseOverLimitMarker);
}

void printReportDetails(struct Expense expenses[], size_t numExpenses) {
    for (size_t i = 0; i < numExpenses; i++)
        printReportDetail(&expenses[i]);
}

void printReportSummary(struct Expense expenses[], size_t numExpenses) {
    printf("Meal expenses: %d\n", sumMealExpenses(expenses, numExpenses));
    printf("Total expenses: %d\n", sumTotal(expenses, numExpenses));
}

void printReport(struct Expense expenses[], size_t numExpenses) {
    printReportHeader();
    printReportDetails(expenses, numExpenses);
    printReportSummary(expenses, numExpenses);
}
