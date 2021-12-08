import Foundation

enum ExpenseType {
    case breakfast
    case dinner
    case carRental
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
            if (expense.type == .dinner || expense.type == .breakfast) {
                mealExpenses += expense.amount
            }

            var expenseName = ""
            switch expense.type {
            case .breakfast: expenseName = "Breakfast"
            case .dinner: expenseName = "Dinner"
            case .carRental: expenseName = "Car Rental"
            }

            let mealOverExpensesMarker = expense.type == .dinner && expense.amount > 5000 || expense.type == .breakfast && expense.amount > 1000 ? "X" : " "
            print("\(expenseName)\t\(expense.amount)\t\(mealOverExpensesMarker)")

            total += expense.amount
        }
        print("Meal Expenses: \(mealExpenses)")
        print("Total Expenses: \(total)")
    }
}
