.equ    STDOUT,         1
.equ    EXIT_SUCCESS,   0
.equ    write,  64
.equ    exit,   93

.macro push reg
    str     \reg, [sp, #-16]!
.endm

.macro pop reg
    ldr     \reg, [sp], #16
.endm

.macro pushp reg1 reg2
    stp     \reg1, \reg2, [sp, #-16]!
.endm

.macro popp reg1 reg2
    ldp     \reg1, \reg2, [sp], #16
.endm

.text
    .global _start

_start:
    ldr     x0, =expenses
    bl      printReport

    mov     x0, #EXIT_SUCCESS
    mov     x8, #exit
    svc     #0

printReport:
    pushp   x29, lr

    mov     x29, x0
    bl      printHeader

    mov     x0, x29
    bl      printDetails

    mov     x0, x29
    bl      printSummary

    popp    x29, lr
    ret

printHeader:
    ldr     x0, =header
    b       print

printDetails:
    pushp   x29, lr
    mov     x29, x0
.loop:
    ldr     x0, [x29]
    cbz     x0, .loopDone

    mov     x0, x29
    bl      printDetail

    add     x29, x29, #16
    b       .loop

.loopDone:
    popp    x29, lr
    ret

printDetail:
    pushp   x29, lr
    mov     x29, x0

    bl      Expense_getName
    bl      print

    bl      printTab

    mov     x0, x29
    bl      Expense_getAmount
    bl      printN

    bl      printTab

    mov     x0, x29
    bl      Expense_getOverLimitMarker
    bl      print

    bl      printNL

    popp    x29, lr
    ret

Expense_getOverLimitMarker:
    push    lr

    bl      Expense_isOverLimit
    cbnz    x0, .overLimitMarker
.notOverLimitMarker:
    ldr     x0, =mealNotOverExpensesMarker
    b       .markerDone
.overLimitMarker:
    ldr     x0, =mealOverExpensesMarker
    b       .markerDone
.markerDone:

    pop     lr
    ret

printSummary:
    pushp   x29, lr
    mov     x29, x0

    ldr     x0, =meals
    bl      print
    mov     x0, x29
    bl      sumMeals
    bl      printN
    bl      printNL

    ldr     x0, =total
    bl      print
    mov     x0, x29
    bl      sumTotal
    bl      printN
    bl      printNL

    popp    x29, lr
    ret

sumMeals:
    push    lr
    mov     x3, x0
    mov     x2, xzr
.sumMealsLoop:
    mov     x0, x3
    bl      Expense_getType
    cbz     x0, .sumMealsLoopDone
    mov     x0, x3
    bl      Expense_isMeal
    cbz     x0, .notMeal
    mov     x0, x3
    bl      Expense_getAmount
    add     x2, x2, x0
.notMeal:
    add     x3, x3, #16
    b       .sumMealsLoop
.sumMealsLoopDone:
    pop     lr
    mov     x0, x2
    ret

sumTotal:
    push    lr
    mov     x1, x0
    mov     x2, xzr
.sumTotalLoop:
    mov     x0, x1
    bl      Expense_getType
    cbz     x0, .sumTotalLoopDone
    mov     x0, x1
    bl      Expense_getAmount
    add     x2, x2, x0
    add     x1, x1, #16
    b       .sumTotalLoop
.sumTotalLoopDone:
    pop     lr
    mov     x0, x2
    ret

printNL:
    ldr     x0, =newline
    b       print

printTab:
    ldr     x0, =tab
    b       print

// Writes a number to STDOUT.
// @param x0 Number to write
printN:
    push    lr
    mov     x1, x0
    ldr     x0, =buffer
    bl      itoa10
    pop     lr
    b       print

// Writes a string to STDOUT.
// @param x0 String to write
print:
    mov     x1, x0
.loopX:
    ldrb    w2, [x0], 1
    cbnz    w2, .loopX
    sub     x2, x0, x1
    sub     x2, x2, #1
    mov     x0, #STDOUT
    mov     x8, #write
    svc     #0
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
    cbnz    x1, .itoa10_loop
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

Expense_getName:
    ldr     x0, [x0]
    ldr     x0, [x0]
    ret

Expense_getType:
    ldr     x0, [x0]
    ret

Expense_getAmount:
    ldr     x0, [x0, #8]
    ret

Expense_isMeal:
    push    lr
    bl      Expense_getType
    ldr     x0, [x0, #16]
    pop     lr
    ret

Expense_isOverLimit:
    push    lr
    mov     x3, x0
    bl      Expense_getType
    ldr     x2, [x0, #8]
    mov     x0, x3
    bl      Expense_getAmount
    cmp     x0, x2
    cset    x0, hi
    pop     lr
    ret

.data
header:
    .asciz  "Expense Report\n"
meals:
    .asciz  "Meal Expenses: "
total:
    .asciz  "Total Expenses: "
tab:
    .asciz  "\t"
newline:
    .asciz "\n"
mealOverExpensesMarker:
    .asciz  "X"
mealNotOverExpensesMarker:
    .asciz  " "

dinnerName:
    .asciz  "Dinner"
breakfastName:
    .asciz  "Breakfast"
carRentalName:
    .asciz  "Car Rental"
lunchName:
    .asciz  "Lunch"

dinner:
    .quad   dinnerName
    .quad   5000
    .quad   1

breakfast:
    .quad   breakfastName
    .quad   1000
    .quad   1

carRental:
    .quad   carRentalName
    .quad   18446744073709551615
    .quad   0

lunch:
    .quad   lunchName
    .quad   2000
    .quad   1

.data
expenses:
    .quad   dinner, 5000
    .quad   dinner, 5001
    .quad   breakfast, 1000
    .quad   breakfast, 1001
    .quad   carRental, 4
    .quad   lunch, 2000
    .quad   lunch, 2001
    .quad   0, 0

.bss
buffer:
    .fill   11,1,0
