const std = @import("std");
const ExpenseType = enum { DINNER, BREAKFAST, CAR_RENTAL };
const print = std.debug.print;

const Expense = struct {
    type: ExpenseType,
    amount: u32,
};

fn printReport(expenses: []Expense) void {
    var total: u32 = 0;
    var meals: u32 = 0;

    print("Expense Report: {s}\n", .{""});

    for (expenses) |expense| {
        if (expense.type == ExpenseType.DINNER or expense.type == ExpenseType.BREAKFAST) {
            meals += expense.amount;
        }

        var name: []const u8 = "";
        switch (expense.type) {
            ExpenseType.DINNER => { name = "Dinner"; },
            ExpenseType.BREAKFAST => { name = "Breakfast"; },
            ExpenseType.CAR_RENTAL => { name = "Car Rental"; },
        }

        var mealOverExpensesMarker: []const u8 = if (expense.type == ExpenseType.DINNER and expense.amount > 5000 or expense.type == ExpenseType.BREAKFAST and expense.amount > 1000) "X" else " ";

        print("{s}\t{d}\t{s}\n", .{name, expense.amount, mealOverExpensesMarker});

        total += expense.amount;
    }

    print("Meal expenses: {d}\n", .{meals});
    print("Total expenses: {d}\n", .{total});
}

pub fn main() void {
    var expenses: [5]Expense = .{
        Expense {.type = ExpenseType.DINNER, .amount = 5000},
        Expense {.type = ExpenseType.DINNER, .amount = 5001},
        Expense {.type = ExpenseType.BREAKFAST, .amount = 1000},
        Expense {.type = ExpenseType.BREAKFAST, .amount = 1001},
        Expense {.type = ExpenseType.CAR_RENTAL, .amount = 4},
    };
    printReport(&expenses);
}
