      MODULE ExpenseReport
        IMPLICIT NONE
        ENUM, BIND(C)
          ENUMERATOR :: BREAKFAST, DINNER, CAR_RENTAL
        ENDENUM

        TYPE :: expense
          INTEGER :: type
          INTEGER :: amount
        END TYPE

        CONTAINS
        SUBROUTINE printReport(expenses)
          TYPE(expense), DIMENSION (:), ALLOCATABLE :: expenses
          INTEGER :: total = 0
          INTEGER :: mealExpenses = 0
          INTEGER :: i
          CHARACTER(LEN = 20) :: expenseName
          CHARACTER(LEN = 1) :: mealOverExpensesMarker
          PRINT "(a)", 'Expenses'
          DO i = LBOUND(expenses, 1), UBOUND(expenses, 1)
            IF (expenses(i)%type == BREAKFAST .OR. expenses(i)%type == DINNER) &
              mealExpenses = mealExpenses + expenses(i)%amount
            SELECT CASE (expenses(i)%type)
              CASE (DINNER)
                expenseName = "Dinner"
              CASE (BREAKFAST)
                expenseName = "Breakfast"
              CASE (CAR_RENTAL)
                expenseName = "Car Rental"
            END SELECT
            IF (expenses(i)%type == BREAKFAST .AND. expenses(i)%amount > 1000 .OR. &
                expenses(i)%type == DINNER .AND. expenses(i)%amount > 5000) THEN
              mealOverExpensesMarker = "X"
            ELSE
              mealOverExpensesMarker = " "
            END IF
            total = total + expenses(i)%amount
            PRINT "(a,1x,i10,1x,a)", expenseName, expenses(i)%amount, mealOverExpensesMarker
          END DO
          PRINT "(a,i10)", 'Meal expenses: ', mealExpenses
          PRINT "(a,i10)", 'Total: ', total
        END SUBROUTINE printReport

      END MODULE ExpenseReport

      PROGRAM main
        USE ExpenseReport
        IMPLICIT NONE
        TYPE(expense), DIMENSION (:), ALLOCATABLE :: expenses
        ALLOCATE(expenses(5))
        expenses(1)%type = BREAKFAST
        expenses(1)%amount = 1000
        expenses(2)%type = BREAKFAST
        expenses(2)%amount = 1001
        expenses(3)%type = DINNER
        expenses(3)%amount = 5000
        expenses(4)%type = DINNER
        expenses(4)%amount = 5001
        expenses(5)%type = CAR_RENTAL
        expenses(5)%amount = 4
        CALL printReport(expenses)
        DEALLOCATE(expenses)
      END PROGRAM main
