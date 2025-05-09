package com.nelkinda.training;

public abstract class ExpenseType {
    public abstract String getName();
    public abstract boolean isMeal();
    public abstract boolean exceedsLimit(int amount);

    public static final ExpenseType DINNER = new ExpenseType() {
        @Override
        public String getName() {
            return "dinner";
        }

        @Override
        public boolean isMeal() {
            return true;
        }

        @Override
        public boolean exceedsLimit(int amount) {
            return amount > 5000;
        }
    };

    public static final ExpenseType BREAKFAST = new ExpenseType() {
        @Override
        public String getName() {
            return "breakfast";
        }

        @Override
        public boolean isMeal() {
            return true;
        }

        @Override
        public boolean exceedsLimit(int amount) {
            return amount > 1000;
        }
    };

    public static final ExpenseType CAR_RENTAL = new ExpenseType() {
        @Override
        public String getName() {
            return "car rental";
        }

        @Override
        public boolean isMeal() {
            return false;
        }

        @Override
        public boolean exceedsLimit(int amount) {
            return false; // No limit for car rental
        }
    };
}
