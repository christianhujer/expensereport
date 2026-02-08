import { printMessage } from './printMessage'
import { sumTwoValues } from './mathUtils'
import { printHelloWorld } from './helloWorldMessage'
import { expenseNameType } from './expenseName'
import { Expense, ExpenseType } from './expense'
import { accumulateTotals, Totals } from './expenseTotals'


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

   let totals: Totals = { totalExpenses: 0, mealExpenses: 0 }
  printMessage('Expenses: ' + reportDate(new Date()) + '\n')

 for (const expense of expenses) {
    totals = accumulateTotals(totals, expense)
    printMessage(formatExpenseLine(expense))
  }

  printMessage(`Meal Expenses: ${totals.mealExpenses}\n`)
  printMessage(`Total Expenses: ${totals.totalExpenses}\n`)
}

export { sumTwoValues, printHelloWorld, printReport, Expense, ExpenseType }
