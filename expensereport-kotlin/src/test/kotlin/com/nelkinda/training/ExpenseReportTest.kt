package com.nelkinda.training

import com.github.stefanbirkner.systemlambda.SystemLambda.tapSystemOut
import com.nelkinda.training.model.Expense
import com.nelkinda.training.model.ExpenseType.BREAKFAST
import com.nelkinda.training.model.ExpenseType.DINNER
import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*
import java.util.*

class ExpenseReportTest {

    @Test
    fun printReport() {
        val expense1 = Expense()
        expense1.amount = 1000
        expense1.type = BREAKFAST

        val expense2 = Expense()
        expense2.amount = 2000
        expense2.type = DINNER

        val expectedResult = listOf(
            "Expenses ${Date()}", "Breakfast\t1000\t ", "Dinner\t2000\t ",
            "Meal expenses: 3000", "Total expenses: 3000", ""
        )

        val expenseReport = ExpenseReport()
        val output = tapSystemOut { expenseReport.printReport(listOf(expense1, expense2)) }
        val actualResult = output.split("\n")

        assertEquals(expectedResult, actualResult)
    }
}