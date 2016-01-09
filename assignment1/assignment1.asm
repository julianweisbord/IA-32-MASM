TITLE assignment 1     (assignment1.asm)

; Author: Julian Weisbord
; Course / Project ID  CS271               Date:01/08/16
; Description:  Displays name and program title. Prompts user for 2 numbers then
; calculates the sum, difference, product, (integer) quotient and remainder of 
; the numbers. Lastly, this program prints a terminating message.

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

my_name BYTE "Hello My Name Is Julian Weisbord",0 
num1 DWORD ?
num2 DWORD ?
message BYTE "End of Program, goodbye...",0

; (insert variable definitions here)


.code
main PROC

;Introduction

mov edx, OFFSET my_name
call WriteString
call CrLf

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
