TITLE assignment 3     (assignment3.asm)

; Author: Julian Weisbord 
; Onid: weisborj@oregonstate.edu
; Course / Project ID  CS271-001    
; Assignment #3          
; Date:02/05/16
; Due Date: 02/07/16
; Description: 

INCLUDE Irvine32.inc

.data

userNamePrompt BYTE "What is your name?", 0
my_name BYTE " My name is Julian Weisbord.", 0
assignment BYTE "This is Assignment 3", 0
your_name BYTE 33 dup(0)
greeting BYTE ", how are you?", 0

.code
main proc

	;Introduction
	mov edx, offset my_name	
	call WriteString
	call crlf
	mov edx, offset assignment
	call WriteString
	call crlf

	mov edx, offset userNamePrompt
	call WriteString
	call crlf
	mov edx, offset your_name
	mov ecx, 32;; not 33 so there is a 0 at the end of the users name
	call readString
	call crlf
	call writestring
	mov edx, offset greeting
	call writestring
	call crlf

exit	
main endp
end main