#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN

#include <doctest/doctest.h>
#include "ExpenseReport.hpp"

TEST_CASE ("ExpenseReport Characterization Test") {
    std::tm tm = {};
    std::stringstream ss("Jan 09 2014 12:35:34");
    ss >> std::get_time(&tm, "%b %d %Y %H:%M:%S");
    auto tp = std::mktime(&tm);
    std::list<Expense> expenses = {
            {BREAKFAST,  1},
            {BREAKFAST,  1000},
            {BREAKFAST,  1001},
            {DINNER,     2},
            {DINNER,     5000},
            {DINNER,     5001},
            {CAR_RENTAL, 4},
            {LUNCH,      8},
            {LUNCH,      2000},
            {LUNCH,      2001}};
    std::ostringstream out;
    std::streambuf *coutbuf = std::cout.rdbuf(); //save old buf
    std::cout.rdbuf(out.rdbuf()); //redirect std::cout to string stream!
    printReport(expenses, tp);
    std::cout.rdbuf(coutbuf); //reset to standard output again
    std::string actual = out.str();
    std::string expected = "Expenses Thu Jan  9 12:35:34 2014\n\n"
                           "Breakfast\t1\t \n"
                           "Breakfast\t1000\t \n"
                           "Breakfast\t1001\tX\n"
                           "Dinner\t2\t \n"
                           "Dinner\t5000\t \n"
                           "Dinner\t5001\tX\n"
                           "Car Rental\t4\t \n"
                           "Lunch\t8\t \n"
                           "Lunch\t2000\t \n"
                           "Lunch\t2001\tX\n"
                           "Meal expenses: 16014\n"
                           "Total expenses: 16018\n";
            CHECK(actual == expected);
}
