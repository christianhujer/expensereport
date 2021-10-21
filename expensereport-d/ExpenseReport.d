import std.stdio;
import std.datetime.systime;

enum ExpenseType { DINNER, BREAKFAST, CAR_RENTAL }

struct Expense {
    ExpenseType type;
    int amount;
}

void printReport(Expense[] expenses) {
    int meals = 0;
    int total = 0;
    writefln("Expenses: %s", Clock.currTime());
    foreach (expense; expenses) {
        if (expense.type == ExpenseType.DINNER || expense.type == ExpenseType.BREAKFAST) {
            meals += expense.amount;
        }
        string name = "";
        switch (expense.type) {
        case ExpenseType.DINNER: name = "Dinner"; break;
        case ExpenseType.BREAKFAST: name = "Breakfast"; break;
        case ExpenseType.CAR_RENTAL: name = "Car Rental"; break;
        default: name = "";
        }
        string mealOverExpensesMarker = expense.type == ExpenseType.DINNER && expense.amount > 5000 || expense.type == ExpenseType.BREAKFAST && expense.amount > 1000 ? "X" : " ";
        writefln("%s\t%s\t%s", name, expense.amount, mealOverExpensesMarker);
        total += expense.amount;
    }
    writefln("Meal expenses: %d", meals);
    writefln("Total expenses: %d", total);
}

void main() {
    Expense[] expenses = [
        { ExpenseType.DINNER, 5000 },
        { ExpenseType.DINNER, 5001 },
        { ExpenseType.BREAKFAST, 1000 },
        { ExpenseType.BREAKFAST, 1001 },
        { ExpenseType.CAR_RENTAL, 4 },
    ];
    printReport(expenses);
}
