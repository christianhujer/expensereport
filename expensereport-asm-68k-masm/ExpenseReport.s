_LVOOpenLibrary 	EQU	-552
_LVOCloseLibrary	EQU	-414
_LVOFindTask		EQU	-294

_LVOWrite		EQU	-48

OS_VERSION		EQU	33

DINNER		EQU	1
BREAKFAST	EQU	2
CAR_RENTAL	EQU	3

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

	lea	(expenses),a0
	bsr.s	printReport

.closeDos
	move.l	(dosBase),a1
	jsr	(_LVOCloseLibrary,a6)
.exit
	move.l	(exitStatus),d0
	moveq	#1,d1
	rts

printReport
	movem.l	d2/d3/d5/d6/d7/a2/a6,-(sp)
	move.l	a0,a2
	moveq	#0,d5	; mealExpenses
	moveq	#0,d6	; totalExpenses

	move.l	(dosBase),a6

	move.l	(stdout),d1
	move.l	#expenseReport,d2
	moveq	#expenseReportEnd-expenseReport,d3
	jsr	(_LVOWrite,a6)

	move.l	(stdout),d1
	move.l	#newline,d2
	moveq	#1,d3
	jsr	(_LVOWrite,a6)

.loop
	move.l	(a2),d0
	beq	.loopDone

	cmp.l	#DINNER,d0
	beq.s	.meal
	cmp.l	#BREAKFAST,d0
	beq.s	.meal
	bra.s	.notMeal
.meal
	move.l	(4,a2),d1
	add.l	d1,d5
.notMeal

	lea	(expenseNames),a0
	move.l	(a0,d0*4),a0
	move.l	a0,d2
.countExpenseName
	move.b	(a0)+,d0
	bne.s	.countExpenseName
	move.l	a0,d3
	sub.l	d2,d3
	subq	#1,d3
	move.l	(stdout),d1
	jsr	(_LVOWrite,a6)

	lea	(tab),a0
	move.l	(stdout),d1
	move.l	a0,d2
	moveq	#1,d3
	jsr	(_LVOWrite,a6)

	move.l	(4,a2),d0
	lea	buffer,a0
	bsr	itoa10
	move.l	d0,d2
	move.l	d2,a0
.countAmount
	move.b	(a0)+,d0
	bne.s	.countAmount
	move.l	a0,d3
	sub.l	d2,d3
	subq	#1,d3
	move.l	(stdout),d1
	jsr	(_LVOWrite,a6)

	lea	(tab),a0
	move.l	(stdout),d1
	move.l	a0,d2
	moveq	#1,d3
	jsr	(_LVOWrite,a6)

	move.l	(a2),d0
	move.l	(4,a2),d1
	cmp.l	#DINNER,d0
	bne.s	.notDinner
	cmp.l	#5000,d1
	bgt.s	.mealOverExpense
	bra.s	.mealNotOverExpense
.notDinner
	cmp.l	#BREAKFAST,d0
	bne.s	.notBreakfast
	cmp.l	#1000,d1
	bgt.s	.mealOverExpense
	bra.s	.mealNotOverExpense
.notBreakfast
	bra.s	.mealNotOverExpense
.mealOverExpense
	lea	(mealOverExpensesMarker),a0
	bra.s	.printMealOverExpensesMarker
.mealNotOverExpense
	lea	(mealNotOverExpensesMarker),a0
.printMealOverExpensesMarker
	move.l	(stdout),d1
	move.l	a0,d2
	moveq	#1,d3
	jsr	(_LVOWrite,a6)

	lea	(newline),a0
	move.l	(stdout),d1
	move.l	a0,d2
	moveq	#1,d3
	jsr	(_LVOWrite,a6)

	move.l	(4,a2),d1
	add.l	d1,d6

	addq	#8,a2	; next expense
	bra	.loop
.loopDone

	move.l	(stdout),d1
	lea	(meals),a0
	move.l	a0,d2
	moveq	#mealsEnd-meals,d3
	jsr	(_LVOWrite,a6)

	move.l	d5,d0
	lea	(buffer),a0
	bsr	itoa10
	move.l	d0,d2
	move.l	d2,a0
.count2
	move.b	(a0)+,d0
	bne.s	.count2
	move.l	a0,d3
	sub.l	d2,d3
	subq	#1,d3
	move.l	(stdout),d1
	move.l	(dosBase),a6
	jsr	(_LVOWrite,a6)

	move.l	(stdout),d1
	lea	(newline),a0
	move.l	a0,d2
	moveq	#1,d3
	jsr	(_LVOWrite,a6)

	move.l	(stdout),d1
	lea	(total),a0
	move.l	a0,d2
	moveq	#totalEnd-total,d3
	jsr	(_LVOWrite,a6)

	move.l	d6,d0
	lea	(buffer),a0
	bsr	itoa10
	move.l	d0,d2
	move.l	d2,a0
.count3
	move.b	(a0)+,d0
	bne.s	.count3
	move.l	a0,d3
	sub.l	d2,d3
	subq	#1,d3
	move.l	(stdout),d1
	move.l	(dosBase),a6
	jsr	(_LVOWrite,a6)

	move.l	(stdout),d1
	lea	(newline),a0
	move.l	a0,d2
	moveq	#1,d3
	jsr	(_LVOWrite,a6)
	movem.l	(sp)+,d2/d3/d5/d6/d7/a2/a6
	rts

; Returns the length of a NUL-terminated string, without the NUL byte
; @param a0 NUL-terminated string
; @return d0 Length of the NUL-terminated string
; @destroys d0,a0,a1
strlen
	move.l	a0,a1
.count
	move.b	(a1)+,d0
	bne.s	.count
	move.l	a1,d0
	sub.l	a0,d0
	subq	#1,d0
	rts

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
	bne.s .loop

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
tab			dc.b	9,0
newline			dc.b	10,0
expenseReport		dc.b	"Expenses: "
expenseReportEnd	dc.b	0
meals			dc.b	"Meal Expenses: "
mealsEnd		dc.b	0
total			dc.b	"Total Expenses: "
totalEnd		dc.b	0
mealOverExpensesMarker	dc.b	"X",0
mealNotOverExpensesMarker	dc.b	" ",0

	SECTION	DATA
	align.l
expenses
	dc.l	DINNER,5000
	dc.l	DINNER,5001
	dc.l	BREAKFAST,1000
	dc.l	BREAKFAST,1001
	dc.l	CAR_RENTAL,4
	dc.l	0,0

	SECTION	BSS
exitStatus	ds.l	1
dosBase		ds.l	1
stdout		ds.l	1
buffer		ds.b	11

	END
