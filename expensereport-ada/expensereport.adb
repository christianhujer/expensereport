with Text_IO, Text_IO.Unbounded_IO, Ada.Command_Line, Ada.Strings.Unbounded, Ada.Strings.Fixed, Ada.Characters.Latin_1;
use Text_IO, Text_IO.Unbounded_IO, Ada.Command_Line, Ada.Strings.Unbounded;

procedure expensereport is
    type ExpenseType is tagged record
        name: Unbounded_String;
        limit: Integer;
        isMeal: Boolean;
    end record;

    type Expense is tagged record
        eType: ExpenseType;
        amount: Integer;
    end record;

    Dinner:    constant ExpenseType := (To_Unbounded_String("Dinner"),     5000, true);
    Breakfast: constant ExpenseType := (To_Unbounded_String("Breakfast"),  1000, true);
    CarRental: constant ExpenseType := (To_Unbounded_String("Car Rental"), 2147483647, false);
    Lunch:     constant ExpenseType := (To_Unbounded_String("Lunch"),      2000, true);

    type ExpenseList is array(Positive range <>) of Expense;

    function isMeal(exp: Expense) return Boolean is
    begin
        return exp.eType.isMeal;
    end;

    function getName(exp: Expense) return Unbounded_String is
    begin
        return exp.eType.name;
    end;

    function isOverLimit(exp: Expense) return Boolean is
    begin
        return exp.amount > exp.eType.limit;
    end;

    function sumMeals(expenses: in ExpenseList) return Integer is
        meals : Integer := 0;
    begin
        meals := 0;
        for i in expenses'Range loop
            if (isMeal(expenses(i))) then
                meals := meals + expenses(i).amount;
            end if;
        end loop;
        return meals;
    end;

    function sumTotal(expenses: in ExpenseList) return Integer is
        total : Integer := 0;
    begin
        total := 0;
        for i in expenses'Range loop
            total := total + expenses(i).amount;
        end loop;
        return total;
    end;

    procedure printHeader is
    begin
        Put_Line("Expenses:");
    end printHeader;

    function overLimitMarker(exp: Expense) return Character is
    begin
        if (isOverLimit(exp)) then
            return 'X';
        else
            return ' ';
        end if;
    end;

    procedure printDetail(exp: Expense) is
    begin
        Put_Line(getName(exp) & Ada.Characters.Latin_1.HT & Ada.Strings.Fixed.Trim(Integer'Image(exp.amount), Ada.Strings.Left) & Ada.Characters.Latin_1.HT & overLimitMarker(exp));
    end printDetail;

    procedure printDetails(expenses: in ExpenseList) is
    begin
        for i in expenses'Range loop
            printDetail(expenses(i));
        end loop;
    end printDetails;

    procedure printSummary(expenses: in ExpenseList) is
    begin
        Put_Line("Meal expenses:" & Integer'Image(sumMeals(expenses)));
        Put_Line("Total expenses:" & Integer'Image(sumTotal(expenses)));
    end printSummary;

    procedure printReport(expenses: in ExpenseList) is
    begin
        printHeader;
        printDetails(expenses);
        printSummary(expenses);
    end printReport;

    expenses : ExpenseList := (
        (Dinner, 5000),
        (Dinner, 5001),
        (Breakfast, 1000),
        (Breakfast, 1001),
        (CarRental, 4),
        (Lunch, 2000),
        (Lunch, 2001)
    );
begin
    printReport(expenses);
end expensereport;
