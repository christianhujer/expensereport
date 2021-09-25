ExpenseType = {
    DINNER = 1,
    BREAKFAST = 2,
    CAR_RENTAL = 3,
}

Expense = { type, amount }

function Expense:new(type, amount)
    o = {}
    setmetatable(o, self)
    self.__index = self
    o.type = type
    o.amount = amount
    return o
end

function printReport(expenses)
    mealExpenses = 0
    total = 0
    print("Expenses: " .. os.date())
    for i, expense in ipairs(expenses) do
        if expense.type == ExpenseType.DINNER or expense.type == ExpenseType.BREAKFAST then
            mealExpenses = mealExpenses + expense.amount
        end
        expenseName = ""
        if expense.type == ExpenseType.DINNER then expenseName = "Dinner" end
        if expense.type == ExpenseType.BREAKFAST then expenseName = "Breakfast" end
        if expense.type == ExpenseType.CAR_RENTAL then expenseName = "Car Rental" end
        mealOverExpensesMarker = (expense.type == ExpenseType.DINNER and expense.amount > 5000 or expense.type == ExpenseType.BREAKFAST and expense.amount > 1000) and "X" or " "
        print(expenseName .. "\t" .. expense.amount .. "\t" .. mealOverExpensesMarker)
        total = total + expense.amount
    end
    print("Meal Expenses: " .. mealExpenses)
    print("Total Expenses: " .. total)
end

expenses = {
    Expense:new(ExpenseType.DINNER, 5000),
    Expense:new(ExpenseType.DINNER, 5001),
    Expense:new(ExpenseType.BREAKFAST, 1000),
    Expense:new(ExpenseType.BREAKFAST, 1001),
    Expense:new(ExpenseType.CAR_RENTAL, 4),
}

printReport(expenses)
