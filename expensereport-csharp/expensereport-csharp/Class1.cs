using System;
using System.Collections.Generic;
using System.Linq;

namespace expensereport_csharp;

public class ExpenseType
{
    public readonly string Name;
    public readonly int Limit;
    public readonly bool IsMeal;

    public static readonly ExpenseType Dinner = new("Dinner", 5000, true);
    public static readonly ExpenseType Breakfast = new("Breakfast", 1000, true);
    public static readonly ExpenseType CarRental = new("Car Rental", int.MaxValue, false);
    public static readonly ExpenseType Lunch = new("Lunch", 2000, true);

    private ExpenseType(string name, int limit, bool isMeal)
    {
        Name = name;
        Limit = limit;
        IsMeal = isMeal;
    }
}

public class Expense
{
    private readonly ExpenseType _type;
    public readonly int Amount;

    public string Name => _type.Name;
    public bool IsOverLimit => Amount > _type.Limit;
    public bool IsMeal => _type.IsMeal;

    public Expense(ExpenseType type, int amount)
    {
        _type = type;
        Amount = amount;
    }
}

public class ExpenseReport
{
    public void PrintReport(List<Expense> expenses) =>
        Console.Write(GenerateReport(expenses, DateTime.Now));

    public static string GenerateReport(List<Expense> expenses, DateTime now) =>
        Header(now) + Details(expenses) + Summary(expenses);

    private static string Header(DateTime now) => "Expenses: " + now + "\n";

    private static string Details(List<Expense> expenses) =>
        expenses.Aggregate("", (current, expense) => current + Detail(expense));

    private static string Detail(Expense expense) =>
        $"{expense.Name}\t{expense.Amount}\t{OverLimitMarker(expense)}\n";

    private static string OverLimitMarker(Expense expense) =>
        expense.IsOverLimit ? "X" : " ";

    private static string Summary(List<Expense> expenses) =>
        $@"Meal expenses: {SumMeals(expenses)}
Total expenses: {SumTotal(expenses)}
";

    private static int SumMeals(List<Expense> expenses) =>
        expenses.Where(expense => expense.IsMeal).Sum(expense => expense.Amount);

    private static int SumTotal(List<Expense> expenses) =>
        expenses.Sum(expense => expense.Amount);
}