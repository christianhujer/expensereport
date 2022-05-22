#ifndef EXPENSE_H
#define EXPENSE_H

#include "ExpenseType.h"

class Expense
{
public:
    const ExpenseType& type;
    const int amount;
    bool isOverLimit() const;
    bool isMeal() const;
    std::string name() const;
    Expense(const ExpenseType& type, const int amount);
};

#endif
