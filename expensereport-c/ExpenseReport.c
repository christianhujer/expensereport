#include "ExpenseReport.h"
#include <stdio.h>
#include <time.h>

void printReport(struct Expense expenses[], size_t numExpenses) {
    int total = 0;
    int mealExpenses = 0;

    time_t now;
    if (time(&now) == -1)
        return;

    printf("Expenses %s", ctime(&now));

    for (size_t i = 0; i < numExpenses; i++) {
        if (expenses[i].type == DINNER || expenses[i].type == BREAKFAST) {
            mealExpenses += expenses[i].amount;
        }

        char *expenseName;
        switch (expenses[i].type) {
        case DINNER:
            expenseName = "Dinner";
            break;
        case BREAKFAST:
            expenseName = "Breakfast";
            break;
        case CAR_RENTAL:
            expenseName = "Car Rental";
            break;
        }

        char *mealOverExpensesMarker = ((expenses[i].type == DINNER && expenses[i].amount > 5000) || (expenses[i].type == BREAKFAST && expenses[i].amount > 1000)) ? "X" : " ";

        printf("%s\t%d\t%s\n", expenseName, expenses[i].amount, mealOverExpensesMarker);
        total += expenses[i].amount;
    }

    printf("Meal expenses: %d\n", mealExpenses);
    printf("Total expenses: %d\n", total);
}
