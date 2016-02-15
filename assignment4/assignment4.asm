TITLE assignment 4     (assignment4.asm)

; Author: Julian Weisbord
; Onid: weisborj@oregonstate.edu
; Course / Project ID  CS271-001
; Assignment #4
; Date:02/14/16
; Due Date: 02/14/16
; Description: This program computes n composite numbers

INCLUDE Irvine32.inc

upper_limit = 400
lower_limit = 0

.data

;userNamePrompt BYTE "What is your name?", 0
my_name BYTE " My name is Julian Weisbord.", 0
assignment BYTE "This is Assignment 4, composite numbers", 0
;your_name BYTE 33 dup(0)
greeting BYTE ", how are you?", 0
enterNum BYTE "Enter a number [1,400]: ", 0
goodbye BYTE "Good day human!",0
err BYTE "Error out of range!", 0
spaces BYTE "   ", 0
spaces4 BYTE "    ", 0
spaces5 BYTE "     ",0
counter_string BYTE "This is counter: ",0
extra BYTE " EXTRA CREDIT: Align everything in ouput columns",0

n DWORD 0
counter DWORD 0
zero DWORD 0
one DWORD 1
two DWORD 2
ten DWORD 10
odd_num DWORD 1
current_num DWORD 3
twentyone DWORD 21
hundred DWORD 100





.code

introduction PROC
	mov edx, offset extra
	call writeString
	call crlf 
	mov edx, offset assignment
	call writeString
	call crlf
	mov edx, offset my_name
	call writeString

	ret
	introduction ENDP

farewell PROC
	call crlf
	mov edx, offset goodbye
	call writeString
	call crlf
	ret
	farewell ENDP

get_data PROC
	mov edx, offset enterNum
	call writeString
	call crlf
	call readInt
	
	mov n, eax
	call validate
	ret
	get_data ENDP

validate PROC
	cmp n, upper_limit
	jg error
	cmp n, lower_limit
	jle error

	ret
	error:
		mov edx, offset err
		call writeString
		call crlf
		call get_data
	ret
	validate ENDP

showComposites PROC

	call isComposite

	ret
	showComposites ENDP

isComposite PROC
	
	mov ecx, n
			

	forLoop:		; check to see if numbers are composite and decrements to 0	
		
			;The even case
		inc current_num
		mov eax, current_num
		cdq
		mov ebx, two
		div ebx
		cmp edx, zero
		je printInc

		oddLoop:
			

			inc odd_num
			inc odd_num
						; if odd_num gets to 19 case
			mov eax, odd_num
			cmp eax, twentyone
			jge forLoop

			mov eax, odd_num

			cmp current_num, eax
			je forLoop

			
		

				;If current_num is divisible by odd_num
			mov eax, current_num
			mov ebx, odd_num
			cdq
			 div ebx
			cmp edx, zero
			je printInc

				;We cant jump to forLoop (too many bytes to jump) so must put this part way through code
			jmp below
			forLoopMid:
			jmp forLoop
			
			below:

			jmp oddLoop

			

		printInc:

			mov eax, one
			mov odd_num, eax

			inc counter
			mov eax, current_num
			call writeInt
			mov eax, current_num
			cmp eax, ten
			jl spacesFive
			cmp eax, hundred
			jl spacesFour
			cmp eax, hundred
			jge spacesThree

			spacesThree:
				mov edx, offset spaces
				call writeString
				jmp cont

			spacesFour:
				mov edx, offset spaces4
				call writeString
				jmp cont
			spacesFive:
				mov edx, offset spaces5
				call writeString
			
			cont:
			mov eax, counter
			cmp eax, ten
			je new_line
			loop forLoopMid
			ret
	
			new_line:	; reset counter
				call crlf
				mov eax, zero
				mov counter, eax	
				loop forLoopMid
				ret

	
	isComposite ENDP




main proc
	call introduction
	call get_data
 	call showComposites
	call farewell
	
 

exit
main endp
end main
