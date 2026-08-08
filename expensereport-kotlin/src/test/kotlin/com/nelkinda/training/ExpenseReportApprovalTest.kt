package com.nelkinda.training

import org.approvaltests.ApprovalUtilities
import org.approvaltests.Approvals
import org.junit.jupiter.api.Test

class ExpenseReportApprovalTest {

    @Test
    fun test() {
        val output = ApprovalUtilities().writeSystemOutToStringBuffer()

        val expense = Expense()
        expense.type = ExpenseType.BREAKFAST
        expense.amount = 500

        ExpenseReport().printReport(listOf(expense))

        // will fail, because of timestamp in expense report
        Approvals.verify(output)
    }
}

