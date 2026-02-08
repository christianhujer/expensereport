import { ExpenseType } from './expense'

export type ExpenseConfig = {
  label: string
  overLimit?: number
}


export const EXPENSE_CONFIG: Record<ExpenseType, ExpenseConfig> = {
  dinner: { label: 'Dinner', overLimit: 5000 },
  breakfast: { label: 'Breakfast', overLimit: 1000 },
  'car-rental': { label: 'Car Rental' },
   lunch: { label: 'Lunch', overLimit: 2000 },
}
