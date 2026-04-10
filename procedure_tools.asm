.model small
.stack 100h

; PROCEDURE TOOLS - ASSEMBLY PROGRAM
; Java equivalent: procedure_tools.java
; Demonstrates CALL and RET with simple numeric procedures

.data
    number db 137
    digit_count db 0
    prime_flag db 0

    title_msg db 'Procedure Demo for Number: $'
    count_msg db 13,10,'Digit Count: $'
    reverse_msg db 13,10,'Reversed: $'
    prime_msg db 13,10,'Prime: $'
    yes_msg db 'Yes',13,10,'$'
    no_msg db 'No',13,10,'$'

.code
start:
    mov ax,@data
    mov ds,ax

    lea dx,title_msg
    mov ah,09h
    int 21h
    mov al,number
    call print_num_al

    call count_digits
    lea dx,count_msg
    mov ah,09h
    int 21h
    mov al,digit_count
    call print_num_al

    lea dx,reverse_msg
    mov ah,09h
    int 21h
    call print_reversed

    call check_prime
    lea dx,prime_msg
    mov ah,09h
    int 21h

    cmp prime_flag,1
    je is_yes

is_no:
    lea dx,no_msg
    mov ah,09h
    int 21h
    jmp program_end

is_yes:
    lea dx,yes_msg
    mov ah,09h
    int 21h

program_end:
    mov ah,4ch
    int 21h

; count_digits: digit_count = number of decimal digits in number
count_digits proc
    push ax
    push bx

    mov al,number
    mov digit_count,0

count_loop:
    cmp al,0
    je count_done
    xor ah,ah
    mov bl,10
    div bl
    inc digit_count
    jmp count_loop

count_done:
    pop bx
    pop ax
    ret
count_digits endp

; print_reversed: prints decimal digits of number in reverse order
print_reversed proc
    push ax
    push bx
    push dx

    mov al,number

reverse_loop:
    cmp al,0
    je reverse_done
    xor ah,ah
    mov bl,10
    div bl

    push ax
    mov dl,ah
    add dl,30h
    mov ah,02h
    int 21h
    pop ax

    jmp reverse_loop

reverse_done:
    pop dx
    pop bx
    pop ax
    ret
print_reversed endp

; check_prime: sets prime_flag = 1 if prime, else 0
check_prime proc
    push ax
    push bx
    push dx

    mov prime_flag,1
    mov dl,number

    cmp dl,2
    jb not_prime

    mov bl,2

prime_loop:
    mov al,bl
    mul bl
    cmp al,dl
    ja done_prime

    mov al,dl
    xor ah,ah
    div bl
    cmp ah,0
    je not_prime

    inc bl
    jmp prime_loop

not_prime:
    mov prime_flag,0

done_prime:
    pop dx
    pop bx
    pop ax
    ret
check_prime endp

; print_num_al: prints AL as unsigned decimal (0..255)
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
