<?php

namespace Refactor\ExpenseReportPhp;

class ExpenseReport
{
    function printReport(array $expenses)
    {
        $mealExpenses = 0;
        $total = 0;
        $date = date("Y-m-d h:i:sa");
        print("Expense " . $date . "\n");
        foreach ($expenses as $expense) {
            if ($expense->type === DINNER || $expense->type === BREAKFAST) {
                $mealExpenses += $expense->amount;
            }
            $expenseName = "";
            switch ($expense->type) {
                case DINNER:
                    $expenseName = "Dinner";
                    break;
                case BREAKFAST:
                    $expenseName = "Breakfast";
                    break;
                case CAR_RENTAL:
                    $expenseName = "Car Rental";
                    break;
            }

            $mealOverExpensesMarker = $expense->type === DINNER && $expense->amount > 5000 || $expense->type === BREAKFAST && $expense->amount > 1000 ? "X" : " ";
            print($expenseName . "\t" . $expense->amount . "\t" . $mealOverExpensesMarker . "\n");
            $total += $expense->amount;
        }
        print("Meal expenses: " . $mealExpenses . "\n");
        print("Total expenses: " . $total . "\n");
    }
}
