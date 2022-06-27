import locale
import sys
from datetime import datetime
from dataclasses import dataclass


@dataclass(frozen=True)
class ExpenseType:
    name: str
    limit: int
    is_meal: bool


# pylint: disable=too-few-public-methods
class ExpenseTypes:
    DINNER = ExpenseType("Dinner", 5000, True)
    BREAKFAST = ExpenseType("Breakfast", 1000, True)
    CAR_RENTAL = ExpenseType("Car Rental", sys.maxsize, False)
    LUNCH = ExpenseType("Lunch", 2000, True)

    @classmethod
    def value_of(cls, name: str):
        return getattr(cls, name)


@dataclass(frozen=True)
class Expense:
    expenseType: ExpenseType
    amount: int

    def name(self):
        return self.expenseType.name

    def is_meal(self):
        return self.expenseType.is_meal

    def is_over_limit(self):
        return self.amount > self.expenseType.limit


class ExpenseReport:
    def print_report(self, expenses: list[Expense], timestamp=datetime.now()):
        print(self.generate_report(expenses, timestamp), end="")

    def generate_report(self, expenses: list[Expense], timestamp=datetime.now()):
        return self.header(timestamp) + self.body(expenses) + self.summary(expenses)

    def header(self, timestamp):
        return f"Expenses {timestamp.strftime(locale.nl_langinfo(locale.D_T_FMT))}\n"

    def body(self, expenses: list[Expense]):
        return "".join(map(self.detail, expenses))

    def detail(self, expense: Expense):
        over_limit_marker = "X" if expense.is_over_limit() else " "
        return f"{expense.name()}\t{expense.amount}\t{over_limit_marker}\n"

    def summary(self, expenses: list[Expense]):
        return (
            f"Meal expenses: {self.sum_meals(expenses)}\n"
            f"Total expenses: {self.sum_total(expenses)}\n"
        )

    def sum_total(self, expenses: list[Expense]):
        return sum(map(lambda e: e.amount, expenses))

    def sum_meals(self, expenses: list[Expense]):
        return sum(map(lambda e: e.amount, filter(Expense.is_meal, expenses)))
