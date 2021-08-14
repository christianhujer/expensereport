#include <stdio.h>
#include <time.h>

enum Type {
    DINNER,
    BREAKFAST,
    CAR_RENTAL
};

struct Expense {
    enum Type type;
    int amount;
};

void printExpenses(struct Expense *expenses[], size_t numExpenses) {
    int total = 0;
    int mealExpenses = 0;

    time_t now;
    if (time(&now) == -1)
        return;

    printf("Expenses %s\n", ctime(&now));

    for (size_t i = 0; i < numExpenses; i++) {
        struct Expense *expense = expenses[i];

        if (expense->type == DINNER || expense->type == BREAKFAST) {
            mealExpenses += expense->amount;
        }

        char *expenseName;
        switch (expense->type) {
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

        char *mealOverExpensesMarker = ((expense->type == DINNER && expense->amount > 5000) || (expense->type == BREAKFAST && expense->amount > 1000)) ? "X" : " ";

        printf("%s\t%d\t%s\n", expenseName, expense->amount, mealOverExpensesMarker);
        total += expense->amount;
    }

    printf("Meal expenses: %d\n", mealExpenses);
    printf("Total expenses: %d\n", total);
}
