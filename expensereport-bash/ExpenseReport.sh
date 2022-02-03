#!/bin/bash

function printReport() {
    total=0
    meals=0

    echo "Expenses: $(date)"

    type=0
    amount=1
    while read -a expense ; do
        if [ "${expense[$type]}" = "DINNER" ] || [ "${expense[$type]}" = "BREAKFAST" ] ; then
            meals=$(( ${meals} + ${expense[$amount]} ))
        fi

        case "${expense[$type]}" in
        "DINNER") expenseName="Dinner" ;;
        "BREAKFAST") expenseName="Breakfast" ;;
        "CAR_RENTAL") expenseName="Car Rental" ;;
        esac

        mealOverExpensesMarker=$(if [ "${expense[$type]}" = "DINNER" ] && [ "${expense[$amount]}" -gt 5000 ] || [ "${expense[$type]}" = "BREAKFAST" ] && [ "${expense[$amount]}" -gt 1000 ] ; then echo "X" ; else echo " " ; fi)

        echo -e "$expenseName\t${expense[$amount]}\t$mealOverExpensesMarker"

        total=$(( ${total} + ${expense[$amount]} ))
    done

    echo "Meal expenses: $meals"
    echo "Total expenses: $total"
}

printReport <<EXPENSES
DINNER 5000
DINNER 5001
BREAKFAST 1000
BREAKFAST 1001
CAR_RENTAL 4
EXPENSES
