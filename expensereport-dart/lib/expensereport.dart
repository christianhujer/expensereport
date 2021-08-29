enum ExpenseType {
    DINNER, BREAKFAST, CAR_RENTAL
}

class Expense {
    ExpenseType type = ExpenseType.DINNER;
    int amount = 0;
    Expense(ExpenseType type, int amount) {
        this.type = type;
        this.amount = amount;
    }
}

class ExpenseReport {
    void printReport(List<Expense> expenses) {
        var mealExpenses = 0;
        var totalExpenses = 0;
        var date = DateTime.now();
        print('Expense Report: $date');
        for (var expense in expenses) {
            if (expense.type == ExpenseType.DINNER || expense.type == ExpenseType.BREAKFAST) {
                mealExpenses += expense.amount;
            }
            String expenseName;
            switch (expense.type) {
                case ExpenseType.DINNER: expenseName = 'Dinner'; break;
                case ExpenseType.BREAKFAST: expenseName = 'Breakfast'; break;
                case ExpenseType.CAR_RENTAL: expenseName = 'Car Rental'; break;
            };
            var mealOverExpensesMarker = expense.type == ExpenseType.DINNER && expense.amount > 5000 || expense.type == ExpenseType.BREAKFAST && expense.amount > 1000 ? 'X' : ' ';
            print('$expenseName\t${expense.amount}\t$mealOverExpensesMarker');
            totalExpenses += expense.amount;
        }
        print('Meal Expenses: $mealExpenses');
        print('Total Expenses: $totalExpenses');
    }
}
