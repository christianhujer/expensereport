#!/usr/bin/gst -f

Object subclass: Expense [
    | type amount |
    Expense class >> type: type amount: amount [
        ^self new type: type; amount: amount; yourself
    ]
    type [ ^type ]
    type: value [ type := value ]
    amount [ ^amount ]
    amount: value [ amount := value ]
]

Object subclass: ExpenseReport [
    printReport: expenses [
        | mealExpenses total |
        mealExpenses := 0.
        total := 0.
        'Expenses:'  display.
        Date dateAndTimeNow displayNl.
        expenses do:[:expense |
            | expenseName mealOverExpensesMarker |
            ((expense type = 'Dinner') | (expense type = 'Breakfast'))
                 ifTrue: [ mealExpenses := mealExpenses + expense amount ].
            (expense type = 'Dinner') ifTrue: [ expenseName := 'Dinner' ].
            (expense type = 'Breakfast') ifTrue: [ expenseName := 'Breakfast' ].
            (expense type = 'Car Rental') ifTrue: [ expenseName := 'Car Rental' ].
            (((expense type = 'Dinner') & (expense amount > 5000)) | ((expense type = 'Breakfast') & (expense amount > 1000)))
                ifTrue: [ mealOverExpensesMarker := 'X' ]
                ifFalse: [ mealOverExpensesMarker := ' ' ].
            expenseName display.
            Character tab asString display.
            expense amount display.
            Character tab asString display.
            mealOverExpensesMarker displayNl.
            total := total + expense amount.
        ].
        'Meals: ' display.
        mealExpenses displayNl.
        'Total: ' display.
        total displayNl.
    ]
]

expenseReport := ExpenseReport new.
expenses := Set new.
expense1 := Expense type: 'Dinner' amount: 5000.
expense2 := Expense type: 'Dinner' amount: 5001.
expense3 := Expense type: 'Breakfast' amount: 1000.
expense4 := Expense type: 'Breakfast' amount: 1001.
expense5 := Expense type: 'Car Rental' amount: 4.

expenses add: expense1.
expenses add: expense2.
expenses add: expense3.
expenses add: expense4.
expenses add: expense5.

expenseReport printReport: expenses.
