import gleam/int
import gleam/list.{fold}
import gleam/io.{println}
import birl/time

type ExpenseType {
  Dinner
  Breakfast
  CarRental
}

type Expense {
  Expense(expense_type: ExpenseType, amount: Int)
}

fn print_report(expenses: List(Expense)) {
  println("Expense Report: " <> time.to_http(time.now()))
  let [meal_expenses, total] =
    fold(
      expenses,
      [0, 0],
      fn(acc, expense) {
        let [meal_expenses, total] = acc
        let meal_expenses = case
          expense.expense_type == Dinner || expense.expense_type == Breakfast
        {
          True -> meal_expenses + expense.amount
          False -> meal_expenses
        }
        let expense_name = case expense.expense_type {
          Dinner -> "Dinner"
          Breakfast -> "Breakfast"
          CarRental -> "Car Rental"
        }
        let meal_over_expenses_marker = case
          expense.expense_type == Dinner && expense.amount > 5000 || expense.expense_type == Breakfast && expense.amount > 1000
        {
          True -> "X"
          False -> " "
        }
        println(
          expense_name <> "\t" <> int.to_string(expense.amount) <> "\t" <> meal_over_expenses_marker,
        )
        let total = total + expense.amount
        [meal_expenses, total]
      },
    )
  println("Meal Expenses: " <> int.to_string(meal_expenses))
  println("Total Expenses: " <> int.to_string(total))
}

pub fn main() {
  print_report([
    Expense(Dinner, 5000),
    Expense(Dinner, 5001),
    Expense(Breakfast, 1000),
    Expense(Breakfast, 1001),
    Expense(CarRental, 4),
  ])
}
