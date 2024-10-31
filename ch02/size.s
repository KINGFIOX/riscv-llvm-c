main:
# int main {
        addi    sp,sp,-32
        sd      ra,24(sp)
        sd      s0,16(sp)
        addi    s0,sp,32

        li      a5,5
        sw      a5,-20(s0)
        li      a5,4 # int size = sizeof(num)，可以看到，编译器是直接给我们了
        sw      a5,-24(s0)
        li      a5,0

# return 0 }
        mv      a0,a5
        ld      ra,24(sp)
        ld      s0,16(sp)
        addi    sp,sp,32
        jr      ra
