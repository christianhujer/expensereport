#!/usr/bin/perl

package ExpenseType;

sub new {
    my $class = shift;
    my $self = {
        'name' => shift,
        'limit' => shift,
        'isMeal' => shift,
    };
    bless $self, $class;
    $self;
}

use constant {
    DINNER      => new ExpenseType("Dinner",        5000,   1),
    BREAKFAST   => new ExpenseType("Breakfast",     1000,   1),
    CAR_RENTAL  => new ExpenseType("Car Rental",   ~0>>1,   0),
    LUNCH       => new ExpenseType("Lunch",         2000,   1),
};


package Expense;

sub new {
    my $class = shift;
    my $self = {
        'type' => shift,
        'amount' => shift,
    };
    bless $self, $class;
    $self;
}

sub getName() {
    shift->{'type'}->{'name'};
}

sub isMeal() {
    shift->{'type'}->{'isMeal'};
}

sub isOverLimit() {
    my $self = shift;
    $self->{'amount'} > $self->{'type'}->{'limit'};
}


package ExpenseReport;

sub printReport(@) {
    print report(@_);
}

sub report(@) {
    header() . details(@_) . summary(@_);
}

sub header() {
    "Expenses: ".localtime()."\n";
}

sub detail($) {
    my $expense = shift;
    my $mealOverExpensesMarker = $expense->isOverLimit() ? "X" : " ";
    $expense->getName()."\t".$expense->{'amount'}."\t$mealOverExpensesMarker\n";
}

sub details(@) {
    my $details = "";
    $details .= detail($_) for @_;
    $details;
}

sub summary(@) {
    "Meal Expenses: ".sumMeals(@_)."\n".
    "Total Expenses: ".sumTotal(@_)."\n";
}

sub sumMeals(@) {
    my $mealExpenses = 0;
    $mealExpenses += $_->{'amount'} * $_->isMeal() for @_;
    $mealExpenses;
}

sub sumTotal(@) {
    my $total = 0;
    $total += $_->{'amount'} for @_;
    $total;
}

printReport(
    new Expense(ExpenseType::DINNER, 5000),
    new Expense(ExpenseType::DINNER, 5001),
    new Expense(ExpenseType::BREAKFAST, 1000),
    new Expense(ExpenseType::BREAKFAST, 1001),
    new Expense(ExpenseType::CAR_RENTAL, 4),
    new Expense(ExpenseType::LUNCH, 2000),
    new Expense(ExpenseType::LUNCH, 2001),
);
