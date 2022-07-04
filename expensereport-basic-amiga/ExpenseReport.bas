DIM SHARED DINNER, BREAKFAST, CARRENTAL
DINNER = 0: BREAKFAST = 1: CARRENTAL = 2: LUNCH = 3

DIM SHARED names$(3), limits(3), isMeal(3)
names$(0) = "Dinner":     limits(0) = 5000:  isMeal(0) = 1
names$(1) = "Breakfast":  limits(1) = 1000:  isMeal(1) = 1
names$(2) = "Car Rental": limits(2) = 65535: isMeal(2) = 0
names$(3) = "Lunch":      limits(3) = 2000:  isMeal(3) = 1

DEF FNisOverLimit(t, a) = a > limits(t)

DIM SHARED mealOverExpensesMarker$(1)
mealOverExpensesMarker$(0) = " "
mealOverExpensesMarker$(1) = "X"
DEF FNmealOverExpensesMarker$(t, a) = mealOverExpensesMarker$(-FNisOverLimit(t, a))
DEF FNdetail$(t, a) = names$(t) + CHR$(9) + STR$(a) + CHR$(9) + FNmealOverExpensesMarker$(t, a)

DEF FNHeader$(n) = "Expenses: " + DATE$

SUB PrintExpenses(type(), amount()) STATIC
    CALL PrintHeader
    CALL PrintDetails(type(), amount())
    CALL PrintSummary(type(), amount())
END SUB

SUB PrintHeader STATIC
    PRINT FNHeader$(0)
END SUB

SUB PrintDetails(type(), amount()) STATIC
    FOR i=LBOUND(type) TO UBOUND(type)
        PRINT FNdetail$(type(i), amount(i))
    NEXT i
END SUB

SUB PrintSummary(type(), amount()) STATIC
    total = 0
    mealExpenses = 0

    FOR i=LBOUND(type) TO UBOUND(type)
        IF isMeal(type(i)) THEN
            mealExpenses = mealExpenses + amount(i)
        END IF
        total = total + amount(i)
    NEXT i

    PRINT "Meal Expenses:"  STR$(mealExpenses)
    PRINT "Total Expenses:" STR$(total)
END SUB

DIM type(6), amount(6)
type(0) = DINNER: amount(0) = 5000
type(1) = DINNER: amount(1) = 5001
type(2) = BREAKFAST: amount(2) = 1000
type(3) = BREAKFAST: amount(3) = 1001
type(4) = CARRENTAL: amount(4) = 4
type(5) = LUNCH: amount(5) = 2000
type(6) = LUNCH: amount(6) = 2001
CALL PrintExpenses(type(), amount())
END
