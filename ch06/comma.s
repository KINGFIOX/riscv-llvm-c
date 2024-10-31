.LC0:
        .string "sum = %d\n"
.LC1:
        .string "b = %d\n"
main:
        addi    sp,sp,-48
        sd      ra,40(sp)
        sd      s0,32(sp)
        addi    s0,sp,48

        sw      zero,-20(s0)
        li      a5,100
        sw      a5,-32(s0)

# 初始化循环
        li      a5,1
        sw      a5,-24(s0)
        lw      a5,-32(s0) # j = n
        sw      a5,-28(s0)
        j       .L2

.L3: # 
# 循环 block
        lw      a5,-20(s0)
        mv      a4,a5
        lw      a5,-24(s0)
        addw    a5,a4,a5 # sum = sum + i -> a5
        sext.w  a5,a5
        lw      a4,-28(s0)
        addw    a5,a4,a5 # sum = sum + i + j -> a5
        sw      a5,-20(s0)

# 更新迭代器
        lw      a5,-24(s0) // i++
        addiw   a5,a5,1
        sw      a5,-24(s0)
        lw      a5,-28(s0) // j--
        addiw   a5,a5,-1
        sw      a5,-28(s0)

.L2: # 
# 判断循环条件
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

# 可以看到，我们的 int b = 3 * 5, a * 4; 这里的 a * 4 直接被扔掉了
        li      a5,10
        sw      a5,-36(s0)
        li      a5,15 # 字面量直接计算出来了结果
        sw      a5,-40(s0)
        lw      a5,-40(s0)
        mv      a1,a5

        lui     a5,%hi(.LC1)
        addi    a0,a5,%lo(.LC1)
        call    printf

# 可以看到，我们的 int b = (3 * 5, a * 4); 这里的 3 * 5 直接被扔掉了
        lw      a5,-36(s0)
        slliw   a5,a5,2 # a * 4
        sw      a5,-40(s0)
        lw      a5,-40(s0)
        mv      a1,a5

        lui     a5,%hi(.LC1)
        addi    a0,a5,%lo(.LC1)
        call    printf

        li      a5,0
        mv      a0,a5
        ld      ra,40(sp)
        ld      s0,32(sp)
        addi    sp,sp,48
        jr      ra
