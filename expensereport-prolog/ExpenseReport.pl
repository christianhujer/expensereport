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
get_amount(Expense, Amount) :- expense(Expense, _, Amount).

print_report(Expenses) :-
    generate_report(Expenses, Report),
    write(Report).

generate_report(Expenses, Report) :-
    report_header(Header),
    report_details(Expenses, Details),
    report_summary(Expenses, Summary),
    atomic_list_concat([Header, Details, Summary], '', Report).

report_header(Header) :-
    get_time(Time),
    stamp_date_time(Time, Date, 'UTC'),
    format_time(atom(TS), '%FT%T%z', Date, posix),
    format(string(Header), 'Expenses: ~a~n', [TS]).

report_details(Expenses, Details) :-
    maplist(report_detail, Expenses, Detail),
    atomic_list_concat(Detail, '', Details).

report_detail(Expense, Detail) :-
    expense(Expense, Type, Amount),
    expense_type(Type, Name, _),
    is_over_limit_marker(Expense, Marker),
    format(string(Detail), '~a\t~a\t~a~n', [Name, Amount, Marker]).

is_over_limit_marker(Expense, 'X') :- is_over_limit(Expense).
is_over_limit_marker(Expense, ' ') :- not(is_over_limit(Expense)).

report_summary(Expenses, Summary) :-
    sum_meals(Meals, Expenses),
    sum_total(Total, Expenses),
    format(string(Summary), 'Meal expenses: ~a~nTotal expenses: ~a~n', [Meals, Total]).

sum_meals(Sum, Expenses) :- include(is_meal, Expenses, Meals), sum_total(Sum, Meals).
sum_total(Sum, Expenses) :- maplist(get_amount, Expenses, Amounts), foldl(plus, Amounts, 0, Sum).

test() :-
    sum_meals(0, []),
    sum_total(0, []),
    sum_meals(11, [[dinner, 1], [breakfast, 2], [car_rental, 4], [lunch, 8]]),
    sum_total(15, [[dinner, 1], [breakfast, 2], [car_rental, 4], [lunch, 8]]),
    is_over_limit([dinner, 5001]),
    is_over_limit([breakfast, 1001]),
    is_over_limit([lunch, 2001]),
    not(is_over_limit([dinner, 5000])),
    not(is_over_limit([breakfast, 1000])),
    not(is_over_limit([lunch, 2000])),
    not(is_over_limit([car_rental, inf])),
    !.

main() :-
    test(),
    print_report([
        [dinner, 5000],
        [dinner, 5001],
        [breakfast, 1000],
        [breakfast, 1001],
        [car_rental, 4],
        [lunch, 2000],
        [lunch, 2001]
    ]).
