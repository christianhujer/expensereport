package main

import (
	"fmt"
	"math"
	"time"
)

type ExpenseType struct {
	name   string
	isMeal bool
	limit  int
}

// Note: As Golang does not support immutable variables, the ExpenseType multiton is not safe.

var Dinner = ExpenseType{name: "Dinner", isMeal: true, limit: 5000}
var Breakfast = ExpenseType{name: "Breakfast", isMeal: true, limit: 1000}
var CarRental = ExpenseType{name: "Car Rental", isMeal: false, limit: math.MaxInt}
var Lunch = ExpenseType{name: "Lunch", isMeal: true, limit: 2000}

type Expense struct {
	Type   ExpenseType
	Amount int
}

func (expense Expense) GetName() string {
	return expense.Type.name
}

func (expense Expense) IsMeal() bool {
	return expense.Type.isMeal
}

func (expense Expense) IsOverLimit() bool {
	return expense.Amount > expense.Type.limit
}

func PrintReport(expenses []Expense) {
	PrintHeader()
	PrintDetails(expenses)
	PrintSummary(expenses)
}

func PrintHeader() {
	fmt.Printf("Expenses %s\n", time.Now().Format("2006-01-02"))
}

func PrintDetails(expenses []Expense) {
	for _, expense := range expenses {
		PrintDetail(expense)
	}
}

func PrintDetail(expense Expense) {
	mealOverExpensesMarker := getOverLimitMarker(expense)
	fmt.Printf("%s\t%d\t%s\n", expense.GetName(), expense.Amount, mealOverExpensesMarker)
}

func PrintSummary(expenses []Expense) {
	fmt.Printf("Meal expenses: %d\n", SumMeals(expenses))
	fmt.Printf("Total expenses: %d\n", SumTotal(expenses))
}

func getOverLimitMarker(expense Expense) string {
	if expense.IsOverLimit() {
		return "X"
	} else {
		return " "
	}
}

func SumMeals(expenses []Expense) int {
	return Sum(expenses, Expense.IsMeal)
}

func SumTotal(expenses []Expense) int {
	return Sum(expenses, func(expense Expense) bool { return true })
}

func Sum(expenses []Expense, predicate func(Expense) bool) int {
	sum := 0
	for _, expense := range expenses {
		if predicate(expense) {
			sum += expense.Amount
		}
	}
	return sum
}
