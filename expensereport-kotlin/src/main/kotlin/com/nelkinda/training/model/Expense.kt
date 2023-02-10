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
        if (expense.type == ExpenseType.DINNER && expense.amount > ExpenseType.DINNER.expenseLimit ||
            expense.type == ExpenseType.BREAKFAST && expense.amount > ExpenseType.BREAKFAST.expenseLimit) {
            return "X"
        }
        return " "
    }
}

