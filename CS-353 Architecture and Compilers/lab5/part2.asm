;	Hayden Parker
;	Lab 5 - 2/27/13
;	Part 2 - Read 15 characters, print reversed

; first setup a pointer to the beginning of free RAM space
	DATA #base
	COPY DR,R0	; increment R0 as we go
	COPY R0,R4	; make a copy in R4 to know when to stop printing
; set J0 to jump out of readchar and into the printreversed routine
	DATA #printreversed
	COPY DR,J0
; set J1 to be our ending condition
	DATA #end
	COPY DR,J1
; set R1 to be 15 to count how many ASCII chars we have read in
	SET R1,xF

#readchar
	SUB R2,R2	; clear R2
	COPY R1,R2	; R2 now stores 15
	SUB R3,R2	; subtract our iterator from 15, store in R2
	JPIF R2,EZ,J0	; if R2 is 0, the we have read in 15 chars, jump out
	READ R2,AD	; Read in a new char
	STORE R2,R0	; Store that char in the free part of RAM
	INC R3,1	; Increment our conter
	INC R0,1	; Move to the next part of RAM
	JUMP #readchar	; start over

#printreversed
	INC R0,-1	; go back one position in RAM
	COPY R4,R5	; set R5 to be the pointer to the beginning of the heap
	SUB R0,R5	; subtract our current position in RAM from the heap pointer
	JPIF R5,GZ,J1	; if R5 is GZ then R0 < R5, meaning we are behind the beginning of the heap
	LOAD R2,R0	; read in the current position in RAM
	WRITE R2,AD	; Write it to the screen
	JUMP #printreversed		; print the previous char
	
#end
	HALT

#base

;assembled: 319 9E0 904 311 9EA 318 9EB 21F 722 912 732 E28 C22 B20 430 400 F08 408 945 705 E55 A20 D22 F11 000
