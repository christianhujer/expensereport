(ns expensereport-clojure.core)

(defn expense [type amount] {:type type :amount amount})

(defn print-report
    [expenses]
    (def total (atom 0))
    (def meal-expenses (atom 0))
    (println "Expenses: " (.toString (java.util.Date.)))
    (doall (for [expense (into #{} expenses)] (do
        (if (or (= (:type expense) :breakfast) (= (:type expense) :dinner)) (reset! meal-expenses (+ @meal-expenses (:amount expense))))
        (def expense-name (case (:type expense)
            :car-rental "Car Rental"
            :breakfast "Breakfast"
            :dinner "Dinner"))
        (def mealOverExpensesMarker (if (or (and (= (:type expense) :breakfast) (>= (:amount expense) 1000)) (and (= (:type expense) :dinner) (>= (:amount expense) 5000))) "X" " "))
        (println expense-name "\t" (:amount expense) "\t" mealOverExpensesMarker)
        (reset! total (+ @total (:amount expense))))))
    (println "Meal expenses: " @meal-expenses)
    (println "Total expenses: " @total)
)

(defn main []
    (print-report [(expense :car-rental 100) (expense :breakfast 1000) (expense :breakfast 1001) (expense :dinner 5000) (expense :dinner 5001)])
)
