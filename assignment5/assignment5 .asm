TITLE assignment 5     (assignment4.asm)

; Author: Julian Weisbord
; Onid: weisborj@oregonstate.edu
; Course / Project ID  CS271-001
; Assignment #5
; Date:02/26/16
; Due Date: 02/28/16
; Description: This program stores random numbers into a user
; defined array and sorts it. Then this program prints out the 
; median number of the array.

INCLUDE Irvine32.inc


STACKM macro  				
		push 	ebp
		mov  	ebp, esp
ENDM

max = 200
min = 10

lo = 100
hi = 999

.data


my_name BYTE " My name is Julian Weisbord.", 0
assignment BYTE "This is Assignment 5, random numbers", 0
errorString BYTE "Error restart!",0
input BYTE "Enter a number in range [10, 200]: ",0
randString BYTE "Random number entered: ", 0
unsorted BYTE "The unsorted list is: ", 0
sorted BYTE "The sorted list is: ", 0 
medianNumber BYTE "The median is: ",0
space BYTE " ",0
user_input DWORD 0
my_array DWORD 200 DUP(0)
x DWORD 0
y DWORD 0
temp DWORD 0
temp1 DWORD 0
two DWORD 2




.code



introduction PROC

;Procedure: introduction
;Description: Introduces the program and programmer

	mov edx, offset assignment
	call writeString
	call crlf
	mov edx, offset my_name
	call writeString
	call crlf
	
	mov edx, offset input
	call writeString

	ret
	introduction ENDP

;---------------------------------------------------------------------

getData PROC

;Procedure: getData
;Description: Gets user input for an array between 10 and 200 in length.

	push ebp
	mov ebp, esp
	mov ebx, [ebp +8] ; get user input from stack
	mov eax, [ebx]

	
	call readInt
	call writeInt
	cmp eax, min
	jl errorLabel
	cmp eax, max
	jg errorLabel
	call crlf

	pop ebp
	ret 4

	errorLabel:
		mov edx, offset errorString 
		call writeString
		call crlf
		exit

	getData ENDP

;---------------------------------------------------------------------


fill_array PROC

;Procedure: fill_array      
;Description: Puts random numbers into an array.

	push ebp
	mov ebp, esp

	mov esi, [ebp +12]; request var
	mov edi, [ebp +8]; address of array

	

	;actually fill array:
	mov ecx, esi
	fillLoop:

		mov eax, hi
		sub eax, lo
		inc eax ;range = hi -lo +1
		add eax, lo; get back to the correct range

		mov edx, offset randString
		call RandomRange
		
		mov [edi], eax
		add edi, 4
		loop fillLoop
		call crlf

	

	pop ebp
	ret 8
	fill_array ENDP
;---------------------------------------------------------------------


display_median PROC

;Procedure: display_median                                                 
;Description: Prints out the median number of the array of random numbers

	STACKM
	mov edx, [ebp+8]
	mov eax, [ebp+12]
	mov edi, [ebp+16]

	call writeString
	call crlf
	

	cdq
	div two ;divide number of elements by 2


	;check if edx >0
	cmp edx, 0
	je median

	printing:

	push [edi +4*eax]
	pop eax
	call writeInt
	call crlf

	pop ebp
	ret 12
	

	median:
	dec eax; round to next number, then get my_array's value at that position
	jmp printing

	display_median ENDP
;---------------------------------------------------------------------


display_list PROC

;Procedure: display_list                                                 
;Description: Displays the array

	push ebp
	mov ebp, esp 
	mov eax, [ebp +8] ;user input
	mov edi, [ebp+12]; array addr
	mov edx, [ebp+16] ;put string in edx

	
	call writeString
	call crlf

	mov ecx, eax
	;call writeInt

	mov ebx,0
	printLoop:

		mov eax, [edi]
		call writeInt
		mov edx, offset space
		call writeString
		add edi, 4
		inc ebx
		mov eax, ebx
		cmp eax, 10
		je returnScreen
		continueLabel: 

		loop printLoop
		jmp finish
	

	returnScreen:
		call crlf
		mov eax, 0
		mov ebx, eax
		jmp continueLabel
	finish:
	pop ebp
	ret 12

	display_list ENDP
;---------------------------------------------------------------------





sortList 		PROC
LOCAL       	req:DWORD

;Procedure: sortList                                                 
;Description: Sorts the passed array in descending value             


	mov  	eax, [ebp+8]
	mov  	req, eax 	
	dec  	req
	mov  	esi, [ebp+12] 	
	mov  	ecx, req
	
outerLoop:

	push 	ecx  
	mov  	ecx, req
	mov  	esi, [ebp+12] 
	
innerLoop:

	mov  	eax, [esi]
	cmp  	[esi+4], eax 	
	jl   	lessThan
	
	push 	[esi+4]
	push 	[esi]
	call 	swap
	pop  	[esi]
	pop  	[esi+4]

lessThan:

	add  	esi, 4
	loop 	innerLoop
	

	pop  	ecx
	loop 	outerLoop	
	
sortFinish:
	ret  	8

sortList 		ENDP
;---------------------------------------------------------------------

swap 		PROC

;Procedure: swap                                                 
;Description: Swaps array[i] with array[j]                      

	STACKM
	
	mov  	eax, [ebp+12]
	mov  	ebx, [ebp+8]
	mov  	[ebp+12], ebx
	mov  	[ebp+8], eax
	
	pop  	ebp
	ret
swap 		ENDP

;--------------------------------------------------------------------------------------




main proc

;Procedure: main                                                 
;Description: Structures and calls functions in the program

	call randomize
	call introduction
	
	push offset user_input

	call getData

	call writeInt
	call crlf
	push eax
	mov user_input, eax ; to save the user input received
	push offset my_array

	call fill_array

	push offset unsorted
	push offset my_array
	push user_input

	call display_list

	push offset my_array
	push user_input


	
	call sortList

	push offset sorted
	push offset my_array
	push user_input

	call display_list
	call crlf

	push offset my_array
	push user_input

	push offset medianNumber
	

	call display_median

exit
	


main endp
end main
