;
; hedosexe.nasm: hello-world as a tiny DOS .exe file
; by pts@fazekas.hu at Wed Jun 24 22:42:23 CEST 2020
;
; $ nasm -f bin -o hedosexe.exe hedosexe.nasm
;

%include "fullprog_dosexe.inc.nasm"

fullprog_code

mov ah, 9  ; WRITE_STDOUT.
mov dx, msg
int 0x21  ; http://spike.scu.edu.au/~barry/interrupts.html

fullprog_data  ; This is mandatory for .exe.

msg: db 'Hello, World!', 13, 10, '$'

fullprog_end
