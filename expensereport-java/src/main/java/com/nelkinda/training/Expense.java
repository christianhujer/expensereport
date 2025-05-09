package com.nelkinda.training;

public record Expense(ExpenseType type, int amount) {
    public boolean isMeal() {
        return type.isMeal();
    }

    public boolean exceedsLimit() {
        return type.exceedsLimit(amount);
    }

    public String getName() {
        return type.getName();
    }
}
