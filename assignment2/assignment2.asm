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
goodbye BYTE "Goodbye, "

numNum DWORd ?
one DWORD 1
fourtySix DWORD 46
i DWORD 0
j DWORD 5

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
	cmp eax, one
	jl throw_error
	cmp eax, fourtySix
	jg throw_error
	mov ecx, j; for counted loop
	;Display fibonacci numbers
	whileFib:
		forLoop:
			
			loop forLoop


;farewell
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