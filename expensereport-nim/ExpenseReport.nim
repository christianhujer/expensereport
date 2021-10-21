type
  ExpenseType = enum DINNER, BREAKFAST, CAR_RENTAL
  Expense = tuple[expenseType: ExpenseType, amount: int]

proc printReport(expenses: seq[Expense]) =
  var meals: int = 0
  var total: int = 0
  echo "Expense Report"
  for i, expense in expenses:
    if expense.expenseType == DINNER or expense.expenseType == BREAKFAST:
      meals += expense.amount
    var name: string = ""
    case expense.expenseType
    of DINNER: name = "Dinner"
    of BREAKFAST: name = "Breakfast"
    of CAR_RENTAL: name = "Car Rental"
    let mealOverExpensesMarker = if expense.expenseType == DINNER and expense.amount > 5000 or expense.expenseType == BREAKFAST and expense.amount > 1000: "X" else: " "
    echo name, "\t", expense.amount, "\t", mealOverExpensesMarker
    total += expense.amount
  echo "Meal expenses: ", meals
  echo "Total expenses: ", total

printReport(@[(expenseType: DINNER, amount: 5000), (expenseType: DINNER, amount: 5001), (expenseType: BREAKFAST, amount: 1000), (expenseType: BREAKFAST, amount: 1001), (expenseType: CAR_RENTAL, amount: 4)])
