;	Hayden Parker
;	Lab 5 - 2/24/13
;	Part 1 - Read 5 numbers, print smallest and largest

; R0 = "max" register
; R1 = "min" register
; R2 = READ register
; R3 = compare register
; R4 = incremented counter

; set jump locations
	DATA #setmax
	COPY DR,J0
	DATA #compare
	COPY DR,J1
	DATA #setmin
	COPY DR,J2
	DATA #end
	COPY DR,J3
; assign the first number to both the min and max
	READ R2,DD
	COPY R2,R0
	COPY R2,R1

#compare
; check if we are done and should jump to the end
	SUB R3,R3	; clear R3
	SET R3,x4	; SET R3 to 4
	SUB R4,R3
	JPIF R3,EZ,J3	; End if we have compared 4 times
; get the next number
	READ R2,DD	; Read in a value as R2
; check if the input is smaller then the smallest
	COPY R1,R3	; R3 is now our min
	SUB R2,R3	; subtract R2 from out last min
	JPIF R3,GZ,J2	; if R3 is still >0, R2 was smaller
; check if the input is larger then the largest
	COPY R0,R3	; R3 is now our max
	SUB R2,R3	; Subtract R2 from our last max
	JPIF R3,LZ,J0	; if R3 is now <0, R2 = new max
; if it was neither of those it is the same size as one of them, so ignore and start over
	INC R4,1
	JUMP J1

#setmax
	COPY R2,R0
	INC R4,1
	JUMP J1

#setmin
	COPY R2,R1
	INC R4,1
	JUMP J1

#end
	WRITE R0,DD
	WRITE R1,DD
	HALT

;assembled: 318 9EA 30B 9EB 31B 9EC 31E 9ED C20 920 921 733 234 743 E3B C20 913 723 E36 903 723 E30 440 F0B 920 440 F0B 921 440 F0B D00 D10 000
