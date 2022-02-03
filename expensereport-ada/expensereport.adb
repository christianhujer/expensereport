with Text_IO, Text_IO.Unbounded_IO, Ada.Command_Line, Ada.Strings.Unbounded, Ada.Strings.Fixed, Ada.Characters.Latin_1;
use Text_IO, Text_IO.Unbounded_IO, Ada.Command_Line, Ada.Strings.Unbounded;

procedure expensereport is
    type ExpenseType is (Breakfast, Dinner, CarRental);

    type Expense is tagged record
        eType: ExpenseType;
        amount: Integer;
    end record;

    type ExpenseList is array(Positive range <>) of Expense;

    procedure printReport(expenses: in ExpenseList) is
        total : Integer := 0;
        mealExpenses : Integer := 0;
        expenseName : Unbounded_String;
        mealOverExpensesMarker : Character := ' ';
    begin
        Put_Line("Expenses:");

        for i in expenses'Range loop
            if (expenses(i).eType = Breakfast or expenses(i).eType = Dinner) then
                mealExpenses := mealExpenses + expenses(i).amount;
            end if;

            expenseName := To_Unbounded_String("Foo" & "Foo");
            case expenses(i).eType is
                when Breakfast =>
                    expenseName := To_Unbounded_String("Breakfast");
                when Dinner =>
                    expenseName := To_Unbounded_String("Dinner");
                when CarRental =>
                    expenseName := To_Unbounded_String("Car Rental");
            end case;

            if ((expenses(i).eType = Breakfast and expenses(i).amount > 1000) or (expenses(i).eType = Dinner and expenses(i).amount > 5000)) then
                mealOverExpensesMarker := 'X';
            else
                mealOverExpensesMarker := ' ';
            end if;

            Put_Line(expenseName & Ada.Characters.Latin_1.HT & Ada.Strings.Fixed.Trim(Integer'Image(expenses(i).amount), Ada.Strings.Left) & Ada.Characters.Latin_1.HT & mealOverExpensesMarker);

            total := total + expenses(i).amount;
        end loop;

        Put_Line("Meal expenses:" & Integer'Image(mealExpenses));
        Put_Line("Total expenses:" & Integer'Image(total));
    end printReport;

    expenses : ExpenseList := (
        (Breakfast, 1),
        (Breakfast, 1)
    );
begin
    printReport(expenses);
end expensereport;
