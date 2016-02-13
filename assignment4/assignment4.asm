TITLE assignment 4     (assignment4.asm)

; Author: Julian Weisbord
; Onid: weisborj@oregonstate.edu
; Course / Project ID  CS271-001
; Assignment #3
; Date:02/05/16
; Due Date: 02/07/16
; Description: This program prints the sum and average of negative numbers between -100, -1

INCLUDE Irvine32.inc

upper_limit = 400
lower_limit = 0

.data

;userNamePrompt BYTE "What is your name?", 0
my_name BYTE " My name is Julian Weisbord.", 0
assignment BYTE "This is Assignment 4, composite numbers", 0
;your_name BYTE 33 dup(0)
greeting BYTE ", how are you?", 0
enterNum BYTE "Enter a number [0,400] ", 0
goodbye BYTE "Good day human!",0
err BYTE "Error out of range!", 0

n DWORD 0
counter DWORD 0
zero DWORD 0
one DWORD 1



.code

introduction PROC
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
	jl error

	ret
	error:
		mov edx, offset err
		call writeString
		call crlf
		call get_data
	ret
	validate ENDP

showComposites PROC
	mov eax, n
	cmp eax, zero
	je skipWrite
	cmp eax, one
	je skipWrite

	inc counter
	call writeInt
	;if counter is 10 then newline

	skipWrite:		; if num is zero or 1 don't write to screen
	call isComposite

	ret
	showComposites ENDP

isComposite PROC
	forLoop:		; check to see if numbers are composite and decrements to 0

	loop forLoop

	
		

	ret
	isComposite ENDP




main proc
	call introduction
	call get_data
	call farewell
	call showComposites
	
	
 

exit
main endp
end main
