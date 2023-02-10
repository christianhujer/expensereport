package com.nelkinda.training

import com.github.stefanbirkner.systemlambda.SystemLambda.tapSystemOut
import com.nelkinda.training.model.Expense
import com.nelkinda.training.model.ExpenseType.*
import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import java.util.*

class ExpenseReportTest {

    private lateinit var expenseReport: ExpenseReport
    @BeforeEach
    fun setUp() {
        expenseReport = ExpenseReport()
    }
    @Test
    fun `should print expense for breakfast and dinner`() {
        val expense1 = Expense(BREAKFAST, 1000)

        val expense2 = Expense(DINNER, 2000)

        val expectedResult = listOf(
            "Expenses ${Date()}", "Breakfast\t1000\t ", "Dinner\t2000\t ",
            "Meal expenses: 3000", "Total expenses: 3000", ""
        )

        val output = tapSystemOut { expenseReport.printReport(listOf(expense1, expense2)) }
        val actualResult = output.split("\n")

        assertEquals(expectedResult, actualResult)
    }

    @Test
    fun `should flag breakfast`() {
        val expense1 = Expense(BREAKFAST, 1001)

        val expectedResult = listOf(
            "Expenses ${Date()}", "Breakfast\t1001\tX",
            "Meal expenses: 1001", "Total expenses: 1001", ""
        )

        val output = tapSystemOut { expenseReport.printReport(listOf(expense1)) }
        val actualResult = output.split("\n")

        assertEquals(expectedResult, actualResult)
    }

    @Test
    fun `should flag the first expense and not the second`(){
        val expense1 = Expense(BREAKFAST, 1001)
        val expense2 = Expense(CAR_RENTAL, 2000)

        val expectedResult = listOf(
            "Expenses ${Date()}", "Breakfast\t1001\tX", "Car Rental\t2000\t ",
            "Meal expenses: 1001", "Total expenses: 3001", ""
        )

        val output = tapSystemOut { expenseReport.printReport(listOf(expense1, expense2)) }
        val actualResult = output.split("\n")

        assertEquals(expectedResult, actualResult)
    }
}