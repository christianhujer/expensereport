#ifndef EXPENSE_H
#define EXPENSE_H

#include "ExpenseType.h"

struct Expense {
    const struct ExpenseType *type;
    int amount;
};

extern const char *Expense_getName(const struct Expense *expense);
extern bool Expense_isOverLimit(const struct Expense *expense);
extern bool Expense_isMeal(const struct Expense *expense);

#endif
