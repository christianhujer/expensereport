package com.nelkinda.training.model

data class Expense(
    val type: ExpenseType,
    val amount: Int = 0
)

