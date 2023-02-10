package com.nelkinda.training.model

class Expense(
    val type: ExpenseType,
    val amount: Int = 0
){
    fun isExpenseTypeAMeal(): Boolean {
        if (type == ExpenseType.CAR_RENTAL) {
            return false
        }
        return true
    }

    fun flagIfOverLimit(): String {
        if (isExpenseTypeAMeal() && amount > type.expenseLimit) {
            return "X"
        }
        return " "
    }
}

