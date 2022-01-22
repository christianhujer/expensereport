#include <chrono>
#include <iostream>
#include <sstream>
#include <iterator>
#include <utility>

#include "ExpenseReport.hpp"

void printReport(const list<Expense> &expenses, time_t now) {
    ExpenseReport report;
    report.printReport(expenses, now);
}

void ExpenseReport::printReport(const list<Expense> &expenses, time_t now) {
    out.clear();
    header(now);
    body(expenses);
    summary(expenses);
    cout << out.str();
}

void ExpenseReport::body(const list<Expense> &expenses) {
    for (auto &expense : expenses) {
        detail(expense);
    }
}

void ExpenseReport::detail(const Expense &expense) {
    out << expense.getName() << '\t' << expense.amount << '\t' << getOverExpenseMarker(expense) << '\n';
}

string ExpenseReport::getOverExpenseMarker(const Expense &expense) const {
    return expense.isOverLimit() ? "X" : " ";
}

void ExpenseReport::summary(const list<Expense> &expenses) {
    out << "Meal expenses: " << sumMeals(expenses) << '\n';
    out << "Total expenses: " << sumTotal(expenses) << '\n';
}

int ExpenseReport::sumTotal(const list<Expense> &expenses) const {
    int total = 0;
    for (auto &expense : expenses) {
        total += expense.amount;
    }
    return total;
}

int ExpenseReport::sumMeals(const list<Expense> &expenses) const {
    int mealExpenses = 0;
    for (auto &expense : expenses) {
        if (expense.isMeal()) {
            mealExpenses += expense.amount;
        }
    }
    return mealExpenses;
}

void ExpenseReport::header(time_t &now) { out << "Expenses " << ctime(&now) << '\n'; }

string Expense::getName() const {
    return type.name;
}

bool Expense::isOverLimit() const {
    return (amount > type.limit);
}

bool Expense::isMeal() const {
    return type.isMeal;
}

Expense::Expense(ExpenseType type, int amount) : type(std::move(type)), amount(amount) {

}
