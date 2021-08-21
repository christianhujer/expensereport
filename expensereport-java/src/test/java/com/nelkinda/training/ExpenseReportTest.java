package com.nelkinda.training;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.ByteArrayOutputStream;
import java.io.PrintStream;
import java.util.Date;
import java.util.List;

import static com.nelkinda.training.ExpenseType.*;
import static org.junit.jupiter.api.Assertions.assertEquals;

class ExpenseReportTest {
    private static final PrintStream originalStdout = System.out;
    private final ByteArrayOutputStream interceptedStdout = new ByteArrayOutputStream();

    @BeforeEach
    void interceptStdout() {
        System.setOut(new PrintStream(interceptedStdout));
    }

    @AfterEach
    void restoreStdout() {
        System.setOut(originalStdout);
    }

    @Test
    void characterizePrintReport() {
        final Date now = new Date();
        new ExpenseReport().printReport(
                List.of(
                        new Expense(BREAKFAST, 1),
                        new Expense(BREAKFAST, 1000),
                        new Expense(BREAKFAST, 1001),
                        new Expense(DINNER, 2),
                        new Expense(DINNER, 5000),
                        new Expense(DINNER, 5001),
                        new Expense(CAR_RENTAL, 4),
                        new Expense(LUNCH, 8),
                        new Expense(LUNCH, 2000),
                        new Expense(LUNCH, 2001)
                ),
                now
        );
        final String actual = interceptedStdout.toString();
        final String expected = "Expenses " + now + "\n" +
                "Breakfast\t1\t \n" +
                "Breakfast\t1000\t \n" +
                "Breakfast\t1001\tX\n" +
                "Dinner\t2\t \n" +
                "Dinner\t5000\t \n" +
                "Dinner\t5001\tX\n" +
                "Car Rental\t4\t \n" +
                "Lunch\t8\t \n" +
                "Lunch\t2000\t \n" +
                "Lunch\t2001\tX\n" +
                "Meal expenses: 16014\n" +
                "Total expenses: 16018\n";
        assertEquals(expected, actual);
    }
}
