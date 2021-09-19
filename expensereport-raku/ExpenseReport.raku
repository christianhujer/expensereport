#!/usr/bin/rakudo

use v6;

enum ExpenseType <DINNER BREAKFAST CAR_RENTAL>;

class Expense {
    has ExpenseType $.type;
    has Int $.amount;
}

sub printReport(*@expenses) {
    my $mealExpenses = 0;
    my $total = 0;
    my $datestring = DateTime.now();
    print "Expenses: $datestring\n";
    for @expenses -> $expense {
        if ($expense.type == DINNER || $expense.type == BREAKFAST) {
            $mealExpenses += $expense.amount;
        }
        my $expenseName = "";
        given $expense.type {
            when DINNER { $expenseName = "Dinner"; }
            when BREAKFAST { $expenseName = "Breakfast"; }
            when CAR_RENTAL { $expenseName = "Car Rental"; }
        }
        my $amount = $expense.amount;
        my $mealOverExpensesMarker = $expense.type == DINNER && $expense.amount > 5000 ?? "X" !! " ";
        print "$expenseName\t$amount\t$mealOverExpensesMarker\n";
        $total += $expense.amount;
    }
    print "Meal Expenses: $mealExpenses\n";
    print "Total Expenses: $total\n";
}
