package org.nelkinda.training

import java.lang.Integer.MAX_VALUE
import java.util.Date

enum class ExpenseType(
    val name_: String,
    val limit: Int,
    val isMeal: Boolean,
) {
    DINNER("Dinner", 5000, true),
    BREAKFAST("Breakfast", 1000, true),
    CAR_RENTAL("Car Rental", MAX_VALUE, false),
    LUNCH("Lunch", 2000, true),
    ;
}

class Expense(
    private val type: ExpenseType,
    val amount: Int,
) {
    val name: String get() = type.name_
    val isMeal: Boolean get() = type.isMeal
    fun isOverLimit() = amount > type.limit
}

class ExpenseReport {
    fun printReport(expenses: List<Expense>, timestamp: Date = Date()) = print(expenses.generateReport(timestamp))

    private fun List<Expense>.generateReport(timestamp: Date) = header(timestamp) + body() + summary()

    private fun header(timestamp: Date) = "Expenses $timestamp\n"

    private fun List<Expense>.body() = joinToString(separator = "") { it.detail() }
    private fun Expense.detail() = "$name\t$amount\t$overLimitMarker\n"
    private val Expense.overLimitMarker get() = if (isOverLimit()) "X" else " "

    private fun List<Expense>.summary() = "Meal expenses: ${sumMeals()}\nTotal expenses: ${sumAll()}\n"
    private fun List<Expense>.sumAll() = sumOf { it.amount }
    private fun List<Expense>.sumMeals() = filter { it.isMeal }.sumAll()
}
