expense([Type, Amount], Type, Amount).

expense_type(dinner, 'Dinner', 5000).
expense_type(breakfast, 'Breakfast', 1000).
expense_type(car_rental, 'Car Rental', inf).
expense_type(lunch, 'Lunch', 2000).
is_meal(dinner).
is_meal(breakfast).
is_meal(lunch).

is_meal(Expense) :- expense(Expense, Type, _), is_meal(Type).
is_over_limit(Expense) :- expense(Expense, Type, Amount), expense_type(Type, _, Limit), Amount > Limit.

print_report(Expenses) :-
    print_header(),
    print_details(Expenses),
    print_summary(Expenses).

print_header() :-
    get_time(Time),
    stamp_date_time(Time, Date, 'UTC'),
    format_time(atom(TS), '%FT%T%z', Date, posix),
    format('Expenses: ~a~n', [TS]).

print_details([Expense|Expenses]) :-
    expense(Expense, Type, Amount),
    expense_type(Type, Name, _),
    is_over_limit_marker(Expense, Marker),
    format('~a\t~a\t~a~n', [Name, Amount, Marker]),
    print_details(Expenses).
print_details([]).

is_over_limit_marker(Expense, 'X') :- is_over_limit(Expense).
is_over_limit_marker(Expense, ' ') :- not(is_over_limit(Expense)).

print_summary(Expenses) :-
    print_meal_expenses(Expenses),
    print_total_expenses(Expenses).

print_meal_expenses([Expense|Expenses], Meals) :-
    is_meal(Expense),
    expense(Expense, _, Amount),
    NMeals is Meals + Amount,
    print_meal_expenses(Expenses, NMeals).
print_meal_expenses([Expense|Expenses], Meals) :-
    not(is_meal(Expense)),
    print_meal_expenses(Expenses, Meals).
print_meal_expenses([], Meals) :-
    format('Meal expenses: ~a~n', [Meals]).
print_meal_expenses(Expenses) :- print_meal_expenses(Expenses, 0).

print_total_expenses([Expense|Expenses], Total) :-
    expense(Expense, _, Amount),
    NTotal is Total + Amount,
    print_total_expenses(Expenses, NTotal).
print_total_expenses([], Total) :-
    format('Total expenses: ~a~n', [Total]).
print_total_expenses(Expenses) :- print_total_expenses(Expenses, 0).

main() :-
    print_report([
        [dinner, 5000],
        [dinner, 5001],
        [breakfast, 1000],
        [breakfast, 1001],
        [car_rental, 4],
        [lunch, 2000],
        [lunch, 2001]
    ]).
