_LVOOpenLibrary 	EQU	-552
_LVOCloseLibrary	EQU	-414
_LVOFindTask		EQU	-294

_LVOWrite		EQU	-48

OS_VERSION		EQU	33

	MC68020 ; using divul.l for itoa

	SECTION	TEXT
main
	move.l	4.w,a6
.openDos
	lea	(dosName),a1
	moveq	#OS_VERSION,d0
	jsr	(_LVOOpenLibrary,a6)
	move.l	d0,dosBase
	bne.s	.dosOk
.dosError
	move.l	#2,(exitStatus)
	bra	.exit
.dosOk

.cli
	sub.l	a1,a1
	jsr	(_LVOFindTask,a6)
	move.l	d0,a0
	tst.l	(172,a0)		; CLI Process?
	bne.s	.cliOk
.cliError
	move.l	#2,(exitStatus)
	bra.s	.closeDos
.cliOk
	move.l	(160,a0),d0
	move.l	d0,(stdout)

	move.l	(dosBase),a6
	lea	(expenses),a0
	bsr	ExpenseList_printReport

.closeDos
	move.l	(dosBase),a1
	jsr	(_LVOCloseLibrary,a6)
.exit
	move.l	(exitStatus),d0
	moveq	#1,d1
	rts

ExpenseList_printReport
	movem.l	a2,-(sp)

	move.l	a0,a2
	bsr	ExpenseList_printReportHeader

	move.l	a2,a0
	bsr	ExpenseList_printReportDetails

	move.l	a2,a0
	bsr	ExpenseList_printReportSummary

	movem.l	(sp)+,a2
	rts

ExpenseList_printReportHeader
	lea	(expenseReport),a0
	bsr	printString
	bra	_newline

ExpenseList_printReportDetails
	movem.l	a2,-(sp)
	move.l	a0,a2
.loop
	move.l	(a2),d0
	beq	.loopDone
	move.l	a2,a0
	bsr	Expense_printDetail
	addq	#8,a2	; next expense
	bra	.loop
.loopDone

	movem.l	(sp)+,a2
	rts

Expense_printDetail
	movem.l	d2/d3/a2,-(sp)
	move.l	a0,a2
	bsr	Expense_getName
	move.l	d0,a0
	bsr	printString

	bsr	_tab

	move.l	(4,a2),d0
	bsr	printNumber

	bsr	_tab

	move.l	a2,a0
	bsr	Expense_isOverLimit
	beq.s	.mealNotOverExpense
.mealOverExpense
	lea	(mealOverExpensesMarker),a0
	bra.s	.printMealOverExpensesMarker
.mealNotOverExpense
	lea	(mealNotOverExpensesMarker),a0
.printMealOverExpensesMarker
	bsr	printString
	bsr	_newline
	movem.l	(sp)+,d2/d3/a2
	rts

ExpenseList_printReportSummary
	movem.l	a3,-(sp)
	move.l	a0,a3

	move.l	a3,a0
	bsr	ExpenseList_sumMeals
	lea	(meals),a0
	bsr	.printReportSummaryLine

	move.l	a3,a0
	bsr	ExpenseList_sumTotal
	lea	(total),a0
	bsr	.printReportSummaryLine

	movem.l	(sp)+,a3
	rts
; @param a0 Label to print.
; @param d0 Number to print
.printReportSummaryLine
	movem.l	d0,-(sp)
	bsr	printString
	movem.l	(sp)+,d0
	bsr	printNumber
	bra	_newline

; Calculates the sum of all expenses.
; @param a0 Expenses, terminated with an expense of type NULL
; @return d0 Sum of all expenses.
; @destroys a0,d0,d1
ExpenseList_sumTotal
	moveq	#0,d0
.loop
	move.l	(a0)+,d1
	beq	.loopDone
	add.l	(a0)+,d0
	bra	.loop
.loopDone
	rts

; Calculates the sum of all meal expenses.
; @param a0 Expenses, terminated with an expense of type NULL
; @return d0 Sum of all expenses.
; @destroys a0,a1,d0,d1
ExpenseList_sumMeals
	movem.l	d2/d3,-(a7)
	move.l	a0,a1
	moveq	#0,d3
.loop
	move.l	(a1)+,d0
	beq	.loopDone
	move.l	d0,a0
	move.l	(a1)+,d2
	bsr	ExpenseType_isMeal
	beq	.notMeal
	add.l	d2,d3
.notMeal
	bra.s	.loop
.loopDone
	move.l	d3,d0
	movem.l	(a7)+,d2/d3
	rts

; Returns whether an expense is a meal.
; @param a0 Expense
; @return d0 1 if the expense is a meal, 0 otherwise.
; @return CC=Z̅ if the expense is a meal, Z otherwise.
; @destroys a0,d0
Expense_isMeal
	move.l	(a0),a0
	; fallthrough
; Returns whether an expense type is a meal.
; @param a0 ExpenseType
; @return d0 1 if the expense is a meal, 0 otherwise.
; @return CC=Z̅ if the expense is a meal, Z otherwise.
; @destroys d0
ExpenseType_isMeal
	move.l	(8,a0),d0
	rts

; Returns whether an expense is over its limit.
; @param a0 Expense
; @return d0 1 if the expense is over its limit, 0 otherwise.
; @return CC=Z̅ if the expense is over its limit, Z otherwise.
; @destroys a0,d0
Expense_isOverLimit
	move.l	(4,a0),d0
	move.l	(a0),a0
	cmp.l	(4,a0),d0
	bls.s	.notOverLimit
.overLimit
	moveq	#1,d0
	rts
.notOverLimit
	moveq	#0,d0
	rts

; Returns the name of an expense.
; @param a0 Expense
; @return d0 The name of the expense.
; @destroys a0,d0
Expense_getName
	move.l	(a0),a0
	; fallthrough
; Returns the name of an expense type.
; @param a0 ExpenseType
; @return d0 The name of the expense.
; @destroys d0
ExpenseType_getName
	move.l	(a0),d0
	rts

; @param a0 String to print
printString
	movem.l	d2/d3,-(sp)
	move.l	a0,d2
.strlen
	move.b	(a0)+,d0
	bne.s	.strlen
	move.l	a0,d3
	sub.l	d2,d3
	subq	#1,d3
	move.l	(stdout),d1
	jsr	(_LVOWrite,a6)
	movem.l	(sp)+,d2/d3
	rts

; @param d0 Number to print
printNumber
	lea	buffer,a0
	bsr	itoa10
	move.l	d0,a0
	bra	printString

_print1
	move.l	a0,d2
	move.l	(stdout),d1
	moveq	#1,d3
	jmp	(_LVOWrite,a6)
_tab
	lea	(tab),a0
	bra	_print1
_newline
	lea	(newline),a0
	bra	_print1


; Converts a number into a decimal string
; @param a0 buffer in which to convert the number
; @param d0 number to convert
; @return d0 buffer from a0
; @destroys d1,a0,a1
itoa10
	movem.l	a0/d2,-(sp)
.loop
	moveq	#10,d1
	divul.l	d1,d1:d0
	add.l	#'0',d1
	move.b	d1,(a0)+
	tst.l	d0
	bne.s	.loop

	move.b	#0,d1
	move.b	d1,(a0)+

	movem.l	(sp)+,a0/d2
	move.l	a0,d0

	move.l	a0,a1
.count
	move.b	(a1)+,d1
	bne.s	.count
	subq	#2,a1

.reverse
	cmp.l	a0,a1
	ble.s	.reverseDone
	move.b	(a0),d1
	move.b	(a1),(a0)
	move.b	d1,(a1)
	subq	#1,a1
	addq	#1,a0
	bra.s	.reverse
.reverseDone
	rts

	SECTION	DATA
dosName		dc.b	"dos.library",0

	SECTION	DATA
			align.l
expenseNames		dc.l	0,dinner,breakfast,car_rental
dinner			dc.b	"Dinner",0
breakfast		dc.b	"Breakfast",0
car_rental		dc.b	"Car Rental",0
lunch			dc.b	"Lunch",0
tab			dc.b	9,0
newline			dc.b	10,0
expenseReport		dc.b	"Expenses: ",0
meals			dc.b	"Meal Expenses: ",0
total			dc.b	"Total Expenses: ",0
mealOverExpensesMarker	dc.b	"X",0
mealNotOverExpensesMarker	dc.b	" ",0
	align.l
ExpenseTypes
DINNER		dc.l	dinner,5000,1
BREAKFAST	dc.l	breakfast,1000,1
CAR_RENTAL	dc.l	car_rental,-1,0
LUNCH		dc.l	lunch,2000,1

	SECTION	DATA
	align.l
expenses
	dc.l	DINNER,5000
	dc.l	DINNER,5001
	dc.l	BREAKFAST,1000
	dc.l	BREAKFAST,1001
	dc.l	CAR_RENTAL,4
	dc.l	LUNCH,2000
	dc.l	LUNCH,2001
	dc.l	0,0

	SECTION	BSS
exitStatus	ds.l	1
dosBase		ds.l	1
stdout		ds.l	1
buffer		ds.b	11

	END
