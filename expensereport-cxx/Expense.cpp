#include "Expense.h"

Expense::Expense(const ExpenseType& type, const int amount) : type(type), amount(amount) {
}

bool Expense::isOverLimit() const {
    return amount > type.limit;
}

bool Expense::isMeal() const {
    return type.isMeal;
}

std::string Expense::name() const {
    return type.name;
}
