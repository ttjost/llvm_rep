; ModuleID = 'dct.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-unknown-linux-gnu"

; Function Attrs: nounwind
define void @levelShift(i16* nocapture %data) #0 {
entry:
  br label %vector.body

vector.body:                                      ; preds = %entry
  %0 = getelementptr i16, i16* %data, i32 56
  %1 = bitcast i16* %0 to <8 x i16>*
  %wide.load = load <8 x i16>, <8 x i16>* %1, align 2, !tbaa !1
  %2 = add <8 x i16> %wide.load, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %3 = bitcast i16* %0 to <8 x i16>*
  store <8 x i16> %2, <8 x i16>* %3, align 2, !tbaa !1
  %4 = getelementptr i16, i16* %data, i32 48
  %5 = bitcast i16* %4 to <8 x i16>*
  %wide.load.1 = load <8 x i16>, <8 x i16>* %5, align 2, !tbaa !1
  %6 = add <8 x i16> %wide.load.1, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %7 = bitcast i16* %4 to <8 x i16>*
  store <8 x i16> %6, <8 x i16>* %7, align 2, !tbaa !1
  %8 = getelementptr i16, i16* %data, i32 40
  %9 = bitcast i16* %8 to <8 x i16>*
  %wide.load.2 = load <8 x i16>, <8 x i16>* %9, align 2, !tbaa !1
  %10 = add <8 x i16> %wide.load.2, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %11 = bitcast i16* %8 to <8 x i16>*
  store <8 x i16> %10, <8 x i16>* %11, align 2, !tbaa !1
  %12 = getelementptr i16, i16* %data, i32 32
  %13 = bitcast i16* %12 to <8 x i16>*
  %wide.load.3 = load <8 x i16>, <8 x i16>* %13, align 2, !tbaa !1
  %14 = add <8 x i16> %wide.load.3, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %15 = bitcast i16* %12 to <8 x i16>*
  store <8 x i16> %14, <8 x i16>* %15, align 2, !tbaa !1
  %16 = getelementptr i16, i16* %data, i32 24
  %17 = bitcast i16* %16 to <8 x i16>*
  %wide.load.4 = load <8 x i16>, <8 x i16>* %17, align 2, !tbaa !1
  %18 = add <8 x i16> %wide.load.4, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %19 = bitcast i16* %16 to <8 x i16>*
  store <8 x i16> %18, <8 x i16>* %19, align 2, !tbaa !1
  %20 = getelementptr i16, i16* %data, i32 16
  %21 = bitcast i16* %20 to <8 x i16>*
  %wide.load.5 = load <8 x i16>, <8 x i16>* %21, align 2, !tbaa !1
  %22 = add <8 x i16> %wide.load.5, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %23 = bitcast i16* %20 to <8 x i16>*
  store <8 x i16> %22, <8 x i16>* %23, align 2, !tbaa !1
  %24 = getelementptr i16, i16* %data, i32 8
  %25 = bitcast i16* %24 to <8 x i16>*
  %wide.load.6 = load <8 x i16>, <8 x i16>* %25, align 2, !tbaa !1
  %26 = add <8 x i16> %wide.load.6, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %27 = bitcast i16* %24 to <8 x i16>*
  store <8 x i16> %26, <8 x i16>* %27, align 2, !tbaa !1
  %28 = bitcast i16* %data to <8 x i16>*
  %wide.load.7 = load <8 x i16>, <8 x i16>* %28, align 2, !tbaa !1
  %29 = add <8 x i16> %wide.load.7, <i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128, i16 -128>
  %30 = bitcast i16* %data to <8 x i16>*
  store <8 x i16> %29, <8 x i16>* %30, align 2, !tbaa !1
  ret void
}

; Function Attrs: nounwind readnone
define float @C(i32 %u) #1 {
entry:
  %cmp = icmp eq i32 %u, 0
  %. = select i1 %cmp, float 0x3FE6A09E60000000, float 1.000000e+00
  ret float %.
}

; Function Attrs: nounwind
define void @dct(i16* nocapture %data) #0 {
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %for.body
  %i.0346 = phi i16 [ 8, %entry ], [ %dec, %for.body ]
  %data.addr.0345 = phi i16* [ %data, %entry ], [ %add.ptr, %for.body ]
  %0 = load i16, i16* %data.addr.0345, align 2, !tbaa !1
  %conv2 = sext i16 %0 to i32
  %arrayidx3 = getelementptr inbounds i16, i16* %data.addr.0345, i32 7
  %1 = load i16, i16* %arrayidx3, align 2, !tbaa !1
  %conv4 = sext i16 %1 to i32
  %add = add nsw i32 %conv4, %conv2
  %sub = sub nsw i32 %conv2, %conv4
  %arrayidx9 = getelementptr inbounds i16, i16* %data.addr.0345, i32 1
  %2 = load i16, i16* %arrayidx9, align 2, !tbaa !1
  %conv10 = sext i16 %2 to i32
  %arrayidx11 = getelementptr inbounds i16, i16* %data.addr.0345, i32 6
  %3 = load i16, i16* %arrayidx11, align 2, !tbaa !1
  %conv12 = sext i16 %3 to i32
  %add13 = add nsw i32 %conv12, %conv10
  %sub18 = sub nsw i32 %conv10, %conv12
  %arrayidx19 = getelementptr inbounds i16, i16* %data.addr.0345, i32 2
  %4 = load i16, i16* %arrayidx19, align 2, !tbaa !1
  %conv20 = sext i16 %4 to i32
  %arrayidx21 = getelementptr inbounds i16, i16* %data.addr.0345, i32 5
  %5 = load i16, i16* %arrayidx21, align 2, !tbaa !1
  %conv22 = sext i16 %5 to i32
  %add23 = add nsw i32 %conv22, %conv20
  %sub28 = sub nsw i32 %conv20, %conv22
  %arrayidx29 = getelementptr inbounds i16, i16* %data.addr.0345, i32 3
  %6 = load i16, i16* %arrayidx29, align 2, !tbaa !1
  %conv30 = sext i16 %6 to i32
  %arrayidx31 = getelementptr inbounds i16, i16* %data.addr.0345, i32 4
  %7 = load i16, i16* %arrayidx31, align 2, !tbaa !1
  %conv32 = sext i16 %7 to i32
  %add33 = add nsw i32 %conv32, %conv30
  %sub38 = sub nsw i32 %conv30, %conv32
  %add39 = add nsw i32 %add33, %add
  %sub40 = sub nsw i32 %add, %add33
  %add41 = add nsw i32 %add23, %add13
  %sub42 = sub nsw i32 %add13, %add23
  %add43 = add nsw i32 %add39, %add41
  %conv44 = trunc i32 %add43 to i16
  store i16 %conv44, i16* %data.addr.0345, align 2, !tbaa !1
  %sub46 = sub nsw i32 %add39, %add41
  %conv47 = trunc i32 %sub46 to i16
  store i16 %conv47, i16* %arrayidx31, align 2, !tbaa !1
  %mul = mul nsw i32 %sub40, 1338
  %mul49 = mul nsw i32 %sub42, 554
  %add50 = add nsw i32 %mul, %mul49
  %shr.337 = lshr i32 %add50, 10
  %conv51 = trunc i32 %shr.337 to i16
  store i16 %conv51, i16* %arrayidx19, align 2, !tbaa !1
  %mul53 = mul nsw i32 %sub40, 554
  %8 = mul nsw i32 %sub42, -1338
  %sub55 = add i32 %mul53, %8
  %shr56.338 = lshr i32 %sub55, 10
  %conv57 = trunc i32 %shr56.338 to i16
  store i16 %conv57, i16* %arrayidx11, align 2, !tbaa !1
  %mul59 = mul nsw i32 %sub, 283
  %9 = mul nsw i32 %sub18, -805
  %sub61 = add i32 %9, %mul59
  %mul62 = mul nsw i32 %sub28, 1204
  %add63 = add nsw i32 %sub61, %mul62
  %10 = mul nsw i32 %sub38, -1420
  %sub65 = add i32 %add63, %10
  %shr66.339 = lshr i32 %sub65, 10
  %conv67 = trunc i32 %shr66.339 to i16
  store i16 %conv67, i16* %arrayidx3, align 2, !tbaa !1
  %mul69 = mul nsw i32 %sub, 805
  %11 = mul nsw i32 %sub18, -1420
  %sub71 = add i32 %11, %mul69
  %mul72 = mul nsw i32 %sub28, 283
  %add73 = add nsw i32 %sub71, %mul72
  %mul74 = mul nsw i32 %sub38, 1204
  %add75 = add nsw i32 %add73, %mul74
  %shr76.340 = lshr i32 %add75, 10
  %conv77 = trunc i32 %shr76.340 to i16
  store i16 %conv77, i16* %arrayidx21, align 2, !tbaa !1
  %mul79 = mul nsw i32 %sub, 1204
  %12 = mul nsw i32 %sub18, -283
  %sub81 = add i32 %12, %mul79
  %13 = mul nsw i32 %sub28, -1420
  %sub83 = add i32 %sub81, %13
  %14 = mul nsw i32 %sub38, -805
  %sub85 = add i32 %sub83, %14
  %shr86.341 = lshr i32 %sub85, 10
  %conv87 = trunc i32 %shr86.341 to i16
  store i16 %conv87, i16* %arrayidx29, align 2, !tbaa !1
  %mul89 = mul nsw i32 %sub, 1420
  %mul90 = mul nsw i32 %sub18, 1204
  %add91 = add nsw i32 %mul90, %mul89
  %mul92 = mul nsw i32 %sub28, 805
  %add93 = add nsw i32 %add91, %mul92
  %mul94 = mul nsw i32 %sub38, 283
  %add95 = add nsw i32 %add93, %mul94
  %shr96.342 = lshr i32 %add95, 10
  %conv97 = trunc i32 %shr96.342 to i16
  store i16 %conv97, i16* %arrayidx9, align 2, !tbaa !1
  %add.ptr = getelementptr inbounds i16, i16* %data.addr.0345, i32 8
  %dec = add nsw i16 %i.0346, -1
  %cmp = icmp eq i16 %dec, 0
  br i1 %cmp, label %for.body.104.preheader, label %for.body

for.body.104.preheader:                           ; preds = %for.body
  br label %for.body.104

for.body.104:                                     ; preds = %for.body.104.preheader, %for.body.104
  %i.1344 = phi i16 [ %dec210, %for.body.104 ], [ 8, %for.body.104.preheader ]
  %data.addr.1343 = phi i16* [ %incdec.ptr, %for.body.104 ], [ %data, %for.body.104.preheader ]
  %15 = load i16, i16* %data.addr.1343, align 2, !tbaa !1
  %conv106 = sext i16 %15 to i32
  %arrayidx107 = getelementptr inbounds i16, i16* %data.addr.1343, i32 56
  %16 = load i16, i16* %arrayidx107, align 2, !tbaa !1
  %conv108 = sext i16 %16 to i32
  %add109 = add nsw i32 %conv108, %conv106
  %sub114 = sub nsw i32 %conv106, %conv108
  %arrayidx115 = getelementptr inbounds i16, i16* %data.addr.1343, i32 8
  %17 = load i16, i16* %arrayidx115, align 2, !tbaa !1
  %conv116 = sext i16 %17 to i32
  %arrayidx117 = getelementptr inbounds i16, i16* %data.addr.1343, i32 48
  %18 = load i16, i16* %arrayidx117, align 2, !tbaa !1
  %conv118 = sext i16 %18 to i32
  %add119 = add nsw i32 %conv118, %conv116
  %sub124 = sub nsw i32 %conv116, %conv118
  %arrayidx125 = getelementptr inbounds i16, i16* %data.addr.1343, i32 16
  %19 = load i16, i16* %arrayidx125, align 2, !tbaa !1
  %conv126 = sext i16 %19 to i32
  %arrayidx127 = getelementptr inbounds i16, i16* %data.addr.1343, i32 40
  %20 = load i16, i16* %arrayidx127, align 2, !tbaa !1
  %conv128 = sext i16 %20 to i32
  %add129 = add nsw i32 %conv128, %conv126
  %sub134 = sub nsw i32 %conv126, %conv128
  %arrayidx135 = getelementptr inbounds i16, i16* %data.addr.1343, i32 24
  %21 = load i16, i16* %arrayidx135, align 2, !tbaa !1
  %conv136 = sext i16 %21 to i32
  %arrayidx137 = getelementptr inbounds i16, i16* %data.addr.1343, i32 32
  %22 = load i16, i16* %arrayidx137, align 2, !tbaa !1
  %conv138 = sext i16 %22 to i32
  %add139 = add nsw i32 %conv138, %conv136
  %sub144 = sub nsw i32 %conv136, %conv138
  %add145 = add nsw i32 %add139, %add109
  %sub146 = sub nsw i32 %add109, %add139
  %add147 = add nsw i32 %add129, %add119
  %sub148 = sub nsw i32 %add119, %add129
  %add149 = add nsw i32 %add145, %add147
  %shr150.329 = lshr i32 %add149, 3
  %conv151 = trunc i32 %shr150.329 to i16
  store i16 %conv151, i16* %data.addr.1343, align 2, !tbaa !1
  %sub153 = sub nsw i32 %add145, %add147
  %shr154.330 = lshr i32 %sub153, 3
  %conv155 = trunc i32 %shr154.330 to i16
  store i16 %conv155, i16* %arrayidx137, align 2, !tbaa !1
  %mul157 = mul nsw i32 %sub146, 1338
  %mul158 = mul nsw i32 %sub148, 554
  %add159 = add nsw i32 %mul157, %mul158
  %shr160.331 = lshr i32 %add159, 13
  %conv161 = trunc i32 %shr160.331 to i16
  store i16 %conv161, i16* %arrayidx125, align 2, !tbaa !1
  %mul163 = mul nsw i32 %sub146, 554
  %23 = mul nsw i32 %sub148, -1338
  %sub165 = add i32 %mul163, %23
  %shr166.332 = lshr i32 %sub165, 13
  %conv167 = trunc i32 %shr166.332 to i16
  store i16 %conv167, i16* %arrayidx117, align 2, !tbaa !1
  %mul169 = mul nsw i32 %sub114, 283
  %24 = mul nsw i32 %sub124, -805
  %sub171 = add i32 %24, %mul169
  %mul172 = mul nsw i32 %sub134, 1204
  %add173 = add nsw i32 %sub171, %mul172
  %25 = mul nsw i32 %sub144, -1420
  %sub175 = add i32 %add173, %25
  %shr176.333 = lshr i32 %sub175, 13
  %conv177 = trunc i32 %shr176.333 to i16
  store i16 %conv177, i16* %arrayidx107, align 2, !tbaa !1
  %mul179 = mul nsw i32 %sub114, 805
  %26 = mul nsw i32 %sub124, -1420
  %sub181 = add i32 %26, %mul179
  %mul182 = mul nsw i32 %sub134, 283
  %add183 = add nsw i32 %sub181, %mul182
  %mul184 = mul nsw i32 %sub144, 1204
  %add185 = add nsw i32 %add183, %mul184
  %shr186.334 = lshr i32 %add185, 13
  %conv187 = trunc i32 %shr186.334 to i16
  store i16 %conv187, i16* %arrayidx127, align 2, !tbaa !1
  %mul189 = mul nsw i32 %sub114, 1204
  %27 = mul nsw i32 %sub124, -283
  %sub191 = add i32 %27, %mul189
  %28 = mul nsw i32 %sub134, -1420
  %sub193 = add i32 %sub191, %28
  %29 = mul nsw i32 %sub144, -805
  %sub195 = add i32 %sub193, %29
  %shr196.335 = lshr i32 %sub195, 13
  %conv197 = trunc i32 %shr196.335 to i16
  store i16 %conv197, i16* %arrayidx135, align 2, !tbaa !1
  %mul199 = mul nsw i32 %sub114, 1420
  %mul200 = mul nsw i32 %sub124, 1204
  %add201 = add nsw i32 %mul200, %mul199
  %mul202 = mul nsw i32 %sub134, 805
  %add203 = add nsw i32 %add201, %mul202
  %mul204 = mul nsw i32 %sub144, 283
  %add205 = add nsw i32 %add203, %mul204
  %shr206.336 = lshr i32 %add205, 13
  %conv207 = trunc i32 %shr206.336 to i16
  store i16 %conv207, i16* %arrayidx115, align 2, !tbaa !1
  %incdec.ptr = getelementptr inbounds i16, i16* %data.addr.1343, i32 1
  %dec210 = add nsw i16 %i.1344, -1
  %cmp102 = icmp eq i16 %dec210, 0
  br i1 %cmp102, label %for.end.211, label %for.body.104

for.end.211:                                      ; preds = %for.body.104
  ret void
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"short", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
