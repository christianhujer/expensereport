import { ExpenseType } from './ExpenseReport'

const EXPENSE_NAME: Record<ExpenseType, string> = {
  dinner: 'Dinner',
  breakfast: 'Breakfast',
  'car-rental': 'Car Rental',
}

export const expenseNameType = (type: ExpenseType): string => {
  return EXPENSE_NAME[type]
}