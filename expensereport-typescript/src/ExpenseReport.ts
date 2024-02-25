const message = 'Hello, World!\n'

const sumTwoValues = (a: number, b: number): number => a + b

const printHelloWorld = (): void => {
  process.stdout.write(message)
}

interface IExpenseType {
  name: string;
  limit: number;
  isMeal: boolean;
}

enum ExpenseType {
  DINNER = 'Dinner',
  BREAKFAST = 'Breakfast',
  CAR_RENTAL = 'Car Rental',
}


class Expense {
  type: ExpenseType
  amount: number

  constructor(type: ExpenseType, amount: number) {
    this.type = type
    this.amount = amount
  }
}

function printReportOn(date: string, expenses: Expense[]) {
  process.stdout.write('Expenses: ' + date + '\n')

  let totalExpenses: number = 0
  let mealExpenses: number = 0


  for (const expense of expenses) {
    if (expense.type == ExpenseType.DINNER || expense.type == ExpenseType.BREAKFAST) {
      mealExpenses += expense.amount
    }

    let expenseName = ''
    switch (expense.type) {
      case ExpenseType.DINNER:
        expenseName = 'Dinner'
        break
      case ExpenseType.BREAKFAST:
        expenseName = 'Breakfast'
        break
      case ExpenseType.CAR_RENTAL:
        expenseName = 'Car Rental'
        break
    }

    let mealOverExpensesMarker = expense.type == ExpenseType.DINNER && expense.amount > 5000 || expense.type == ExpenseType.BREAKFAST && expense.amount > 1000 ? 'X' : ' '

    process.stdout.write(expenseName + '\t' + expense.amount + '\t' + mealOverExpensesMarker + '\n')

    totalExpenses += expense.amount
  }

  process.stdout.write('Meal Expenses: ' + mealExpenses + '\n')
  process.stdout.write('Total Expenses: ' + totalExpenses + '\n')
}

function printReport(expenses: Expense[]): void {
  printReportOn(new Date().toISOString(), expenses)
}

export { sumTwoValues, printHelloWorld, printReport, Expense, ExpenseType }
