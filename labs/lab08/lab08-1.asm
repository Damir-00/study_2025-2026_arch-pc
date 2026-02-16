section .data
    prompt  db "Enter N: ", 0
    plen    equ $ - prompt
    
    newline db 10
    
    ; Буфер для преобразования чисел
    num_buf times 10 db 0
    
section .bss
    input   resb 10     ; буфер для ввода N
    n       resd 1      ; число N
    i       resd 1      ; счетчик
    
section .text
    global _start

_start:
    ; Выводим приглашение
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, plen
    int 0x80

    ; Читаем N
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 10
    int 0x80

    ; Преобразуем строку в число
    mov esi, input
    xor eax, eax
    xor ebx, ebx
    
convert:
    mov bl, [esi]
    cmp bl, 10         ; новая строка
    je convert_done
    cmp bl, 0          ; конец строки
    je convert_done
    sub bl, '0'
    imul eax, 10
    add eax, ebx
    inc esi
    jmp convert
    
convert_done:
    mov [n], eax       ; сохраняем N
    
    ; Инициализируем счетчик i = 0
    mov dword [i], 0
    
print_loop:
    ; Проверяем условие i < N
    mov eax, [i]
    cmp eax, [n]
    jge exit_loop      ; если i >= N, выходим
    
    ; Преобразуем i в строку и выводим
    mov eax, [i]
    call print_number
    
    ; Выводим новую строку
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    
    ; Увеличиваем счетчик
    inc dword [i]
    jmp print_loop
    
exit_loop:
    ; Завершаем программу
    mov eax, 1
    xor ebx, ebx
    int 0x80

; ===========================================
; Подпрограмма: вывод числа
; Вход: eax - число
; ===========================================
print_number:
    push eax
    push ebx
    push ecx
    push edx
    
    mov ebx, 10        ; основание системы
    mov ecx, num_buf + 9 ; конец буфера
    mov byte [ecx], 0  ; нулевой символ
    
    ; Обрабатываем 0 отдельно
    cmp eax, 0
    jne .divide
    mov byte [ecx-1], '0'
    dec ecx
    jmp .print
    
.divide:
    xor edx, edx
    div ebx             ; eax = частное, edx = остаток
    add dl, '0'         ; в символ
    dec ecx
    mov [ecx], dl
    
    test eax, eax
    jnz .divide
    
.print:
    ; Вычисляем длину строки
    mov edx, num_buf + 9
    sub edx, ecx
    
    ; Выводим
    mov eax, 4
    mov ebx, 1
    ; ecx уже указывает на начало строки
    ; edx уже содержит длину
    int 0x80
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
