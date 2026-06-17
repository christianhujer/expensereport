#include "Expense.h"

const char *Expense_getName(const struct Expense *expense) {
    return expense->type->name;
}

bool Expense_isOverLimit(const struct Expense *expense) {
    return expense->amount > expense->type->limit;
}

bool Expense_isMeal(const struct Expense *expense) {
    return expense->type->isMeal;
}
