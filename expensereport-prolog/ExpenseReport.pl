expenseType(dinner, 'Dinner', 5000).
expenseType(breakfast, 'Breakfast', 1000).
expenseType(car_rental, 'Car Rental', 2000000000).
isMeal(dinner).
isMeal(breakfast).

expense(Type, Amount, [Type, Amount]).
mealAmount(Type, Amount, Result) :- isMeal(Type), Result is Amount.
mealAmount(_, _, Result) :- Result is 0.

print_report2([X|Y], Meals, Total) :-
    expense(Type, Amount, X),
    expenseType(Type, ExpenseName, Limit),
    mealAmount(Type, Amount, MealAmount),
    format('~a\t~a\t', [ExpenseName, Amount]),
    ( Amount > Limit -> writeln('X'); writeln(' ')),
    NMeals is Meals + MealAmount,
    NTotal is Total + Amount,
    print_report2(Y, NMeals, NTotal).

print_report2([], Meals, Total) :-
    format('Meal expenses: ~a~n', [Meals]),
    format('Total expenses: ~a~n', [Total]).

print_report(X) :-
    format('Expenses: ~a~n', ['']),
    print_report2(X, 0, 0).

main() :-
    print_report([
        [dinner, 5000],
        [dinner, 5001],
        [breakfast, 1000],
        [breakfast, 1001],
        [car_rental, 4]
    ]).
