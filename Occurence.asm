%include "asm_io.inc"
section .data
    array: times 100 dd 0 ;; reserve space in memory
    msg: db "​The answer is:​",10,0 ;; the final answer ...
section .text
        global asm_main
asm_main:
    enter 0,0
    pusha
    mov ebx,array ;; first number in the reserved memory
    mov ecx,array ;; last number reserved memory
operator:
    call read_int
    cmp eax,0 ;; input terminator
    je done ;; if 0 is entered, this jump ends the operations
    call check ;; counts how much the given number is occured 
    mov [ebx],eax 
    add ebx,4 ;; placing each result in their given cell
    jmp operator ;; begins the whole solving thing again
done:
    mov eax,0 
    sub ebx,4 ;; the final cell is null, we don't really need that one
formula:
    mov edx,[ebx]
    imul edx,[ecx]
    add eax,edx
    sub ebx,4
    add ecx,4
    cmp ebx,ecx
    jge formula
    call printer
    call print_int
    call print_nl
    popa
    leave
    ret
printer:
    push eax 
    mov ebx,msg
    inc ebx
nigger:
    mov al,[ebx] ;; indirect addressing
    inc ebx ;; incrementing for characters
    cmp al,0 ;; null terminator
    je rekt ;; return jump
    call print_char ;; reads the next character from the string
    jmp nigger
rekt:
    pop eax
    ret
check:
    push ecx
    push ebx
    xor ecx,ecx
lp1:
    mov ebx,11b
    and ebx,eax
    shr eax,1
    cmp ebx,11b
    jne if1
    inc ecx
if1:
    cmp eax,0 
    jne lp1
    mov eax,ecx
    pop ebx
    pop ecx
    ret
