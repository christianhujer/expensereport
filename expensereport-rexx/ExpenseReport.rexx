/* Expense Report */
DINNER = 0; BREAKFAST = 1; CAR_RENTAL = 2

expense.0.type = DINNER; expense.0.amount = 5000
expense.1.type = DINNER; expense.1.amount = 5001
expense.2.type = BREAKFAST; expense.2.amount = 1000
expense.3.type = BREAKFAST; expense.3.amount = 1001
expense.4.type = CAR_RENTAL; expense.4.amount = 4

CALL printReport
EXIT 0

printReport:
    total = 0
    mealExpenses = 0

    SAY "Expenses:" DATE() TIME()

    DO i = 0 TO 4
        IF expense.i.type = DINNER | expense.i.type = BREAKFAST THEN mealExpenses = mealExpenses + expense.i.amount

        expenseName = ""
        SELECT
            WHEN expense.i.type = DINNER THEN expenseName = "Dinner"
            WHEN expense.i.type = BREAKFAST THEN expenseName = "Breakfast"
            WHEN expense.i.type = CAR_RENTAL THEN expenseName = "Car Rental"
        END

        IF expense.i.type = DINNER & expense.i.amount > 5000 | expense.i.type = BREAKFAST & expense.i.amount > 1000 THEN mealOverExpensesMarker = "X"
        ELSE mealOverExpensesMarker = " "

        SAY expenseName expense.i.amount mealOverExpensesMarker

        total = total + expense.i.amount
    END

    SAY "Meal expenses:" mealExpenses
    SAY "Total expenses:" total
    RETURN
