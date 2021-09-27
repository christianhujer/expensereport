10 DINNER = 0: BREAKFAST = 1: CARRENTAL = 2
20 DIM type(4): DIM amount(4)
30 type[0] = DINNER: amount[0] = 5000
40 type[1] = DINNER: amount[1] = 5001
50 type[2] = BREAKFAST: amount[2] = 1000
60 type[3] = BREAKFAST: amount[3] = 1001
70 type[4] = CARRENTAL: amount[4] = 4
80 GOSUB 100
90 END
100 REM PrintReport
110 meals = 0: total = 0
120 PRINT "Expenses:"
130 FOR i = 0 TO 4
140 IF type[i] = 0 OR type[i] = 1 THEN meals = meals + amount[i]
150 expenseName$ = ""
160 IF type[i] = 0 THEN expenseName$ = "Dinner"
170 IF type[i] = 1 THEN expenseName$ = "Breakfast"
180 IF type[i] = 2 THEN expenseName$ = "Car Rental"
190 IF type[i] = 0 AND amount[i] > 5000 OR type[i] = 1 AND amount[i] > 1000 THEN mealOverExpensesMarker$ = "X" ELSE mealOverExpensesMarker$ = " "
200 PRINT expenseName$, amount[i], mealOverExpensesMarker$
210 total = total + amount[i]
220 NEXT i
230 PRINT "Meal expenses:", meals
240 PRINT "Total expenses:", total
250 RETURN
