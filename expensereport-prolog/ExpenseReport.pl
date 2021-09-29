expense(Type, Amount, [Type, Amount]).

print_report([X|Y], Meals, Total) :-
    expense(Type, Amount, X),
    ((Type = dinner; Type = breakfast) -> NMeals is Meals + Amount; NMeals is Meals),

    (Type = dinner -> Name = 'Dinner';
    Type = breakfast -> Name = 'Breakfast';
    Type = car_rental -> Name = 'Car Rental'),

    ((Type = dinner, Amount > 5000; Type = breakfast, Amount > 1000) -> Marker = 'X'; Marker = ' '),

    format('~a\t~a\t~a~n', [Name, Amount, Marker]),
    NTotal is Total + Amount,
    print_report(Y, NMeals, NTotal).

print_report([], Meals, Total) :-
    format('Meal expenses: ~a~n', [Meals]),
    format('Total expenses: ~a~n', [Total]).

print_report(X) :-
    format('Expenses: ~a~n', ['']),
    print_report(X, 0, 0).

main() :-
    print_report([
        [dinner, 5000],
        [dinner, 5001],
        [breakfast, 1000],
        [breakfast, 1001],
        [car_rental, 4]
    ]).
