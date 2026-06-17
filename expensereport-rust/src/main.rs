use chrono;

struct ExpenseType {
    name: &'static str,
    limit: i32,
    is_meal: bool,
}

const DINNER: ExpenseType = ExpenseType {name: "Dinner", limit: 5000, is_meal: true};
const BREAKFAST: ExpenseType = ExpenseType {name: "Breakfast", limit: 1000, is_meal: true};
const CAR_RENTAL: ExpenseType = ExpenseType {name: "Car Rental", limit: i32::MAX, is_meal: false};
const LUNCH: ExpenseType = ExpenseType {name: "Lunch", limit: 2000, is_meal: true};

struct Expense {
    type_: ExpenseType,
    amount: i32,
}

impl Expense {
    fn get_name(&self) -> &str {
        self.type_.name
    }

    fn is_over_limit(&self) -> bool {
        self.amount > self.type_.limit
    }

    fn is_meal(&self) -> bool {
        self.type_.is_meal
    }
}

fn print_report(expenses: &[Expense]) {
    println!("Expense Report {}", chrono::offset::Utc::now());

    for expense in expenses {
        let expense_name = expense.get_name();
        let expense_over_limit_marker = if expense.is_over_limit() { "X" } else { " " };

        println!("{}\t{}\t{}", expense_name, expense.amount, expense_over_limit_marker);
    }

    println!("Meal Expenses: {}", sum_meal_expenses(expenses));
    println!("Total Expenses: {}", sum_expenses(expenses));
}

fn sum_expenses(expenses: &[Expense]) -> i32 {
    sum_filtered_expenses(expenses, |_| { true })
}

fn sum_meal_expenses(expenses: &[Expense]) -> i32 {
    sum_filtered_expenses(expenses, |expense: &&Expense| { expense.is_meal() })
}

fn sum_filtered_expenses(expenses: &[Expense], predicate: fn(&&Expense) -> bool) -> i32 {
    expenses.iter()
        .filter(predicate)
        .map(|expense| { expense.amount })
        .sum()
}

fn main() {
    print_report(&[
        Expense{ type_: DINNER, amount: 1},
        Expense{ type_: DINNER, amount: 5000},
        Expense{ type_: DINNER, amount: 5001},
        Expense{ type_: BREAKFAST, amount: 2},
        Expense{ type_: BREAKFAST, amount: 1000},
        Expense{ type_: BREAKFAST, amount: 1001},
        Expense{ type_: CAR_RENTAL, amount: 4},
        Expense{ type_: LUNCH, amount: 8},
        Expense{ type_: LUNCH, amount: 2000},
        Expense{ type_: LUNCH, amount: 2001},
    ]);
}

#[cfg(test)]
mod tests {
    // use crate::{print_report, Expense, ExpenseType};

    #[test]
    fn characterize_print_report() {
        // print_report(&[Expense{ type_: ExpenseType::Dinner, amount: 1000}]);
        // assert_eq!()
    }
}
