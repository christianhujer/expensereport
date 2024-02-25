      MODULE ExpenseReport
        IMPLICIT NONE
        TYPE :: expenseType
          CHARACTER(LEN = 20) :: name
          INTEGER :: limit
          LOGICAL :: isMeal
        END TYPE

        TYPE(expenseType) :: DINNER = expenseType("Dinner", 5000, .TRUE.)
        TYPE(expenseType) :: BREAKFAST = expenseType("Breakfast", 1000, .TRUE.)
        TYPE(expenseType) :: CAR_RENTAL = expenseType("Car Rental", huge(0), .FALSE.)
        TYPE(expenseType) :: LUNCH = expenseType("Lunch", 2000, .TRUE.)

        TYPE, PUBLIC :: expense
          TYPE(expenseType) :: type
          INTEGER :: amount
        CONTAINS
            PROCEDURE :: isMeal => expense_isMeal
            PROCEDURE :: getName => expense_getName
            PROCEDURE :: isOverLimit => expense_isOverLimit
        END TYPE

      CONTAINS
        FUNCTION expense_isMeal(this) RESULT(meal)
          CLASS(expense), INTENT(IN) :: this
          LOGICAL :: meal
          meal = this%type%isMeal
        END FUNCTION expense_isMeal

        FUNCTION expense_getName(this) RESULT(expenseName)
          CLASS(expense), INTENT(IN) :: this
          CHARACTER(LEN = 20) :: expenseName
          expenseName = this%type%name
        END FUNCTION expense_getName

        FUNCTION expense_isOverLimit(this) RESULT(overLimit)
          CLASS(expense), INTENT(IN) :: this
          LOGICAL :: overLimit
          overLimit = this%amount > this%type%limit
        END FUNCTION expense_isOverLimit

        FUNCTION sumTotal(expenses) RESULT(total)
          TYPE(expense), DIMENSION (:), ALLOCATABLE :: expenses
          INTEGER :: total
          INTEGER :: i
          total = 0
          DO i = LBOUND(expenses, 1), UBOUND(expenses, 1)
            total = total + expenses(i)%amount
          END DO
        END FUNCTION sumTotal

        FUNCTION sumMeals(expenses) RESULT(meals)
          TYPE(expense), DIMENSION (:), ALLOCATABLE :: expenses
          INTEGER :: meals
          INTEGER :: i
          meals = 0
          DO i = LBOUND(expenses, 1), UBOUND(expenses, 1)
            IF (expenses(i)%isMeal()) meals = meals + expenses(i)%amount
          END DO
        END FUNCTION sumMeals

        SUBROUTINE printHeader()
          PRINT "(a)", 'Expenses'
        END SUBROUTINE

        SUBROUTINE printDetails(expenses)
          TYPE(expense), DIMENSION (:), ALLOCATABLE :: expenses
          INTEGER :: i
          DO i = LBOUND(expenses, 1), UBOUND(expenses, 1)
            CALL printDetail(expenses(i))
          END DO
        END SUBROUTINE

        SUBROUTINE printDetail(exp)
          TYPE(expense) :: exp
          CHARACTER(LEN = 1) :: mealOverExpensesMarker
          IF (exp%isOverLimit()) THEN
            mealOverExpensesMarker = "X"
          ELSE
            mealOverExpensesMarker = " "
          END IF
          PRINT "(a,1x,i10,1x,a)", exp%getName(), exp%amount, mealOverExpensesMarker
        END SUBROUTINE

        SUBROUTINE printSummary(expenses)
          TYPE(expense), DIMENSION (:), ALLOCATABLE :: expenses
          PRINT "(a,i10)", 'Meal expenses: ', sumMeals(expenses)
          PRINT "(a,i10)", 'Total: ', sumTotal(expenses)
        END SUBROUTINE

        SUBROUTINE printReport(expenses)
          TYPE(expense), DIMENSION (:), ALLOCATABLE :: expenses
          CALL printHeader()
          CALL printDetails(expenses)
          CALL printSummary(expenses)
        END SUBROUTINE printReport

      END MODULE ExpenseReport

      PROGRAM main
        USE ExpenseReport
        IMPLICIT NONE
        TYPE(expense), DIMENSION (:), ALLOCATABLE :: expenses
        ALLOCATE(expenses(7))
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
        expenses(6)%type = LUNCH
        expenses(6)%amount = 2000
        expenses(7)%type = LUNCH
        expenses(7)%amount = 2001
        CALL printReport(expenses)
        DEALLOCATE(expenses)
      END PROGRAM main
