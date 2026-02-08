import { printMessage } from './printMessage'
import { sumTwoValues } from './mathUtils'
import { printHelloWorld } from './helloWorldMessage'
import { expenseNameType } from './expenseName'
import { Expense, ExpenseType } from './expense'


const isMeal = (type: ExpenseType): boolean => type === 'dinner' || type === 'breakfast'


const isMealOverExpense = (expense: Expense): boolean =>
  (expense.type === 'dinner' && expense.amount > 5000) ||
  (expense.type === 'breakfast' && expense.amount > 1000)

const overExpenseMarker = (expense: Expense): string => (isMealOverExpense(expense) ? 'X' : ' ')

const reportDate = (date: Date): string => date.toISOString().substr(0, 10)

const formatExpenseLine = (expense: Expense): string => {
  const expenseName = expenseNameType(expense.type)
  const marker = overExpenseMarker(expense)
  return `${expenseName}\t${expense.amount}\t${marker}\n`
}

function printReport(expenses: Expense[]) {
  let totalExpenses: number = 0
  let mealExpenses: number = 0

  printMessage('Expenses: ' + reportDate(new Date()) + '\n')

  for (const expense of expenses) {
    if (isMeal(expense.type)) {
      mealExpenses += expense.amount
    }
    printMessage(formatExpenseLine(expense))

    totalExpenses += expense.amount
  }

  printMessage('Meal Expenses: ' + mealExpenses + '\n')
  printMessage('Total Expenses: ' + totalExpenses + '\n')
}

export { sumTwoValues, printHelloWorld, printReport, Expense, ExpenseType }
