main:                                   # @main
        addi    sp, sp, -80
        sd      ra, 72(sp)                      # 8-byte Folded Spill
        sd      s0, 64(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 80

        li      a0, 0
        sd      a0, -80(s0)                     # 8-byte Folded Spill
        sw      a0, -20(s0)
        sd      a0, -32(s0)
        sd      a0, -40(s0)
        sd      a0, -48(s0)
        sd      a0, -56(s0)
        sd      a0, -64(s0)
        sd      a0, -72(s0)

    /**
	 * arr [][3] = 
     * 1, 2, 3
     * 4, 5, 0
     * 6, 0, 0
     * 0, 0, 0
     */


        li      a0, 1
        sw      a0, -72(s0)
        li      a0, 2
        sw      a0, -68(s0)
        li      a0, 3
        sw      a0, -64(s0)
        li      a0, 4
        sw      a0, -60(s0)
        li      a0, 5
        sw      a0, -56(s0)
        li      a0, 6
        sw      a0, -48(s0)
        lw      a1, -56(s0)

.Lpcrel_hi0:
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi0)
        call    printf

# 退栈
        ld      a0, -80(s0)                     # 8-byte Folded Reload
        ld      ra, 72(sp)                      # 8-byte Folded Reload
        ld      s0, 64(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 80
        ret
.L.str:
        .asciz  "%d\n"
