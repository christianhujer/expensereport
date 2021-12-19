#!/usr/bin/env elixir

defmodule Expense do
    defstruct [:type, :amount]
end

defmodule ExpenseReport do
    def printReport(expenses) when is_list(expenses) do
        IO.puts("Expense Report")

        for expense <- expenses do
            expenseName = case expense.type do
                :breakfast -> "Breakfast"
                :dinner -> "Dinner"
                :carrental -> "Car Rental"
            end
            mealOverExpensesMarker = case expense.type do
                :breakfast -> if expense.amount > 1000 do "X" else " " end
                :dinner -> if expense.amount > 5000 do "X" else " " end
                _ -> " "
            end
            IO.puts(expenseName <> "\t" <> to_string(expense.amount) <> "\t" <> mealOverExpensesMarker)
        end

        mealExpenses = Enum.sum(Enum.map(Enum.filter(expenses, fn expense -> expense.type == :breakfast || expense.type == :dinner end), fn expense -> expense.amount end))
        total = Enum.sum(Enum.map(expenses, fn expense -> expense.amount end))

        IO.puts("Meal expenses: " <> to_string(mealExpenses))
        IO.puts("Total expenses: " <> to_string(total))
    end
end

defmodule Main do
    def main do
        ExpenseReport.printReport([
            %Expense{type: :breakfast, amount: 50},
        ])
    end
end

Main.main
