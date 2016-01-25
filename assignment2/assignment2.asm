TITLE assignment 2     (assignment2.asm)

; Author: Julian Weisbord 
; Onid: weisborj@oregonstate.edu
; Course / Project ID  CS271-001    
; Assignment #2          
; Date:01/22/16
; Due Date: 01/24/16
; Description: This program prints out the fibonacci sequence specified by the user from 1 to 46 

INCLUDE Irvine32.inc

fourtySix = 46

.data

my_name BYTE "by Julian Weisbord.", 0
assignment2 BYTE "Assignment 2, fibonacci numbers ",0
userNamePrompt BYTE "What is your name: ",0
greeting BYTE ", How are you? ",0
userName BYTE 33 dup(0)
num_prompt BYTE "How many numbers should we display(1-46): ", 0
errorPrompt BYTE "Error! ", 0
goodbye BYTE " Goodbye, ",0
space BYTE "     ", 0

fib_num DWORD ?
one BYTE "1",0
two DWORD "2",0

j DWORD 3 ;because we aren't counting the first 2 numbers
i DWORD 1
new_num DWORD ?
prev_num DWORD 1
prev_num2 DWORD 1
oneNum DWORD 1
twoNum DWORD 2
zero DWORD 0
five DWORD 5

.code
main PROC

;Introduction
mov edx, offset assignment2
call WriteString
mov edx, offset my_name
call writestring
call crlf

;Get name
mov edx, offset userNamePrompt
call writeString
call crlf
mov edx, offset userName
mov ecx, 32; not 33 so there is a 0 at the end of the users name
call ReadString

call writestring
mov edx, offset greeting
call writestring
call crlf

;Get num of fibonacci numbers

;if out of range, reprompt
whileLoop:
	mov edx, offset num_prompt
	call writeString
	call readint
	mov fib_num, eax
	cmp eax, oneNum
	jl throw_error
	cmp eax, fourtySix
	jg throw_error
	cmp eax, oneNum; check for 1 case
	je onecase
	cmp eax, oneNum
	jne twocase
	
	
	;Display fibonacci numbers
	

	whileFib:
		;if fib_num == 0 jmp to farewell
		mov eax, fib_num
		cmp eax, zero
		je farewell

		mov ecx, j; for counted loop
		forLoop:
			
			;Fibonacci calculations
			mov eax,prev_num
			add eax, prev_num2; new_num = prev_num + prev_num2
			mov new_num, eax
			call writeDec; print fibonacci number here!
			mov edx, offset space
			call writestring

			mov eax, prev_num
			mov prev_num2, eax ;prev_num2 = prev_num
			mov eax, new_num
			mov prev_num, eax; prev_num = new_num
			
			;increment loops
			mov eax, i
			cmp eax, fib_num
			jge farewell
			add eax, 1
			mov i, eax

			mov eax, five ;make for loop new line every 5 numbers
			mov j, eax
			loop forLoop
			call crlf
			jmp whileFib; once forLoop is done, jump to while

onecase:
	mov edx, offset one
	call writestring
	call crlf
	mov eax, fib_num
	sub eax, 1
	jmp farewell

twocase:
	mov edx, offset one
	call writestring
	mov edx, offset space
	call writestring

	mov edx, offset one
	call writestring
	mov edx, offset space
	call writestring

	mov eax, fib_num
	sub eax, 2
	mov fib_num, eax
	jmp whileFib

farewell:
	call crlf
	mov edx, offset goodbye
	call writestring
	mov edx, offset userName
	call writestring
	call crlf
	exit

throw_error:
	mov edx, offset errorPrompt
	call writestring
	call crlf
	jmp whileLoop

exit
main ENDP
END main