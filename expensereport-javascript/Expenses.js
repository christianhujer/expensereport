const process = require("node:process");

const type = {
  BREAKFAST: 1,
  DINNER: 2,
  CAR_RENTAL: 3
};

function expenseNameFactory (expense) {
  let expenseName;
  switch (expense.type) {
    case type.DINNER:
      expenseName = "Dinner";
      break;
    case type.BREAKFAST:
      expenseName = "Breakfast";
      break;
    case type.CAR_RENTAL:
      expenseName = "Car Rental";
      break;
  }
  return expenseName;
}

function calculateTotal (expenses) {
  let total = 0;
  for (const expense of expenses) {
    total += expense.amount;
  }
  return total;
}

function isMeal (expense) {
  return expense.type === type.DINNER || expense.type === type.BREAKFAST;
}

function calculateMealExpenses (expenses) {
  let mealExpenses = 0;
  for (const expense of expenses) {
    if (isMeal(expense)) {
      mealExpenses += expense.amount;
    }
  }
  return mealExpenses;
}

function shouldMark (expense) {
  return (expense.type === type.DINNER && expense.amount > 5000) || (expense.type === type.BREAKFAST && expense.amount > 1000);
}

function getMealOverExpensesMarker (expense) {
  return shouldMark(expense) ? "X" : " ";
}

function printReport (expenses) {
  const total = calculateTotal(expenses);
  const mealExpenses = calculateMealExpenses(expenses);

  process.stdout.write("Expenses " + new Date().toISOString().slice(0, 10) + "\n");

  for (const expense of expenses) {
    process.stdout.write(expenseNameFactory(expense) + "\t" + expense.amount + "\t" + getMealOverExpensesMarker(expense));
  }

  process.stdout.write("Meal expenses: " + mealExpenses);
  process.stdout.write("Total expenses: " + total);
}

module.exports = {
  printReport,
  type
};
