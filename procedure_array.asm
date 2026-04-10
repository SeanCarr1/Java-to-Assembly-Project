.model small
.stack 100h

; PROCEDURE + ARRAY DEMO - ASSEMBLY PROGRAM
; Java equivalent: procedure_array.java
; Uses CALL/RET and array processing

.data
    values db 8,15,22,5,19
    sum db 0
    maxval db 0

    array_msg db 'Array values: $'
    sum_msg db 'Sum: $'
    max_msg db 'Maximum: $'
    space_msg db ' $'
    newline db 13,10,'$'

.code
start:
    mov ax,@data
    mov ds,ax

    call print_array

    call get_sum
    mov sum,al

    call get_max
    mov maxval,al

    lea dx,sum_msg
    mov ah,09h
    int 21h
    mov al,sum
    call print_num_al

    lea dx,newline
    mov ah,09h
    int 21h

    lea dx,max_msg
    mov ah,09h
    int 21h
    mov al,maxval
    call print_num_al

    lea dx,newline
    mov ah,09h
    int 21h

    mov ah,4ch
    int 21h

; Procedure 1: print all array elements
print_array proc
    lea dx,array_msg
    mov ah,09h
    int 21h

    xor si,si
    mov cx,5

print_array_loop:
    mov al,values[si]
    call print_num_al

    lea dx,space_msg
    mov ah,09h
    int 21h

    inc si
    loop print_array_loop

    lea dx,newline
    mov ah,09h
    int 21h
    ret
print_array endp

; Procedure 2: compute sum of array elements, return in AL
get_sum proc
    xor al,al
    xor si,si
    mov cx,5

get_sum_loop:
    add al,values[si]
    inc si
    loop get_sum_loop
    ret
get_sum endp

; Procedure 3: find maximum array element, return in AL
get_max proc
    mov al,values[0]
    mov si,1
    mov cx,4

get_max_loop:
    cmp values[si],al
    ja set_new_max
    jmp keep_max

set_new_max:
    mov al,values[si]

keep_max:
    inc si
    loop get_max_loop
    ret
get_max endp

; Print AL as unsigned decimal (0..255)
print_num_al proc
    push ax
    push bx
    push cx
    push dx

    xor ah,ah
    mov bl,100
    div bl
    mov bh,al

    mov al,ah
    xor ah,ah
    mov bl,10
    div bl
    mov ch,al
    mov cl,ah

    cmp bh,0
    je skip_hundreds
    mov dl,bh
    add dl,30h
    mov ah,02h
    int 21h

skip_hundreds:
    cmp bh,0
    jne print_tens
    cmp ch,0
    je skip_tens

print_tens:
    mov dl,ch
    add dl,30h
    mov ah,02h
    int 21h

skip_tens:
    mov dl,cl
    add dl,30h
    mov ah,02h
    int 21h

    pop dx
    pop cx
    pop bx
    pop ax
    ret
print_num_al endp

end start
