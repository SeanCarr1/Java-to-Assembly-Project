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
    ; Initialize DS to access variables in .data
    mov ax,@data
    mov ds,ax

    ; Print header
    lea dx,header_msg
    mov ah,09h
    int 21h

    ; Outer loop setup: 3 stores total
    mov cx,3              ; CX = number of stores (outer loop counter)
    xor si,si             ; SI = index into flattened sales array
    mov bl,1              ; BL = store number to display (1..3)

outer_loop:
    push cx               ; save outer counter; inner loop also uses CX

    ; Inner loop setup: 4 days per store
    xor al,al             ; AL = running total for current store
    mov cx,4              ; CX = day counter

inner_loop:
    ; Add each day's sale and move to next array item
    add al,sales[si]
    inc si
    loop inner_loop

    ; Store total for printing
    mov total,al

    ; Print line format: Store X Total: NN
    lea dx,store_msg
    mov ah,09h
    int 21h

    ; Print store number as single digit ('1', '2', '3')
    mov dl,bl
    add dl,30h
    mov ah,02h
    int 21h

    lea dx,total_msg
    mov ah,09h
    int 21h

    ; Print total in decimal 
    mov al,total
    call print_num_al

    lea dx,newline
    mov ah,09h
    int 21h

    inc bl                ; next store number
    pop cx                ; restore outer loop counter
    loop outer_loop

    ; Exit to DOS
    mov ah,4ch
    int 21h

; Prints AL as decimal (0..99, for this program)
print_num_al proc
    ; Preserve caller-visible registers used in this routine
    push ax
    push bx
    push dx

    ; Split value into tens and ones
    xor ah,ah
    mov bl,10
    div bl
    mov ch,al         ; CH = tens digit
    mov cl,ah         ; CL = ones digit

    ; Print tens only when non-zero (skip leading zero for single digits)
    cmp ch,0
    je skip_tens
    mov dl,ch
    add dl,30h
    mov ah,02h
    int 21h

skip_tens:
    ; Always print ones digit
    mov dl,cl
    add dl,30h
    mov ah,02h
    int 21h

    ; Restore registers and return
    pop dx
    pop bx
    pop ax
    ret
print_num_al endp

end start