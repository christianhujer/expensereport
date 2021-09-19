#!/usr/bin/tclsh

set DINNER 1
set BREAKFAST 2
set CAR_RENTAL 3

::oo::class create Expense {
    variable Type
    variable Amount

    constructor {type amount} {
        set Type $type
        set Amount $amount
    }

    method amount {} {
        return $Amount
    }

    method type {} {
        return $Type
    }
}

proc printExpenses { args } {
    set expenses $args
    set total 0
    set mealExpenses 0
    set now [clock format [clock seconds] -format "%Y-%m-%d %H:%M:%S"]
    puts "Expenses: $now"
    foreach expense $expenses {
        if {[$expense type] == 1} {
            set mealExpenses [expr { $mealExpenses + [$expense amount]}]
        }
        set expenseName ""
        switch [$expense type] {
            1 { set expenseName "Dinner" }
            2 { set expenseName "Breakfast" }
            3 { set expenseName "Car Rental" }
        }
        if {[$expense type] == 1 && [$expense amount] > 5000 || [$expense type] == 2 && [$expense amount] > 1000} {
            set mealOverExpensesMarker "X"
        } else {
            set mealOverExpensesMarker " "
        }
        set amount [$expense amount]
        puts "$expenseName\t$amount\t$mealOverExpensesMarker"
        set total [expr { $total + [$expense amount]}]
    }
    puts "Meal Expenses: $mealExpenses"
    puts "Total Expenses: $total"
}
