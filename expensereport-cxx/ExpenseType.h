#ifndef EXPENSETYPE_H
#define EXPENSETYPE_H

#include <string>

class ExpenseType {
public:
    const std::string name;
    const int limit;
    const bool isMeal;
    static const ExpenseType& BREAKFAST;
    static const ExpenseType& DINNER;
    static const ExpenseType& CAR_RENTAL;
    static const ExpenseType& LUNCH;
private:
    ExpenseType(const std::string& name, const int limit, const bool isMeal);
};

#endif
