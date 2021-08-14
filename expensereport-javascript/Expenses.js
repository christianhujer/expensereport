const type = {
    BREAKFAST: 1,
    LUNCH: 2,
    DINNER: 3,
};

function printReport(expenses) {
    let total = 0;
    let mealExpenses = 0;

    process.stdout.write("Expenses " + new Date().toISOString().slice(0, 10) + "\n");

    for (const expense of expenses) {
        if (expense.type == type.DINNER || expense.type == type.BREAKFAST) {
            mealExpenses += expense.amount;
        }

        let expenseName;
        switch (expense.type) {
        case type.DINNER:
            expenseName = "Dinner";
            break;
        case type.BREAKFAST:
            expenseName = "Breakfast";
            break;
        case type.CAR_RENTAL:
            expenseName = "Car Rental";
            break;
        }

        const mealOverExpensesMarker = ((expense.type == type.DINNER && expense.amount > 5000) || (expense.type == type.BREAKFAST && expense.amount > 1000)) ? "X" : " ";

        process.stdout.write(expenseName + "\t" + expense.amount + "\t" + mealOverExpensesMarker);
        total += expense.amount;
    }

    process.stdout.write("Meal expenses: " + mealExpenses);
    process.stdout.write("Total expenses: " + total);
}
