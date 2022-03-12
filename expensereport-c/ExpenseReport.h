#ifndef EXPENSEREPORT_H
#define EXPENSEREPORT_H

#include <stddef.h>

enum Type {
    DINNER,
    BREAKFAST,
    CAR_RENTAL
};

struct Expense {
    enum Type type;
    int amount;
};

extern void printReport(struct Expense expenses[], size_t numExpenses);

#endif
