TITLE Program 2			(Program2.asm)

; Program Description:this program takes the users names
;	as string input and an integer (1-46) number to calculate the
;	Fibonacci number. The program displays all of the Fibonacci numbers
; Author:Alex Marsh
; Date Created: July 11, 2015
; Last Modification Date: July 12, 2015

INCLUDE Irvine32.inc

; (insert symbol definitions here)

.data

; (insert variables here)
userNum DWORD ?                 ;user entered number
MAX = 80						;max chars to read
userName BYTE MAX+1 DUP (?)		;room for null
LOWERLIMIT equ 1
UPPERLIMIT equ 46
prev DWORD 0
current DWORD 1
next DWORD 1 
numCount DWORD 0				;counter for numbers on one line
LINELIMIT equ 5

space1 BYTE "         ",0

title1 BYTE "Fibonacci Numbers", 0 
myName BYTE " Programmed by Alex Marsh",0
welcome BYTE "Welcome to Program 2!",0
namePrompt BYTE "What's your name?     ",0
helloUser BYTE "Hello ",0
intro1 BYTE "Enter the number of Fibonaci terms to be displayed",0
intro2 BYTE "Give the number as an integer in the range (1...46).",0
outRange BYTE "Sorry, your number is out of range.",0
howMany BYTE "How many Fibonacci terms do you want? ",0
listFib BYTE "Here is the list of Fibonacci numbers: ",0
certified BYTE "Results certified by Alex Marsh.",0
bye1 BYTE "Thanks for playing.  Goodbye ",0
bye2 BYTE "! ",0

.code
main PROC

; (insert executable instructions here)

introduction:

;display title
	mov edx,OFFSET title1
	call WriteString
	call Crlf
	call Crlf

;display my name
	mov edx,OFFSET myName
	call WriteString
	call Crlf
	call Crlf

;display welcome
	mov edx,OFFSET welcome
	call WriteString
	call Crlf
	call Crlf

;get user name
	mov edx,OFFSET namePrompt
	call WriteString
	mov edx,OFFSET userName
	mov ecx,MAX
	call ReadString
	call Crlf
	call Crlf

;display greeting to user
	mov edx,OFFSET helloUser
	call WriteString
	mov edx,OFFSET userName
	call WriteString
	call Crlf
	call Crlf

userInstructions: 

;display intro to Fibonacci sequence
	mov edx,OFFSET intro1
	call WriteString
	call Crlf

getUserData: 

;display intro to Fibonacci sequence
	mov edx,OFFSET intro2
	call WriteString
	call Crlf


;get integer for user
	call ReadInt
	mov userNum, eax

;validate the input is higher than 1
	mov eax, userNum
	mov ebx, LOWERLIMIT
	cmp eax, ebx
	jb invalid

;validate the input is lower then 46
	mov eax, userNum
	mov ebx, UPPERLIMIT
	cmp eax, ebx
	ja invalid
	jmp fibNums

invalid: 
	;display invalid message
	mov edx,OFFSET outRange
	call WriteString
	call Crlf
	loop getUserData

fibNums:
	mov eax, current
	mov ecx, userNum

	call Crlf
	mov edx,OFFSET listFib
	call WriteString
	call Crlf
	call Crlf

displayFibs:

	
	mov ebx, prev
	add ebx, current
	mov next, ebx
	call WriteDec
	mov edx,OFFSET space1
	call WriteString

	mov eax, current
	mov prev, eax
	mov eax, next
	mov current, eax
	
	inc numCount
	mov eax, numCount
	mov ebx, LINELIMIT
	cmp ebx, eax
	mov eax, next
	je newLine
	loop displayFibs

	jmp farewell

newLine:
	call Crlf
	sub numCount, LINELIMIT     ;reset count
	loop displayFibs             ;if ECX == 0 loop stops	


farewell:

	;display results are certified
	call Crlf
	call Crlf
	mov edx,OFFSET certified
	call WriteString
	call Crlf
	call Crlf

	;display goodbye to user
	mov edx,OFFSET bye1
	call WriteString
	mov edx,OFFSET userName
	call WriteString
	mov edx,OFFSET bye2
	call WriteString
	call Crlf
	call Crlf

	



	exit		; exit to operating system
main ENDP

; (insert additional procedures here)

END main