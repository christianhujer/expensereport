from expense_report import ExpenseReport, Expense, ExpenseTypes


# Press the green button in the gutter to run the script.
if __name__ == "__main__":
    ExpenseReport().print_report(
        [
            Expense(ExpenseTypes.DINNER, 5000),
            Expense(ExpenseTypes.DINNER, 5001),
            Expense(ExpenseTypes.BREAKFAST, 1000),
            Expense(ExpenseTypes.BREAKFAST, 1001),
            Expense(ExpenseTypes.CAR_RENTAL, 4),
        ]
    )

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
