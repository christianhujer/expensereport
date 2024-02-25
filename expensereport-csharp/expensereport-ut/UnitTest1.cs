using System;
using System.Collections.Generic;
using expensereport_csharp;
using NUnit.Framework;

namespace Tests;

public class Tests
{
    [Test]
    public void Test1()
    {
        var expenses = new List<Expense> {
            new Expense(ExpenseType.Dinner, 5000),
            new Expense(ExpenseType.Dinner, 5001),
            new Expense(ExpenseType.Breakfast, 1000),
            new Expense(ExpenseType.Breakfast, 1001),
            new Expense(ExpenseType.CarRental, 4),
            new Expense(ExpenseType.Lunch, 2000),
            new Expense(ExpenseType.Lunch, 2001),
        };
        var actual = ExpenseReport.GenerateReport(expenses, DateTime.Parse("2022-06-02T15:15:00"));
        var expected = @"Expenses: 02/06/2022 3:15:00 pm
Dinner	5000	 
Dinner	5001	X
Breakfast	1000	 
Breakfast	1001	X
Car Rental	4	 
Lunch	2000	 
Lunch	2001	X
Meal expenses: 16003
Total expenses: 16007
";
        Assert.AreEqual(expected, actual);
    }
}