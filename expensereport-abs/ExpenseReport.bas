DIM SHARED DINNER, BREAKFAST, CARRENTAL
DINNER = 0: BREAKFAST = 1: CARRENTAL = 2

DIM type(4), amount(4)
type(0) = DINNER: amount(0) = 5000
type(1) = DINNER: amount(1) = 5001
type(2) = BREAKFAST: amount(2) = 1000
type(3) = BREAKFAST: amount(3) = 1001
type(4) = CARRENTAL: amount(4) = 4
CALL PrintExpenses(type(), amount())
END

SUB PrintExpenses(type(), amount()) STATIC
    total = 0
    mealExpenses = 0

    PRINT "Expenses: " DATE$

    FOR i=LBOUND(type) TO UBOUND(type)
        IF type(i) = DINNER OR type(i) = BREAKFAST THEN
            mealExpenses = mealExpenses + amount(i)
        END IF

        expenseName$ = ""
        IF type(i) = DINNER THEN expenseName$ = "Dinner"
        IF type(i) = BREAKFAST THEN expenseName$ = "Breakfast"
        IF type(i) = CARRENTAL THEN expenseName$ = "Car Rental"

        IF type(i) = DINNER AND amount(i) > 5000 OR type(i) = BREAKFAST AND amount(i) > 1000 THEN mealOverExpensesMarker$ = "X" ELSE mealOverExpensesMarker$ = " "

        PRINT expenseName$ CHR$(9) STR$(amount(i)) CHR$(9) mealOverExpensesMarker$

        total = total + amount(i)
    NEXT i

    PRINT "Meal Expenses:" STR$(mealExpenses)
    PRINT "Total Expenses:" STR$(total)
END SUB
