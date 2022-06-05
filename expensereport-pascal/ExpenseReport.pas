PROGRAM ExpenseReport;

USES sysutils;

TYPE
    ExpenseType = RECORD
        name: string;
        limit: INTEGER;
        isMeal: BOOLEAN;
    END;
    Expense = RECORD
        type_: ^ ExpenseType;
        amount: integer;
    END;

CONST
    Dinner:    ExpenseType = ( name: 'Dinner';     limit:  5000; isMeal: true;  );
    Breakfast: ExpenseType = ( name: 'Breakfast';  limit:  1000; isMeal: true;  );
    CarRental: ExpenseType = ( name: 'Car Rental'; limit: 32767; isMeal: false; );
    Lunch:     ExpenseType = ( name: 'Lunch';      limit:  2000; isMeal: true; );

FUNCTION isMeal(exp: Expense): BOOLEAN;
BEGIN
    isMeal := exp.type_^.isMeal;
END;

FUNCTION getName(exp: Expense): STRING;
BEGIN
    getName := exp.type_^.name;
END;

FUNCTION isOverLimit(exp: Expense): BOOLEAN;
BEGIN
    isOverLimit := exp.amount > exp.type_^.limit;
END;

FUNCTION sumTotal(expenses: ARRAY OF Expense): INTEGER;
VAR exp: Expense;
BEGIN
    sumTotal := 0;
    FOR exp IN expenses DO
    BEGIN
        sumTotal := sumTotal + exp.amount;
    END;
END;

FUNCTION sumMeals(expenses: ARRAY OF Expense): INTEGER;
VAR exp : Expense;
BEGIN
    sumMeals := 0;
    FOR exp IN expenses DO
    BEGIN
        IF (isMeal(exp)) THEN sumMeals := sumMeals + exp.amount;
    END;
END;

PROCEDURE printHeader();
BEGIN
    writeln('Expenses: ', FormatDateTime('YYYY-MM-DD hh:mm:ss', Now));
END;

FUNCTION overLimitMarker(exp: Expense): string;
BEGIN
    IF (isOverLimit(exp)) THEN overLimitMarker := 'X' ELSE overLimitMarker := ' ';
END;

PROCEDURE printDetails(expenses: ARRAY OF Expense);
VAR exp: Expense;
BEGIN
    FOR exp IN expenses DO
    BEGIN
        writeln(getName(exp), #9, exp.amount, #9, overLimitMarker(exp));
    END;
END;

PROCEDURE printSummary(expenses: ARRAY OF Expense);
BEGIN
    writeln('Meal expenses: ', sumMeals(expenses));
    writeln('Total expenses: ', sumTotal(expenses));
END;

PROCEDURE printReport(expenses: ARRAY OF Expense);
BEGIN
    printHeader();
    printDetails(expenses);
    printSummary(expenses);
END;


VAR expenses: ARRAY [1 .. 7] OF Expense;
BEGIN
    expenses[1].type_ := @Dinner; expenses[1].amount := 5000;
    expenses[2].type_ := @Dinner; expenses[2].amount := 5001;
    expenses[3].type_ := @Breakfast; expenses[3].amount := 1000;
    expenses[4].type_ := @Breakfast; expenses[4].amount := 1001;
    expenses[5].type_ := @CarRental; expenses[5].amount := 4;
    expenses[6].type_ := @Lunch; expenses[6].amount := 2000;
    expenses[7].type_ := @Lunch; expenses[7].amount := 2001;
    printReport(expenses);
END.
