import { Expense } from './expense'
import { ExpenseType } from './expense'

const isMeal = (type: ExpenseType): boolean =>
  type === 'dinner' || type === 'breakfast'

export type Totals = {
  totalExpenses: number
  mealExpenses: number
}

export const accumulateTotals = (
  totals: Totals,
  expense: Expense
): Totals => {
  const totalExpenses = totals.totalExpenses + expense.amount
  const mealExpenses = isMeal(expense.type)
    ? totals.mealExpenses + expense.amount
    : totals.mealExpenses

  return { totalExpenses, mealExpenses }
}
