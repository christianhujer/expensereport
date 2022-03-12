#ifndef EXPENSEREPORT_H
#define EXPENSEREPORT_H

#include <list>

using namespace std;

enum Type
{
    BREAKFAST, DINNER, CAR_RENTAL
};

class Expense
{
    public:
    Type type;
    int amount;
};

extern void printReport(list<Expense> expenses);

#endif
