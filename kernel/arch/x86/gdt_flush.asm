[BITS 32]

; Mark stack as non-executable
section .note.GNU-stack noalloc noexec nowrite progbits

section .text

; gdt_flush(uint32_t gdt_ptr_addr)
; Loads the GDT, reloads all segment registers, and does a safe far-return
; to flush the CPU instruction pipeline with the new CS selector.
global gdt_flush
gdt_flush:
    ; Get the pointer passed as first argument [esp+4]
    mov eax, [esp+4]
    lgdt [eax]

    ; Reload data segment registers with kernel data selector (0x10 = index 2)
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Far return to reload CS with kernel code selector (0x08 = index 1)
    ; Push the new CS selector, then the address of .flush label
    push 0x08
    lea eax, [.flush]
    push eax
    retf
.flush:
    ret
