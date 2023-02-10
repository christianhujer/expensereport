package com.nelkinda.training

import com.nelkinda.training.model.Expense
import com.nelkinda.training.model.ExpenseType
import com.nelkinda.training.model.ExpenseType.*
import com.nelkinda.training.model.FinalExpense
import java.util.Date

class ExpenseReport {
    fun printReport(expenses: List<Expense>) {
        println("Expenses ${Date()}")

        val finalExpense = getTotalAndMealExpenses(expenses)
        val mealExpenses = finalExpense.mealExpense
        val total = finalExpense.total

        println("Meal expenses: $mealExpenses")
        println("Total expenses: $total")
    }

    fun getTotalAndMealExpenses(
        expenses: List<Expense>
    ): FinalExpense {
        var mealExpenses = 0
        var total = 0

        for (expense in expenses) {
            var mealOverExpensesMarker = " "
            if (expense.isExpenseTypeAMeal) {
                mealExpenses += expense.amount
                mealOverExpensesMarker = expense.mealExpenseOverLimit
            }
            println(expense.type.stringName + "\t" + expense.amount + "\t" + mealOverExpensesMarker)

            total += expense.amount
        }
        return FinalExpense(mealExpenses, total)
    }

}
