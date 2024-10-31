ascending:                              # @ascending
        addi    sp, sp, -32
        sd      ra, 24(sp)                      # 8-byte Folded Spill
        sd      s0, 16(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 32
        sw      a0, -20(s0) # a 
        sw      a1, -24(s0) # b

        lw      a1, -20(s0) # a1 = a
        lw      a0, -24(s0) # a0 = b
        slt     a0, a0, a1 # slt (less then) ，a0 = b < a

        ld      ra, 24(sp)                      # 8-byte Folded Reload
        ld      s0, 16(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 32
        ret

descending:                             # @descending
        addi    sp, sp, -32
        sd      ra, 24(sp)                      # 8-byte Folded Spill
        sd      s0, 16(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 32
        sw      a0, -20(s0)
        sw      a1, -24(s0)

        lw      a0, -20(s0) # a0 = a
        lw      a1, -24(s0) # a1 = b
        slt     a0, a0, a1 # a0 = a < b

        ld      ra, 24(sp)                      # 8-byte Folded Reload
        ld      s0, 16(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 32
        ret

sort:                                   # @sort
        addi    sp, sp, -64
        sd      ra, 56(sp)                      # 8-byte Folded Spill
        sd      s0, 48(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 64 
        sd      a0, -24(s0) # arr
        sw      a1, -28(s0) # len 
        sd      a2, -40(s0) # bool (*compare)(int a, int b)

        li      a0, 0
        sw      a0, -44(s0) # int i = 0
        j       .LBB2_1
.LBB2_1:                                # =>This Loop Header: Depth=1
	# 循环条件判断
        lw      a0, -44(s0)
        lw      a1, -28(s0)
        addiw   a1, a1, -1
        bge     a0, a1, .LBB2_10 # i >= len
        j       .LBB2_2
.LBB2_2:                                #   in Loop: Header=BB2_1 Depth=1
        li      a0, 0
        sw      a0, -48(s0) # int j = 0;
        j       .LBB2_3
.LBB2_3:                                #   Parent Loop BB2_1 Depth=1
        lw      a0, -48(s0) # j
        lw      a2, -28(s0) # len
        lw      a1, -44(s0) # i
        not     a1, a1 # 取反，相当于是 ~a1 ， 相当于是 ~i ，~i + 1 = -i => ~i = -i - 1
        addw    a1, a1, a2 # a1 = len - i - 1
        bge     a0, a1, .LBB2_8 # j >= len - i - 1
        j       .LBB2_4
.LBB2_4:                                #   in Loop: Header=BB2_3 Depth=2
        ld      a2, -40(s0) # a2 = cmp
        ld      a0, -24(s0) # arr
        lw      a1, -48(s0) # j
        slli    a1, a1, 2
        add     a1, a1, a0 # arr[j]
        lw      a0, 0(a1) # a0 = arr[j]
        lw      a1, 4(a1) # a1 = arr[j+1]

        jalr    a2 # 调用函数，遵守函数调用惯例
        beqz    a0, .LBB2_6
        j       .LBB2_5
.LBB2_5:                                #   in Loop: Header=BB2_3 Depth=2
        ld      a0, -24(s0) # arr
        lw      a1, -48(s0) # j
        slli    a1, a1, 2
        add     a0, a0, a1 # arr[j]
        lw      a0, 0(a0)
        sw      a0, -52(s0) # int temp = arr[j]

        ld      a0, -24(s0) # arr
        lw      a1, -48(s0) # j
        slli    a1, a1, 2
        add     a1, a1, a0 # a1 = &arr[j]
        lw      a0, 4(a1) # a0 = arr[j+1]
        sw      a0, 0(a1) # arr[j] = arr[j+1]

        lw      a0, -52(s0) # temp
        ld      a2, -24(s0) # arr
        lw      a1, -48(s0) # j
        slli    a1, a1, 2
        add     a1, a1, a2 # &arr[j]
        sw      a0, 4(a1) # arr[j+1] = temp
        j       .LBB2_6
.LBB2_6:                                #   in Loop: Header=BB2_3 Depth=2
        j       .LBB2_7
.LBB2_7:                                #   in Loop: Header=BB2_3 Depth=2
        lw      a0, -48(s0)
        addiw   a0, a0, 1
        sw      a0, -48(s0) # j++
        j       .LBB2_3
.LBB2_8:                                #   in Loop: Header=BB2_1 Depth=1
        j       .LBB2_9
.LBB2_9:                                #   in Loop: Header=BB2_1 Depth=1
        lw      a0, -44(s0)
        addiw   a0, a0, 1
        sw      a0, -44(s0) # i++
        j       .LBB2_1
.LBB2_10:
        ld      ra, 56(sp)                      # 8-byte Folded Reload
        ld      s0, 48(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 64
        ret

printArray:                             # @printArray
        addi    sp, sp, -32
        sd      ra, 24(sp)                      # 8-byte Folded Spill
        sd      s0, 16(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 32
        sd      a0, -24(s0)
        sw      a1, -28(s0)
        li      a0, 0
        sw      a0, -32(s0)
        j       .LBB3_1
.LBB3_1:                                # =>This Inner Loop Header: Depth=1
        lw      a0, -32(s0)
        lw      a1, -28(s0)
        bge     a0, a1, .LBB3_4
        j       .LBB3_2
.LBB3_2:                                #   in Loop: Header=BB3_1 Depth=1
        ld      a0, -24(s0)
        lw      a1, -32(s0)
        slli    a1, a1, 2
        add     a0, a0, a1
        lw      a1, 0(a0)
.Lpcrel_hi0:
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi0)
        call    printf
        j       .LBB3_3
.LBB3_3:                                #   in Loop: Header=BB3_1 Depth=1
        lw      a0, -32(s0)
        addiw   a0, a0, 1
        sw      a0, -32(s0)
        j       .LBB3_1
.LBB3_4:
        li      a0, 10
        call    putchar
        ld      ra, 24(sp)                      # 8-byte Folded Reload
        ld      s0, 16(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 32
        ret

main:                                   # @main
        addi    sp, sp, -80
        sd      ra, 72(sp)                      # 8-byte Folded Spill
        sd      s0, 64(sp)                      # 8-byte Folded Spill
        addi    s0, sp, 80

        li      a0, 0
        sd      a0, -64(s0)                     # 8-byte Folded Spill
        sw      a0, -20(s0)
        li      a0, 3
        slli    a0, a0, 33
        addi    a0, a0, 5
        sd      a0, -32(s0)
        li      a0, 1
        slli    a1, a0, 32
        addi    a1, a1, 9
        sd      a1, -40(s0)
        slli    a0, a0, 33
        addi    a0, a0, 5
        sd      a0, -48(s0)
        li      a0, 6
        sw      a0, -52(s0)
.Lpcrel_hi1:
        auipc   a0, %pcrel_hi(.L.str.1)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi1)
        call    printf

        lw      a1, -52(s0)
        addi    a0, s0, -48
        sd      a0, -72(s0)                     # 8-byte Folded Spill
        call    printArray

        ld      a0, -72(s0)                     # 8-byte Folded Reload
        lw      a1, -52(s0)
.Lpcrel_hi2:
        auipc   a2, %pcrel_hi(ascending)
        addi    a2, a2, %pcrel_lo(.Lpcrel_hi2)
        call    sort

.Lpcrel_hi3:
        auipc   a0, %pcrel_hi(.L.str.2)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi3)
        call    printf

        ld      a0, -72(s0)                     # 8-byte Folded Reload
        lw      a1, -52(s0)
        call    printArray

        ld      a0, -72(s0)                     # 8-byte Folded Reload
        lw      a1, -52(s0)
.Lpcrel_hi4:
        auipc   a2, %pcrel_hi(descending)
        addi    a2, a2, %pcrel_lo(.Lpcrel_hi4)
        call    sort

.Lpcrel_hi5:
        auipc   a0, %pcrel_hi(.L.str.3)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi5)
        call    printf
        ld      a0, -72(s0)                     # 8-byte Folded Reload
        lw      a1, -52(s0)
        call    printArray

        ld      a0, -64(s0)                     # 8-byte Folded Reload
        ld      ra, 72(sp)                      # 8-byte Folded Reload
        ld      s0, 64(sp)                      # 8-byte Folded Reload
        addi    sp, sp, 80
        ret
.L.str:
        .asciz  "%d "

.L.str.1:
        .asciz  "Original array: \n"

.L.str.2:
        .asciz  "Sorted array in ascending order: \n"

.L.str.3:
        .asciz  "Sorted array in descending order: \n"
