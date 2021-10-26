       IDENTIFICATION DIVISION.
       PROGRAM-ID. EXPENSE-REPORT.

       DATA DIVISION.
            WORKING-STORAGE SECTION.
            01 TOTAL PIC 9(10) VALUE 0.
            01 MEALS PIC 9(10) VALUE 0.
            01 EXPENSENAME PIC A(11).
            01 MEALOVEREXPENSESMARKER PIC A(1).
            01 WS-TABLE.
                05 WS-EXPENSES OCCURS 5 TIMES INDEXED BY I.
                    10 WS-TYPE PIC 9(1).
                    10 WS-AMOUNT PIC 9(10).
            01 FORMATTED-INT PIC Z(04)9.

       PROCEDURE DIVISION.
           MOVE 1 TO WS-TYPE(1)
           MOVE 1 TO WS-TYPE(2)
           MOVE 2 TO WS-TYPE(3)
           MOVE 2 TO WS-TYPE(4)
           MOVE 3 TO WS-TYPE(5)
           MOVE 5000 TO WS-AMOUNT(1)
           MOVE 5001 TO WS-AMOUNT(2)
           MOVE 1000 TO WS-AMOUNT(3)
           MOVE 1001 TO WS-AMOUNT(4)
           MOVE 4 TO WS-AMOUNT(5)
           PERFORM PRINTREPORT
           STOP RUN.

       PRINTREPORT.
           DISPLAY 'Expenses: '.
           MOVE 1 TO I
           PERFORM SHOWEXPENSEDETAIL
           MOVE MEALS TO FORMATTED-INT
           DISPLAY "Meals: "FORMATTED-INT.
           MOVE TOTAL TO FORMATTED-INT
           DISPLAY "Total: "FORMATTED-INT.

       SHOWEXPENSEDETAIL.
           IF WS-TYPE(I) = 1 OR 2
            ADD WS-AMOUNT(I) TO MEALS
           END-IF
           EVALUATE WS-TYPE(I)
                    WHEN 1 MOVE 'Dinner'      TO EXPENSENAME
                    WHEN 2 MOVE 'Breakfast'   TO EXPENSENAME
                    WHEN 3 MOVE 'Car Rental'  TO EXPENSENAME
           END-EVALUATE.
           IF WS-TYPE(I) = 1 AND WS-AMOUNT(I) > 5000
           OR WS-TYPE(I) = 2 AND WS-AMOUNT(I) > 1000
             MOVE 'X' TO MEALOVEREXPENSESMARKER
           ELSE
             MOVE ' ' TO MEALOVEREXPENSESMARKER
           END-IF.
           MOVE WS-AMOUNT(I) TO FORMATTED-INT
           DISPLAY EXPENSENAME FORMATTED-INT ' ' MEALOVEREXPENSESMARKER
           ADD WS-AMOUNT(I) TO TOTAL
           IF I < 5
               ADD 1 TO I
               PERFORM SHOWEXPENSEDETAIL
           END-IF.
