TITLE assignment 1     (assignment1.asm)

; Author: Julian Weisbord
; Course / Project ID  CS271               Date:01/08/16
; Description:  Displays name and program title. Prompts user for 2 numbers then
; calculates the sum, difference, product, (integer) quotient and remainder of 
; the numbers. Lastly, this program prints a terminating message.

INCLUDE Irvine32.inc


.data

num_1 DWORD ?; 32 bit unsigned int
num_2 DWORD ?
my_name BYTE "Name: Julian Weisbord ",0
my_title BYTE "Title: project01.asm", 0
bye BYTE "goodbye", 0
prompt_1 BYTE "Enter first number",0
prompt_2 BYTE "Enter second number",0

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

;print name and title
mov edx, offset my_name
call WriteString
mov edx, offset my_title
call WriteString
call CrLf

;Enter numbers one and two
mov edx, offset prompt_1
call WriteString
call CrLf
call ReadInt
call WriteDec
call CrLf
mov ebx, eax ;can't have 2 numbers in eax
mov num_1, ebx; store in num_1

mov edx, offset prompt_2
call WriteString
call CrLf
call ReadInt; in eax
call WriteDec
call CrLf
mov num_2, eax

;sum of numbers

add eax, ebx
mov edx, offset sum_string
call writeDec
call CrLf

;difference of numbers
;What if second is smaller than first?
mov eax, num_2
sub eax, num_1
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

;Quotient of numbers, num_1 already in eax
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



exit
main ENDP
END main
