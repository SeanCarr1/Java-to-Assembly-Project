.model small
.stack 100h

; BMI CALCULATOR - ASSEMBLY PROGRAM
; Topics: Selection Statement, Array, Loop

.data
    weights db 50,70,90,60,120
    bmi db 0

    header_msg db 'BMI Classification:',13,10,'$'
    weight_msg db 'Weight: $'
    bmi_msg db ' -> BMI: $'
    obese_str db 'Obese',13,10,'$'
    overweight_str db 'Overweight',13,10,'$'
    normal_str db 'Normal',13,10,'$'
    underweight_str db 'Underweight',13,10,'$'

.code
start:
    mov ax,@data
    mov ds,ax

    lea dx,header_msg
    mov ah,09h
    int 21h

    xor si,si
    mov cl,5

loop_start:
    mov al,weights[si]
    xor ah,ah
    mov bl,2
    div bl
    mov bmi,al

    lea dx,weight_msg
    mov ah,09h
    int 21h

    mov al,weights[si]
    call print_num_al

    lea dx,bmi_msg
    mov ah,09h
    int 21h

    mov al,bmi
    cmp al,30
    jae is_obese

    cmp al,25
    jae is_overweight

    cmp al,18
    jae is_normal

    jmp is_underweight

is_obese:
    lea dx,obese_str
    mov ah,09h
    int 21h
    jmp next_item

is_overweight:
    lea dx,overweight_str
    mov ah,09h
    int 21h
    jmp next_item

is_normal:
    lea dx,normal_str
    mov ah,09h
    int 21h
    jmp next_item

is_underweight:
    lea dx,underweight_str
    mov ah,09h
    int 21h

next_item:
    inc si
    loop loop_start

    mov ah,4ch
    int 21h

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
