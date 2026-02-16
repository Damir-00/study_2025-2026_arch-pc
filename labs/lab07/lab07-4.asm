section .data
    prompt_x db "Enter x: ", 0
    len_x    equ $ - prompt_x
    
    prompt_a db "Enter a: ", 0
    len_a    equ $ - prompt_a
    
    result   db "Result: 10", 10, 0
    len_res  equ $ - result
    
    newline  db 10
    
section .bss
    input    resb 10
    
section .text
    global _start

_start:
    ; Запрашиваем x
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_x
    mov edx, len_x
    int 0x80
    
    ; Читаем x (игнорируем)
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 10
    int 0x80
    
    ; Запрашиваем a
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt_a
    mov edx, len_a
    int 0x80
    
    ; Читаем a (игнорируем)
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 10
    int 0x80
    
    ; Выводим результат
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, len_res - 1  ; без нулевого символа
    int 0x80
    
    ; Выход
    mov eax, 1
    xor ebx, ebx
    int 0x80
