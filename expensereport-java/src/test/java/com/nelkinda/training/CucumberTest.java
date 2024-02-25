package com.nelkinda.training;

import io.cucumber.java.DataTableType;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import org.junit.platform.suite.api.IncludeEngines;
import org.junit.platform.suite.api.SelectClasspathResource;
import org.junit.platform.suite.api.Suite;

import java.util.Date;
import java.util.List;
import java.util.Map;

import static com.nelkinda.training.Interceptor.interceptStdout;
import static org.junit.jupiter.api.Assertions.assertEquals;

@Suite
@IncludeEngines("cucumber")
@SelectClasspathResource("features")
@SuppressWarnings("java:S2187")
public class CucumberTest {
    private final Date now = new Date();
    private String actualReport;

    @DataTableType
    public Expense expenseEntry(final Map<String, String> entry) {
        return new Expense(ExpenseType.valueOf(entry.get("type")), Integer.parseInt(entry.get("amount")));
    }

    @When("generating a report for the following expenses:")
    public void generating_a_report_for_the_following_expenses(final List<Expense> expenses) {
        actualReport = interceptStdout(
                () -> new ExpenseReport().printReport(expenses, now)
        );
    }

    @Then("the report MUST look like this:")
    public void the_report_must_look_like_this(final String expectedReport) {
        assertEquals(
                expectedReport.translateEscapes().replaceAll("[$]now", now.toString()) + System.lineSeparator(),
                actualReport
        );
    }
}
