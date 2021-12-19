import Control.Monad (forM_)
import Data.Array
import Data.IORef

data ExpenseType = Dinner | Breakfast | CarRental

data Expense = Expense { eType :: ExpenseType, amount :: Int }

printReport :: [Expense] -> IO ()
printReport expenses = do
    total <- newIORef 0
    --total :: IORef Integer
    mealExpenses <- newIORef 0
    --mealExpenses :: IORef Integer
    putStrLn("Expense Report")
    forM_ expenses $ \expense -> do
        modifyIORef mealExpenses (+ (
            case (eType expense) of
                    Dinner -> (amount expense)
                    Breakfast -> (amount expense)
                    _ -> 0
            ))
        let expenseName = "" ++ case (eType expense) of
                Dinner    -> "Dinner"
                Breakfast -> "Breakfast"
                CarRental -> "Car Rental"
        let mealOverExpensesMarker = case (eType expense) of
                Dinner -> if (amount expense) > 5000 then "X" else " "
                Breakfast -> if (amount expense) > 1000 then "X" else " "
                _ -> " "
        putStrLn(expenseName ++ "\t" ++ (show (amount expense)) ++ "\t" ++ mealOverExpensesMarker)
        modifyIORef total (+ (amount expense))
    putStr("Meal expenses: ")
    readIORef mealExpenses >>= print
    putStr("Total expenses: ")
    readIORef total >>= print

main :: IO ()
main = do
    printReport([
        Expense Breakfast 50
        ])
