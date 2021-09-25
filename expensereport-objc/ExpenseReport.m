#include <stdio.h>
#include <time.h>

typedef enum {
    DINNER,
    BREAKFAST,
    CAR_RENTAL
} ExpenseType;

struct Expense {
    ExpenseType type;
    int amount;
} Expense;

void printReport(struct Expense expenses[], size_t numExpenses) {
    int total = 0;
    int mealExpenses = 0;

    int i;
    time_t now;
    if (time(&now) == -1)
        return;

    printf("Expenses %s:\n", ctime(&now));

    for (i = 0; i < numExpenses; i++) {
        struct Expense expense = expenses[i];

        if (expense.type == DINNER || expense.type == BREAKFAST) {
            mealExpenses += expense.amount;
        }

        char *expenseName;
        switch (expense.type) {
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

        char *mealOverExpensesMarker = ((expense.type == DINNER && expense.amount > 5000) || (expense.type == BREAKFAST && expense.amount > 1000)) ? "X" : " ";

        printf("%s\t%d\t%s\n", expenseName, expense.amount, mealOverExpensesMarker);
        total += expense.amount;
    }

    printf("Meal expenses: %d\n", mealExpenses);
    printf("Total expenses: %d\n", total);
}

int main(void) {
    struct Expense expenses[5];
    expenses[0].type = DINNER; expenses[0].amount = 5000;
    expenses[1].type = DINNER; expenses[1].amount = 5001;
    expenses[2].type = BREAKFAST; expenses[2].amount = 1000;
    expenses[3].type = BREAKFAST; expenses[3].amount = 1001;
    expenses[4].type = CAR_RENTAL; expenses[4].amount = 4;
    printReport(expenses, 5);
    return 0;
}
