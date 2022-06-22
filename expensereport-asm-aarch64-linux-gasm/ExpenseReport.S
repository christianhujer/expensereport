.equ    STDOUT,         1
.equ    EXIT_SUCCESS,   0
.equ    write,  64
.equ    exit,   93

.equ    DINNER, 1
.equ    BREAKFAST,  2
.equ    CAR_RENTAL, 3

.text
    .global _start

_start:
    ldr     x0, =expenses
    bl      printReport

    mov     x0, #EXIT_SUCCESS
    mov     x8, #exit
    svc     #0

printReport:
    str     x30, [sp,#16]!
    mov     x9, x0              // x9 = current expese pointer
    mov     x12, xzr            // x12 = meal expenses
    mov     x13, xzr            // x13 = total expenses

    mov     x0, #STDOUT
    ldr     x1, =header
    mov     x2, #headerLen
    mov     x8, #write
    svc     #0

.loop:
    ldr     x10, [x9], #8       // x10 = expense type
    cmp     xzr, x10
    beq     .loopDone
    ldr     x11, [x9], #8       // x11 = expense amount

    cmp     x10, #DINNER
    beq     .mealExpense
    cmp     x10, #BREAKFAST
    beq     .mealExpense
    b       .notMeal
.mealExpense:
    add     x12, x12, x11
.notMeal:

.printExpenseName:
    mov     x0, #STDOUT
    ldr     x1, =expenseNames
    ldr     x1, [x1, x10, LSL#3]
    ldr     x2, =expenseNameLengths
    ldr     x2, [x2, x10, LSL#3]
    mov     x8, #write
    svc     #0

    mov     x0, #STDOUT
    ldr     x1, =tab
    mov     x2, #tabLen
    mov     x8, #write
    svc     #0

    ldr     x0, =buffer
    mov     x1, x11
    bl      itoa10
    mov     x1, x0
.lenLoop:
    ldrb    w2, [x0], 1
    cbnz    w2, .lenLoop
    sub     x2, x0, x1
    sub     x2, x2, #1
    mov     x0, #STDOUT
    mov     x8, #write
    svc     #0

    mov     x0, #STDOUT
    ldr     x1, =tab
    mov     x2, #tabLen
    mov     x8, #write
    svc     #0

    cmp     x10, DINNER
    cset    x1, eq
    mov     x0, 5000
    cmp     x11, x0
    cset    x2, gt
    ands    x3, x2, x1
    bne     .mealOverExpense
    cmp     x10, BREAKFAST
    cset    x1, eq
    mov     x0, 1000
    cmp     x11, x0
    cset    x2, gt
    ands    x3, x2, x1
    bne     .mealOverExpense
.mealNotOverExpense:
    ldr     x1, =mealNotOverExpensesMarker
    b       .printMealOverExpensesMarker
.mealOverExpense:
    ldr     x1, =mealOverExpensesMarker
    b       .printMealOverExpensesMarker
.printMealOverExpensesMarker:
    mov     x2, #1
    mov     x0, #STDOUT
    mov     x8, #write
    svc     #0

    mov     x0, #STDOUT
    ldr     x1, =newline
    mov     x2, #newlineLen
    mov     x8, #write
    svc     #0

    add     x13, x13, x11
    b       .loop

.loopDone:

    mov     x0, #STDOUT
    ldr     x1, =meals
    mov     x2, #mealsLen
    mov     x8, #write
    svc     #0

    ldr     x0, =buffer
    mov     x1, x12
    bl      itoa10
    mov     x1, x0
.lenLoop2:
    ldrb    w2, [x0], 1
    cbnz    w2, .lenLoop2
    sub     x2, x0, x1
    sub     x2, x2, #1
    mov     x0, #STDOUT
    mov     x8, #write
    svc     #0

    mov     x0, #STDOUT
    ldr     x1, =newline
    mov     x2, #newlineLen
    mov     x8, #write
    svc     #0

    mov     x0, #STDOUT
    ldr     x1, =total
    mov     x2, #totalLen
    mov     x8, #write
    svc     #0

    ldr     x0, =buffer
    mov     x1, x13
    bl      itoa10
    mov     x1, x0
.lenLoop3:
    ldrb    w2, [x0], 1
    cbnz    w2, .lenLoop3
    sub     x2, x0, x1
    sub     x2, x2, #1
    mov     x0, #STDOUT
    mov     x8, #write
    svc     #0

    mov     x0, #STDOUT
    ldr     x1, =newline
    mov     x2, #newlineLen
    mov     x8, #write
    svc     #0

    ldr     x30, [sp], #16
    ret

// Converts a number into a decimal string.
// @param x0 buffer in which to convert the number.
// @param x1 number to convert
// @return x0 buffer from x0
itoa10:
    mov     x6, x0
    mov     x2, #10
    mov     x5, #'0'

.itoa10_loop:
    udiv    x3, x1, x2
    msub    x4, x3, x2, x1
    add     x4, x4, x5
    strb    w4, [x0], #1
    mov     x1, x3
    cmp     x1, xzr
    bne     .itoa10_loop
    strb    wzr, [x0], #-1

    mov     x1, x6
.reverse:
    cmp     x0, x1
    ble     .reverseDone
    ldrb    w2,[x0]
    ldrb    w3,[x1]
    strb    w3,[x0], #-1
    strb    w2,[x1], #1
    b       .reverse

.reverseDone:
    mov     x0,x6
    ret

.data
header:
    .ascii  "Expense Report\n"
    headerLen = . - header
meals:
    .ascii  "Meal Expenses: "
    mealsLen = . - meals
total:
    .ascii  "Total Expenses: "
    totalLen = . - total
tab:
    .ascii  "\t"
    tabLen = . - tab
newline:
    .ascii "\n"
    newlineLen = . - newline
mealOverExpensesMarker:
    .ascii  "X"
mealNotOverExpensesMarker:
    .ascii  " "

dinner:
    .ascii  "Dinner"
    dinnerLen = . - dinner
breakfast:
    .ascii  "Breakfast"
    breakfastLen = . - breakfast
carRental:
    .ascii  "Car Rental"
    carRentalLen = . - carRental

expenseNames:
    .quad   0
    .quad   dinner
    .quad   breakfast
    .quad   carRental
expenseNameLengths:
    .quad   0
    .quad   dinnerLen
    .quad   breakfastLen
    .quad   carRentalLen

expenses:
    .quad   DINNER, 5000
    .quad   DINNER, 5001
    .quad   BREAKFAST, 1000
    .quad   BREAKFAST, 1001
    .quad   CAR_RENTAL, 4
    .quad   0, 0

.bss
buffer:
    .fill   11,1,0
