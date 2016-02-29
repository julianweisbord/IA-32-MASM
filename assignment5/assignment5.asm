TITLE assignment 4     (assignment4.asm)

; Author: Julian Weisbord
; Onid: weisborj@oregonstate.edu
; Course / Project ID  CS271-001
; Assignment #5
; Date:02/26/16
; Due Date: 02/28/16
; Description:

INCLUDE Irvine32.inc

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
space BYTE " ",0
user_input DWORD 0
my_array DWORD 200 DUP(0)
;array_count DWORD LENGTHOF my_array



.code

introduction PROC
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

getData PROC

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

fill_array PROC
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
		call crlf
		call RandomRange
		call writeInt
		
		mov [edi], eax
		add edi, 4
		loop fillLoop
		call crlf

	

	pop ebp
	ret 12
	fill_array ENDP

sort_list PROC
	ret
	sort_list ENDP

display_median PROC
	
	ret
	display_median ENDP

display_list PROC

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
	ret

	display_list ENDP


main proc
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
	push user_input; hopefully this is the same
	call display_list

exit
	


main endp
end main
