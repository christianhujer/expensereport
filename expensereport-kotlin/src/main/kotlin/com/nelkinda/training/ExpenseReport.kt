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
            val pair = calculateExpenseAndFlagIfOverLimit(expense, mealExpenses, total)
            mealExpenses = pair.first
            total = pair.second
        }

        println("Meal expenses: $mealExpenses")
        println("Total expenses: $total")
    }

    private fun calculateExpenseAndFlagIfOverLimit(
        expense: Expense,
        mealExpenses: Int,
        total: Int
    ): Pair<Int, Int> {
        var mealExpenses1 = mealExpenses
        var total1 = total
        var mealOverExpensesMarker = " "
        if (expense.isExpenseTypeAMeal(expense.type)) {
            mealExpenses1 += expense.amount
            mealOverExpensesMarker = expense.flagIfOverLimit(expense)
        }
        println(expense.type.stringName + "\t" + expense.amount + "\t" + mealOverExpensesMarker)

        total1 += expense.amount
        return Pair(mealExpenses1, total1)
    }

}
