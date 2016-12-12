; ModuleID = 'simple.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-unknown-linux-gnu"

@a = common global [32 x i32] zeroinitializer, align 4
@b = common global [32 x i32] zeroinitializer, align 4
@c = common global [32 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define i32 @main() #0 {
entry:
  %wide.load = load <16 x i32>, <16 x i32>* bitcast ([32 x i32]* @a to <16 x i32>*), align 4, !tbaa !1
  %wide.load9 = load <16 x i32>, <16 x i32>* bitcast ([32 x i32]* @b to <16 x i32>*), align 4, !tbaa !1
  %0 = add nsw <16 x i32> %wide.load9, %wide.load
  store <16 x i32> %0, <16 x i32>* bitcast ([32 x i32]* @c to <16 x i32>*), align 4, !tbaa !1
  %wide.load.1 = load <16 x i32>, <16 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @a, i32 0, i32 16) to <16 x i32>*), align 4, !tbaa !1
  %wide.load9.1 = load <16 x i32>, <16 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @b, i32 0, i32 16) to <16 x i32>*), align 4, !tbaa !1
  %1 = add nsw <16 x i32> %wide.load9.1, %wide.load.1
  store <16 x i32> %1, <16 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @c, i32 0, i32 16) to <16 x i32>*), align 4, !tbaa !1
  ret i32 0
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="knl" "target-features"="+adx,+aes,+avx,+avx2,+avx512cd,+avx512er,+avx512f,+avx512pf,+bmi,+bmi2,+cx16,+f16c,+fma,+fsgsbase,+lzcnt,+pclmul,+popcnt,+rdrnd,+rdseed,+rtm,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
