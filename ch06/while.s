.LC0:
        .string "sum = %d\n"
main:
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        addi    s0,sp,32

        sw      zero,-20(s0) # sum
        li      a5,100
        sw      a5,-28(s0)
        li      a5,1
        sw      a5,-24(s0)
        j       .L2

.L3:
        lw      a5,-20(s0)
        mv      a4,a5
        lw      a5,-24(s0)
        addw    a5,a4,a5
        sw      a5,-20(s0)
        lw      a5,-24(s0)
        addiw   a5,a5,1
        sw      a5,-24(s0)

# 这个就很有意思了，循环体结束以后，会 fall 到条件判断

.L2:
# 循环条件判断
        lw      a5,-24(s0)
        mv      a4,a5
        lw      a5,-28(s0)
        sext.w  a4,a4
        sext.w  a5,a5
        ble     a4,a5,.L3

# printf
        lw      a5,-20(s0)
        mv      a1,a5
        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf

# return 
        li      a5,0
        mv      a0,a5
        ld      ra,24(sp)
        ld      s0,16(sp)
        addi    sp,sp,32
        jr      ra
