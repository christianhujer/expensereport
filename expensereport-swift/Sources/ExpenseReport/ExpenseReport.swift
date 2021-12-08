import Foundation

enum ExpenseType {
    case BREAKFAST
    case DINNER
    case CAR_RENTAL
}

struct Expense {
    var type: ExpenseType
    var amount: Int
}

class ExpenseReport {
    func printReport(expenses: [Expense]) {
        var mealExpenses = 0
        var total = 0
        print("Expense Report \(Date())")
        for expense in expenses {
            if (expense.type == ExpenseType.DINNER || expense.type == ExpenseType.BREAKFAST) {
                mealExpenses += expense.amount
            }

            var expenseName = ""
            switch (expense.type) {
            case .BREAKFAST: expenseName = "Breakfast"
            case .DINNER: expenseName = "Dinner"
            case .CAR_RENTAL: expenseName = "Car Rental"
            }

            let mealOverExpensesMarker = expense.type == ExpenseType.DINNER && expense.amount > 5000 || expense.type == ExpenseType.BREAKFAST && expense.amount > 1000 ? "X" : " "
            print("\(expenseName)\t\(expense.amount)\t\(mealOverExpensesMarker)")

            total += expense.amount
        }
        print("Meal Expenses: \(mealExpenses)")
        print("Total Expenses:\(total)")
    }
}
