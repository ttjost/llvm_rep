; ModuleID = 'simple.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-unknown-linux-gnu"

@a = common global [32 x i32] zeroinitializer, align 4
@b = common global [32 x i32] zeroinitializer, align 4
@c = common global [32 x i32] zeroinitializer, align 4

; Function Attrs: nounwind
define i32 @main() #0 {
entry:
  br label %vector.body

vector.body:                                      ; preds = %entry
  %wide.load = load <8 x i32>, <8 x i32>* bitcast ([32 x i32]* @a to <8 x i32>*), align 4, !tbaa !1
  %wide.load9 = load <8 x i32>, <8 x i32>* bitcast ([32 x i32]* @b to <8 x i32>*), align 4, !tbaa !1
  %0 = add nsw <8 x i32> %wide.load9, %wide.load
  store <8 x i32> %0, <8 x i32>* bitcast ([32 x i32]* @c to <8 x i32>*), align 4, !tbaa !1
  %wide.load.1 = load <8 x i32>, <8 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @a, i32 0, i32 8) to <8 x i32>*), align 4, !tbaa !1
  %wide.load9.1 = load <8 x i32>, <8 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @b, i32 0, i32 8) to <8 x i32>*), align 4, !tbaa !1
  %1 = add nsw <8 x i32> %wide.load9.1, %wide.load.1
  store <8 x i32> %1, <8 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @c, i32 0, i32 8) to <8 x i32>*), align 4, !tbaa !1
  %wide.load.2 = load <8 x i32>, <8 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @a, i32 0, i32 16) to <8 x i32>*), align 4, !tbaa !1
  %wide.load9.2 = load <8 x i32>, <8 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @b, i32 0, i32 16) to <8 x i32>*), align 4, !tbaa !1
  %2 = add nsw <8 x i32> %wide.load9.2, %wide.load.2
  store <8 x i32> %2, <8 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @c, i32 0, i32 16) to <8 x i32>*), align 4, !tbaa !1
  %wide.load.3 = load <8 x i32>, <8 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @a, i32 0, i32 24) to <8 x i32>*), align 4, !tbaa !1
  %wide.load9.3 = load <8 x i32>, <8 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @b, i32 0, i32 24) to <8 x i32>*), align 4, !tbaa !1
  %3 = add nsw <8 x i32> %wide.load9.3, %wide.load.3
  store <8 x i32> %3, <8 x i32>* bitcast (i32* getelementptr inbounds ([32 x i32], [32 x i32]* @c, i32 0, i32 24) to <8 x i32>*), align 4, !tbaa !1
  ret i32 0
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="true" "no-nans-fp-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="broadwell" "target-features"="+adx,+aes,+avx,+avx2,+bmi,+bmi2,+cx16,+f16c,+fma,+fsgsbase,+lzcnt,+pclmul,+popcnt,+rdrnd,+rdseed,+rtm,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
