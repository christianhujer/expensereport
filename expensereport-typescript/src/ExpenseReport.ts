import { printMessage } from './printMessage'
import { sumTwoValues } from './mathUtils'
import { printHelloWorld } from './helloWorldMessage'
import { expenseNameType } from './expenseName'
import { Expense, ExpenseType } from './expense'
import { accumulateTotals, Totals } from './expenseTotals'
import { EXPENSE_CONFIG } from './expenseConfig'


const isMealOverExpense = (expense: Expense): boolean => {
  const limit = EXPENSE_CONFIG[expense.type].overLimit
  return limit !== undefined && expense.amount > limit
}

const overExpenseMarker = (expense: Expense): string => (isMealOverExpense(expense) ? 'X' : ' ')

const reportDate = (date: Date): string => date.toISOString().slice(0, 10)

const formatExpenseLine = (expense: Expense): string => {
  const { label } = EXPENSE_CONFIG[expense.type]
  const marker = overExpenseMarker(expense)
  return `${label}\t${expense.amount}\t${marker}\n`
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
