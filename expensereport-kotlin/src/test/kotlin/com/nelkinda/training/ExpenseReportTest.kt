package com.nelkinda.training

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import java.io.File
import java.io.FileOutputStream
import java.io.OutputStream
import java.io.PrintStream
import java.util.Date
import java.util.stream.Stream

class PrintCapture(out: OutputStream) : PrintStream(out) {

    private val capturedOutput = mutableListOf<String>()
    override fun println(inputString: String?) {
        if (inputString != null) {
            capturedOutput.add(inputString)
        }
    }

    fun outputSize(): Int = capturedOutput.size

}

class DateStub(date: Long) : Date(date)

class ExpenseReportTest {
    private val printStream = PrintCapture(FileOutputStream(File.createTempFile("prefix", "suffix")))
    private val currentTimeInMillis = 1676007131492L
    private val dateStub: DateStub = DateStub(currentTimeInMillis)
    private val expenseReport: ExpenseReport = ExpenseReport(printStream, dateStub)

    @Test
    fun `it should not print anything given no expenses`() {
        expenseReport.printReport(emptyList())

        assertEquals(3, printStream.outputSize())
    }
}