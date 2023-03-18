const int intMaxValue = 9223372036854775807;

enum ExpenseType {
  DINNER(name: "Dinner", limit: 5000),
  BREAKFAST(name: "Breakfast", limit: 1000),
  CAR_RENTAL(name: "Car Rental", limit: intMaxValue, isMeal: false);

  final int limit;
  final String name;
  final bool isMeal;

  const ExpenseType(
      {required this.name, required this.limit, this.isMeal = true});
}

class Expense {
  ExpenseType type = ExpenseType.DINNER;
  int amount = 0;

  String get name => type.name;
  bool get exceedsLimit => amount > type.limit;

  Expense(ExpenseType type, int amount) {
    this.type = type;
    this.amount = amount;
  }
}

class ExpenseReport {
  int _getMealExpense(List<Expense> expenses) {
    return expenses
        .where((e) => (e.type.isMeal))
        .fold(0, (a, b) => a + b.amount);
  }

  int _getTotalExpense(List<Expense> expenses) {
    return expenses.fold(0, (a, b) => a + b.amount);
  }

  String _getHeader(DateTime date) {
    return 'Expense Report: $date\n';
  }

  String _getSingleExpenseReport(Expense expense) {
    var mealOverExpensesMarker = expense.exceedsLimit ? "X" : "";
    return '${expense.name}\t${expense.amount}\t$mealOverExpensesMarker\n';
  }

  String _getBody(List<Expense> expenses) {
    return expenses.map((e) => _getSingleExpenseReport(e)).join("");
  }

  String _getMealExpenseReport(List<Expense> expenses) {
    var mealExpenses = _getMealExpense(expenses);
    return 'Meal Expenses: $mealExpenses\n';
  }

  String _getTotalExpenseReport(List<Expense> expenses) {
    var totalExpenses = _getTotalExpense(expenses);
    return 'Total Expenses: $totalExpenses\n';
  }

  String _getFooter(List<Expense> expenses) {
    return _getMealExpenseReport(expenses) + _getTotalExpenseReport(expenses);
  }

  String _getFormattedReport(List<Expense> expenses) {
    var date = DateTime.now();
    return _getHeader(date) + _getBody(expenses) + _getFooter(expenses);
  }

  void printReport(List<Expense> expenses) {
    print(_getFormattedReport(expenses));
  }
}
