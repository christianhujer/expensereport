const message = 'Hello, World!\n';

const sumTwoValues = (a: number, b: number): number => a + b

const printHelloWorld = (): void => {
  process.stdout.write(message);
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

  process.stdout.write("Expenses: " + reportDate(new Date()) + "\n")

  for (const expense of expenses) {

  if (isMeal(expense.type)) {
  mealExpenses += expense.amount
   }


  const expenseName = expenseNameType(expense.type);

  const mealOverExpensesMarker = overExpenseMarker(expense);

    process.stdout.write(expenseName + "\t" + expense.amount + "\t" + mealOverExpensesMarker + "\n")

    totalExpenses += expense.amount
  }

  process.stdout.write("Meal Expenses: " + mealExpenses + "\n")
  process.stdout.write("Total Expenses: " + totalExpenses + "\n")
}

export {sumTwoValues, printHelloWorld, printReport, Expense, ExpenseType}
