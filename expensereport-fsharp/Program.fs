// vi: filetype=cs
open System

type ExpenseType = DINNER | BREAKFAST | CAR_RENTAL

type Expense(expenseType: ExpenseType, amount: int) =
    member this.expenseType = expenseType
    member this.amount = amount

let printReport (expenses: seq<Expense>) =
    let mutable total = 0
    let mutable mealExpenses = 0
    printfn "Expense Report: %s" (DateTime.Now.ToString())
    for expense in expenses do
        if (expense.expenseType = DINNER || expense.expenseType = BREAKFAST) then
            mealExpenses <- mealExpenses + expense.amount
        let mutable expenseName = ""
        match expense.expenseType with
        | DINNER -> expenseName <- "Dinner"
        | BREAKFAST -> expenseName <- "Breakfast"
        | CAR_RENTAL -> expenseName <- "Car Rental"
        let mealOverExpensesMarker = if (expense.expenseType = DINNER && expense.amount > 5000 || expense.expenseType = BREAKFAST && expense.amount > 1000) then "X" else " "
        printfn "%s\t%d\t%s" expenseName expense.amount mealOverExpensesMarker
        total <- total + expense.amount
    printfn "Meal Expenses: %d" mealExpenses
    printfn "Total Expenses: %d" total

[<EntryPoint>]
let main argv =
    printReport [
        Expense(DINNER, 5000)
        Expense(DINNER, 5001)
        Expense(BREAKFAST, 1000)
        Expense(BREAKFAST, 1001)
        Expense(CAR_RENTAL, 4)
    ]
    0
