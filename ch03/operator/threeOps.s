.LC0:
        .string "please input a number"
.LC1:
        .string "%d"
.LC2:
        .string "even"
.LC3:
        .string "odd"
main:
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        addi    s0,sp,32

# printf
        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf

# scanf
        addi    a5,s0,-24 
		// -24 ~ -20 存放着 num（以为 num 是 i32 ），s0-24 是 num 的地址
        mv      a1,a5 #
        lui     a5,%hi(.LC1)
        addi    a0,a5,%lo(.LC1)
        call    __isoc99_scanf

# 有意思，这里 num%2==0 转换成了 num|1?
        lw      a5,-24(s0)
        andi    a5,a5,1
        sext.w  a5,a5
        bne     a5,zero,.L2 

# # printf("even")
        lui     a5,%hi(.LC2)
        addi    a0,a5,%lo(.LC2)
        call    printf
        mv      a5,a0
        j       .L3

.L2: # printf("odd")
        lui     a5,%hi(.LC3)
        addi    a0,a5,%lo(.LC3)
        call    printf
        mv      a5,a0
.L3:
        sw      a5,-20(s0)

# 这里发现了一个比较有趣的现象：m 明明要比 num 晚创建，但是却在 num 之上

        li      a5,0
        mv      a0,a5
        ld      ra,24(sp)
        ld      s0,16(sp)
        addi    sp,sp,32
        jr      ra
