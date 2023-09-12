.globl binary_search
binary_search:

	MOV R3, R2
			 			//R0 is array of numbers
						//R1 is key
	MOV R2, #0			//R2 is start index
	SUB R3, R3, #1		//R3 is end index
	MOV R4, R3, LSR #1	//R4 is middle index
	MOV R5, #-1			//R5 is key index
	MOV	R6, #1			//R6 is numiters
	
Loop: 	
	
	CMP R2,R3			//if start == end
	BGT Error			//print -1
	
	LDR R9,[R0,R4, LSL #2] //num[mid]
	
	CMP R9, R1			//if num[mid] == key
	BEQ Found			//found
	BGT RightShift		//rightshift
	BLT LeftShift		//leftshift
	B	Loop

Mustloop:
	RSB R10, R6, #0		//Overwrite the data value
	STR R10, [R0,R4, LSL #2]
	
	SUB R7, R3, R2		//end-start
	MOV R7, R7, LSR #1	//end-start/2
	ADD R4, R7, R2		//start+(end-start)/2
	ADD R6, R6, #1		//num++
	B	Loop

Found:
	RSB R10, R6, #0		//Overwrite the data value
	STR R10, [R0,R4, LSL #2]
	MOV R5, R4
	B	Exit 

RightShift: 
	SUB R3, R4, #1
	B	Mustloop
		
LeftShift:
	ADD R2, R4, #1		
	B	Mustloop

Error: 
	MOV R5, #-1
	B	Exit
	
Exit:	
	MOV R0, R5
    MOV pc,lr
    
