# Fortran Solution

The Fotran Solution deserves some commentary.
The Fortran language has received many updates since its inception in 1957.
The language version used here is Fortran 2018.
Fortran 2018 offers object-oriented programming with polymorphism and even map-reduce.

The solution provided here has exactly the same structure as the solutions in other languages.
At the time I'm writing this, I had already provided solutions in C, C++, Golang, Java, Kotlin, and Rust.
The solution in Fortran has exactly the same structure.

In this structure, Fortran shows its age.
Compared with other languages, the price for a fine-grained structure is particularly high in Fortran.
The overall source code length approximately doubled.
This is a consequence of the verbosity of the Fotran language.
In Kotlin, trivial functions can conveniently be written as one-liners.
In Fortran, a trivial function requires at least 3 lines, and that also only in the simplest case when no arguments and no return value are involved.

However, I decided to still provide a solution with the same structure as in the other languages.
In the case of Fortran, the solution is not to demonstrate what is best.
Because in Fortran, this isn't.
In Fortran, this is just a practice exercise.
For real-world Fortran, we should rather find a balance that feels better supported by the language.
And that means avoiding tiny function.

However, note that the primary goal of the refactoring is achieved: It is possible to add new expense types without modifying existing functions.
All you need to do is add a `TYPE(expenseType) :: LUNCH = expenseType("Lunch", 2000, .TRUE.)` for example.
And this can also be achieved with fewer but larger functions, if you like.
