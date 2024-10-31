# ch07 - 函数

## 静态地址 与 相对地址

对于全局变量的访问，gcc 与 clang 采用了不同的策略

### gcc 静态地址

```gcc
.LC0:
        .string "f(20) = %ld\n"
main:
		...

        lui     a5,%hi(.LC0)
        addi    a0,a5,%lo(.LC0)

		...
```

这里是计算出来了 .LC0 的绝对地址，先取 高 20 位到 a5 中；再取 低 12 位 + 高 20 位 到 a0 中

### llvm 相对地址

```clang
main:                                   # @main
		...

.Lpcrel_hi0:
        auipc   a0, %pcrel_hi(.L.str)
        addi    a0, a0, %pcrel_lo(.Lpcrel_hi0)

		...

.L.str:
        .asciz  "f(20) = %ld\n"
```

对于准备访问 全局变量，clang 会在访问点处设置一个标号。

auipc(add upper immediate to PC)，其实不是 to PC 啦，而是将结果保存到一个寄存器中。
这里`auipc a0, %pcrel_hi(.L.str)`，等价于`a0 = PC + %pcrel_hi(.L.str)`。
其中，这里的 pcrel_hi(program counter relative)，行为是计算 当前指令位置 与 .L.str 的差值

相对地址非常好，可以支持 PIC(Position-Independent Code，位置无关代码) 的生成（动态库通常都要有 PIC）。

## 调试信息

clang(llvm) 生成的汇编代码中，还有如下片段

```clang
.Ldebug_list_header_start0:
        .half   5                               # Version
        .byte   8                               # Address size
        .byte   0                               # Segment selector size
        .word   1                               # Offset entry count
        .word   .Ldebug_loc0 - .Lloclists_table_base0
        .byte   4                               # DW_LLE_offset_pair
        .byte   2                               # Loc expr size
        .byte   123                             # DW_OP_breg11
        .byte   0                               # 0
        .byte   4                               # DW_LLE_offset_pair
        .byte   3                               # Loc expr size
        .byte   120                             # DW_OP_breg8
        .byte   72                              # -56
        .byte   6                               # DW_OP_deref
        .byte   0                               # DW_LLE_end_of_list
.Ldebug_list_header_end0:
```

这段代码是调试信息的一部分，用于描述程序中变量的位置信息，以便在调试时可以准确地定位和检视这些变量。
它遵循了 DWARF 调试信息格式，这是一种广泛用于不同编译器和调试器之间的调试数据标准格式。我将逐项解释这些指令和标记的含义：

- `.Ldebug_list_header_start0:` 到 `.Ldebug_list_header_end0:` 这两个标签之间的内容定义了一段特定的调试信息。

- `.half 5`：定义了调试信息格式的版本号，这里是版本 5。
- `.byte 8`：指明了地址大小，这里是 8 字节，意味着目标平台是 64 位的。
- `.byte 0`：段选择器的大小，这里是 0，表明不使用段选择器。
- `.word 1`：偏移量条目的数量，这里为 1，表明有一个偏移量条目。
- `.word .Ldebug_loc0 - .Lloclists_table_base0`：计算两个标签（`.Ldebug_loc0` 和 `.Lloclists_table_base0`）之间的差异，并将这个差异作为值。
  这通常用于定位调试信息中特定部分的偏移量。
- `.byte 4`：`DW_LLE_offset_pair`，表示一对偏移量，这是 DWARF 调试信息中用于指定变量位置的一种编码方式。
- `.byte 2` 和 `.byte 3`：分别表示后续位置表达式的大小，用字节计。
- `DW_OP_breg11` (`123`) 和 `DW_OP_breg8` (`120`)：这些是操作码，分别表示基于特定寄存器的相对地址计算。
  `DW_OP_breg`系列的操作码通常后跟一个偏移量，表示从该寄存器指向的地址开始，加上或减去偏移量得到的地址。
- `.byte 0` 和 `.byte 72` (`-56`)：这些值与前面的 `DW_OP_breg` 操作码一起使用，表示具体的偏移量。
- `DW_OP_deref` (`6`)：一个操作码，表示对前面计算得到的地址进行解引用操作，以获取该地址处的值。
- `DW_LLE_end_of_list` (`0`)：标记位置表达式列表的结束。

简而言之，这段代码在调试信息中定义了变量的内存位置，以便调试器能够在程序执行时访问和展示这些变量的值。
通过使用特定的操作码和偏移量，它描述了如何从寄存器内容和已知偏移量计算出变量的确切位置。
