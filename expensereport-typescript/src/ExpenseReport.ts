const message = 'Hello, World!\n'

const sumTwoValues = (a: number, b: number): number => a + b

const printHelloWorld = (): void => {
  process.stdout.write(message)
}

interface IExpenseType {
  name: string;
  limit: number;
  isMeal?: boolean;
}

enum ExpenseType {
  DINNER = 'Dinner',
  BREAKFAST = 'Breakfast',
  CAR_RENTAL = 'Car Rental',
}

const ExpenseTypes: Record<ExpenseType, IExpenseType> = {
  [ExpenseType.DINNER]: {name: 'Dinner', limit: 5000},
  [ExpenseType.BREAKFAST]: {name: 'Breakfast', limit: 1000},
  [ExpenseType.CAR_RENTAL]: {name: 'Car Rental', limit: Number.MAX_SAFE_INTEGER},
}

class Expense {
  type: ExpenseType
  amount: number

  constructor(type: ExpenseType, amount: number) {
    this.type = type
    this.amount = amount
  }

  isMeal(): boolean {
    return this.type == ExpenseType.DINNER || this.type == ExpenseType.BREAKFAST
  }

  getName(): string {
    return ExpenseTypes[this.type].name
  }

  isOverLimit(): boolean {
    return this.amount > ExpenseTypes[this.type].limit
  }

}

function printReport(expenses: Expense[]): void {
  printReportOn(new Date().toISOString(), expenses)
}

function printReportOn(date: string, expenses: Expense[]): void {
  process.stdout.write('Expenses: ' + date + '\n')

  let totalExpenses: number = 0
  let mealExpenses: number = 0


  for (const expense of expenses) {
    if (expense.isMeal()) {
      mealExpenses += expense.amount
    }
    let expenseName = expense.getName()

    let mealOverExpensesMarker = expense.isOverLimit() ? 'X' : ' '

    process.stdout.write(expenseName + '\t' + expense.amount + '\t' + mealOverExpensesMarker + '\n')

    totalExpenses += expense.amount
  }

  process.stdout.write('Meal Expenses: ' + mealExpenses + '\n')
  process.stdout.write('Total Expenses: ' + totalExpenses + '\n')
}


export { sumTwoValues, printHelloWorld, printReport, Expense, ExpenseType }
