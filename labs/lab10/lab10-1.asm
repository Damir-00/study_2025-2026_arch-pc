section .data
    prompt db "Введите строку: ", 0
    filename db "readme.txt", 0
    newline db 10
    
section .bss
    buffer resb 256
    input_len resd 1
    
section .text
    global _start

_start:
    ; Выводим приглашение для ввода
    mov eax, 4          ; sys_write
    mov ebx, 1          ; файловый дескриптор stdout
    mov ecx, prompt     ; указатель на строку
    mov edx, 16         ; длина строки
    int 0x80

    ; Читаем строку от пользователя
    mov eax, 3          ; sys_read
    mov ebx, 0          ; файловый дескриптор stdin
    mov ecx, buffer     ; буфер для ввода
    mov edx, 256        ; максимальная длина
    int 0x80
    
    ; Сохраняем длину введённой строки
    mov [input_len], eax

    ; Создаём или открываем файл для записи
    mov eax, 8          ; sys_creat (системный вызов creat)
    mov ebx, filename   ; имя файла
    mov ecx, 0o644      ; режим: rw-r--r--
    int 0x80
    
    ; Сохраняем файловый дескриптор
    mov ebx, eax

    ; Записываем строку в файл
    mov eax, 4          ; sys_write
    ; ebx уже содержит файловый дескриптор
    mov ecx, buffer     ; буфер с данными
    mov edx, [input_len]; длина данных
    int 0x80

    ; Добавляем перенос строки в файл
    mov eax, 4          ; sys_write
    mov ecx, newline    ; символ новой строки
    mov edx, 1          ; длина 1 байт
    int 0x80

    ; Закрываем файл
    mov eax, 6          ; sys_close
    ; ebx уже содержит файловый дескриптор
    int 0x80

    ; Завершаем программу
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; код возврата 0
    int 0x80
