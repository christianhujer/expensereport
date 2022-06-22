data ExpenseType = ExpenseType { name :: String, limit :: Int, isMeal3 :: Bool }
dinner    = ExpenseType "Dinner"                  5000 True
breakfast = ExpenseType "Breakfast"               1000 True
carRental = ExpenseType "Car Rental" (maxBound :: Int) False
lunch     = ExpenseType "Lunch"                   2000 True

data Expense = Expense { eType :: ExpenseType, amount :: Int }

expenseName :: Expense -> String
expenseName expense = name (eType expense)

isMeal :: Expense -> Bool
isMeal expense = isMeal3 (eType expense)

isOverLimit :: Expense -> Bool
isOverLimit expense = (amount expense) > (limit (eType expense))

printReport :: [Expense] -> IO ()
printReport expenses = putStr(generateReport expenses)

generateReport :: [Expense] -> String
generateReport expenses = header ++ (details expenses) ++ (summary expenses)

header :: String
header = "Expense Report\n"

details :: [Expense] -> String
details [] = ""
details (expense:expenses) = detail(expense) ++ details(expenses)

detail :: Expense -> String
detail expense = expenseName(expense) ++ "\t" ++ (show (amount expense)) ++ "\t" ++ (overLimitMarker expense) ++ "\n"

overLimitMarker :: Expense -> String
overLimitMarker expense = if isOverLimit expense then "X" else " "

summary :: [Expense] -> String
summary expenses = "Meal expenses: " ++ (show (sumMeals expenses)) ++ "\n" ++ "Total expenses: " ++ (show (sumTotal expenses)) ++ "\n"

sumMeals :: [Expense] -> Int
sumMeals [] = 0
sumMeals (expense:expenses) = (if isMeal expense then amount expense else 0) + sumMeals expenses

sumTotal :: [Expense] -> Int
sumTotal [] = 0
sumTotal (expense:expenses) = (amount expense) + (sumTotal expenses)


main :: IO ()
main = do
    printReport([
        Expense dinner 5000,
        Expense dinner 5001,
        Expense breakfast 1000,
        Expense breakfast 1001,
        Expense carRental 4,
        Expense lunch 2000,
        Expense lunch 2001
        ])
