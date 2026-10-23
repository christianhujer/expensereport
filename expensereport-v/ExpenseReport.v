import time

enum ExpenseType {
	dinner
	breakfast
	car_rental
}

struct Expense {
	typ    ExpenseType
	amount int
}

fn print_report(expenses []Expense) {
	mut total := 0
	mut meal_expenses := 0

	println('Expenses ${time.now().custom_format('YYYY-MM-DD')}')

	for expense in expenses {
		if expense.typ == .dinner || expense.typ == .breakfast {
			meal_expenses += expense.amount
		}

		expense_name := match expense.typ {
			.dinner { 'Dinner' }
			.breakfast { 'Breakfast' }
			.car_rental { 'Car Rental' }
		}

		meal_over_expenses_marker := if (expense.typ == .dinner && expense.amount > 5000) || (expense.typ == .breakfast && expense.amount > 1000) { 'X' } else { ' ' }

		println('${expense_name}\t${expense.amount}\t${meal_over_expenses_marker}')

		total += expense.amount
	}

	println('Meal expenses: ${meal_expenses}')
	println('Total expenses: ${total}')
}

fn main() {
	expenses := [
		Expense{ typ: .dinner, amount: 5000 },
		Expense{ typ: .dinner, amount: 5001 },
		Expense{ typ: .breakfast, amount: 1000 },
		Expense{ typ: .breakfast, amount: 1001 },
		Expense{ typ: .car_rental, amount: 4 },
	]
	print_report(expenses)
}
