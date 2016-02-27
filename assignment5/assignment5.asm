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

;userNamePrompt BYTE "What is your name?", 0
my_name BYTE " My name is Julian Weisbord.", 0
assignment BYTE "This is Assignment 5, random numbers", 0




.code

introduction PROC
	mov edx, offset assignment
	call writeString
	call crlf
	mov edx, offset my_name
	call writeString
	call crlf

	ret
	introduction ENDP


main proc
	call introduction
	
 

exit
main endp
end main
