       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 INDEX1 USAGE IS BINARY-LONG SIGNED.
       01 RETURNI1 USAGE IS BINARY-DOUBLE UNSIGNED.
      *01 RETURNV1 REDEFINES RETURNI1 USAGE POINTER.
       PROCEDURE DIVISION.
       000-Main. *>Can this be something else?
           PERFORM LOOP1 VARYING INDEX1 FROM 0 BY 1 UNTIL INDEX1 > 16
           STOP RUN.
       LOOP1.
           CALL 'r_' USING BY CONTENT INDEX1, RETURNING RETURNI1
           IF RETURNI1 = 5
               DISPLAY "Y" RETURNI1
           ELSE
               DISPLAY "N" RETURNI1
           END-IF.
       END PROGRAM MAIN.