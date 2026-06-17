#include <assert.h>
#include <stdlib.h>

#include "ExpenseReport.h"

int main(void) {
    struct Expense expenses[] = {
        { DINNER, 1 },
        { BREAKFAST, 2 },
        { CAR_RENTAL, 4 },
        { LUNCH, 8 },
        { DINNER, 5000 },
        { DINNER, 5001 },
        { BREAKFAST, 1000 },
        { BREAKFAST, 1001 },
        { LUNCH, 2000 },
        { LUNCH, 2001 },
    };
    assert(sumMealExpenses(expenses, sizeof(expenses) / sizeof(expenses[0])) == 16014);
    assert(sumTotal(expenses, sizeof(expenses) / sizeof(expenses[0])) == 16018);
    printReport(expenses, sizeof(expenses) / sizeof(expenses[0]));
    return EXIT_SUCCESS;
}
