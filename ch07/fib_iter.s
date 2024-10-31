# 其实我这里 fib 写的不是很规范，因为我是用到了 int arr[n]; 但是这个 n 其实是事先不知道的

fib: # long fib(int n) {
        addi    sp,sp,-64
        sd      ra,56(sp)
        sd      s0,48(sp)
        addi    s0,sp,64

        mv      a1,a0
        sw      a1,-52(s0) # 保存传入的参数
        mv      a1,sp
        mv      t3,a1 # 将 sp （栈顶）的位置 放到了 t3

        lw      a1,-52(s0)
        addiw   a1,a1,1
        sext.w  a1,a1
        mv      a0,a1 # a1 = n + 1
        addi    a0,a0,-1 # a0 = n
        sd      a0,-32(s0)
        mv      a0,a1
        mv      t1,a0
        li      t2,0
        srli    a0,t1,58
        slli    a3,t2,6
        or      a3,a0,a3
        slli    a2,t1,6
        mv      a3,a1
        mv      a6,a3
        li      a7,0
        srli    a3,a6,58
        slli    a5,a7,6
        or      a5,a3,a5
        slli    a4,a6,6
        mv      a5,a1
        slli    a5,a5,3
        addi    a5,a5,15
        srli    a5,a5,4
        slli    a5,a5,4
        sub     sp,sp,a5
        mv      a5,sp
        addi    a5,a5,7
        srli    a5,a5,3
        slli    a5,a5,3
        sd      a5,-40(s0)
        ld      a5,-40(s0)
        sd      zero,0(a5)
        ld      a5,-40(s0)
        li      a4,1
        sd      a4,8(a5)
        li      a5,2
        sw      a5,-20(s0)
        j       .L2
.L3:
        lw      a5,-20(s0)
        addiw   a5,a5,-1
        sext.w  a5,a5
        ld      a4,-40(s0)
        slli    a5,a5,3
        add     a5,a4,a5
        ld      a4,0(a5)
        lw      a5,-20(s0)
        addiw   a5,a5,-2
        sext.w  a5,a5
        ld      a3,-40(s0)
        slli    a5,a5,3
        add     a5,a3,a5
        ld      a5,0(a5)
        add     a4,a4,a5
        ld      a3,-40(s0)
        lw      a5,-20(s0)
        slli    a5,a5,3
        add     a5,a3,a5
        sd      a4,0(a5)
        lw      a5,-20(s0)
        addiw   a5,a5,1
        sw      a5,-20(s0)

.L2:
# for ( i <= n  )
        lw      a5,-20(s0)
        mv      a4,a5
        lw      a5,-52(s0)
        sext.w  a4,a4
        sext.w  a5,a5
        ble     a4,a5,.L3

        ld      a4,-40(s0)
        lw      a5,-52(s0)
        slli    a5,a5,3
        add     a5,a4,a5
        ld      a5,0(a5)
        mv      sp,t3

# } 退栈
        mv      a0,a5
        addi    sp,s0,-64
        ld      ra,56(sp)
        ld      s0,48(sp)
        addi    sp,sp,64
        jr      ra
.LC0:
        .string "f(20) = %ld\n"

main:
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        addi    s0,sp,32

        li      a0,20
        call    fib
        sd      a0,-24(s0)

        ld      a1,-24(s0)
        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf

        li      a5,0
        mv      a0,a5
        ld      ra,24(sp)
        ld      s0,16(sp)
        addi    sp,sp,32
        jr      ra
