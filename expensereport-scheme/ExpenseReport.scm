#!/usr/bin/env -S guile -s
!#

(define (print-report expenses)
    (display
        (string-concatenate (list "Expense Report " (strftime "%c" (localtime (current-time))) "\n"))
    )
    (define meal-expenses 0)
    (define total-expenses 0)

    (for-each
        (lambda (expense)
            (define expense-name "")
            (if (or (eq? (list-ref expense 0) 'dinner) (eq? (list-ref expense 0) 'breakfast)) (set! meal-expenses (+ meal-expenses (list-ref expense 1))))
            (if (eq? (list-ref expense 0) 'dinner) (set! expense-name "Dinner"))
            (if (eq? (list-ref expense 0) 'breakfast) (set! expense-name "Breakfast"))
            (if (eq? (list-ref expense 0) 'car-rental) (set! expense-name "Car Rental"))
            (define meal-over-expenses-marker (if (or (and (eq? (list-ref expense 0) 'dinner) (> (list-ref expense 1) 5000)) (and (eq? (list-ref expense 0) 'breakfast) (> (list-ref expense 1) 1000) )) "X" " "))
            (display (string-concatenate (list expense-name "\t" (number->string (list-ref expense 1)) "\t" meal-over-expenses-marker "\n")))
            (set! total-expenses (+ total-expenses (list-ref expense 1)))
        )
        expenses
    )

    (display (string-concatenate (list "Meal expenses: " (number->string meal-expenses) "\n")))
    (display (string-concatenate (list "Total expenses: " (number->string total-expenses) "\n")))
)

(print-report (list (list 'dinner 5000) (list 'dinner 5001) (list 'breakfast 1000) (list 'breakfast 1001) (list 'car-rental 4)))
