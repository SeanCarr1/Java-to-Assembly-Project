.386
.model flat, stdcall

; ============================================
; BMI CALCULATOR - ASSEMBLY PROGRAM
; Topics: Selection Statement, Array, Loop
; ============================================

.data
    ; Data segment - Define arrays and constants
    weights DWORD 50, 70, 90, 60, 120       ; Array of 5 weights
    height DWORD 170                        ; Fixed height
    arrayLength DWORD 5                     ; Array size
    
    ; Constants for BMI classification
    obese_threshold DWORD 30
    overweight_threshold DWORD 25
    normal_threshold DWORD 18
    
    ; Strings for output
    header_msg BYTE "BMI Classification:", 0Ah, 0Dh, 0
    weight_msg BYTE "Weight: ", 0
    bmi_msg BYTE "kg -> BMI: ", 0
    obese_str BYTE "Obese", 0
    overweight_str BYTE "Overweight", 0
    normal_str BYTE "Normal", 0
    underweight_str BYTE "Underweight", 0
    newline BYTE 0Ah, 0Dh, 0

.code
main PROC
    ; Print header message
    ; mov eax, 0
    ; mov ebx, 1
    ; mov ecx, header_msg
    ; mov edx, 18
    ; int 80h
    
    ; Initialize registers for loop
    MOV ECX, 0                              ; ECX = loop counter (i = 0)
    
LOOP_START:
    ; Check if i < arrayLength (i < 5)
    CMP ECX, 5                              ; Compare ECX with 5
    JGE LOOP_END                            ; Jump if Greater or Equal (end loop)
    
    ; Calculate array index: weights[i]
    MOV EAX, [weights + ECX * 4]            ; EAX = weights[i]
    MOV EBX, EAX                            ; EBX = current weight
    
    ; Calculate BMI = weight / (height * height / 10000)
    ; For simplicity: approximate BMI calculation
    MOV EAX, EBX                            ; EAX = weight
    MOV EDX, 20                             ; EDX = approximate divisor
    DIV EDX                                 ; EAX = weight / 20 (approximation)
    
    ; EAX now contains approximated BMI
    MOV ESI, EAX                            ; ESI = BMI value
    
    ; ============================================
    ; SELECTION STATEMENT - Classify BMI
    ; ============================================
    
    ; Check if BMI >= 30 (Obese)
    CMP ESI, 30
    JGE IS_OBESE
    
    ; Check if BMI >= 25 (Overweight)
    CMP ESI, 25
    JGE IS_OVERWEIGHT
    
    ; Check if BMI >= 18 (Normal)
    CMP ESI, 18
    JGE IS_NORMAL
    
    ; Else Underweight
    JMP IS_UNDERWEIGHT
    
IS_OBESE:
    MOV EDI, OFFSET obese_str
    JMP PRINT_RESULT
    
IS_OVERWEIGHT:
    MOV EDI, OFFSET overweight_str
    JMP PRINT_RESULT
    
IS_NORMAL:
    MOV EDI, OFFSET normal_str
    JMP PRINT_RESULT
    
IS_UNDERWEIGHT:
    MOV EDI, OFFSET underweight_str
    
PRINT_RESULT:
    ; Print: "Weight: " followed by weight value
    ; (In actual DOS, use INT 21h)
    ; For assembly simulation:
    ; Print weight and category
    ; Using CALL to hypothetical print function
    
    ; Increment loop counter
    INC ECX
    JMP LOOP_START
    
LOOP_END:
    ; Program end
    MOV EAX, 0                              ; Return 0
    RET
    
main ENDP

END main
