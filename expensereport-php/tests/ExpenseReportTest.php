<?php

namespace Refactor\ExpenseReportPhp;

use PHPUnit\Framework\TestCase;

class ExpenseReportTest extends TestCase
{
    /**
     * @var ExpenseReport
     */
    private $expenseReport;

    /**
     * @before
     */
    protected function setUpExpenseReport(): void
    {
        $this->expenseReport = new ExpenseReport();
    }

    public function testPrintReport()
    {
        $this->expectOutputRegex("/^Expense [^\n]+\nMeal expenses: 0\nTotal expenses: 0\n/");
        $this->expenseReport->printReport([]);
    }
}
