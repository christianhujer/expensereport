package com.nelkinda.training.model

class Expense(var type: ExpenseType, var amount: Int) {
    var isExpenseTypeAMeal: Boolean = false
    var mealExpenseOverLimit: String = " "

    init {
        this.isExpenseTypeAMeal = type != ExpenseType.CAR_RENTAL
        this.mealExpenseOverLimit = if(isExpenseTypeAMeal && amount > type.expenseLimit) "X" else " "
    }

}

