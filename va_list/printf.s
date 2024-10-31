vprintf(int, char const*, void*):
        addi    sp, sp, -48
        sd      ra, 40(sp)
        sd      s0, 32(sp)
        addi    s0, sp, 48
        sw      a0, -20(s0)
        sd      a1, -32(s0)
        sd      a2, -40(s0)
        ld      ra, 40(sp)
        ld      s0, 32(sp)
        addi    sp, sp, 48
        ret

printf(char const*, ...):
        addi    sp, sp, -96
        sd      ra, 24(sp)
        sd      s0, 16(sp)
        addi    s0, sp, 32
        sd      a7, 56(s0)
        sd      a6, 48(s0)
        sd      a5, 40(s0)
        sd      a4, 32(s0)
        sd      a3, 24(s0)
        sd      a2, 16(s0)
        sd      a1, 8(s0)
        sd      a0, -24(s0)
        addi    a0, s0, 8
        sd      a0, -32(s0)
        ld      a1, -24(s0)
        ld      a2, -32(s0)
        li      a0, 1
        call    vprintf(int, char const*, void*)
        ld      ra, 24(sp)
        ld      s0, 16(sp)
        addi    sp, sp, 96
        ret
