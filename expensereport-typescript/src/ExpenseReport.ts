const message = 'Hello, World!\n';
import { printMessage } from "./printMessage";


const sumTwoValues = (a: number, b: number): number => a + b

const printHelloWorld = (): void => {
  printMessage(message);
}

type ExpenseType = "dinner" | "breakfast" | "car-rental"

class Expense {
  type: ExpenseType
  amount: number
  constructor(type: ExpenseType, amount: number) {
    this.type = type
    this.amount = amount
  }
}

const isMeal = (type: ExpenseType): boolean => type === "dinner" || type === "breakfast";


const expenseNameType = (type: ExpenseType): string => {
  switch (type) {
    case "dinner":   return "Dinner"
    case "breakfast":  return "Breakfast"
    case "car-rental": return "Car Rental"
  }
}

const isMealOverExpense = (expense: Expense): boolean =>
  (expense.type === "dinner" && expense.amount > 5000) ||
  (expense.type === "breakfast" && expense.amount > 1000);

const overExpenseMarker = (expense: Expense): string =>
  isMealOverExpense(expense) ? "X" : " ";


const reportDate = (date: Date): string => date.toISOString().substr(0, 10);






function printReport(expenses: Expense[]) {
  let totalExpenses: number = 0
  let mealExpenses: number = 0

  printMessage("Expenses: " + reportDate(new Date()) + "\n")

  for (const expense of expenses) {

  if (isMeal(expense.type)) {
  mealExpenses += expense.amount
   }


  const expenseName = expenseNameType(expense.type);

  const mealOverExpensesMarker = overExpenseMarker(expense);

    printMessage(expenseName + "\t" + expense.amount + "\t" + mealOverExpensesMarker + "\n")

    totalExpenses += expense.amount
  }

  printMessage("Meal Expenses: " + mealExpenses + "\n")
  printMessage("Total Expenses: " + totalExpenses + "\n")
}

export {sumTwoValues, printHelloWorld, printReport, Expense, ExpenseType}
