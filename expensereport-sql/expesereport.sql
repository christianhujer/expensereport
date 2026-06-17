#!/bin/sh
sqlite3 <<END
PRAGMA foreign_keys = ON;
CREATE TABLE ExpenseTypes (
    id VARCHAR(10) PRIMARY KEY NOT NULL,
    name VARCHAR(10) NOT NULL,
    expenseLimit INT,
    isMeal BOOL NOT NULL
);

CREATE TABLE Expenses (
    type VARCHAR(10) NOT NULL,
    amount INT NOT NULL
);

INSERT INTO ExpenseTypes (id, name, expenseLimit, isMeal) VALUES
("dinner", "Dinner", 5000, true),
("breakfast", "Breakfast", 1000, true),
("car_rental", "Car Rental", NULL, false),
("lunch", "Lunch", 2000, true);

INSERT INTO Expenses (type, amount) VALUES
("dinner", 5000),
("dinner", 5001),
("breakfast", 1000),
("breakfast", 1001),
("car_rental", 4),
("lunch", 2000),
("lunch", 2001);

SELECT printf("Expense report: %s", datetime('now'));
SELECT printf("%s	%s	%s", name, amount, substr(" X", (expenseLimit IS NOT NULL AND amount > expenseLimit) + 1, 1))
    FROM Expenses JOIN ExpenseTypes ON Expenses.type = ExpenseTypes.id;
SELECT printf("Meal expenses: %s", sum(amount))
    FROM Expenses JOIN ExpenseTypes ON Expenses.type = ExpenseTypes.id
    WHERE isMeal;
SELECT printf("Total expenses: %s", sum(amount))
    FROM Expenses;

END
