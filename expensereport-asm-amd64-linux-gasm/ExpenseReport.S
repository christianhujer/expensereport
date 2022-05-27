.equ    STDOUT,         1
.equ    EXIT_SUCCESS,   0
.equ    write,  1
.equ    exit,   60

.equ    DINNER, 1
.equ    BREAKFAST,  2
.equ    CAR_RENTAL, 3

.text
    .global _start

_start:
    endbr64

    leaq    expenses(%rip),%rdi
    call    printReport

    mov     $EXIT_SUCCESS,%rdi
    mov     $exit,%rax
    syscall

printReport:
    endbr64

    push    %rbp                // current expense pointer
    push    %r15                // current expense type
    push    %r14                // current expense amount
    push    %r13                // total
    push    %r12                // meals

    mov     %rdi,%rbp
    xor     %r13,%r13
    xor     %r12,%r12

    mov     $STDOUT,%rdi
    leaq    header(%rip),%rsi
    mov     $headerLen,%rdx
    mov     $write,%rax
    syscall

.loop:
    mov     (%rbp),%r15
    cmp     $0,%r15
    jz      .loopDone
    add     $8,%rbp
    mov     (%rbp),%r14
    add     $8,%rbp

    cmp     $DINNER,%r15
    jz      .mealExpense
    cmp     $BREAKFAST,%r15
    jz      .mealExpense
    jmp     .notMeal
.mealExpense:
    add     %r14,%r12
.notMeal:

.printExpenseName:
    lea     expenseNames(%rip), %rsi
    movq    (%rsi, %r15, 8), %rsi
    lea     expenseNameLengths(%rip), %rdx
    movq    (%rdx, %r15, 8), %rdx
    mov     $STDOUT,%rdi
    mov     $write,%rax
    syscall

    mov     $STDOUT,%rdi
    leaq    tab(%rip),%rsi
    mov     $tabLen,%rdx
    mov     $write,%rax
    syscall

    mov     %r14,%rsi
    leaq    buffer(%rip),%rdi
    call    itoa10

    mov     %rax,%rsi
    xor     %al,%al
    xor     %rdx,%rdx
.lenLoop:
    mov     (%rsi,%rdx),%al
    cmp     $0, %al
    jz      .lenDone
    inc     %rdx
    jmp     .lenLoop
.lenDone:
    mov     $STDOUT,%rdi
    mov     $write,%rax
    syscall

    mov     $STDOUT,%rdi
    leaq    tab(%rip),%rsi
    mov     $tabLen,%rdx
    mov     $write,%rax
    syscall

    cmp     $DINNER,%r15
    jnz     .notDinner
.dinner:
    cmp     $5000,%r14
    jg      .mealOverExpense
    jmp     .mealNotOverExpense
.notDinner:
    cmp     $BREAKFAST,%r15
    jnz     .notBreakfast
    cmp     $1000,%r14
    jg      .mealOverExpense
    jmp     .mealNotOverExpense
.mealOverExpense:
    leaq    mealOverExpensesMarker(%rip), %rsi
    jmp     .printMealOverExpensesMarker
.notBreakfast:
.mealNotOverExpense:
    leaq    mealNotOverExpensesMarker(%rip), %rsi
.printMealOverExpensesMarker:
    mov     $1,%rdx
    mov     $STDOUT,%rdi
    mov     $write,%rax
    syscall

    mov     $STDOUT,%rdi
    leaq    newline(%rip),%rsi
    mov     $newlineLen,%rdx
    mov     $write,%rax
    syscall

    add     %r14,%r13

    jmp     .loop
.loopDone:

    mov     $STDOUT,%rdi
    leaq    meals(%rip),%rsi
    mov     $mealsLen,%rdx
    mov     $write,%rax
    syscall

    mov     %r12,%rsi
    leaq    buffer(%rip),%rdi
    call    itoa10

    mov     %rax,%rsi
    xor     %al,%al
    xor     %rdx,%rdx
.lenLoop2:
    mov     (%rsi,%rdx),%al
    cmp     $0, %al
    jz      .lenDone2
    inc     %rdx
    jmp     .lenLoop2
.lenDone2:
    mov     $STDOUT,%rdi
    mov     $write,%rax
    syscall

    mov     $STDOUT,%rdi
    leaq    newline(%rip),%rsi
    mov     $newlineLen,%rdx
    mov     $write,%rax
    syscall

    mov     $STDOUT,%rdi
    leaq    total(%rip),%rsi
    mov     $totalLen,%rdx
    mov     $write,%rax
    syscall

    mov     %r13,%rsi
    leaq    buffer(%rip),%rdi
    call    itoa10

    mov     %rax,%rsi
    xor     %al,%al
    xor     %rdx,%rdx
.lenLoop3:
    mov     (%rsi,%rdx),%al
    cmp     $0, %al
    jz      .lenDone3
    inc     %rdx
    jmp     .lenLoop3
.lenDone3:
    mov     $STDOUT,%rdi
    mov     $write,%rax
    syscall

    mov     $STDOUT,%rdi
    leaq    newline(%rip),%rsi
    mov     $newlineLen,%rdx
    mov     $write,%rax
    syscall

    pop     %r12
    pop     %r13
    pop     %r14
    pop     %r15
    pop     %rbp
    ret

// Converts a number into a decimal string.
// @param %rdi buffer in which to convert the number.
// @param %rsi number to convert
// @return %rax buffer from %rdi
itoa10:
    endbr64
    push    %rdi
    cld
    mov     $10,%rcx
    mov     %rsi,%rax
    mov     %rdi,%rsi

.itoa10_loop:
    xor     %rdx,%rdx
    div     %rcx
    add     $'0', %rdx
    mov     %dl, (%rdi)
    inc     %rdi
    cmp     $0, %rax
    jnz     .itoa10_loop

    xor     %dl,%dl
    mov     %dl, (%rdi)
    dec     %rdi

.reverse:
    cmp     %rsi,%rdi
    jle     .reverseDone
    mov     (%rsi),%al
    mov     (%rdi),%ah
    mov     %ah,(%rsi)
    mov     %al,(%rdi)
    dec     %rdi
    inc     %rsi
    jmp     .reverse
.reverseDone:
    pop     %rax
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

buffer:
    .fill   11,1,0
