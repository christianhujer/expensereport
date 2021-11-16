#!/usr/bin/env julia

using Dates

@enum ExpenseType begin
    BREAKFAST
    DINNER
    CAR_RENTAL
end

struct Expense
    type::ExpenseType
    amount::Int64
end


function printReport(expenses)
    mealExpenses = 0
    total = 0
    println("Expenses: ", Dates.now())
    for expense in expenses
        if expense.type == BREAKFAST || expense.type == DINNER
            mealExpenses += expense.amount
        end
        expenseName = ""
        if expense.type == BREAKFAST
            expenseName = "Breakfast"
        elseif expense.type == DINNER
            expenseName = "Dinner"
        elseif expense.type == CAR_RENTAL
            expenseName = "Car Rental"
        end
        mealOverExpensesMarker = expense.type == DINNER && expense.amount > 5000 || expense.type == BREAKFAST && expense.amount > 1000 ? "X" : " "
        println(expenseName, "\t", expense.amount, "\t", mealOverExpensesMarker)
        total += expense.amount
    end
    println("Meal expenses: ", mealExpenses)
    println("Total expenses: ", total)
end

printReport([
    Expense(BREAKFAST, 1000),
    Expense(BREAKFAST, 1001),
    Expense(DINNER, 5000),
    Expense(DINNER, 5001),
    Expense(CAR_RENTAL, 4),
])
