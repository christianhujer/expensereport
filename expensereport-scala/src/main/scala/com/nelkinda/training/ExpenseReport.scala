package com.nelkinda.training

import java.util.Date

enum ExpenseType:
  case DINNER, BREAKFAST, CAR_RENTAL

class Expense(
    val `type`: ExpenseType,
    val amount: Int
)

class ExpenseReport:
  def printReport(expenses: List[Expense]): Unit =
    var total = 0
    var mealExpenses = 0

    println("Expenses " + new Date())

    for (expense <- expenses)
      if (expense.`type` == ExpenseType.DINNER || expense.`type` == ExpenseType.BREAKFAST)
        mealExpenses += expense.amount

      var expenseName = ""
      expense.`type` match
        case ExpenseType.DINNER =>
          expenseName = "Dinner"
        case ExpenseType.BREAKFAST =>
          expenseName = "Breakfast"
        case ExpenseType.CAR_RENTAL =>
          expenseName = "Car Rental"

      val mealOverExpensesMarker =
        if (
          expense.`type` == ExpenseType.DINNER && expense.amount > 5000 ||
          expense.`type` == ExpenseType.BREAKFAST && expense.amount > 1000
        ) "X"
        else " "

      println(expenseName + "\t" + expense.amount + "\t" + mealOverExpensesMarker)

      total += expense.amount

    println("Meal expenses: " + mealExpenses)
    println("Total expenses: " + total)
