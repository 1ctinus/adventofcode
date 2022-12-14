       IDENTIFICATION DIVISION.
       PROGRAM-ID. read-file-line-by-line.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT input-file ASSIGN TO "3.txt"
           ORGANIZATION LINE SEQUENTIAL
           FILE STATUS input-file-status.

       DATA DIVISION.
       FILE SECTION.
       FD  input-file.
       01  input-record PIC X(256).
       WORKING-STORAGE SECTION.
       01  input-file-status PIC 99.
           88  file-is-ok    VALUE 0.
           88  end-of-file   VALUE 10.
       01  line-count        PIC 9(6).
       01 line1 PIC X(256).
       01 line2 PIC X(256).
       01 line3 PIC X(256).
       01 chosenone PIC X(1).
       01 h pic 9(1) value 1.
       01 linelength pic 9(4).
       01 k pic 9(4) value 1.
       01 j pic 9(4) value 1.
       01 i pic 9(4) value 1.
       01 out pic 9(16) value 0.
       01 lookup pic X(52) value
           "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".
       PROCEDURE DIVISION.
       main.
           OPEN INPUT input-file
           IF NOT file-is-ok
             DISPLAY "The file could not be opened."
GOBACK
           END-IF

           PERFORM VARYING line-count FROM 1 BY 1 UNTIL end-of-file

             READ input-file
               IF h = 1
                 MOVE FUNCTION TRIM(input-record) TO line1
               END-IF
               IF h = 2
                 MOVE FUNCTION TRIM(input-record) TO line2
               END-IF
               IF h = 3
                 MOVE 0 TO h
                 MOVE FUNCTION TRIM(input-record) TO line3 
                 PERFORM VARYING i FROM 1 BY 1 UNTIL i > 
                   FUNCTION BYTE-LENGTH(FUNCTION TRIM(line1))
                   PERFORM VARYING j FROM 1 BY 1 UNTIL j > 
                     FUNCTION BYTE-LENGTH(FUNCTION TRIM(line2))
                     PERFORM VARYING k FROM 1 BY 1 UNTIL k > 
                       FUNCTION BYTE-LENGTH(FUNCTION TRIM(line3))
                       IF line1(i:1) = line2(j:1)
                         IF line1(i:1) = line3(k:1)
                           MOVE line2(j:1) TO chosenone
                         END-IF
                       END-IF

                     END-PERFORM
                   END-PERFORM
                 END-PERFORM
                 MOVE 1 TO i
                 PERFORM VARYING i FROM 1 BY 1 UNTIL i = 53
                   IF chosenone = lookup(i:1)
                     ADD i to out
                   END-IF
                 END-PERFORM  
                 DISPLAY out
               END-IF
               ADD 1 TO h
           END-PERFORM
           CLOSE input-file
GOBACK
           .
