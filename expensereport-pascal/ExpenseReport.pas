PROGRAM ExpenseReport;

USES sysutils;

TYPE
    ExpenseType = (Dinner, Breakfast, CarRental);
    Expense = RECORD
        type_: ExpenseType;
        amount: integer;
    END;

PROCEDURE printReport(expenses: ARRAY OF Expense);
VAR total: integer = 0;
VAR mealExpenses: integer = 0;
VAR exp: Expense;
VAR expenseName: string;
VAR mealOverExpensesMarker: string;
BEGIN
    writeln('Expenses: ', FormatDateTime('YYYY-MM-DD hh:mm:ss', Now));
    FOR exp IN expenses DO
    BEGIN
        IF (exp.type_ = Dinner) OR (exp.type_ = Breakfast) THEN mealExpenses := mealExpenses + exp.amount;
        CASE (exp.type_) of
            Dinner: expenseName := 'Dinner';
            Breakfast: expenseName := 'Breakfast';
            CarRental: expenseName := 'Car Rental';
        END;
        IF (exp.type_ = Dinner) AND (exp.amount > 5000) OR (exp.type_ = Breakfast) AND (exp.amount > 1000) THEN mealOverExpensesMarker := 'X' ELSE mealOverExpensesMarker := ' ';
        writeln(expenseName, #9, exp.amount, #9, mealOverExpensesMarker);
        total := total + exp.amount;
    END;
    writeln('Meal expenses: ', mealExpenses);
    writeln('Total expenses: ', total);
END;


VAR expenses: ARRAY OF Expense;
BEGIN
    writeln('Hello, world!');
END.
