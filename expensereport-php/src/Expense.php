<?php

namespace Refactor\ExpenseReportPhp;

const DINNER = 1;
const BREAKFAST = 2;
const CAR_RENTAL = 3;

class Expense
{
    public $type;
    public $amount;

    function __construct($type, $amount)
    {
        $this->type = $type;
        $this->amount = $amount;
    }
}
