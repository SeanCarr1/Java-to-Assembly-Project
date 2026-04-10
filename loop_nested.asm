.model small
.stack 100h

; WEEKLY SALES REPORT - ASSEMBLY PROGRAM
; Topics: Loop / Nested Loop, Array

.data
    ; 3 stores x 4 days (flattened 2D array)
    sales db 12,15,10,8, 9,14,11,13, 16,7,12,10
    total db 0

    header_msg db 'Weekly Sales Report',13,10,'$'
    store_msg db 'Store $'
    total_msg db ' Total: $'
    newline db 13,10,'$'

.code
start:
    mov ax,@data
    mov ds,ax

    ; Print header
    lea dx,header_msg
    mov ah,09h
    int 21h

    ; Outer loop (stores)
    mov cx,3              ; 3 stores
    xor si,si             ; index in sales array
    mov bl,1              ; store number starts at 1

outer_loop:
    push cx               ; save outer loop counter

    ; Inner loop (4 days per store)
    xor al,al             ; AL = running sum
    mov cx,4

inner_loop:
    add al,sales[si]
    inc si
    loop inner_loop

    mov total,al

    ; Print: Store X Total: NN
    lea dx,store_msg
    mov ah,09h
    int 21h

    mov dl,bl
    add dl,30h
    mov ah,02h
    int 21h

    lea dx,total_msg
    mov ah,09h
    int 21h

    mov al,total
    call print_num_al

    lea dx,newline
    mov ah,09h
    int 21h

    inc bl
    pop cx                ; restore outer loop counter
    loop outer_loop

    mov ah,4ch
    int 21h

; Prints AL as decimal (0..255)
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
