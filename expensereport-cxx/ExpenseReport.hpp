#pragma once

#include <list>

using namespace std;

class ExpenseType {
public:
    string name;
    int limit;
    bool isMeal;
};

const auto BREAKFAST = ExpenseType{"Breakfast", 1000, true};
const auto DINNER = ExpenseType{"Dinner", 5000, true};
const auto LUNCH = ExpenseType{"Lunch", 2000, true};
const auto CAR_RENTAL = ExpenseType{"Car Rental", numeric_limits<int>::max(), false};

class Expense {
public:
    Expense(ExpenseType type, int amount);

    int amount;
    ExpenseType type;

    string getName() const;

    bool isOverLimit() const;

    bool isMeal() const;
};

void printReport(const list<Expense> &expenses, time_t now);

class ExpenseReport {
public:
    void printReport(const list<Expense> &expenses, time_t now);

    ostringstream out;

    void header(time_t &now);

    int sumMeals(const list<Expense> &expenses) const;

    int sumTotal(const list<Expense> &expenses) const;

    void summary(const list<Expense> &expenses);

    void body(const list<Expense> &expenses);

    void detail(const Expense &expense);

    string getOverExpenseMarker(const Expense &expense) const;

};
