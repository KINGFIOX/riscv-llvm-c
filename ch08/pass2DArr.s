# void AverforStud(int score[][COURSE_N], int sum[], float aver[], size_t n) 
AverforStud:                            # @AverforStud
        addi    sp, sp, -64
        sd      ra, 56(sp)                      # 8-byte Folded Spill
        sd      s0, 48(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 64
        sd      a0, -24(s0) # score[][COURSE_N]
        sd      a1, -32(s0) # sum[]
        sd      a2, -40(s0) # ever[]
        sd      a3, -48(s0) # n

        li      a0, 0 # int i = 0
        sd      a0, -56(s0)
        j       .LBB0_1
.LBB0_1:                                # =>This Loop Header: Depth=1
        ld      a0, -56(s0) # i
        ld      a1, -48(s0) # n
        bgeu    a0, a1, .LBB0_8 # i >= n
        j       .LBB0_2
.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
        li      a0, 0
        sd      a0, -64(s0) # int j = 0;
        j       .LBB0_3
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
        ld      a1, -64(s0)
        li      a0, 4
        bltu    a0, a1, .LBB0_6 # j >= COURSE_N
        j       .LBB0_4
.LBB0_4:                                #   in Loop: Header=BB0_3 Depth=2
        ld      a0, -32(s0)
        ld      a3, -56(s0) # i
        slli    a1, a3, 2 
        add     a1, a1, a0 
        lw      a0, 0(a1) # a0 = sum[i]
        ld      a2, -24(s0) # score
        li      a4, 20 # 每行的大小是 5 * sizeof(int)
        mul     a3, a3, a4 # i * 20
        add     a2, a2, a3 # score + i*20
        ld      a3, -64(s0) # j
        slli    a3, a3, 2 # j*4
        add     a2, a2, a3 # score + i*20 + j
        lw      a2, 0(a2) # a2 = score[i][j]
        addw    a0, a0, a2 # sum[i] + score[i][j]
        sw      a0, 0(a1)
        j       .LBB0_5
.LBB0_5:                                #   in Loop: Header=BB0_3 Depth=2
        ld      a0, -64(s0) // j++
        addi    a0, a0, 1
        sd      a0, -64(s0)
        j       .LBB0_3
.LBB0_6:                                #   in Loop: Header=BB0_1 Depth=1
        ld      a0, -32(s0) # score
        ld      a1, -56(s0) # i
        slli    a1, a1, 2
        add     a0, a0, a1
        lw      a0, 0(a0) # sum[i]
        fcvt.s.w        fa5, a0
        lui     a0, 264704 # load upper immediate，加载到高20位，这应该是 5 的 float 形式
        fmv.w.x fa4, a0
        fdiv.s  fa5, fa5, fa4
        ld      a0, -40(s0) # ever
        add     a0, a0, a1 # ever + i*4
        fsw     fa5, 0(a0)
        j       .LBB0_7
.LBB0_7:                                #   in Loop: Header=BB0_1 Depth=1
        ld      a0, -56(s0) # i++
        addi    a0, a0, 1
        sd      a0, -56(s0)
        j       .LBB0_1
.LBB0_8:
        ld      ra, 56(sp)                      # 8-byte Folded Reload
        ld      s0, 48(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 64
        ret

# 稍微总结一下，riscv 汇编中，对于 二位数组，是直接计算出来了一个立即数
# 因此，我们也就知道，C语言中，二维数组，一行有多少维度，一定要事先知道
