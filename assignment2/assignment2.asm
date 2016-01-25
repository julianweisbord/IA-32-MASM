TITLE assignment 2     (assignment1.asm)

; Author: Julian Weisbord 
; Onid: weisborj@oregonstate.edu
; Course / Project ID  CS271-001    
; Assignment #2          
; Date:01/22/16
; Due Date: 01/24/16
; Description:  

INCLUDE Irvine32.inc

.data

my_name BYTE "by Julian Weisbord.", 0
assignment2 BYTE "Assignment 2 ",0
userNamePrompt BYTE "What is your name: ",0
greeting BYTE ", How are you? ",0
userName BYTE 33 dup(0)
num_prompt BYTE "How many numbers should we display(1-46): ", 0
errorPrompt BYTE "Error! ", 0
goodbye BYTE " Goodbye, "
space BYTE " ", 0

fib_num DWORD ?
one BYTE "1",0
two DWORD "2",0
fourtySix DWORD 46
j DWORD 5
i DWORD 1
new_num DWORD ?
prev_num DWORD 1
prev_num2 DWORD 1
oneNum DWORD 1
twoNum DWORD 2

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
	cmp eax, oneNum; check for 1 or 2 case
	je onecase
	cmp eax, twoNum
	je twocase
	
	;Display fibonacci numbers
	whileFib:
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

			;add eax, prev_num; prev_num = new_num + prev_num
			;mov prev_num, eax
			;mov eax, prev_num2
			;add eax, new_num
			;mov prev_num2, eax
			
			;increment loops
			mov eax, i
			cmp eax, fib_num
			jge farewell
			add eax, 1
			mov i, eax
			loop forLoop
			call crlf
			jmp whileFib; once forLoop is done, jump to while

onecase:
	mov edx, offset one
	call writestring
	call crlf
	jmp farewell

twocase:
	mov edx, offset one
	call writestring
	mov edx, offset space
	call writestring

	mov edx, offset two
	call writestring
	call crlf

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