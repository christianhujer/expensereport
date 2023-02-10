package com.nelkinda.training

import org.approvaltests.Approvals
import org.approvaltests.core.Options
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource
import java.io.File
import java.io.FileOutputStream
import java.io.OutputStream
import java.io.PrintStream
import java.util.Date
import java.util.stream.Stream

class PrintCapture(out: OutputStream) : PrintStream(out) {

    val capturedOutput = mutableListOf<String>()

    override fun println(inputString: String?) {
        if (inputString != null) {
            capturedOutput.add(inputString)
        }
    }
}

class DateStub(date: Long) : Date(date)

class ExpenseReportTest {
    private val printStream = PrintCapture(FileOutputStream(File.createTempFile("prefix", "suffix")))
    private val currentTimeInMillis = 1676007131492L
    private val dateStub: DateStub = DateStub(currentTimeInMillis)
    private val expenseReport: ExpenseReport = ExpenseReport(printStream, dateStub)

    companion object {
        @JvmStatic
        fun inputForExpenseReport(): Stream<Arguments> {
            return Stream.of(
                Arguments.of(emptyList<Expense>(), "output when are no expenses"),
                Arguments.of(listOf(Expense(ExpenseType.BREAKFAST, 100)), "output when there is one breakfast expense costing 100"),
                Arguments.of(listOf(Expense(ExpenseType.DINNER, 100)), "output when there is one dinner expense costing 100"),
                Arguments.of(listOf(Expense(ExpenseType.CAR_RENTAL, 100)), "output when there is one car rental expense costing 100"),
                Arguments.of(listOf(Expense(ExpenseType.CAR_RENTAL, 100), Expense(ExpenseType.BREAKFAST, 200), Expense(ExpenseType.CAR_RENTAL, 500)), "output when there are multiple expenses"),
                Arguments.of(listOf(Expense(ExpenseType.DINNER, 5000)), "output when there is one dinner expense at the expense limit border"),
                Arguments.of(listOf(Expense(ExpenseType.DINNER, 10000)), "output when there is one dinner expense costing more than the expense limit"),
                Arguments.of(listOf(Expense(ExpenseType.BREAKFAST, 1000)), "output when there is one breakfast expense at the expense limit border"),
                Arguments.of(listOf(Expense(ExpenseType.BREAKFAST, 2000)), "output when there is one breakfast expense costing more than the expense limit"),
                Arguments.of(listOf(Expense(ExpenseType.BREAKFAST, 2000), Expense(ExpenseType.DINNER, 10000)), "output when there are multiple expenses costing more than the expense limit"),
                Arguments.of(listOf(Expense(ExpenseType.BREAKFAST, 2000), Expense(ExpenseType.BREAKFAST, 2000)), "output when there are multiple expenses of the same type"),
            )
        }
    }

    @ParameterizedTest(name = "{index} {1}")
    @MethodSource("inputForExpenseReport")
    fun `approval test`(expenses: List<Expense>, testName: String) {
        expenseReport.printReport(expenses)
        Approvals.verifyAll(
            testName,
            printStream.capturedOutput,
            Options().forFile().withBaseName(testName)
        )
    }
}