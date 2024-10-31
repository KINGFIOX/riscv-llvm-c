.LC0:
        .string "sum = %d\n"
main:
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        addi    s0,sp,32

        sw      zero,-20(s0)
        li      a5,100
        sw      a5,-28(s0) # n
		
# 迭代器初始化
        li      a5,1
        sw      a5,-24(s0) # i
        j       .L2

.L3:
# 满足循环条件 {
        lw      a5,-20(s0)
        mv      a4,a5
        lw      a5,-24(s0)
        addw    a5,a4,a5
        sw      a5,-20(s0)

# } 迭代器下一步
        lw      a5,-24(s0)
        addiw   a5,a5,1
        sw      a5,-24(s0)

.L2:
# 循环条件
        lw      a5,-24(s0) # i
        mv      a4,a5
        lw      a5,-28(s0) # n
        sext.w  a4,a4
        sext.w  a5,a5
        ble     a4,a5,.L3

# 不满足循环条件
        lw      a5,-20(s0)
        mv      a1,a5
        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf

# return 0; }
        li      a5,0
        mv      a0,a5
        ld      ra,24(sp)
        ld      s0,16(sp)
        addi    sp,sp,32
        jr      ra
