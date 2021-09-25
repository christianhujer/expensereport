Imports System

Module Program
    Enum ExpenseType
        DINNER
        BREAKFAST
        CAR_RENTAL
    End Enum

    Class Expense
        Public expenseType As ExpenseType
        Public amount As Integer
    End Class

    Sub PrintReport(expenses As List(Of Expense))
        Dim mealExpenses As Integer = 0
        Dim total As Integer = 0
        Console.WriteLine("Expense Report:")

        For Each expense In expenses
            If expense.expenseType = ExpenseType.DINNER OR expense.expenseType = ExpenseType.BREAKFAST Then
                mealExpenses += expense.amount
            End If
            Dim expenseName As String = ""
            Select expense.expenseType
                Case ExpenseType.DINNER
                    expenseName = "Dinner"
                Case ExpenseType.BREAKFAST
                    expenseName = "Breakfast"
                Case ExpenseType.CAR_RENTAL
                    expenseName = "Car Rental"
            End Select
            Dim mealOverExpensesMarker As String = If(expense.expenseType = ExpenseType.DINNER AND expense.amount > 5000 OR expense.expenseType = ExpenseType.BREAKFAST AND expense.amount > 1000, "X", " ")
            Console.WriteLine(expenseName & Chr(9) & expense.amount & Chr(9) & mealOverExpensesMarker)
            total += expense.amount
        Next expense

        Console.WriteLine("Meal Expenses: " & mealExpenses)
        Console.WriteLine("Total Expenses: " & total)
    End Sub

    Sub Main(args As String())
    End Sub
End Module
