package com.nelkinda.training

import com.nelkinda.training.model.Expense
import com.nelkinda.training.model.ExpenseType
import com.nelkinda.training.model.ExpenseType.*
import java.util.Date

class ExpenseReport {
    fun printReport(expenses: List<Expense>) {
        println("Expenses ${Date()}")

        val pair1 = getTotalAndMealExpenses(expenses)
        val mealExpenses = pair1.first
        val total = pair1.second

        println("Meal expenses: $mealExpenses")
        println("Total expenses: $total")
    }

    private fun getTotalAndMealExpenses(
        expenses: List<Expense>
    ): Pair<Int, Int> {
        var mealExpenses = 0
        var total = 0

        for (expense in expenses) {
            var mealOverExpensesMarker = " "
            if (expense.isExpenseTypeAMeal(expense.type)) {
                mealExpenses += expense.amount
                mealOverExpensesMarker = expense.flagIfOverLimit(expense)
            }
            println(expense.type.stringName + "\t" + expense.amount + "\t" + mealOverExpensesMarker)

            total += expense.amount
        }
        return Pair(mealExpenses, total)
    }

}
