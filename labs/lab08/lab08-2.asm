section .data
    space   db " "
    newline db 10
    
section .text
    global _start

_start:
    mov ebp, esp
    
    ; argc в ecx
    mov ecx, [ebp]
    
    ; Если argc <= 1, нет аргументов
    cmp ecx, 1
    jle exit
    
    ; Начинаем с argv[1]
    mov esi, 1
    
print_loop:
    ; Получаем argv[esi]
    mov eax, esi
    shl eax, 2          ; *4
    add eax, ebp
    add eax, 4
    mov edi, [eax]      ; edi = argv[esi]
    
    ; Выводим аргумент
    call strlen
    mov edx, eax        ; длина строки
    mov eax, 4
    mov ebx, 1
    mov ecx, edi
    int 0x80
    
    ; Проверяем, последний ли аргумент
    inc esi
    cmp esi, ecx
    je print_nl
    
    ; Пробел между аргументами
    push ecx
    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80
    pop ecx
    
    jmp print_loop
    
print_nl:
    ; Новая строка
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    
exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80

; Длина строки
; Вход: edi - строка
; Выход: eax - длина
strlen:
    push edi
    xor eax, eax
    
len_loop:
    cmp byte [edi+eax], 0
    je len_done
    inc eax
    jmp len_loop
    
len_done:
    pop edi
    ret
