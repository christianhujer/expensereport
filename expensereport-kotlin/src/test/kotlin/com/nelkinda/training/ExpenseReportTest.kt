package com.nelkinda.training

import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Test
import java.io.File
import java.io.FileOutputStream
import java.io.OutputStream
import java.io.PrintStream

class PrintCapture(out: OutputStream) : PrintStream(out) {

    private val capturedOutput = mutableListOf<String>()
    override fun println(inputString: String?) {
        if (inputString != null) {
            capturedOutput.add(inputString)
        }
    }

    fun outputSize(): Int = capturedOutput.size

}

class ExpenseReportTest {
    private val printStream = PrintCapture(FileOutputStream(File.createTempFile("prefix", "suffix")))
    private val expenseReport: ExpenseReport = ExpenseReport(printStream)

    @Test
    fun `it should not print anything given no expenses`() {
        expenseReport.printReport(emptyList())

        assertEquals(3, printStream.outputSize())
    }
}