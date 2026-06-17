#ifndef EXPENSETYPE_H
#define EXPENSETYPE_H

#include <stdbool.h>

struct ExpenseType {
    const char *const name;
    const int limit;
    const bool isMeal;
};

extern const struct ExpenseType
    *const DINNER,
    *const BREAKFAST,
    *const CAR_RENTAL,
    *const LUNCH;

#endif
