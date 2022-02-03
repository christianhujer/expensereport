package com.nelkinda.training

import com.nelkinda.training.ExpenseType.*
import java.time.Clock
import java.time.LocalDateTime
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import java.time.format.FormatStyle
import java.util.*

enum class ExpenseType {
    DINNER, BREAKFAST, CAR_RENTAL
}

class Expense {
    lateinit var type: ExpenseType
    var amount: Int = 0

    fun isMeal() =
        type == DINNER || type == BREAKFAST

    val name
        get() = when (type) {
            DINNER -> "Dinner"
            BREAKFAST -> "Breakfast"
            CAR_RENTAL -> "Car Rental"
        }

    fun isOverLimit() =
        type == DINNER && amount > 5000 || type == BREAKFAST && amount > 1000
}

class ExpenseReport(
    private val clock: Clock = Clock.systemDefaultZone()
) {
    fun printReport(expenses: List<Expense>) {
        printReport(expenses, Date.from(clock.instant()).toString())
    }

    fun printReport(expenses: List<Expense>, date: String) {
        println("Expenses $date")

        for (expense in expenses) {
            val expenseName = expense.name
            val mealOverExpensesMarker = if (expense.isOverLimit()) "X" else " "
            println(expenseName + "\t" + expense.amount + "\t" + mealOverExpensesMarker)
        }

        println("Meal expenses: ${expenses.sumMeals()}")
        println("Total expenses: ${expenses.sumTotal()}")
    }

    private fun List<Expense>.sumTotal(): Int = sumOf { it.amount }
    private fun List<Expense>.sumMeals(): Int = filter { it.isMeal() }.sumOf { it.amount }
}
