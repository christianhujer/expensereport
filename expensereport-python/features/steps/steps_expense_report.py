from behave import *
from expense_report import ExpenseReport, Expense, ExpenseTypes
import locale
from datetime import datetime


@when("generating a report for the following expenses")
def step_impl(context):
    expenses = list(
        map(
            lambda row: Expense(ExpenseTypes.value_of(row["type"]), int(row["amount"])),
            context.table,
        )
    )
    context.timestamp = datetime.now()
    ExpenseReport().print_report(expenses, context.timestamp)
    context.captured_stdout = context.stdout_capture.getvalue()


@then("the report MUST look like this")
def step_impl(context):
    expected = (
        context.text.replace(
            "$now", context.timestamp.strftime(locale.nl_langinfo(locale.D_T_FMT))
        )
        .replace("\\t", "\t")
        .replace("\\s", " ")
    )
    assert expected == context.captured_stdout
