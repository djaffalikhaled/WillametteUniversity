;	Hayden Parker
;	Lab 5 - 3/4/13
;	Part 4 - Bubble sort

; ending condition is reading in a period
	DATA '.'
	COPY DR,R1 ; R1 holds the value to compare against to see if we are done
; first setup a pointer to the beginning of free RAM space
	DATA #base
	COPY DR,R0	; increment R0 as we go
	COPY R0,R5	; hold onto the heap pointer
; set J0 as our finished reading in jump
	DATA #setup
	COPY DR,J0
; set J1 to be our sort routine
	DATA #sort
	COPY DR,J1
; set J2 to be our print routine
	DATA #printstart
	COPY DR,J2
; set J3 to be our halt
	DATA #switch
	COPY DR,J3
; set R4 to be 1 so setup doesn't leave the first time
	SET R4,x1

#readchar
	READ R3,AD	; read in a new char in R3
	STORE R3,R0	; Store that char in the free part of RAM
	INC R0,1	; Move to the next part of RAM
	COPY R1,R2	; R2 now stores '.'
	SUB R3,R2	; subtract R3 from the period (R2).  If R3 was a period, R2 will be 0
	JPIF R2,EZ,J0	; if R2 is 0, the char we read in was a '.', we are done
	JUMP #readchar	; start over
	
#setup	; this routine will copy the heap pointer R5 to R0 to start a new sort round
	JPIF R4,EZ,J2 ; it will also jump to the print section if the lst sort round did nothing
	SUB R4,R4	  ; clear R4 for the next sort
	COPY R5,R0	  ; make a copy of the the heap pointer in R0

#sort	; all registers are safe except R5 and R1.  R0 should be used for position in RAM
	COPY R0,R2
	INC R2,1
	LOAD R2,R2
	SUB R1,R2
	JPIF R2,EZ,J0 ; everything from here up is a check if the next char is a '.'.  if so, go back to setup
	LOAD R2,R0
	INC R0,1
	LOAD R3,R0	; here we loaded two ram positions into R2 and R3
	COPY R3,R6
	SUB R2,R6
	JPIF R6,GZ,J3 ; jump to switch if they are in the wrong order
	JUMP #sort

#switch
	INC R0,-1
	STORE R3,R0
	INC R0,1
	STORE R2,R0
	INC R4,1
	JPIF PC,GZ,J1

#printstart
	DATA #halt
	COPY DR,J1

#print
	LOAD R0,R5
	WRITE R0,AD
	SUB R1,R0
	JPIF R0,EZ,J1
	INC R5,1
	JUMP #print

#halt
	HALT

#base

; assembled: 32E 9E1 333 9E0 905 315 9EA 318 9EB 32A 9EC 324 9ED 241 C32 B30 400 912 732 E28 F0E E4A 744 950 902 420 A22 712 E28 A20 400 A30 936 726 E67 F18 408 B30 400 B20 440 EF5 332 9EB A05 D02 710 E09 450 F2C 000
