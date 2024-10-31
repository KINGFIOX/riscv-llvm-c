Average:                                # @Average
        addi    sp, sp, -48
        sd      ra, 40(sp)                      # 8-byte Folded Spill
        sd      s0, 32(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 48

        sd      a0, -24(s0) # socre
        sw      a1, -28(s0) # n

        li      a0, 0
        sw      a0, -32(s0) # sum
        sw      a0, -36(s0) # i
        j       .LBB0_1

.LBB0_1: # 循环条件                                # =>This Inner Loop Header: Depth=1
        lw      a0, -36(s0)
        lw      a1, -28(s0)
        bge     a0, a1, .LBB0_4 # if i >= n
        j       .LBB0_2

.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
        ld      a0, -24(s0) # score
        lw      a1, -36(s0) # i
        slli    a1, a1, 2 # i * 4
        add     a0, a0, a1 # a0 = score + i * 4
        lw      a1, 0(a0) # 读取 score[i]
        lw      a0, -32(s0) # 读取 sum
        addw    a0, a0, a1 # sum = sum + score[i]
        sw      a0, -32(s0)
        j       .LBB0_3

.LBB0_3:                                #   in Loop: Header=BB0_1 Depth=1
        lw      a0, -36(s0) # i++
        addiw   a0, a0, 1
        sw      a0, -36(s0)
        j       .LBB0_1

.LBB0_4:
        lw      a0, -32(s0)
        fcvt.s.w        fa5, a0
        lw      a0, -28(s0)
        fcvt.s.w        fa4, a0
        fdiv.s  fa0, fa5, fa4

		// 感觉很奇怪，为什么这里不用 s0 ，而是用 sp 呢？
        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret

ReadScore:                              # @ReadScore
        addi    sp, sp, -32
        sd      ra, 24(sp)                      # 8-byte Folded Spill
        sd      s0, 16(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 32

        sd      a0, -24(s0) # score 指针
        sw      a1, -28(s0) # n -28 ~ -25
.Lpcrel_hi0:
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi0)
        call    printf

        li      a0, 0 # int i = 0; -32 ~ -29
        sw      a0, -32(s0)

        j       .LBB1_1

.LBB1_1:                                # =>This Inner Loop Header: Depth=1 循环条件
        lw      a0, -32(s0) # i
        lw      a1, -28(s0) # n
        bge     a0, a1, .LBB1_4 # if i >= n

        j       .LBB1_2

.LBB1_2:                                #   in Loop: Header=BB1_1 Depth=1
        ld      a0, -24(s0)
        lw      a1, -32(s0)
        slli    a1, a1, 2 # sizeof(i32) == 4B
        add     a1, a1, a0 # a1 = &score[i]
.Lpcrel_hi1:
        auipc   a0, %pcrel_hi(.L.str.1)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi1)
        call    __isoc99_scanf
        j       .LBB1_3

.LBB1_3:                                #   in Loop: Header=BB1_1 Depth=1
        lw      a0, -32(s0)
        addiw   a0, a0, 1
        sw      a0, -32(s0)
        j       .LBB1_1

.LBB1_4:
        ld      ra, 24(sp)                      # 8-byte Folded Reload
        ld      s0, 16(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 32
        ret

main:                                   # @main
        addi    sp, sp, -208
        sd      ra, 200(sp)                     # 8-byte Folded Spill
        sd      s0, 192(sp)                     # 8-byte Folded Spill
        addi    s0, sp, 208

        li      a0, 0
        sd      a0, -200(s0)                    # 8-byte Folded Spill
        sw      a0, -20(s0)
.Lpcrel_hi2:
        auipc   a0, %pcrel_hi(.L.str.2)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi2)
        call    printf

.Lpcrel_hi3:
        auipc   a0, %pcrel_hi(.L.str.1)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi3)
        addi    a1, s0, -24 # 
        call    __isoc99_scanf

        lw      a1, -24(s0)  // -24 ~ -21 存放的是 n 的地址 // -20 ~ -17 存放的才是 n 的值
        addi    a0, s0, -184
        sd      a0, -208(s0)                    # 8-byte Folded Spill
        call    ReadScore

        ld      a0, -208(s0)                    # 8-byte Folded Reload
        lw      a1, -24(s0)
        call    Average

        fsw     fa0, -188(s0)
        flw     fa5, -188(s0)
        fcvt.d.s        fa5, fa5
        fmv.x.d a1, fa5

.Lpcrel_hi4:
        auipc   a0, %pcrel_hi(.L.str.3)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi4)
        call    printf

        ld      a0, -200(s0)                    # 8-byte Folded Reload
        ld      ra, 200(sp)                     # 8-byte Folded Reload
        ld      s0, 192(sp)                     # 8-byte Folded Reload
        addi    sp, sp, 208
        ret
.L.str:
        .asciz  "input socre: "

.L.str.1:
        .asciz  "%d"

.L.str.2:
        .asciz  "input n:"

.L.str.3:
        .asciz  "Average score is %f\n"
