main:                                   # @main
        addi    sp, sp, -48
        sd      ra, 40(sp)                      # 8-byte Folded Spill
        sd      s0, 32(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 48

        li      a2, 0
        sw      a2, -20(s0)

        sw      a0, -24(s0) # argc
        sd      a1, -32(s0) # argv

        lw      a1, -24(s0) # argc
.Lpcrel_hi0:
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi0)
        call    printf

        ld      a0, -32(s0) # argv
        ld      a1, 0(a0)
.Lpcrel_hi1:
        auipc   a0, %pcrel_hi(.L.str.1)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi1)
        call    printf

        lw      a0, -24(s0) # argc
        li      a1, 2
        blt     a0, a1, .LBB0_6 # argc < 2
        j       .LBB0_1
.LBB0_1:
.Lpcrel_hi2:
        auipc   a0, %pcrel_hi(.L.str.2)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi2)
        call    printf

        li      a0, 1 # int i = 0
        sd      a0, -40(s0)
        j       .LBB0_2
.LBB0_2:                                # =>This Inner Loop Header: Depth=1
        ld      a0, -40(s0)
        lw      a1, -24(s0)
        bgeu    a0, a1, .LBB0_5
        j       .LBB0_3
.LBB0_3:                                #   in Loop: Header=BB0_2 Depth=1
        ld      a0, -32(s0)
        ld      a1, -40(s0)
        slli    a1, a1, 3
        add     a0, a0, a1 # argv[i]
        ld      a1, 0(a0)
.Lpcrel_hi3:
        auipc   a0, %pcrel_hi(.L.str.3)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi3)
        call    printf

        j       .LBB0_4
.LBB0_4:                                #   in Loop: Header=BB0_2 Depth=1
        ld      a0, -40(s0)
        addi    a0, a0, 1
        sd      a0, -40(s0)
        j       .LBB0_2
.LBB0_5:
        j       .LBB0_6
.LBB0_6:
	# main 函数结束 
        li      a0, 0
        ld      ra, 40(sp)                      # 8-byte Folded Reload
        ld      s0, 32(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 48
        ret
.L.str:
        .asciz  "the number of command line arguments is:%d\n"

.L.str.1:
        .asciz  "the program name is: %s\n"

.L.str.2:
        .asciz  "the other arguments are following:\n"

.L.str.3:
        .asciz  "%s\n"
