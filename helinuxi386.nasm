;
; helinuxi386.nasm: hello-world as a tiny Linux i386 ELF executable
; by pts@fazekas.hu at Mon Jul 13 21:05:33 CEST 2020
;
; $ nasm -f bin -o helinuxi386 helinuxi386.nasm && chmod +x helinuxi386
;
; Based on https://www.muppetlabs.com/~breadbox/software/tiny/teensy.html
;

bits 32
              org     0x08048000

ehdr:                                                 ; Elf32_Ehdr
              db      0x7F, "ELF"                     ;   e_ident[EI_MAG*]
              db      1                               ;   e_ident[EI_CLASS]
              db      1                               ;   e_ident[EI_DATA]
              db      1                               ;   e_ident[EI_VERSION]
              db      3                               ;   e_ident[EI_OSABI]
              dd      0, 0                            ;   e_ident[EI_PAD+]
              dw      2                               ;   e_type
              dw      3                               ;   e_machine
              dd      1                               ;   e_version
              dd      _start                          ;   e_entry
              dd      phdr - $$                       ;   e_phoff
              dd      0                               ;   e_shoff
              dd      0                               ;   e_flags
              dw      ehdrsize                        ;   e_ehsize
              dw      phdrsize                        ;   e_phentsize
              dw      1                               ;   e_phnum
              dw      0                               ;   e_shentsize
              dw      0                               ;   e_shnum
              dw      0                               ;   e_shstrndx

ehdrsize      equ     $ - ehdr

phdr:                                                 ; Elf32_Phdr
              dd      1                               ;   p_type
              dd      0                               ;   p_offset
              dd      $$                              ;   p_vaddr
              dd      $$                              ;   p_paddr
              dd      filesize                        ;   p_filesz
              dd      memsize                         ;   p_memsz
              dd      5                               ;   p_flags
              dd      0x1000                          ;   p_align

phdrsize      equ     $ - phdr

_start:
              mov eax, 4  ; __NR_write.
              mov ebx, 1  ; STDOUT_FILENO.
              mov ecx, msg
              mov edx, msg_end-msg
              int 0x80

              xor eax, eax
              inc eax  ; __NR_exit.
              xor ebx, ebx  ; EXIT_SUCCESS.
              int 0x80

msg:          db 'Hello, World!', 10
msg_end:

filesize      equ     $ - $$

memsize       equ     $ - $$
