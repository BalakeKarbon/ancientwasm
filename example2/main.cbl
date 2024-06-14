000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. MAIN.
000300 DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 INDEX1 USAGE IS BINARY-LONG SIGNED.
       01 RETURN1 USAGE IS BINARY-LONG SIGNED.
       01 JSCODE PIC A(37) VALUE 'console.log("Hello from Javascript")'.
       01 RETURN2 USAGE IS BINARY-LONG SIGNED.
       01 RS PIC X(26) VALUE HIGH-VALUE.
       01 RSV USAGE IS BINARY-CHAR UNSIGNED.
      *01 RETURNP1 REDEFINES RETURN1 USAGE POINTER.
       PROCEDURE DIVISION.
       000-Main. *>Can this be something else?
           DISPLAY "Hello from COBOL"
           CALL 'emscripten_run_script' USING BY CONTENT JSCODE
001600     MOVE 26 TO RSV
           CALL 'ff_' USING BY REFERENCE RS, BY VALUE RSV,
               RETURNING RETURN2
           DISPLAY RS
           DISPLAY "ff return: " RETURN2
           PERFORM LOOP1 VARYING INDEX1 FROM 0 BY 1 UNTIL INDEX1 > 2
           STOP RUN.
       LOOP1.
           CALL 'f_' USING BY CONTENT INDEX1, RETURNING RETURN1
           DISPLAY "f return: " RETURN1.
       END PROGRAM MAIN.
