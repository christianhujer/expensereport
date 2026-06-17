#ifndef EXPENSEREPORT_H
#define EXPENSEREPORT_H

#include <stddef.h>

#include "Expense.h"

extern void printReport(struct Expense expenses[], size_t numExpenses);

extern int sumMealExpenses(const struct Expense expenses[], size_t numExpenses);
extern int sumTotal(const struct Expense expenses[], size_t numExpenses);

#endif
