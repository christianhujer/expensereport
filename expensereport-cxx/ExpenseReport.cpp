#include <chrono>
#include <iostream>
#include <iterator>
#include <list>

using namespace std;

enum Type
{
    BREAKFAST, DINNER, CAR_RENTAL
};

class Expense
{
    public:
    Type type;
    int amount;
};

void printReport(list<Expense> expenses)
{
    int total = 0;
    int mealExpenses = 0;

    auto now = chrono::system_clock::to_time_t(chrono::system_clock::now());
    cout << "Expenses " << ctime(&now) << '\n';

    for (list<Expense>::iterator expense = expenses.begin(); expense != expenses.end(); ++expense) {
        if (expense->type == BREAKFAST || expense->type == DINNER) {
            mealExpenses += expense->amount;
        }

        string expenseName = "";
        switch (expense->type) {
        case DINNER:
            expenseName = "Dinner";
            break;
        case BREAKFAST:
            expenseName = "Breakfast";
            break;
        case CAR_RENTAL:
            expenseName = "Car Rental";
            break;
        }

        string mealOverExpensesMarker = (expense->type == DINNER && expense->amount > 5000) || (expense->type == BREAKFAST && expense->amount > 1000) ? "X" : " ";

        cout << expenseName << '\t' << expense->amount << '\t' << mealOverExpensesMarker << '\n';

        total += expense->amount;
    }

    cout << "Meal expenses: " << mealExpenses << '\n';
    cout << "Total expenses: " << total << '\n';
}
