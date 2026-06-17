#include <chrono>
#include <climits>
#include <iostream>
#include <iterator>
#include <numeric>
#include <optional>
#include <ranges>
#include <tuple>
#include <utility>
#include <variant>
#include "ExpenseReport.h"

using namespace std;

template<class InputIterator> int sumTotal(InputIterator& expenses) {
    return accumulate(begin(expenses), end(expenses), 0, [](int acc, const Expense &expense) { return acc + expense.amount; });
}

int sumMeals(const list<Expense>& expenses) {
    auto meals = expenses | views::filter(&Expense::isMeal);
    return sumTotal(meals);
}

void printHeader(ostream& cout) {
    auto now = chrono::system_clock::to_time_t(chrono::system_clock::now());
    cout << "Expenses " << ctime(&now);
}

void printDetail(ostream& cout, const Expense& expense) {
    string mealOverExpensesMarker = expense.isOverLimit() ? "X" : " ";
    cout << expense.name() << '\t' << expense.amount << '\t' << mealOverExpensesMarker << endl;
}

void printDetails(ostream& cout, const list<Expense>& expenses) {
    for (auto const &expense : expenses)
        printDetail(cout, expense);
}

void printSummary(ostream& cout, const list<Expense>& expenses) {
    cout << "Meal expenses: " << sumMeals(expenses) << endl;
    cout << "Total expenses: " << sumTotal(expenses) << endl;
}

void printReport(ostream& cout, const list<Expense>& expenses) {
    printHeader(cout);
    printDetails(cout, expenses);
    printSummary(cout, expenses);
}

void printReport(const list<Expense>& expenses) {
    printReport(cout, expenses);
}
