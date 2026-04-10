.model small
.stack 100h

; ARRAY ANALYZER - ASSEMBLY PROGRAM
; Java equivalent: array_analyzer.java

.data
    arr db 18,7,25,12,30,9

    minval db 0
    maxval db 0
    sum db 0
    avg db 0
    even_count db 0

    array_msg db 'Array values: $'
    min_msg db 13,10,'Minimum: $'
    max_msg db 13,10,'Maximum: $'
    sum_msg db 13,10,'Sum: $'
    avg_msg db 13,10,'Average: $'
    even_msg db 13,10,'Even Count: $'
    space_msg db ' $'
    newline db 13,10,'$'

.code
start:
    mov ax,@data
    mov ds,ax

    ; Initialize min and max with first element
    mov al,arr[0]
    mov minval,al
    mov maxval,al
    mov sum,0
    mov even_count,0

    lea dx,array_msg
    mov ah,09h
    int 21h

    xor si,si
    mov cx,6

analyze_loop:
    mov al,arr[si]

    ; Print array element
    call print_num_al
    lea dx,space_msg
    mov ah,09h
    int 21h

    ; sum += data[i]
    add sum,al

    ; if data[i] < min
    cmp al,minval
    jae check_max
    mov minval,al

check_max:
    ; if data[i] > max
    cmp al,maxval
    jbe check_even
    mov maxval,al

check_even:
    ; if data[i] % 2 == 0, increment even_count
    mov ah,0
    mov bl,2
    div bl
    cmp ah,0
    jne next_item
    inc even_count

next_item:
    inc si
    loop analyze_loop

    ; average = sum / 6
    mov al,sum
    mov ah,0
    mov bl,6
    div bl
    mov avg,al

    lea dx,min_msg
    mov ah,09h
    int 21h
    mov al,minval
    call print_num_al

    lea dx,max_msg
    mov ah,09h
    int 21h
    mov al,maxval
    call print_num_al

    lea dx,sum_msg
    mov ah,09h
    int 21h
    mov al,sum
    call print_num_al

    lea dx,avg_msg
    mov ah,09h
    int 21h
    mov al,avg
    call print_num_al

    lea dx,even_msg
    mov ah,09h
    int 21h
    mov al,even_count
    call print_num_al

    lea dx,newline
    mov ah,09h
    int 21h

    mov ah,4ch
    int 21h

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
