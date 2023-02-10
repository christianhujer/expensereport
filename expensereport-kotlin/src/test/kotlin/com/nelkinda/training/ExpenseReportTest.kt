package com.nelkinda.training

import com.github.stefanbirkner.systemlambda.SystemLambda.tapSystemOut
import com.nelkinda.training.model.Expense
import com.nelkinda.training.model.ExpenseType.*
import org.junit.jupiter.api.Test

import org.junit.jupiter.api.Assertions.*
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource
import java.util.*
import java.util.stream.Stream

class ExpenseReportTest {

    private companion object{
        @JvmStatic
        fun expenseListArguments() = Stream.of(
            Arguments.of(listOf(Expense(BREAKFAST, 100), Expense(DINNER, 200), Expense(CAR_RENTAL, 200)), Pair(300, 500)),
            Arguments.of(listOf(Expense(BREAKFAST, 10000), Expense(DINNER, 5000)), Pair(15000, 15000))
        )
    }

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
    fun `should flag dinner`(){
        val expense1 = Expense(DINNER, 5001)

        val expectedResult = listOf(
            "Expenses ${Date()}", "Dinner\t5001\tX",
            "Meal expenses: 5001", "Total expenses: 5001", ""
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

    @ParameterizedTest
    @MethodSource("expenseListArguments")
    fun `should test each expense list for meal and total expense`(expenseList: List<Expense>, expectedExpense: Pair<Int, Int>){
        val actualExpense = expenseReport.getTotalAndMealExpenses(expenseList)

        assertEquals(expectedExpense, actualExpense)
    }
}