.model small
.stack 100h

; ARRAY ANALYZER - ASSEMBLY PROGRAM
; Java equivalent: ArrayAnalyzer.java
; Topics used: Array, Selection Statement, Loop, Procedure



.data
    ; Input array (5 elements, varied single-digit values)
    ; Kept small so sum/avg/even count still print correctly with one-digit output.
    arr db 1,   3,1,2,2

    ; Result variables
    minval db 0
    maxval db 0
    sum db 0
    avg db 0
    even_count db 0

    ; Display strings ($-terminated for DOS int 21h, AH=09h)
    array_msg db 'Array values: $'
    min_msg db 13,10,'Minimum: $'
    max_msg db 13,10,'Maximum: $'
    sum_msg db 13,10,'Sum: $'
    avg_msg db 13,10,'Average: $'
    even_msg db 13,10,'Even Count: $'
    newline db 13,10,'$'

.code
start:
    ; Program setup: load data segment register (DS)
    mov ax,@data
    mov ds,ax

    ; Initialize min and max with first element
    mov al,arr[0]
    mov minval,al
    mov maxval,al
    mov sum,0
    mov even_count,0

    ; Print heading for array values
    lea dx,array_msg
    mov ah,09h  
    int 21h

    ; SI = index, CX = loop counter (array length)
    xor si,si
    mov cx,5

analyze_loop:
    ; Load current element arr[SI] into AL
    mov al,arr[si]

    ; Print array element (single digit) then a space
    call print_digit_al
    mov dl,' '
    mov ah,02h
    int 21h
    mov al,arr[si]

    ; sum += data[i]
    add sum,al

    ; if data[i] < min
    cmp al,minval
    jae check_max  ; if CF = 0
    mov minval,al

check_max:
    ; if data[i] > max
    cmp al,maxval
    jbe check_even ; if CF or ZF = 1
    mov maxval,al

check_even:
    ; if data[i] is odd, skip increment
    test al,1
    jne next_item  ; if ZF = 0
    inc even_count

next_item:
    ; Move to next element until CX reaches 0
    inc si
    loop analyze_loop

    ; average = sum / 5 (integer division, fractional part discarded)
    mov al,sum
    mov ah,0
    mov bl,5
    div bl
    mov avg,al

    ; Print all computed results
    ; Output minimum value
    lea dx,min_msg
    mov ah,09h
    int 21h
    mov al,minval
    call print_digit_al

    ; Output maximum value
    lea dx,max_msg
    mov ah,09h
    int 21h
    mov al,maxval
    call print_digit_al

    ; Output sum value
    lea dx,sum_msg
    mov ah,09h
    int 21h
    mov al,sum
    call print_digit_al

    ; Output average value
    lea dx,avg_msg
    mov ah,09h
    int 21h
    mov al,avg
    call print_digit_al

    ; Output even-count value
    lea dx,even_msg
    mov ah,09h
    int 21h
    mov al,even_count
    call print_digit_al

    ; Print final newline for clean terminal output
    lea dx,newline
    mov ah,09h
    int 21h

    ; Exit
    mov ah,4ch
    int 21h

; print_digit_al: prints AL as one decimal digit (0..9)
print_digit_al proc
    ; Preserve registers used by this procedure
    push ax
    push dx

    ; Convert 0..9 to ASCII by adding '0'
    add al,30h
    mov dl,al
    mov ah,02h
    int 21h

    ; Restore registers and return to caller
    pop dx
    pop ax
    ret   
print_digit_al endp

end start
