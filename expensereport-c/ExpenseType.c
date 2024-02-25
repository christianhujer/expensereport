#include "ExpenseType.h"

#include <limits.h>

const struct ExpenseType
    *const DINNER     = &(const struct ExpenseType) { "Dinner",        5000, true },
    *const BREAKFAST  = &(const struct ExpenseType) { "Breakfast",     1000, true },
    *const CAR_RENTAL = &(const struct ExpenseType) { "Car Rental", INT_MAX, false },
    *const LUNCH      = &(const struct ExpenseType) { "Lunch",         2000, true };
