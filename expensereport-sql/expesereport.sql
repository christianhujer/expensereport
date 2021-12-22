#!/bin/sh
sqlite3 <<END
CREATE TABLE Expenses (
    type VARCHAR(10) NOT NULL,
    amount INT NOT NULL
);

INSERT INTO Expenses (type, amount) VALUES
("dinner", 5000),
("dinner", 5001),
("breakfast", 1000),
("breakfast", 1001),
("car_rental", 4);

SELECT printf("Expense report: %s", datetime('now'));
SELECT printf("%s	%s	%s", type, amount, substr(" X", (type = "dinner" and amount > 5000 or type = "breakfast" and amount > 1000) + 1, 1))
    FROM Expenses;
SELECT printf("Meal expenses: %s", sum(amount))
    FROM Expenses
    WHERE type = "dinner" OR type = "breakfast";
SELECT printf("Total expenses: %s", sum(amount))
    FROM Expenses;

END
