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
    Lunch:     ExpenseType = ( name: 'Lunch';      limit:  2000; isMeal: true;  );
    TAB: STRING = #9;
    NL: STRING = #10;

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

FUNCTION header(): STRING;
BEGIN
    header := 'Expenses: ' + FormatDateTime('YYYY-MM-DD hh:mm:ss', Now) + NL;
END;

FUNCTION overLimitMarker(exp: Expense): STRING;
BEGIN
    IF (isOverLimit(exp)) THEN overLimitMarker := 'X' ELSE overLimitMarker := ' ';
END;

FUNCTION detail(exp: Expense): STRING;
BEGIN
    detail := getName(exp) + TAB + IntToStr(exp.amount) + TAB + overLimitMarker(exp) + NL;
END;

FUNCTION details(expenses: ARRAY OF Expense): STRING;
VAR exp: Expense;
BEGIN
    details := '';
    FOR exp IN expenses DO
    BEGIN
        details := details + detail(exp);
    END;
END;

FUNCTION summary(expenses: ARRAY OF Expense): STRING;
BEGIN
    summary :=
        'Meal expenses: ' + IntToStr(sumMeals(expenses)) + NL +
        'Total expenses: ' + IntToStr(sumTotal(expenses)) + NL;
END;

FUNCTION report(expenses: ARRAY OF Expense): STRING;
BEGIN
    report := header() + details(expenses) + summary(expenses);
END;

PROCEDURE printReport(expenses: ARRAY OF Expense);
BEGIN
    write(report(expenses));
END;


VAR expenses: ARRAY [1 .. 7] OF Expense;
BEGIN
    expenses[1].type_ := @Dinner;    expenses[1].amount := 5000;
    expenses[2].type_ := @Dinner;    expenses[2].amount := 5001;
    expenses[3].type_ := @Breakfast; expenses[3].amount := 1000;
    expenses[4].type_ := @Breakfast; expenses[4].amount := 1001;
    expenses[5].type_ := @CarRental; expenses[5].amount :=    4;
    expenses[6].type_ := @Lunch;     expenses[6].amount := 2000;
    expenses[7].type_ := @Lunch;     expenses[7].amount := 2001;
    printReport(expenses);
END.
