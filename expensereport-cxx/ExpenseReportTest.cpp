#include "ExpenseReport.h"
#include <iostream>
#include <list>
#include <stdio.h>
#include <cassert>

int main(void) {
    std::list<Expense> expenses = {
        Expense(ExpenseType::DINNER, 1),
        Expense(ExpenseType::BREAKFAST, 2),
        Expense(ExpenseType::CAR_RENTAL, 4),
        Expense(ExpenseType::LUNCH, 8),
        Expense(ExpenseType::DINNER, 5000),
        Expense(ExpenseType::DINNER, 5001),
        Expense(ExpenseType::BREAKFAST, 1000),
        Expense(ExpenseType::BREAKFAST, 1001),
        Expense(ExpenseType::LUNCH, 2000),
        Expense(ExpenseType::LUNCH, 2001),
    };
    printReport(std::cout, expenses);

    assert(&ExpenseType::DINNER == &expenses.front().type);
}
