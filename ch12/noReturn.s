/* struct date {
 *     int year;
 *     int month;
 *     int day;
 * };
 * 
 * struct date Func(struct date p)
 * {
 *     p.year = 2000;
 *     p.month = 5;
 *     p.day = 22;
 *	   return p;
 * }
 *
 * 这个结构体的大小是 12
 */

Func:                                   # @Func
        addi    sp, sp, -80
        sd      ra, 72(sp)                      # 8-byte Folded Spill
        sd      s0, 64(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 80

# 这一块我没理解是在干啥 {
        sd      a1, -56(s0)
        sd      a0, -64(s0)
        lw      a0, -56(s0)
        sw      a0, -40(s0)
        ld      a0, -64(s0)
        sd      a0, -48(s0)
# } 这一块我没理解是在干啥

        li      a0, 2000
        sw      a0, -48(s0)
        li      a0, 5
        sw      a0, -44(s0)
        li      a0, 22
        sw      a0, -40(s0)

# 这一块我没理解是在干啥 {
        lw      a0, -40(s0)
        sw      a0, -24(s0)
        ld      a0, -48(s0)
        sd      a0, -32(s0)
        lw      a0, -24(s0)
        sw      a0, -72(s0)
        ld      a0, -32(s0)
        sd      a0, -80(s0)
        ld      a0, -80(s0)
        ld      a1, -72(s0)
# } 这一块我没理解是在干啥

        ld      ra, 72(sp)                      # 8-byte Folded Reload
        ld      s0, 64(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 80
        ret

main:                                   # @main
        addi    sp, sp, -96
        sd      ra, 88(sp)                      # 8-byte Folded Spill
        sd      s0, 80(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 96

        li      a0, 0
        sd      a0, -96(s0)                     # 8-byte Folded Spill
        sw      a0, -20(s0)
.Lpcrel_hi0:
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi0)
        li      a1, 12
        call    printf

        li      a0, 31
        sw      a0, -24(s0)
        li      a0, 3
        slli    a0, a0, 34
        addi    a0, a0, 1999
        sd      a0, -32(s0)
        lw      a0, -24(s0)

        sw      a0, -40(s0)
        ld      a0, -32(s0)
        sd      a0, -48(s0)
        ld      a1, -40(s0)
        ld      a0, -48(s0)
        call    Func

        mv      a2, a0
        ld      a0, -96(s0)                     # 8-byte Folded Reload
        sd      a2, -88(s0)                     # 8-byte Folded Spill
        mv      a2, a1
        ld      a1, -88(s0)                     # 8-byte Folded Reload
        sd      a2, -72(s0)
        sd      a1, -80(s0)
        lw      a1, -72(s0)
        sw      a1, -56(s0)
        ld      a1, -80(s0)
        sd      a1, -64(s0)

        ld      ra, 88(sp)                      # 8-byte Folded Reload
        ld      s0, 80(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 96
        ret
.L.str:
        .asciz  "%d\n"
