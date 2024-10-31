swap:                                   # @swap
        addi    sp, sp, -48
        sd      ra, 40(sp)                      # 8-byte Folded Spill
        sd      s0, 32(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 48
        sd      a0, -24(s0)
        sd      a1, -32(s0)

        ld      a0, -24(s0)
        lw      a0, 0(a0)
        sw      a0, -36(s0) # int tmp = *x

        ld      a0, -32(s0)
        lw      a0, 0(a0)
        ld      a1, -24(s0)
        sw      a0, 0(a1) # *x = *y

        lw      a0, -36(s0)
        ld      a1, -32(s0)
        sw      a0, 0(a1) # *y = tmp

        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret

main:                                   # @main
        addi    sp, sp, -48
        sd      ra, 40(sp)                      # 8-byte Folded Spill
        sd      s0, 32(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 48

        li      a0, 0
        sd      a0, -40(s0)                     # 8-byte Folded Spill
        sw      a0, -20(s0)
        li      a0, 5
        sw      a0, -24(s0)
        li      a0, 9
        sw      a0, -28(s0)

        lw      a1, -24(s0)
        lw      a2, -28(s0)
.Lpcrel_hi0:
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi0)
		// 因为这里会复用 printf 的格式串，因此这里将 格式串给先保存到了栈中
        sd      a0, -48(s0)                     # 8-byte Folded Spill
        call    printf

        addi    a0, s0, -24 # &a，使用 addi 就是取地址了
        addi    a1, s0, -28 # &b
        call    swap

        ld      a0, -48(s0)                     # 8-byte Folded Reload
        lw      a1, -24(s0)
        lw      a2, -28(s0)
        call    printf

		// 感觉下面这行有点多余了，因为实际上 -40 这个位置好像没有用，
		// 当然 a0 这里是返回值啦
        ld      a0, -40(s0)                     # 8-byte Folded Reload

        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret
.L.str:
        .asciz  "a=%d, b=%d\n"
