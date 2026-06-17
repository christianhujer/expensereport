/* Expense Report */
expenseType.DINNER.name = "Dinner"
expenseType.DINNER.limit = 5000
expenseType.DINNER.isMeal = 1
expenseType.BREAKFAST.name = "Breakfast"
expenseType.BREAKFAST.limit = 1000
expenseType.BREAKFAST.isMeal = 1
expenseType.CAR_RENTAL.name = "Car Rental"
expenseType.CAR_RENTAL.limit = 65535
expenseType.CAR_RENTAL.isMeal = 0
expenseType.LUNCH.name = "Lunch"
expenseType.LUNCH.limit = 2000
expenseType.LUNCH.isMeal = 1

expense.0 = 7
expense.1.type = DINNER; expense.1.amount = 5000
expense.2.type = DINNER; expense.2.amount = 5001
expense.3.type = BREAKFAST; expense.3.amount = 1000
expense.4.type = BREAKFAST; expense.4.amount = 1001
expense.5.type = CAR_RENTAL; expense.5.amount = 4
expense.6.type = LUNCH; expense.6.amount = 2000
expense.7.type = LUNCH; expense.7.amount = 2001

CALL printReport
EXIT 0

printReport:
    CALL printHeader
    CALL printDetails
    CALL printSummary
    RETURN

printHeader:
    SAY "Expenses:" DATE() TIME()
    RETURN

printDetail:
    typ = expense.i.type
    expenseName = expenseType.typ.name
    IF expense.i.amount > expenseType.typ.limit THEN mealOverExpensesMarker = "X"
    ELSE mealOverExpensesMarker = " "
    SAY expenseName expense.i.amount mealOverExpensesMarker
    RETURN

printDetails:
    DO i = 1 TO expense.0
        CALL printDetail
    END
    RETURN

printSummary:
    SAY "Meal expenses:" sumMeals()
    SAY "Total expenses:" sumTotal()
    RETURN

sumMeals:
    meals = 0
    DO i = 1 TO expense.0
        typ = expense.i.type
        IF expenseType.typ.isMeal THEN meals = meals + expense.i.amount
    END
    RETURN meals

sumTotal:
    total = 0
    DO i = 1 TO expense.0
        total = total + expense.i.amount
    END
    RETURN total
