package com.nelkinda.training.model

class Expense(
    val type: ExpenseType,
    val amount: Int = 0
){
    fun isExpenseTypeAMeal(expenseType: ExpenseType): Boolean {
        if (expenseType == ExpenseType.CAR_RENTAL) {
            return false
        }
        return true
    }

    fun flagIfOverLimit(expense: Expense): String {
        if (isExpenseTypeAMeal(type) && amount > type.expenseLimit) {
            return "X"
        }
        return " "
    }
}

