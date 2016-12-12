; ModuleID = 'quant.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-unknown-linux-gnu"

@zigzagTable = global [64 x i8] c"\00\01\05\06\0E\0F\1B\1C\02\04\07\0D\10\1A\1D*\03\08\0C\11\19\1E)+\09\0B\12\18\1F(,5\0A\13\17 '-46\14\16!&.37<\15\22%/28;=#$019:>?", align 1
@initQuantizationTables.luminanceQuantTable = private unnamed_addr constant [64 x i8] c"\10\0B\0A\10\18(3=\0C\0C\0E\13\1A:<7\0E\0D\10\18(9E8\0E\11\16\1D3WP>\12\16%8DmgM\18#7@Qhq\5C1@NWgyxeH\5C_bpdgc", align 1
@initQuantizationTables.chrominanceQuantTable = private unnamed_addr constant [64 x i8] c"\11\12\18/cccc\12\15\1ABcccc\18\1A8ccccc/Bcccccccccccccccccccccccccccccccccccccc", align 1
@Lqt = external global [64 x i8], align 1
@ILqt = external global [64 x i16], align 2
@Cqt = external global [64 x i8], align 1
@ICqt = external global [64 x i16], align 2
@Temp = external global [64 x i16], align 2

; Function Attrs: nounwind readnone
define zeroext i16 @dspDivision(i32 %numer, i32 %denom) #0 {
entry:
  %shl = shl i32 %denom, 15
  %cmp2 = icmp ult i32 %shl, %numer
  br i1 %cmp2, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %sub = sub i32 %numer, %shl
  %shl4 = shl i32 %sub, 1
  %inc = or i32 %shl4, 1
  br label %for.inc

if.else:                                          ; preds = %entry
  %shl5 = shl i32 %numer, 1
  br label %for.inc

for.inc:                                          ; preds = %if.then, %if.else
  %numer.addr.1 = phi i32 [ %inc, %if.then ], [ %shl5, %if.else ]
  %cmp2.1 = icmp ugt i32 %numer.addr.1, %shl
  br i1 %cmp2.1, label %if.then.1, label %if.else.1

if.else.1:                                        ; preds = %for.inc
  %shl5.1 = shl i32 %numer.addr.1, 1
  br label %for.inc.1

if.then.1:                                        ; preds = %for.inc
  %sub.1 = sub i32 %numer.addr.1, %shl
  %shl4.1 = shl i32 %sub.1, 1
  %inc.1 = or i32 %shl4.1, 1
  br label %for.inc.1

for.inc.1:                                        ; preds = %if.then.1, %if.else.1
  %numer.addr.1.1 = phi i32 [ %inc.1, %if.then.1 ], [ %shl5.1, %if.else.1 ]
  %cmp2.2 = icmp ugt i32 %numer.addr.1.1, %shl
  br i1 %cmp2.2, label %if.then.2, label %if.else.2

if.else.2:                                        ; preds = %for.inc.1
  %shl5.2 = shl i32 %numer.addr.1.1, 1
  br label %for.inc.2

if.then.2:                                        ; preds = %for.inc.1
  %sub.2 = sub i32 %numer.addr.1.1, %shl
  %shl4.2 = shl i32 %sub.2, 1
  %inc.2 = or i32 %shl4.2, 1
  br label %for.inc.2

for.inc.2:                                        ; preds = %if.then.2, %if.else.2
  %numer.addr.1.2 = phi i32 [ %inc.2, %if.then.2 ], [ %shl5.2, %if.else.2 ]
  %cmp2.3 = icmp ugt i32 %numer.addr.1.2, %shl
  br i1 %cmp2.3, label %if.then.3, label %if.else.3

if.else.3:                                        ; preds = %for.inc.2
  %shl5.3 = shl i32 %numer.addr.1.2, 1
  br label %for.inc.3

if.then.3:                                        ; preds = %for.inc.2
  %sub.3 = sub i32 %numer.addr.1.2, %shl
  %shl4.3 = shl i32 %sub.3, 1
  %inc.3 = or i32 %shl4.3, 1
  br label %for.inc.3

for.inc.3:                                        ; preds = %if.then.3, %if.else.3
  %numer.addr.1.3 = phi i32 [ %inc.3, %if.then.3 ], [ %shl5.3, %if.else.3 ]
  %cmp2.4 = icmp ugt i32 %numer.addr.1.3, %shl
  br i1 %cmp2.4, label %if.then.4, label %if.else.4

if.else.4:                                        ; preds = %for.inc.3
  %shl5.4 = shl i32 %numer.addr.1.3, 1
  br label %for.inc.4

if.then.4:                                        ; preds = %for.inc.3
  %sub.4 = sub i32 %numer.addr.1.3, %shl
  %shl4.4 = shl i32 %sub.4, 1
  %inc.4 = or i32 %shl4.4, 1
  br label %for.inc.4

for.inc.4:                                        ; preds = %if.then.4, %if.else.4
  %numer.addr.1.4 = phi i32 [ %inc.4, %if.then.4 ], [ %shl5.4, %if.else.4 ]
  %cmp2.5 = icmp ugt i32 %numer.addr.1.4, %shl
  br i1 %cmp2.5, label %if.then.5, label %if.else.5

if.else.5:                                        ; preds = %for.inc.4
  %shl5.5 = shl i32 %numer.addr.1.4, 1
  br label %for.inc.5

if.then.5:                                        ; preds = %for.inc.4
  %sub.5 = sub i32 %numer.addr.1.4, %shl
  %shl4.5 = shl i32 %sub.5, 1
  %inc.5 = or i32 %shl4.5, 1
  br label %for.inc.5

for.inc.5:                                        ; preds = %if.then.5, %if.else.5
  %numer.addr.1.5 = phi i32 [ %inc.5, %if.then.5 ], [ %shl5.5, %if.else.5 ]
  %cmp2.6 = icmp ugt i32 %numer.addr.1.5, %shl
  br i1 %cmp2.6, label %if.then.6, label %if.else.6

if.else.6:                                        ; preds = %for.inc.5
  %shl5.6 = shl i32 %numer.addr.1.5, 1
  br label %for.inc.6

if.then.6:                                        ; preds = %for.inc.5
  %sub.6 = sub i32 %numer.addr.1.5, %shl
  %shl4.6 = shl i32 %sub.6, 1
  %inc.6 = or i32 %shl4.6, 1
  br label %for.inc.6

for.inc.6:                                        ; preds = %if.then.6, %if.else.6
  %numer.addr.1.6 = phi i32 [ %inc.6, %if.then.6 ], [ %shl5.6, %if.else.6 ]
  %cmp2.7 = icmp ugt i32 %numer.addr.1.6, %shl
  br i1 %cmp2.7, label %if.then.7, label %if.else.7

if.else.7:                                        ; preds = %for.inc.6
  %shl5.7 = shl i32 %numer.addr.1.6, 1
  br label %for.inc.7

if.then.7:                                        ; preds = %for.inc.6
  %sub.7 = sub i32 %numer.addr.1.6, %shl
  %shl4.7 = shl i32 %sub.7, 1
  %inc.7 = or i32 %shl4.7, 1
  br label %for.inc.7

for.inc.7:                                        ; preds = %if.then.7, %if.else.7
  %numer.addr.1.7 = phi i32 [ %inc.7, %if.then.7 ], [ %shl5.7, %if.else.7 ]
  %cmp2.8 = icmp ugt i32 %numer.addr.1.7, %shl
  br i1 %cmp2.8, label %if.then.8, label %if.else.8

if.else.8:                                        ; preds = %for.inc.7
  %shl5.8 = shl i32 %numer.addr.1.7, 1
  br label %for.inc.8

if.then.8:                                        ; preds = %for.inc.7
  %sub.8 = sub i32 %numer.addr.1.7, %shl
  %shl4.8 = shl i32 %sub.8, 1
  %inc.8 = or i32 %shl4.8, 1
  br label %for.inc.8

for.inc.8:                                        ; preds = %if.then.8, %if.else.8
  %numer.addr.1.8 = phi i32 [ %inc.8, %if.then.8 ], [ %shl5.8, %if.else.8 ]
  %cmp2.9 = icmp ugt i32 %numer.addr.1.8, %shl
  br i1 %cmp2.9, label %if.then.9, label %if.else.9

if.else.9:                                        ; preds = %for.inc.8
  %shl5.9 = shl i32 %numer.addr.1.8, 1
  br label %for.inc.9

if.then.9:                                        ; preds = %for.inc.8
  %sub.9 = sub i32 %numer.addr.1.8, %shl
  %shl4.9 = shl i32 %sub.9, 1
  %inc.9 = or i32 %shl4.9, 1
  br label %for.inc.9

for.inc.9:                                        ; preds = %if.then.9, %if.else.9
  %numer.addr.1.9 = phi i32 [ %inc.9, %if.then.9 ], [ %shl5.9, %if.else.9 ]
  %cmp2.10 = icmp ugt i32 %numer.addr.1.9, %shl
  br i1 %cmp2.10, label %if.then.10, label %if.else.10

if.else.10:                                       ; preds = %for.inc.9
  %shl5.10 = shl i32 %numer.addr.1.9, 1
  br label %for.inc.10

if.then.10:                                       ; preds = %for.inc.9
  %sub.10 = sub i32 %numer.addr.1.9, %shl
  %shl4.10 = shl i32 %sub.10, 1
  %inc.10 = or i32 %shl4.10, 1
  br label %for.inc.10

for.inc.10:                                       ; preds = %if.then.10, %if.else.10
  %numer.addr.1.10 = phi i32 [ %inc.10, %if.then.10 ], [ %shl5.10, %if.else.10 ]
  %cmp2.11 = icmp ugt i32 %numer.addr.1.10, %shl
  br i1 %cmp2.11, label %if.then.11, label %if.else.11

if.else.11:                                       ; preds = %for.inc.10
  %shl5.11 = shl i32 %numer.addr.1.10, 1
  br label %for.inc.11

if.then.11:                                       ; preds = %for.inc.10
  %sub.11 = sub i32 %numer.addr.1.10, %shl
  %shl4.11 = shl i32 %sub.11, 1
  %inc.11 = or i32 %shl4.11, 1
  br label %for.inc.11

for.inc.11:                                       ; preds = %if.then.11, %if.else.11
  %numer.addr.1.11 = phi i32 [ %inc.11, %if.then.11 ], [ %shl5.11, %if.else.11 ]
  %cmp2.12 = icmp ugt i32 %numer.addr.1.11, %shl
  br i1 %cmp2.12, label %if.then.12, label %if.else.12

if.else.12:                                       ; preds = %for.inc.11
  %shl5.12 = shl i32 %numer.addr.1.11, 1
  br label %for.inc.12

if.then.12:                                       ; preds = %for.inc.11
  %sub.12 = sub i32 %numer.addr.1.11, %shl
  %shl4.12 = shl i32 %sub.12, 1
  %inc.12 = or i32 %shl4.12, 1
  br label %for.inc.12

for.inc.12:                                       ; preds = %if.then.12, %if.else.12
  %numer.addr.1.12 = phi i32 [ %inc.12, %if.then.12 ], [ %shl5.12, %if.else.12 ]
  %cmp2.13 = icmp ugt i32 %numer.addr.1.12, %shl
  br i1 %cmp2.13, label %if.then.13, label %if.else.13

if.else.13:                                       ; preds = %for.inc.12
  %shl5.13 = shl i32 %numer.addr.1.12, 1
  br label %for.inc.13

if.then.13:                                       ; preds = %for.inc.12
  %sub.13 = sub i32 %numer.addr.1.12, %shl
  %shl4.13 = shl i32 %sub.13, 1
  %inc.13 = or i32 %shl4.13, 1
  br label %for.inc.13

for.inc.13:                                       ; preds = %if.then.13, %if.else.13
  %numer.addr.1.13 = phi i32 [ %inc.13, %if.then.13 ], [ %shl5.13, %if.else.13 ]
  %cmp2.14 = icmp ugt i32 %numer.addr.1.13, %shl
  br i1 %cmp2.14, label %if.then.14, label %if.else.14

if.else.14:                                       ; preds = %for.inc.13
  %shl5.14 = shl i32 %numer.addr.1.13, 1
  br label %for.inc.14

if.then.14:                                       ; preds = %for.inc.13
  %sub.14 = sub i32 %numer.addr.1.13, %shl
  %shl4.14 = shl i32 %sub.14, 1
  %inc.14 = or i32 %shl4.14, 1
  br label %for.inc.14

for.inc.14:                                       ; preds = %if.then.14, %if.else.14
  %numer.addr.1.14 = phi i32 [ %inc.14, %if.then.14 ], [ %shl5.14, %if.else.14 ]
  %cmp2.15 = icmp ugt i32 %numer.addr.1.14, %shl
  br i1 %cmp2.15, label %if.then.15, label %if.else.15

if.else.15:                                       ; preds = %for.inc.14
  %shl5.15 = shl i32 %numer.addr.1.14, 1
  br label %for.inc.15

if.then.15:                                       ; preds = %for.inc.14
  %sub.15 = sub i32 %numer.addr.1.14, %shl
  %shl4.15 = shl i32 %sub.15, 1
  %inc.15 = or i32 %shl4.15, 1
  br label %for.inc.15

for.inc.15:                                       ; preds = %if.then.15, %if.else.15
  %numer.addr.1.15 = phi i32 [ %inc.15, %if.then.15 ], [ %shl5.15, %if.else.15 ]
  %conv6 = trunc i32 %numer.addr.1.15 to i16
  ret i16 %conv6
}

; Function Attrs: nounwind
define void @initQuantizationTables(i32 %qualityFactor) #1 {
entry:
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i32 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [64 x i8], [64 x i8]* @zigzagTable, i32 0, i32 %indvars.iv
  %0 = load i8, i8* %arrayidx, align 1, !tbaa !1
  %arrayidx4 = getelementptr inbounds [64 x i8], [64 x i8]* @initQuantizationTables.luminanceQuantTable, i32 0, i32 %indvars.iv
  %1 = load i8, i8* %arrayidx4, align 1, !tbaa !1
  %conv5 = zext i8 %1 to i32
  %mul = mul i32 %conv5, %qualityFactor
  %add = add i32 %mul, 512
  %shr = lshr i32 %add, 10
  %cmp6 = icmp eq i32 %shr, 0
  %cmp8 = icmp ugt i32 %add, 262143
  %.shr = select i1 %cmp8, i32 255, i32 %shr
  %value.0 = select i1 %cmp6, i32 1, i32 %.shr
  %conv12 = trunc i32 %value.0 to i8
  %idxprom13 = zext i8 %0 to i32
  %arrayidx14 = getelementptr inbounds [64 x i8], [64 x i8]* @Lqt, i32 0, i32 %idxprom13
  store i8 %conv12, i8* %arrayidx14, align 1, !tbaa !1
  %call = tail call zeroext i16 @dspDivision(i32 32768, i32 %value.0)
  %arrayidx16 = getelementptr inbounds [64 x i16], [64 x i16]* @ILqt, i32 0, i32 %indvars.iv
  store i16 %call, i16* %arrayidx16, align 2, !tbaa !4
  %arrayidx18 = getelementptr inbounds [64 x i8], [64 x i8]* @initQuantizationTables.chrominanceQuantTable, i32 0, i32 %indvars.iv
  %2 = load i8, i8* %arrayidx18, align 1, !tbaa !1
  %conv19 = zext i8 %2 to i32
  %mul20 = mul i32 %conv19, %qualityFactor
  %add21 = add i32 %mul20, 512
  %shr22 = lshr i32 %add21, 10
  %cmp23 = icmp eq i32 %shr22, 0
  %cmp27 = icmp ugt i32 %add21, 262143
  %.shr22 = select i1 %cmp27, i32 255, i32 %shr22
  %value.1 = select i1 %cmp23, i32 1, i32 %.shr22
  %conv32 = trunc i32 %value.1 to i8
  %arrayidx34 = getelementptr inbounds [64 x i8], [64 x i8]* @Cqt, i32 0, i32 %idxprom13
  store i8 %conv32, i8* %arrayidx34, align 1, !tbaa !1
  %call35 = tail call zeroext i16 @dspDivision(i32 32768, i32 %value.1)
  %arrayidx37 = getelementptr inbounds [64 x i16], [64 x i16]* @ICqt, i32 0, i32 %indvars.iv
  store i16 %call35, i16* %arrayidx37, align 2, !tbaa !4
  %indvars.iv.next = add nuw nsw i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 64
  br i1 %exitcond, label %for.end, label %for.body

for.end:                                          ; preds = %for.body
  ret void
}

; Function Attrs: nounwind
define void @quantization(i16* nocapture readonly %data, i16* nocapture readonly %quant_table_ptr) #1 {
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %indvars.iv = phi i32 [ 63, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds i16, i16* %data, i32 %indvars.iv
  %0 = load i16, i16* %arrayidx, align 2, !tbaa !4
  %conv2 = sext i16 %0 to i32
  %arrayidx4 = getelementptr inbounds i16, i16* %quant_table_ptr, i32 %indvars.iv
  %1 = load i16, i16* %arrayidx4, align 2, !tbaa !4
  %conv5 = zext i16 %1 to i32
  %mul = mul nsw i32 %conv5, %conv2
  %add = add nsw i32 %mul, 16384
  %shr.18 = lshr i32 %add, 15
  %conv6 = trunc i32 %shr.18 to i16
  %arrayidx8 = getelementptr inbounds [64 x i8], [64 x i8]* @zigzagTable, i32 0, i32 %indvars.iv
  %2 = load i8, i8* %arrayidx8, align 1, !tbaa !1
  %idxprom9 = zext i8 %2 to i32
  %arrayidx10 = getelementptr inbounds [64 x i16], [64 x i16]* @Temp, i32 0, i32 %idxprom9
  store i16 %conv6, i16* %arrayidx10, align 2, !tbaa !4
  %indvars.iv.next = add nsw i32 %indvars.iv, -1
  %cmp = icmp sgt i32 %indvars.iv, 0
  br i1 %cmp, label %for.body, label %for.end

for.end:                                          ; preds = %for.body
  ret void
}

attributes #0 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"omnipotent char", !3, i64 0}
!3 = !{!"Simple C/C++ TBAA"}
!4 = !{!5, !5, i64 0}
!5 = !{!"short", !2, i64 0}
