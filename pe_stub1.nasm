;
; pe_stub1.nasm: DOS stub for Windows PE header, short message, shortest
; by pts@fazekas.hu at Fri Jun 26 18:21:46 CEST 2020
;
; $ nasm -f bin -o pe_stub1.exe pe_stub1.nasm
; $ ndisasm -b 16 -e 24 -o 8 pe_stub1.exe
;

%include "fullprog_dosexe.inc.nasm"

fullprog_code

mov ah, 9  ; WRITE_STDOUT.
mov dx, msg
int 0x21
%define fullprog_omit_code_exit
mov ax, 0x4c01
int 0x21

fullprog_data

msg: db 'Not a DOS program.', 13, 10, '$'
db 0  ; Padding.
dd 0x40  ; Points to the "PE\0\0" header.

fullprog_end
