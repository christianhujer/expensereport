DINNER = 0: BREAKFAST = 0: CARRENTAL = 0
DIM type(5), amount(5)
type(0) = DINNER: amount(0) = 5000
type(1) = DINNER: amount(1) = 5001
type(2) = DINNER: amount(2) = 1000
type(3) = DINNER: amount(3) = 1001
type(4) = DINNER: amount(4) = 4
GOSUB PrintExpenses
END

PrintExpenses:
    PRINT "Expensereport: " $DATE
    meals = 0
    total = 0
    FOR i=0 TO 4
        IF type(i) = DINNER or type(i) = BREAKFAST THEN meals = meals + amount(i)
        expenseName$ = ""
        IF type(i) = DINNER THEN expenseName$ = "Dinner"
        IF type(i) = BREAKFAST THEN expenseName$ = "BREAKFAST"
        IF type(i) = CARRENTAL THEN expenseName$ = "Car Rental"
        IF type(i) = DINNER AND amount(i) > 5000 OR type(i) = BREAKFAST AND amount(i) > 1000 THEN mealOverExpensesMarker$ = "X" ELSE mealOverExpensesMarker$ = " "
        PRINT expenseName$, amount(i), mealOverExpensesMarker$
        total = total + amount(i)
    NEXT i
    PRINT "Meal Expenses: ", meals
    PRINT "Total Expenses: ", total
    RETURN
