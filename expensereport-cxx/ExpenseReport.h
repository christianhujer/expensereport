#ifndef EXPENSEREPORT_H
#define EXPENSEREPORT_H

#include <list>
#include <iostream>
#include <string>

#include "ExpenseType.h"
#include "Expense.h"

extern void printReport(const std::list<Expense>& expenses);
extern void printReport(std::ostream& out, const std::list<Expense>& expenses);

#endif
