package com.nelkinda.training

import io.cucumber.java.DataTableType
import io.cucumber.java.en.Then
import io.cucumber.java.en.When
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.platform.suite.api.IncludeEngines
import org.junit.platform.suite.api.SelectClasspathResource
import org.junit.platform.suite.api.Suite
import java.util.Date

@Suite
@IncludeEngines("cucumber")
@SelectClasspathResource("features")
class CucumberTest {
    private val now = Date()
    private lateinit var actualReport: String

    @DataTableType
    fun expenseEntry(entry: Map<String, String>): Expense =
        Expense(ExpenseType.valueOf(entry["type"]!!), entry["amount"]!!.toInt())

    @When("generating a report for the following expenses:")
    fun generating_a_report_for_the_following_expenses(expenses: List<Expense>) {
        actualReport = interceptStdout {
            ExpenseReport().printReport(expenses, now)
        }
    }

    @Then("the report MUST look like this:")
    fun the_report_must_look_like_this(expectedReport: String) {
        assertEquals(
            expectedReport.translateEscapes().replace(Regex("[$]now"), now.toString()) + System.lineSeparator(),
            actualReport
        )
    }
}
