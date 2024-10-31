.LC0:
        .string "please enter the expression: "
.LC1:
        .string "%d%c%d"
.LC2:
        .string "%d + %d = %d\n"
.LC3:
        .string "%d - %d = %d\n"
.LC4:
        .string "%d * %d = %d\n"
.LC5:
        .string "division by zero!\n"
.LC6:
        .string "%d / %d = %d\n"
main: # int main(void) {
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        addi    s0,sp,32

        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)
        call    printf

        addi    a3,s0,-24
        addi    a4,s0,-25
        addi    a5,s0,-20
        mv      a2,a4
        mv      a1,a5 # a1 和 a3 分别是 data1 和 data2
        lui     a5,%hi(.LC1)
        addi    a0,a5,%lo(.LC1)
        call    __isoc99_scanf

        lbu     a5,-25(s0)
        sext.w  a5,a5 # signed_extern_word(word 是 i32)

        li      a4,47 # '/'
        beq     a5,a4,.L2
        li      a4,47 # 如果比 '/' 大，那么就是进入了 default 分支
        bgt     a5,a4,.L3

        li      a4,45 # '-'
        beq     a5,a4,.L4
        li      a4,45
        bgt     a5,a4,.L3

        li      a4,42 # '*'
        beq     a5,a4,.L5
        li      a4,43
        bne     a5,a4,.L3

        lw      a1,-20(s0) # 加法没有 label ，加法是直接放到了 main 中
        lw      a2,-24(s0)
        lw      a4,-20(s0)
        lw      a5,-24(s0)
        addw    a5,a4,a5
        sext.w  a5,a5
        mv      a3,a5

        lui     a5,%hi(.LC2)
        addi    a0,a5,%lo(.LC2)
        call    printf
        j       .L6

.L4: # '-'
        lw      a1,-20(s0)
        lw      a2,-24(s0)
        lw      a4,-20(s0)
        lw      a5,-24(s0)
        subw    a5,a4,a5
        sext.w  a5,a5
        mv      a3,a5
        lui     a5,%hi(.LC3)
        addi    a0,a5,%lo(.LC3)
        call    printf
        j       .L6

.L5: # '*'
        lw      a1,-20(s0)
        lw      a2,-24(s0)
        lw      a4,-20(s0)
        lw      a5,-24(s0)
        mulw    a5,a4,a5
        sext.w  a5,a5
        mv      a3,a5
        lui     a5,%hi(.LC4)
        addi    a0,a5,%lo(.LC4)
        call    printf
        j       .L6

.L2: # 这个应该是 '/' 分支
        lw      a5,-24(s0)
        bne     a5,zero,.L7
        lui     a5,%hi(.LC5) # 0==data2
        addi    a0,a5,%lo(.LC5)
        call    perror
        j       .L6

.L7: # '/' -> 0!=data2
        lw      a1,-20(s0)
        lw      a2,-24(s0)
        lw      a4,-20(s0)
        lw      a5,-24(s0)
        divw    a5,a4,a5
        sext.w  a5,a5
        mv      a3,a5
        lui     a5,%hi(.LC6)
        addi    a0,a5,%lo(.LC6)
        call    printf
        j       .L6

.L3: # 这里是进入了 default 分支
        lui     a5,%hi(.LC5)
        addi    a0,a5,%lo(.LC5)
        call    perror
.L6: # return 0; }
        li      a5,0
        mv      a0,a5
        ld      ra,24(sp)
        ld      s0,16(sp)
        addi    sp,sp,32
        jr      ra
