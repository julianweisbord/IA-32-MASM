TITLE assignment 3     (assignment3.asm)

; Author: Julian Weisbord
; Onid: weisborj@oregonstate.edu
; Course / Project ID  CS271-001
; Assignment #3
; Date:02/05/16
; Due Date: 02/07/16
; Description: This program prints the sum and average of negative numbers between -100, -1

INCLUDE Irvine32.inc

lower_limit = -100
upper_limit = -1
zero = 0
one =1

.data

userNamePrompt BYTE "What is your name?", 0
my_name BYTE " My name is Julian Weisbord.", 0
assignment BYTE "This is Assignment 3", 0
your_name BYTE 33 dup(0)
greeting BYTE ", how are you?", 0
enterNum BYTE "Enter a number ", 0
error BYTE "Your number was out of range! Try again ", 0
averageOutput BYTE "The average is: ", 0
sum BYTE "The sum is: ", 0
counter_string BYTE "Number of numbers entered: ", 0
noNumEntered BYTE "You did not enter any negative numbers. ",0
sumString BYTE "The sum is: ",0
colonSpace BYTE " : ", 0
extra_credit BYTE "EXTRA CREDIT: The lines are numbered!", 0

temp_num DWORD ?
total DWORD ?
counter DWORD 0
average DWORD ?

.code
main proc

	;Introduction
	mov edx, offset my_name
	call WriteString
	call crlf
	mov edx, offset assignment
	call WriteString
	call crlf
	mov edx, offset extra_credit
	call writeString
	call crlf

	mov edx, offset userNamePrompt
	call WriteString
	call crlf
	mov edx, offset your_name
	mov ecx, 32; not 33 so there is a 0 at the end of the users name
	call readString
	call crlf
	call writestring
	mov edx, offset greeting
	call writestring
	call crlf

  ;User input

  whileLoop:
	
    mov edx, offset enterNum
    call writeString
	mov eax, counter
	inc eax
	call writeDec
	mov edx, offset colonSpace
	call writeString
    call readInt
    call crlf
    mov temp_num, eax
    cmp eax, lower_limit
    jl outRange

	mov eax, total
    add eax, temp_num	; add new number to running total
	mov total, eax

    ; increment number of numbers entered
	inc counter
	mov eax,counter
	;call writeInt
	call crlf
	mov eax, zero
    cmp temp_num, eax
    jl whileLoop

	
	mov eax, temp_num
    sub total, eax
	;mov total, eax

	;mov eax, one
    ;sub counter, eax
	;mov counter, eax
	dec counter

	mov edx, offset counter_string
	mov eax, counter
	call writeString 
	call writeInt
	call crlf

	mov eax, zero
	cmp counter, eax
	je noNum

    ;average


    mov eax, total
	mov ebx, counter
	cdq
    idiv ebx
		;idiv counter; might not divide into eax
    mov edx, offset averageOutput
    call writeString
    call crlf
	
    call writeInt
	call crlf


	;sum

	mov edx, offset sumString
	call writeString
	mov eax, total
	call writeInt
	call crlf

    exit


noNum:
	mov edx, offset noNumEntered
	call writeString
	call crlf
	jmp whileLoop

outRange:
  mov edx, offset error
  call writeString
  jmp whileLoop; if they entered a number out of range re-prompt

exit
main endp
end main
