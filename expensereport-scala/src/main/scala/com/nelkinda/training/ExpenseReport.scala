package com.nelkinda.training

import java.util.Date

class ExpenseType {
}

object ExpenseType {
    val DINNER = new ExpenseType()
    val BREAKFAST = new ExpenseType()
    val CAR_RENTAL = new ExpenseType()
}

class Expense(val `type`: ExpenseType, val amount: Int)


class ExpenseReport {
    def printReport(expenses: List[Expense]) {
        var total = 0
        var mealExpenses = 0

        println(s"Expense Report: ${new Date()}")

        for (expense <- expenses) {
            if (expense.`type` == ExpenseType.DINNER || expense.`type` == ExpenseType.BREAKFAST) {
                mealExpenses += expense.amount
            }

            var expenseName = expense.`type` match {
                case ExpenseType.DINNER => "Dinner"
                case ExpenseType.BREAKFAST => "Breakfast"
                case ExpenseType.CAR_RENTAL => "Car Rental"
            }

            var mealOverExpensesMarker = if (expense.`type` == ExpenseType.DINNER && expense.amount > 5000 || expense.`type` == ExpenseType.BREAKFAST && expense.amount > 1000) "X" else " "

            println(s"${expenseName}\t${expense.amount}\t${mealOverExpensesMarker}")

            total += expense.amount
        }

        println(s"Meal Expenses: ${mealExpenses}")
        println(s"Total Expenses: ${total}")
    }
}
