Feature: Expense Report
  Scenario: Empty Report
    When generating a report for the following expenses:
      | type | amount |
    Then the report MUST look like this:
      """
      Expenses $now
      Meal expenses: 0
      Total expenses: 0
      """

  Scenario: Dinner is a meal with a limit of 5000
    When generating a report for the following expenses:
      | type   | amount |
      | DINNER | 5000   |
      | DINNER | 5001   |
    Then the report MUST look like this:
      """
      Expenses $now
      Dinner\t5000\t\s
      Dinner\t5001\tX
      Meal expenses: 10001
      Total expenses: 10001
      """

  Scenario: Breakfast is a meal with a limit of 1000
    When generating a report for the following expenses:
      | type      | amount |
      | BREAKFAST | 1000   |
      | BREAKFAST | 1001   |
    Then the report MUST look like this:
      """
      Expenses $now
      Breakfast\t1000\t\s
      Breakfast\t1001\tX
      Meal expenses: 2001
      Total expenses: 2001
      """

  Scenario: Car Rental is not a meal and has no limit
    When generating a report for the following expenses:
      | type       | amount     |
      | CAR_RENTAL | 2147483647 |
    Then the report MUST look like this:
      """
      Expenses $now
      Car Rental\t2147483647\t\s
      Meal expenses: 0
      Total expenses: 2147483647
      """

  Scenario: Lunch is a meal with a limit of 2000
    When generating a report for the following expenses:
      | type  | amount |
      | LUNCH | 2000   |
      | LUNCH | 2001   |
    Then the report MUST look like this:
      """
      Expenses $now
      Lunch\t2000\t\s
      Lunch\t2001\tX
      Meal expenses: 4001
      Total expenses: 4001
      """

  Scenario: Combined characterization test
    When generating a report for the following expenses:
      | type       | amount |
      | DINNER     |   5000 |
      | DINNER     |   5001 |
      | BREAKFAST  |   1000 |
      | BREAKFAST  |   1001 |
      | CAR_RENTAL |      4 |
      | LUNCH      |   2000 |
      | LUNCH      |   2001 |
    Then the report MUST look like this:
      """
      Expenses $now
      Dinner\t5000\t\s
      Dinner\t5001\tX
      Breakfast\t1000\t\s
      Breakfast\t1001\tX
      Car Rental\t4\t\s
      Lunch\t2000\t\s
      Lunch\t2001\tX
      Meal expenses: 16003
      Total expenses: 16007
      """
