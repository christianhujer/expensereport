export type ExpenseType = 'dinner' | 'breakfast' | 'car-rental'

export class Expense {
  constructor(public type: ExpenseType, public amount: number) {
      this.type = type
      this.amount = amount
  }
}