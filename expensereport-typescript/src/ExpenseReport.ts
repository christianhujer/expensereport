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

const ExpenseTypes: Record<ExpenseType, IExpenseType> = {
  [ExpenseType.DINNER]: {name: 'Dinner', limit: 5000, isMeal: true},
  [ExpenseType.BREAKFAST]: {name: 'Breakfast', limit: 1000, isMeal: true},
  [ExpenseType.CAR_RENTAL]: {name: 'Car Rental', limit: Number.MAX_SAFE_INTEGER, isMeal: false},
}

class Expense {
  type: ExpenseType
  amount: number

  constructor(type: ExpenseType, amount: number) {
    this.type = type
    this.amount = amount
  }

  isMeal(): boolean {
    return ExpenseTypes[this.type].isMeal
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
  printHeader(date)
  printDetails(expenses)
  printSummary(expenses)
}

function printHeader(date: string) {
  process.stdout.write('Expenses: ' + date + '\n')
}

function printDetails(expenses: Expense[]) {
  for (const expense of expenses) {
    process.stdout.write(expense.getName() + '\t' + expense.amount + '\t' + (expense.isOverLimit() ? 'X' : ' ') + '\n')
  }
}

function printSummary(expenses: Expense[]) {
  process.stdout.write('Meal Expenses: ' + sumMeal(expenses) + '\n')
  process.stdout.write('Total Expenses: ' + sumTotal(expenses) + '\n')
}

function sumMeal(expenses: Expense[]) {
  let mealExpenses: number = 0
  for (const expense of expenses) {
    if (expense.isMeal()) {
      mealExpenses += expense.amount
    }
  }
  return mealExpenses
}

function sumTotal(expenses: Expense[]) {
  let totalExpenses: number = 0
  for (const expense of expenses) {
    totalExpenses += expense.amount
  }
  return totalExpenses
}

export { sumTwoValues, printHelloWorld, printReport, Expense, ExpenseType }
