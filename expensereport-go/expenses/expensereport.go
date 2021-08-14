package expenses

import (
    "fmt"
    "time"
)

type Type int

const (
    DINNER Type = iota + 1
    BREAKFAST
    CAR_RENTAL
)

type Expense struct {
    Type Type
    Amount int
}

func printReport(expenses []Expense) {
    total := 0
    mealExpenses := 0

    fmt.Printf("Expenses %s\n", time.Now().Format("2006-01-02"))

    for _, expense := range expenses {
        if expense.Type == DINNER || expense.Type == BREAKFAST {
            mealExpenses += expense.Amount
        }

        var expenseName string
        switch (expense.Type) {
        case DINNER:
            expenseName = "Dinner"
        case BREAKFAST:
            expenseName = "Breakfast"
        case CAR_RENTAL:
            expenseName = "Car Rental"
        }

        var mealOverExpensesMarker string
        if expense.Type == DINNER && expense.Amount > 5000 || expense.Type == BREAKFAST && expense.Amount > 1000 {
            mealOverExpensesMarker = "X"
        } else {
            mealOverExpensesMarker = " "
        }

        fmt.Printf("%s\t%d\t%s\n", expenseName, expense.Amount, mealOverExpensesMarker)
        total += expense.Amount
    }

    fmt.Println("Meal expenses: %d\n", mealExpenses)
    fmt.Println("Total expenses: %d\n", total)
}
