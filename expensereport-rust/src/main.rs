use chrono;

enum ExpenseType {
    Dinner, Breakfast, CarRental
}

struct Expense {
    type_: ExpenseType,
    amount: i32,
}

fn print_report(expenses: &[Expense]) {
    let mut meal_expenses = 0;
    let mut total = 0;

    println!("Expense Report {}", chrono::offset::Utc::now());

    for expense in expenses {
        match expense.type_ {
            ExpenseType::Dinner => meal_expenses += expense.amount,
            ExpenseType::Breakfast => meal_expenses += expense.amount,
            _ => (),
        }

        let expense_name: &str;
        match expense.type_ {
            ExpenseType::Dinner => expense_name = "Dinner",
            ExpenseType::Breakfast => expense_name = "Breakfast",
            ExpenseType::CarRental => expense_name = "Car Rental",
        }

        let meal_over_expenses_marker = if matches!(expense.type_, ExpenseType::Dinner) && expense.amount > 5000 || matches!(expense.type_, ExpenseType::Breakfast) && expense.amount > 1000 { "X" }  else { " " };

        println!("{}\t{}\t{}", expense_name, expense.amount, meal_over_expenses_marker);
        total += expense.amount;
    }

    println!("Meal Expenses: {}", meal_expenses);
    println!("Total Expenses: {}", total);
}

fn main() {
}

#[cfg(test)]
mod tests {
    #[test]
    fn characterize_print_report() {

    }
}
