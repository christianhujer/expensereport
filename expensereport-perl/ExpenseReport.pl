#!/usr/bin/perl

package Expense;

use constant {
    DINNER => 1,
    BREAKFAST => 2,
    CAR_RENTAL => 3,
};

sub new {
    my $class = shift;
    my $self = {
        'type' => shift,
        'amount' => shift
    };
    bless $self, $class;
    return $self;
}

sub printReport(@) {
    my @expenses = @_;
    my $mealExpenses = 0;
    my $total = 0;
    my $datestring = localtime();
    print "Expenses: $datestring\n";
    for my $expense (@expenses) {
        if ($expense->{'type'} == DINNER or $expense->{'type'} == BREAKFAST) {
            $mealExpenses += $expense->{'amount'};
        }

        my $expenseName = "";
        if ($expense->{'type'} == DINNER) {
            $expenseName = "Dinner";
        } elsif ($expense->{'type'} == BREAKFAST) {
            $expenseName = "Breakfast";
        } elsif ($expense->{'type'} == CAR_RENTAL) {
            $expenseName = "Car Rental";
        }

        my $mealOverExpensesMarker = $expense->{'type'} == DINNER && $expense->{'amount'} > 5000 || $expense->{'type'} == BREAKFAST && $expense->{'amount'} > 1000 ? "X" : " ";

        print "$expenseName\t".$expense->{'amount'}."\t$mealOverExpensesMarker\n";
        $total += $expense->{'amount'};
    }
    print "Meal Expenses: $mealExpenses\n";
    print "Total Expenses: $total\n";
}

printReport(new Expense(CAR_RENTAL, 5), new Expense(DINNER, 5000), new Expense(BREAKFAST, 1001), new Expense(CAR_RENTAL, 4));
