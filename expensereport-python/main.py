from expense_report import ExpenseReport, Expense, ExpenseType


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    expense = Expense()
    expense.type = ExpenseType.DINNER
    expense.amount = 7500
    ExpenseReport().print_report([expense])

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
