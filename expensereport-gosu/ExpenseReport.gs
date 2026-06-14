enum ExpenseType {
    DINNER, BREAKFAST, CAR_RENTAL
}

class Expense {
    var _type: ExpenseType
    var _amount: int
    construct(type: ExpenseType, amount: int) {
        _type = type
        _amount = amount
    }
}

public class ExpenseReporter {
    function printReport(expenses: List<Expense>) {
        var total: int = 0
        var mealExpenses: int = 0

        System.out.println("Expenses " + new Date())

        for (expense in expenses) {
            if (expense._type == ExpenseType.DINNER || expense._type == ExpenseType.BREAKFAST) {
                mealExpenses += expense._amount
            }

            var expenseName: String = ""
            switch (expense._type) {
            case DINNER:
                expenseName = "Dinner"
                break
            case BREAKFAST:
                expenseName = "Breakfast"
                break
            case CAR_RENTAL:
                expenseName = "Car Rental"
                break
            }

            var mealOverExpensesMarker: String = expense._type == ExpenseType.DINNER && expense._amount > 5000 || expense._type == ExpenseType.BREAKFAST && expense._amount > 1000 ? "X" : " "

            System.out.println(expenseName + "\t" + expense._amount + "\t" + mealOverExpensesMarker)

            total += expense._amount
        }

        System.out.println("Meal expenses: " + mealExpenses)
        System.out.println("Total expenses: " + total)
    }
}
