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
                Arguments.of(emptyList<Expense>(), "output when no input is given")
            )
        }
    }

    @ParameterizedTest(name = "{index} {1}")
    @MethodSource("inputForExpenseReport")
    fun `approval test`(expenses: List<Expense>, testName: String) {
        expenseReport.printReport(expenses)
        Approvals.verifyAll("Output when no input is given", printStream.capturedOutput, Options().forFile().withBaseName(testName))
    }
}