package com.nelkinda.training

import com.nelkinda.training.model.Expense
import com.nelkinda.training.model.ExpenseType
import com.nelkinda.training.model.ExpenseType.*
import java.util.Date

class ExpenseReport {
    fun printReport(expenses: List<Expense>) {
        var total = 0
        var mealExpenses = 0

        println("Expenses ${Date()}")

        for (expense in expenses) {
            var mealOverExpensesMarker = " "
            if (isExpenseTypeAMeal(expense.type)) {
                mealExpenses += expense.amount
                mealOverExpensesMarker = flagIfOverLimit(expense)
            }


            println(expense.type.stringName + "\t" + expense.amount + "\t" + mealOverExpensesMarker)

            total += expense.amount
        }

        println("Meal expenses: $mealExpenses")
        println("Total expenses: $total")
    }

    private fun flagIfOverLimit(expense: Expense): String {
        if (expense.type == DINNER && expense.amount > DINNER.expenseLimit || expense.type == BREAKFAST && expense.amount > BREAKFAST.expenseLimit) {
            return "X"
        }
        return " "
    }

    private fun isExpenseTypeAMeal(expenseType: ExpenseType): Boolean {
        if (expenseType == CAR_RENTAL) {
            return false
        }
        return true
    }
}
