(defstruct expense
    type
    amount
)

(defvar NL "
")
(defvar TAB "	")

(defun print-report (&rest expenses)
    (defvar mealExpenses 0)
    (defvar total 0)
    (princ (concatenate 'string "Expenses:" NL))
    (loop for expense in expenses do
        (if (or (eq (expense-type expense) :dinner) (eq (expense-type expense) :breakfast))
            (setq mealExpenses (+ mealExpenses (expense-amount expense))))
        (defvar expenseName "")
        (case (expense-type expense)
            (:dinner (setq expenseName "Dinner"))
            (:breakfast (setq expenseName "Breakfast"))
            (:car_rental (setq expenseName "Car Rental"))
        )
        (setq mealOverExpensesMarker (if (or (and (eq (expense-type expense) :dinner) (> (expense-amount expense) 5000)) (and (eq (expense-type expense) :breakfast) (> (expense-amount expense) 1000))) "X" " "))
        (princ (concatenate 'string expenseName TAB (write-to-string (expense-amount expense)) TAB mealOverExpensesMarker NL))
        (setq total (+ total (expense-amount expense)))
    )
    (princ (concatenate 'string "Meal Expenses: " (write-to-string mealExpenses) NL))
    (princ (concatenate 'string "Total Expenses: " (write-to-string total) NL))
)

(print-report
    (make-expense :type :dinner :amount 5000)
    (make-expense :type :dinner :amount 5001)
    (make-expense :type :breakfast :amount 1000)
    (make-expense :type :breakfast :amount 1001)
    (make-expense :type :car_rental :amount 4)
)
