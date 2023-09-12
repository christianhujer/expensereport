import '../lib/expensereport.dart';

void main(List<String> arguments) {
  var expenseReport = ExpenseReport();
  expenseReport.printReport([
    Expense(ExpenseType.DINNER, 1),
    Expense(ExpenseType.BREAKFAST, 2),
    Expense(ExpenseType.CAR_RENTAL, 4),
    Expense(ExpenseType.DINNER, 5000),
    Expense(ExpenseType.DINNER, 5001),
    Expense(ExpenseType.BREAKFAST, 1000),
    Expense(ExpenseType.BREAKFAST, 1001),
  ]);
}
