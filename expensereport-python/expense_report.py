import locale
from enum import Enum, unique, auto
from datetime import datetime
from typing import List


@unique
class ExpenseType(Enum):
    DINNER = auto()
    BREAKFAST = auto()
    CAR_RENTAL = auto()


class Expense:
    type: ExpenseType
    amount: int


class ExpenseReport:
    def print_report(self, expenses: List[Expense]):
        total = 0
        meals = 0

        print("Expense Report", datetime.now().strftime(locale.nl_langinfo(locale.D_T_FMT)))

        for expense in expenses:
            if expense.type == ExpenseType.DINNER or expense.type == ExpenseType.BREAKFAST:
                meals += expense.amount

            name = ""
            if expense.type == ExpenseType.DINNER:
                name = "Dinner"
            elif expense.type == ExpenseType.BREAKFAST:
                name = "Breakfast"
            elif expense.type == ExpenseType.CAR_RENTAL:
                name = "Car Rental"

            meal_over_expenses_marker = "X" if expense.type == ExpenseType.DINNER and expense.amount > 5000 or expense.type == ExpenseType.BREAKFAST and expense.amount > 1000 else " "
            print(name, "\t", expense.amount, "\t", meal_over_expenses_marker)
            total += expense.amount

        print("Meals:", meals)
        print("Total:", total)
