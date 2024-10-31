; ModuleID = 'size.c'
source_filename = "size.c"
; target datalayout 
; 	e 小端存储
;	m:o mach-o 目标文件格式，常用于 macOS 或者 iOS
; 	i64:64 表示 i64 自然对齐是 64bit
;	i128:128 表示 i128 自然对齐是 128bit
;	n32:64 表示 n32(32位整数) 是本地整数类型; :64 表示: 32位整数应该按 64bit 对齐
;	S128 规定了 最大对齐(可能就是内存模数)
;		结构体的对齐，在我的这台电脑上就是: min{16, sizeof(结构体中最大的元素的 对齐要求)}
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx14.0.0"

; Function Attrs: noinline nounwind optnone ssp uwtable(sync)
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 5, ptr %1, align 4
  ; size = sizeof(int) ，这里 sizeof 是直接计算出来了
  store i32 4, ptr %2, align 4
  ret i32 0
}

attributes #0 = { noinline nounwind optnone ssp uwtable(sync) "frame-pointer"="non-leaf" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-m1" "target-features"="+aes,+crc,+dotprod,+fp-armv8,+fp16fml,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+sha3,+v8.1a,+v8.2a,+v8.3a,+v8.4a,+v8.5a,+v8a,+zcm,+zcz" }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"uwtable", i32 1}
!3 = !{i32 7, !"frame-pointer", i32 1}
!4 = !{!"Homebrew clang version 17.0.6"}
