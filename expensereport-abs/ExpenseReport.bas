DINNER = 0: BREAKFAST = 1: CARRENTAL = 2
DIM type(5), amount(5)
type(0) = DINNER: amount(0) = 5000
type(1) = DINNER: amount(1) = 5001
type(2) = BREAKFAST: amount(2) = 1000
type(3) = BREAKFAST: amount(3) = 1001
type(4) = CARRENTAL: amount(4) = 4
GOSUB PrintExpenses
END

PrintExpenses:
    meals = 0
    total = 0
    PRINT "Expensereport: " DATE$
    FOR i=0 TO 4
        IF type(i) = DINNER OR type(i) = BREAKFAST THEN meals = meals + amount(i)
        expenseName$ = ""
        IF type(i) = DINNER THEN expenseName$ = "Dinner"
        IF type(i) = BREAKFAST THEN expenseName$ = "Breakfast"
        IF type(i) = CARRENTAL THEN expenseName$ = "Car Rental"
        IF type(i) = DINNER AND amount(i) > 5000 OR type(i) = BREAKFAST AND amount(i) > 1000 THEN mealOverExpensesMarker$ = "X" ELSE mealOverExpensesMarker$ = " "
        PRINT expenseName$ CHR$(9) STR$(amount(i)) CHR$(9) mealOverExpensesMarker$
        total = total + amount(i)
    NEXT i
    PRINT "Meal Expenses:" STR$(meals)
    PRINT "Total Expenses:" STR$(total)
    RETURN
