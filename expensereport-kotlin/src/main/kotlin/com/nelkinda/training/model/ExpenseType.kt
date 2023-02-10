package com.nelkinda.training.model

enum class ExpenseType(val stringName: String, val expenseLimit: Int) {
    DINNER("Dinner", 5000),
    BREAKFAST("Breakfast", 1000),
    CAR_RENTAL("Car Rental", 0),
    LUNCH("Lunch", 2000)
}