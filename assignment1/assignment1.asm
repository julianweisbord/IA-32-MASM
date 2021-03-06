TITLE assignment 1     (assignment1.asm)

; Author: Julian Weisbord 
; Onid: weisborj@oregonstate.edu
; Course / Project ID  CS271-001    
; Assignment #1          
; Date:01/08/16
; Due Date: 01/17/16
; Description:  Displays name and program title. Prompts user for 2 numbers then
; calculates the sum, difference, product, (integer) quotient and remainder of 
; the numbers. Lastly, this program prints a terminating message.

INCLUDE Irvine32.inc


.data

num_1 DWORD ?; 32 bit unsigned int
num_2 DWORD ?
my_name BYTE "Name: Julian Weisbord ",0
my_title BYTE "Title: project01.asm", 0
bye BYTE "Impressed? Bye!", 0
prompt_1 BYTE "Enter first number:",0
prompt_2 BYTE "Enter second number:",0
description BYTE "Enter 2 numbers, and I'll show you the sum, difference, product, quotient, and remainder.",0
ecDescription BYTE "**EC: Program varifies second number less than first. Program also prompts the user to quit or repeat program.",0
val_error BYTE "The second number must be less than the first.", 0
quit_string BYTE "Would you like to keep playing?(1 =yes/ 0 = no)", 0
yes DWORD 1 ; check if user wants to repeat

sum DWORD ?
difference DWORD ?
product DWORD ?
quotient DWORD ?
remainder DWORD ?

sum_string BYTE "Sum: ",0
difference_string BYTE "Difference: ",0
product_string BYTE "Product: ",0
quotient_string BYTE "Quotient: ",0
remainder_string BYTE "Remainder: ",0
.code
main PROC

;print name, title, and extra credit description
mov edx, offset my_name
call WriteString
mov edx, offset my_title
call WriteString
call CrLf
mov edx, offset ecDescription
call WriteString
call crlf
call crlf

mov eax,1000
writeInt
call crlf

whileLoop:
	;Enter numbers one and two
	mov edx, offset description
	call WriteString
	call crlf
	mov edx, offset prompt_1
	call WriteString
	call CrLf
	call ReadInt
	;call WriteDec
	call CrLf
	mov ebx, eax ;can't have 2 numbers in eax
	mov num_1, ebx; store in num_1

	mov edx, offset prompt_2
	call WriteString
	call CrLf
	call ReadInt; in eax
	;call WriteDec
	call CrLf
	mov num_2, eax

		;compare numbers
	cmp num_1, eax
	jle valError

	;sum of numbers

	add eax, ebx
	mov edx, offset sum_string
	call WriteString
	call WriteDec
	call CrLf

	;difference of numbers
	;What if second is smaller than first?
	mov eax, num_1
	sub eax, num_2
	mov edx, offset difference_string
	call WriteString
	call WriteInt
	call CrLf

	;product of numbers
	mov eax, num_1
	mul num_2
	mov edx, offset product_string
	call WriteString
	call WriteInt
	call CrLf

	;Quotient of numbers
	mov eax, num_1
	sub edx, edx
	div num_2
	mov remainder,edx
	mov edx, offset quotient_string
	call WriteString
	call WriteDec
	call crlf

	;Remainder
	mov eax, remainder
	mov edx, offset remainder_string
	call WriteString
	call WriteInt
	call crlf
	
	;repeat program?
	mov edx, offset quit_string
	call WriteString
	call ReadInt
	call crlf
	cmp yes, eax
	jne repeater
	jmp whileLoop

	valError:
		mov edx, offset val_error
		call WriteString
		call crlf
		exit

repeater:
	;good bye
	mov edx, offset bye
	call WriteString
	call crlf

	exit

exit
main ENDP
END main