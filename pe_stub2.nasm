;
; pe_stub2.nasm: DOS stub for Windows PE header, full message
; by pts@fazekas.hu at Fri Jun 26 18:21:46 CEST 2020
;
; $ nasm -f bin -o pe_stub2.exe pe_stub2.nasm
; $ ndisasm -b 16 -e 24 -o 8 pe_stub2.exe
;

%include "fullprog_dosexe.inc.nasm"

fullprog_code

mov ah, 9  ; WRITE_STDOUT.
mov dx, msg
int 0x21
mov dx, msg2
int 0x21
%define fullprog_omit_code_exit
mov ax, 0x4c01
int 0x21

fullprog_data

msg: db 'This program can$'
dd 0x60  ; Points to the "PE\0\0" header.
msg2: db 'not be run in DOS mode.', 13, 10, '$'
times 6 db 0

fullprog_end
