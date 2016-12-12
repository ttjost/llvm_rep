; ModuleID = 'rgbimage.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-unknown-linux-gnu"

%struct.RgbImage = type { i32, i32, [512 x [512 x i32]], [512 x [512 x i32]], [512 x [512 x i32]] }

@IMAGE_SIZE = global i32 512, align 4

; Function Attrs: nounwind
define void @makeGrayscale(%struct.RgbImage* nocapture %image) #0 {
entry:
  br label %vector.ph

vector.ph:                                        ; preds = %for.inc.29, %entry
  %i.060 = phi i32 [ 0, %entry ], [ %inc30, %for.inc.29 ]
  br label %vector.body

vector.body:                                      ; preds = %vector.body, %vector.ph
  %index = phi i32 [ 0, %vector.ph ], [ %index.next, %vector.body ]
  %0 = getelementptr inbounds %struct.RgbImage, %struct.RgbImage* %image, i32 0, i32 2, i32 %i.060, i32 %index
  %1 = bitcast i32* %0 to <4 x i32>*
  %wide.load = load <4 x i32>, <4 x i32>* %1, align 4, !tbaa !1
  %2 = sitofp <4 x i32> %wide.load to <4 x float>
  %3 = fmul <4 x float> %2, <float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000, float 0x3FD3333340000000>
  %4 = getelementptr inbounds %struct.RgbImage, %struct.RgbImage* %image, i32 0, i32 3, i32 %i.060, i32 %index
  %5 = bitcast i32* %4 to <4 x i32>*
  %wide.load62 = load <4 x i32>, <4 x i32>* %5, align 4, !tbaa !1
  %6 = sitofp <4 x i32> %wide.load62 to <4 x float>
  %7 = fmul <4 x float> %6, <float 0x3FE2E147A0000000, float 0x3FE2E147A0000000, float 0x3FE2E147A0000000, float 0x3FE2E147A0000000>
  %8 = fadd <4 x float> %3, %7
  %9 = getelementptr inbounds %struct.RgbImage, %struct.RgbImage* %image, i32 0, i32 4, i32 %i.060, i32 %index
  %10 = bitcast i32* %9 to <4 x i32>*
  %wide.load63 = load <4 x i32>, <4 x i32>* %10, align 4, !tbaa !1
  %11 = sitofp <4 x i32> %wide.load63 to <4 x float>
  %12 = fmul <4 x float> %11, <float 0x3FBC28F5C0000000, float 0x3FBC28F5C0000000, float 0x3FBC28F5C0000000, float 0x3FBC28F5C0000000>
  %13 = fadd <4 x float> %8, %12
  %14 = fptosi <4 x float> %13 to <4 x i16>
  %15 = sext <4 x i16> %14 to <4 x i32>
  %16 = bitcast i32* %0 to <4 x i32>*
  store <4 x i32> %15, <4 x i32>* %16, align 4, !tbaa !1
  %17 = bitcast i32* %4 to <4 x i32>*
  store <4 x i32> %15, <4 x i32>* %17, align 4, !tbaa !1
  %18 = bitcast i32* %9 to <4 x i32>*
  store <4 x i32> %15, <4 x i32>* %18, align 4, !tbaa !1
  %index.next = add i32 %index, 4
  %19 = icmp eq i32 %index.next, 512
  br i1 %19, label %for.inc.29, label %vector.body, !llvm.loop !5

for.inc.29:                                       ; preds = %vector.body
  %inc30 = add nuw nsw i32 %i.060, 1
  %exitcond61 = icmp eq i32 %inc30, 512
  br i1 %exitcond61, label %for.end.31, label %vector.ph

for.end.31:                                       ; preds = %for.inc.29
  ret void
}

; Function Attrs: nounwind
define void @readMcuFromRgbImage(%struct.RgbImage* nocapture readonly %image, i32 %x, i32 %y, i16* nocapture %data) #0 {
entry:
  %add.1 = add nsw i32 %x, 1
  %add.2 = add nsw i32 %x, 2
  %add.3 = add nsw i32 %x, 3
  %add.4 = add nsw i32 %x, 4
  %add.5 = add nsw i32 %x, 5
  %add.6 = add nsw i32 %x, 6
  %add.7 = add nsw i32 %x, 7
  br label %for.cond.1.preheader

for.cond.1.preheader:                             ; preds = %for.cond.1.preheader, %entry
  %i.020 = phi i32 [ 0, %entry ], [ %inc9, %for.cond.1.preheader ]
  %add4 = add nsw i32 %i.020, %y
  %mul = shl i32 %i.020, 3
  %arrayidx5 = getelementptr inbounds %struct.RgbImage, %struct.RgbImage* %image, i32 0, i32 2, i32 %add4, i32 %x
  %0 = load i32, i32* %arrayidx5, align 4, !tbaa !1
  %conv = trunc i32 %0 to i16
  %arrayidx7 = getelementptr inbounds i16, i16* %data, i32 %mul
  store i16 %conv, i16* %arrayidx7, align 2, !tbaa !8
  %arrayidx5.1 = getelementptr inbounds %struct.RgbImage, %struct.RgbImage* %image, i32 0, i32 2, i32 %add4, i32 %add.1
  %1 = load i32, i32* %arrayidx5.1, align 4, !tbaa !1
  %conv.1 = trunc i32 %1 to i16
  %add6.1 = or i32 %mul, 1
  %arrayidx7.1 = getelementptr inbounds i16, i16* %data, i32 %add6.1
  store i16 %conv.1, i16* %arrayidx7.1, align 2, !tbaa !8
  %arrayidx5.2 = getelementptr inbounds %struct.RgbImage, %struct.RgbImage* %image, i32 0, i32 2, i32 %add4, i32 %add.2
  %2 = load i32, i32* %arrayidx5.2, align 4, !tbaa !1
  %conv.2 = trunc i32 %2 to i16
  %add6.2 = or i32 %mul, 2
  %arrayidx7.2 = getelementptr inbounds i16, i16* %data, i32 %add6.2
  store i16 %conv.2, i16* %arrayidx7.2, align 2, !tbaa !8
  %arrayidx5.3 = getelementptr inbounds %struct.RgbImage, %struct.RgbImage* %image, i32 0, i32 2, i32 %add4, i32 %add.3
  %3 = load i32, i32* %arrayidx5.3, align 4, !tbaa !1
  %conv.3 = trunc i32 %3 to i16
  %add6.3 = or i32 %mul, 3
  %arrayidx7.3 = getelementptr inbounds i16, i16* %data, i32 %add6.3
  store i16 %conv.3, i16* %arrayidx7.3, align 2, !tbaa !8
  %arrayidx5.4 = getelementptr inbounds %struct.RgbImage, %struct.RgbImage* %image, i32 0, i32 2, i32 %add4, i32 %add.4
  %4 = load i32, i32* %arrayidx5.4, align 4, !tbaa !1
  %conv.4 = trunc i32 %4 to i16
  %add6.4 = or i32 %mul, 4
  %arrayidx7.4 = getelementptr inbounds i16, i16* %data, i32 %add6.4
  store i16 %conv.4, i16* %arrayidx7.4, align 2, !tbaa !8
  %arrayidx5.5 = getelementptr inbounds %struct.RgbImage, %struct.RgbImage* %image, i32 0, i32 2, i32 %add4, i32 %add.5
  %5 = load i32, i32* %arrayidx5.5, align 4, !tbaa !1
  %conv.5 = trunc i32 %5 to i16
  %add6.5 = or i32 %mul, 5
  %arrayidx7.5 = getelementptr inbounds i16, i16* %data, i32 %add6.5
  store i16 %conv.5, i16* %arrayidx7.5, align 2, !tbaa !8
  %arrayidx5.6 = getelementptr inbounds %struct.RgbImage, %struct.RgbImage* %image, i32 0, i32 2, i32 %add4, i32 %add.6
  %6 = load i32, i32* %arrayidx5.6, align 4, !tbaa !1
  %conv.6 = trunc i32 %6 to i16
  %add6.6 = or i32 %mul, 6
  %arrayidx7.6 = getelementptr inbounds i16, i16* %data, i32 %add6.6
  store i16 %conv.6, i16* %arrayidx7.6, align 2, !tbaa !8
  %arrayidx5.7 = getelementptr inbounds %struct.RgbImage, %struct.RgbImage* %image, i32 0, i32 2, i32 %add4, i32 %add.7
  %7 = load i32, i32* %arrayidx5.7, align 4, !tbaa !1
  %conv.7 = trunc i32 %7 to i16
  %add6.7 = or i32 %mul, 7
  %arrayidx7.7 = getelementptr inbounds i16, i16* %data, i32 %add6.7
  store i16 %conv.7, i16* %arrayidx7.7, align 2, !tbaa !8
  %inc9 = add nuw nsw i32 %i.020, 1
  %exitcond = icmp eq i32 %inc9, 8
  br i1 %exitcond, label %for.end.10, label %for.cond.1.preheader

for.end.10:                                       ; preds = %for.cond.1.preheader
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = distinct !{!5, !6, !7}
!6 = !{!"llvm.loop.vectorize.width", i32 1}
!7 = !{!"llvm.loop.interleave.count", i32 1}
!8 = !{!9, !9, i64 0}
!9 = !{!"short", !3, i64 0}
