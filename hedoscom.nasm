;
; hedoscom.nasm: hello-world as a tiny DOS .com file
; by pts@fazekas.hu at Wed Jun 24 22:42:23 CEST 2020
;
; $ nasm -f bin -o hedoscom.com hedoscom.nasm
;

%include "fullprog_doscom.inc.nasm"

fullprog_code

mov ah, 9  ; WRITE_STDOUT.
mov dx, msg
int 0x21  ; http://spike.scu.edu.au/~barry/interrupts.html

fullprog_data  ; This is optional for .com, data can be code.

msg: db 'Hello, World!', 13, 10, '$'

fullprog_end
