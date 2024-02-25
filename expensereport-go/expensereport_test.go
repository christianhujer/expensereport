package main

import (
	"expenses/interceptor"
	"fmt"
	"github.com/cucumber/godog"
	"github.com/cucumber/messages-go/v16"
	"strconv"
	"strings"
	"testing"
	"time"
)

var actualReport string

func expenseEntry(row *messages.PickleTableRow) (*Expense, error) {
	expenseTypes := map[string]ExpenseType{
		"DINNER":     Dinner,
		"BREAKFAST":  Breakfast,
		"CAR_RENTAL": CarRental,
		"LUNCH":      Lunch,
	}
	amount, err := strconv.Atoi(row.Cells[1].Value)
	if err != nil {
		return nil, err
	}
	expenseType, present := expenseTypes[row.Cells[0].Value]
	if !present {
		return nil, fmt.Errorf("unknown expense type %s", row.Cells[0].Value)
	}
	return &Expense{Type: expenseType, Amount: amount}, nil
}

func generatingAReportForTheFollowingExpenses(dataTable *godog.Table) error {
	var expenses []Expense
	for _, row := range dataTable.Rows[1:] {
		expense, err := expenseEntry(row)
		if err != nil {
			return err
		}
		expenses = append(expenses, *expense)
	}
	actualReport = interceptor.InterceptStdout(func() { PrintReport(expenses) })
	return nil
}

func translateEscapes(s string) string {
	s = strings.ReplaceAll(s, "\\s", " ")
	s = strings.ReplaceAll(s, "\\t", "\t")
	return s
}

func theReportMUSTLookLikeThis(arg1 *godog.DocString) error {
	expectedReport := strings.ReplaceAll(translateEscapes(arg1.Content), "$now", time.Now().Format("2006-01-02")) + "\n"
	if actualReport != expectedReport {
		return fmt.Errorf("expected report: <%s>, actual report: <%s>", expectedReport, actualReport)
	}
	return nil
}

//goland:noinspection GoUnusedExportedFunction
func InitializeScenario(ctx *godog.ScenarioContext) {
	ctx.Step(`^generating a report for the following expenses:$`, generatingAReportForTheFollowingExpenses)
	ctx.Step(`^the report MUST look like this:$`, theReportMUSTLookLikeThis)
}

func TestFeatures(t *testing.T) {
	suite := godog.TestSuite{
		ScenarioInitializer: InitializeScenario,
		Options: &godog.Options{
			Format:   "pretty",
			Paths:    []string{"features"},
			TestingT: t, // Testing instance that will run subtests.
		},
	}

	if suite.Run() != 0 {
		t.Fatal("non-zero status returned, failed to run feature tests")
	}
}
