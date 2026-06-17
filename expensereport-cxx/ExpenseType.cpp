#include "ExpenseType.h"

#include <climits>

const ExpenseType& ExpenseType::BREAKFAST  = ExpenseType("Breakfast",     1000, true);
const ExpenseType& ExpenseType::DINNER     = ExpenseType("Dinner",        5000, true);
const ExpenseType& ExpenseType::CAR_RENTAL = ExpenseType("Car Rental", INT_MAX, false);
const ExpenseType& ExpenseType::LUNCH      = ExpenseType("Lunch",         2000, true);

ExpenseType::ExpenseType(const std::string& name, const int limit, const bool isMeal) : name(name), limit(limit), isMeal(isMeal) {}
