; ModuleID = '../softfloat.c'
target datalayout = "E-m:e-i64:64-n32:64-S128"
target triple = "sparc64-unknown-linux-gnu"

@float_rounding_mode = global i8 0, align 1
@float_exception_flags = global i8 0, align 1
@float_detect_tininess = global i8 0, align 1
@countLeadingZeros32.countLeadingZerosHigh = internal unnamed_addr constant [256 x i8] c"\08\07\06\06\05\05\05\05\04\04\04\04\04\04\04\04\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\03\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\02\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\01\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", align 1
@estimateSqrt32.sqrtOddAdjustments = internal unnamed_addr constant [16 x i16] [i16 4, i16 34, i16 93, i16 177, i16 285, i16 415, i16 566, i16 736, i16 924, i16 1128, i16 1349, i16 1585, i16 1835, i16 2098, i16 2374, i16 2663], align 2
@estimateSqrt32.sqrtEvenAdjustments = internal unnamed_addr constant [16 x i16] [i16 2605, i16 2223, i16 1882, i16 1577, i16 1306, i16 1065, i16 854, i16 670, i16 512, i16 377, i16 265, i16 175, i16 104, i16 52, i16 18, i16 2], align 2

; Function Attrs: inlinehint nounwind
define void @shift32RightJamming(i32 zeroext %a, i32 signext %count, i32* nocapture %zPtr) #0 {
entry:
  %cmp = icmp eq i32 %count, 0
  br i1 %cmp, label %if.end.7, label %if.else

if.else:                                          ; preds = %entry
  %cmp1 = icmp slt i32 %count, 32
  br i1 %cmp1, label %if.then.2, label %if.else.4

if.then.2:                                        ; preds = %if.else
  %shr = lshr i32 %a, %count
  %sub = sub nsw i32 0, %count
  %and = and i32 %sub, 31
  %shl = shl i32 %a, %and
  %cmp3 = icmp ne i32 %shl, 0
  %conv = zext i1 %cmp3 to i32
  %or = or i32 %conv, %shr
  br label %if.end.7

if.else.4:                                        ; preds = %if.else
  %cmp5 = icmp ne i32 %a, 0
  %conv6 = zext i1 %cmp5 to i32
  br label %if.end.7

if.end.7:                                         ; preds = %entry, %if.then.2, %if.else.4
  %z.0 = phi i32 [ %or, %if.then.2 ], [ %conv6, %if.else.4 ], [ %a, %entry ]
  store i32 %z.0, i32* %zPtr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @shift64Right(i32 zeroext %a0, i32 zeroext %a1, i32 signext %count, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr) #0 {
entry:
  %sub = sub nsw i32 0, %count
  %and = and i32 %sub, 31
  %cmp = icmp eq i32 %count, 0
  br i1 %cmp, label %if.end.12, label %if.else

if.else:                                          ; preds = %entry
  %cmp2 = icmp slt i32 %count, 32
  br i1 %cmp2, label %if.then.4, label %if.else.7

if.then.4:                                        ; preds = %if.else
  %shl = shl i32 %a0, %and
  %shr = lshr i32 %a1, %count
  %or = or i32 %shl, %shr
  %shr6 = lshr i32 %a0, %count
  br label %if.end.12

if.else.7:                                        ; preds = %if.else
  %cmp8 = icmp slt i32 %count, 64
  %and10 = and i32 %count, 31
  %shr11 = lshr i32 %a0, %and10
  %cond = select i1 %cmp8, i32 %shr11, i32 0
  br label %if.end.12

if.end.12:                                        ; preds = %if.else.7, %entry, %if.then.4
  %z1.0 = phi i32 [ %or, %if.then.4 ], [ %a1, %entry ], [ %cond, %if.else.7 ]
  %z0.0 = phi i32 [ %shr6, %if.then.4 ], [ %a0, %entry ], [ 0, %if.else.7 ]
  store i32 %z1.0, i32* %z1Ptr, align 4, !tbaa !1
  store i32 %z0.0, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @shift64RightJamming(i32 zeroext %a0, i32 zeroext %a1, i32 signext %count, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr) #0 {
entry:
  %sub = sub nsw i32 0, %count
  %and = and i32 %sub, 31
  %cmp = icmp eq i32 %count, 0
  br i1 %cmp, label %if.end.37, label %if.else

if.else:                                          ; preds = %entry
  %cmp2 = icmp slt i32 %count, 32
  br i1 %cmp2, label %if.then.4, label %if.else.12

if.then.4:                                        ; preds = %if.else
  %shl = shl i32 %a0, %and
  %shr = lshr i32 %a1, %count
  %or = or i32 %shl, %shr
  %shl7 = shl i32 %a1, %and
  %cmp8 = icmp ne i32 %shl7, 0
  %conv9 = zext i1 %cmp8 to i32
  %or10 = or i32 %or, %conv9
  %shr11 = lshr i32 %a0, %count
  br label %if.end.37

if.else.12:                                       ; preds = %if.else
  %cmp13 = icmp eq i32 %count, 32
  br i1 %cmp13, label %if.then.15, label %if.else.19

if.then.15:                                       ; preds = %if.else.12
  %cmp16 = icmp ne i32 %a1, 0
  %conv17 = zext i1 %cmp16 to i32
  %or18 = or i32 %conv17, %a0
  br label %if.end.37

if.else.19:                                       ; preds = %if.else.12
  %cmp20 = icmp slt i32 %count, 64
  br i1 %cmp20, label %if.then.22, label %if.else.31

if.then.22:                                       ; preds = %if.else.19
  %and23 = and i32 %count, 31
  %shr24 = lshr i32 %a0, %and23
  %shl26 = shl i32 %a0, %and
  %or27 = or i32 %shl26, %a1
  %cmp28 = icmp ne i32 %or27, 0
  %conv29 = zext i1 %cmp28 to i32
  %or30 = or i32 %conv29, %shr24
  br label %if.end.37

if.else.31:                                       ; preds = %if.else.19
  %or32 = or i32 %a1, %a0
  %cmp33 = icmp ne i32 %or32, 0
  %conv34 = zext i1 %cmp33 to i32
  br label %if.end.37

if.end.37:                                        ; preds = %if.then.15, %if.else.31, %if.then.22, %entry, %if.then.4
  %z1.1 = phi i32 [ %or10, %if.then.4 ], [ %a1, %entry ], [ %or18, %if.then.15 ], [ %or30, %if.then.22 ], [ %conv34, %if.else.31 ]
  %z0.0 = phi i32 [ %shr11, %if.then.4 ], [ %a0, %entry ], [ 0, %if.then.15 ], [ 0, %if.then.22 ], [ 0, %if.else.31 ]
  store i32 %z1.1, i32* %z1Ptr, align 4, !tbaa !1
  store i32 %z0.0, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @shift64ExtraRightJamming(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %a2, i32 signext %count, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr, i32* nocapture %z2Ptr) #0 {
entry:
  %sub = sub nsw i32 0, %count
  %and = and i32 %sub, 31
  %cmp = icmp eq i32 %count, 0
  br i1 %cmp, label %if.end.32, label %if.else

if.else:                                          ; preds = %entry
  %cmp2 = icmp slt i32 %count, 32
  br i1 %cmp2, label %if.then.4, label %if.else.9

if.then.4:                                        ; preds = %if.else
  %shl = shl i32 %a1, %and
  %shl7 = shl i32 %a0, %and
  %shr = lshr i32 %a1, %count
  %or = or i32 %shl7, %shr
  %shr8 = lshr i32 %a0, %count
  br label %if.end.28

if.else.9:                                        ; preds = %if.else
  %cmp10 = icmp eq i32 %count, 32
  br i1 %cmp10, label %if.end.28, label %if.else.13

if.else.13:                                       ; preds = %if.else.9
  %or14 = or i32 %a2, %a1
  %cmp15 = icmp slt i32 %count, 64
  br i1 %cmp15, label %if.then.17, label %if.else.22

if.then.17:                                       ; preds = %if.else.13
  %shl19 = shl i32 %a0, %and
  %and20 = and i32 %count, 31
  %shr21 = lshr i32 %a0, %and20
  br label %if.end.28

if.else.22:                                       ; preds = %if.else.13
  %cmp23 = icmp eq i32 %count, 64
  %cmp25 = icmp ne i32 %a0, 0
  %conv26 = zext i1 %cmp25 to i32
  %cond = select i1 %cmp23, i32 %a0, i32 %conv26
  br label %if.end.28

if.end.28:                                        ; preds = %if.else.22, %if.then.17, %if.else.9, %if.then.4
  %z0.0 = phi i32 [ %shr8, %if.then.4 ], [ 0, %if.else.9 ], [ 0, %if.then.17 ], [ 0, %if.else.22 ]
  %z1.1 = phi i32 [ %or, %if.then.4 ], [ %a0, %if.else.9 ], [ %shr21, %if.then.17 ], [ 0, %if.else.22 ]
  %z2.1 = phi i32 [ %shl, %if.then.4 ], [ %a1, %if.else.9 ], [ %shl19, %if.then.17 ], [ %cond, %if.else.22 ]
  %a2.addr.1 = phi i32 [ %a2, %if.then.4 ], [ %a2, %if.else.9 ], [ %or14, %if.then.17 ], [ %or14, %if.else.22 ]
  %cmp29 = icmp ne i32 %a2.addr.1, 0
  %conv30 = zext i1 %cmp29 to i32
  %or31 = or i32 %conv30, %z2.1
  br label %if.end.32

if.end.32:                                        ; preds = %entry, %if.end.28
  %z0.1 = phi i32 [ %z0.0, %if.end.28 ], [ %a0, %entry ]
  %z1.2 = phi i32 [ %z1.1, %if.end.28 ], [ %a1, %entry ]
  %z2.2 = phi i32 [ %or31, %if.end.28 ], [ %a2, %entry ]
  store i32 %z2.2, i32* %z2Ptr, align 4, !tbaa !1
  store i32 %z1.2, i32* %z1Ptr, align 4, !tbaa !1
  store i32 %z0.1, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @shortShift64Left(i32 zeroext %a0, i32 zeroext %a1, i32 signext %count, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr) #0 {
entry:
  %shl = shl i32 %a1, %count
  store i32 %shl, i32* %z1Ptr, align 4, !tbaa !1
  %cmp = icmp eq i32 %count, 0
  br i1 %cmp, label %cond.end, label %cond.false

cond.false:                                       ; preds = %entry
  %shl1 = shl i32 %a0, %count
  %sub = sub nsw i32 0, %count
  %and = and i32 %sub, 31
  %shr = lshr i32 %a1, %and
  %or = or i32 %shr, %shl1
  br label %cond.end

cond.end:                                         ; preds = %entry, %cond.false
  %cond = phi i32 [ %or, %cond.false ], [ %a0, %entry ]
  store i32 %cond, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @shortShift96Left(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %a2, i32 signext %count, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr, i32* nocapture %z2Ptr) #0 {
entry:
  %shl = shl i32 %a2, %count
  %shl1 = shl i32 %a1, %count
  %shl2 = shl i32 %a0, %count
  %cmp = icmp sgt i32 %count, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %sub = sub nsw i32 0, %count
  %and = and i32 %sub, 31
  %shr = lshr i32 %a2, %and
  %or = or i32 %shr, %shl1
  %shr5 = lshr i32 %a1, %and
  %or6 = or i32 %shr5, %shl2
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %z1.0 = phi i32 [ %or, %if.then ], [ %shl1, %entry ]
  %z0.0 = phi i32 [ %or6, %if.then ], [ %shl2, %entry ]
  store i32 %shl, i32* %z2Ptr, align 4, !tbaa !1
  store i32 %z1.0, i32* %z1Ptr, align 4, !tbaa !1
  store i32 %z0.0, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @add64(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %b0, i32 zeroext %b1, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr) #0 {
entry:
  %add = add i32 %b1, %a1
  store i32 %add, i32* %z1Ptr, align 4, !tbaa !1
  %add1 = add i32 %b0, %a0
  %cmp = icmp ult i32 %add, %a1
  %conv = zext i1 %cmp to i32
  %add2 = add i32 %add1, %conv
  store i32 %add2, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @add96(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %a2, i32 zeroext %b0, i32 zeroext %b1, i32 zeroext %b2, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr, i32* nocapture %z2Ptr) #0 {
entry:
  %add = add i32 %b2, %a2
  %cmp = icmp ult i32 %add, %a2
  %add2 = add i32 %b1, %a1
  %cmp3 = icmp ult i32 %add2, %a1
  %add6 = add i32 %b0, %a0
  %conv7 = zext i1 %cmp to i32
  %add8 = add i32 %conv7, %add2
  %cmp10 = icmp ult i32 %add8, %conv7
  %conv11 = zext i1 %cmp10 to i32
  %conv13 = zext i1 %cmp3 to i32
  %add12 = add i32 %add6, %conv13
  %add14 = add i32 %add12, %conv11
  store i32 %add, i32* %z2Ptr, align 4, !tbaa !1
  store i32 %add8, i32* %z1Ptr, align 4, !tbaa !1
  store i32 %add14, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @sub64(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %b0, i32 zeroext %b1, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr) #0 {
entry:
  %sub = sub i32 %a1, %b1
  store i32 %sub, i32* %z1Ptr, align 4, !tbaa !1
  %sub1 = sub i32 %a0, %b0
  %cmp = icmp ult i32 %a1, %b1
  %conv.neg = sext i1 %cmp to i32
  %sub2 = add i32 %sub1, %conv.neg
  store i32 %sub2, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @sub96(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %a2, i32 zeroext %b0, i32 zeroext %b1, i32 zeroext %b2, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr, i32* nocapture %z2Ptr) #0 {
entry:
  %sub = sub i32 %a2, %b2
  %cmp = icmp ult i32 %a2, %b2
  %sub2 = sub i32 %a1, %b1
  %cmp3 = icmp ult i32 %a1, %b1
  %sub6 = sub i32 %a0, %b0
  %conv7 = zext i1 %cmp to i32
  %cmp8 = icmp ult i32 %sub2, %conv7
  %conv9.neg = sext i1 %cmp8 to i32
  %sub12 = sub i32 %sub2, %conv7
  %conv13.neg = sext i1 %cmp3 to i32
  %sub10 = add i32 %sub6, %conv13.neg
  %sub14 = add i32 %sub10, %conv9.neg
  store i32 %sub, i32* %z2Ptr, align 4, !tbaa !1
  store i32 %sub12, i32* %z1Ptr, align 4, !tbaa !1
  store i32 %sub14, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @mul32To64(i32 zeroext %a, i32 zeroext %b, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr) #0 {
entry:
  %shr = lshr i32 %a, 16
  %shr3 = lshr i32 %b, 16
  %conv5 = and i32 %a, 65535
  %conv6 = and i32 %b, 65535
  %mul = mul nuw i32 %conv6, %conv5
  %mul9 = mul nuw i32 %shr3, %conv5
  %mul12 = mul nuw i32 %conv6, %shr
  %mul15 = mul nuw i32 %shr3, %shr
  %add = add i32 %mul9, %mul12
  %cmp = icmp ult i32 %add, %mul12
  %conv16 = zext i1 %cmp to i32
  %shl = shl nuw nsw i32 %conv16, 16
  %shr17 = lshr i32 %add, 16
  %add18 = or i32 %shl, %shr17
  %add19 = add i32 %add18, %mul15
  %shl20 = shl i32 %add, 16
  %add21 = add i32 %shl20, %mul
  %cmp22 = icmp ult i32 %add21, %shl20
  %conv23 = zext i1 %cmp22 to i32
  %add24 = add i32 %add19, %conv23
  store i32 %add21, i32* %z1Ptr, align 4, !tbaa !1
  store i32 %add24, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @mul64By32To96(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %b, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr, i32* nocapture %z2Ptr) #0 {
entry:
  %shr.i = lshr i32 %a1, 16
  %shr3.i = lshr i32 %b, 16
  %conv5.i = and i32 %a1, 65535
  %conv6.i = and i32 %b, 65535
  %mul.i = mul nuw i32 %conv6.i, %conv5.i
  %mul9.i = mul nuw i32 %shr3.i, %conv5.i
  %mul12.i = mul nuw i32 %conv6.i, %shr.i
  %mul15.i = mul nuw i32 %shr3.i, %shr.i
  %add.i = add i32 %mul9.i, %mul12.i
  %cmp.i = icmp ult i32 %add.i, %mul12.i
  %conv16.i = zext i1 %cmp.i to i32
  %shl.i = shl nuw nsw i32 %conv16.i, 16
  %shr17.i = lshr i32 %add.i, 16
  %add18.i = or i32 %shl.i, %shr17.i
  %shl20.i = shl i32 %add.i, 16
  %add21.i = add i32 %shl20.i, %mul.i
  %cmp22.i = icmp ult i32 %add21.i, %shl20.i
  %conv23.i = zext i1 %cmp22.i to i32
  %shr.i.4 = lshr i32 %a0, 16
  %conv5.i.6 = and i32 %a0, 65535
  %mul.i.8 = mul nuw i32 %conv6.i, %conv5.i.6
  %mul9.i.9 = mul nuw i32 %shr3.i, %conv5.i.6
  %mul12.i.10 = mul nuw i32 %conv6.i, %shr.i.4
  %mul15.i.11 = mul nuw i32 %shr3.i, %shr.i.4
  %add.i.12 = add i32 %mul9.i.9, %mul12.i.10
  %cmp.i.13 = icmp ult i32 %add.i.12, %mul12.i.10
  %conv16.i.14 = zext i1 %cmp.i.13 to i32
  %shl.i.15 = shl nuw nsw i32 %conv16.i.14, 16
  %shr17.i.16 = lshr i32 %add.i.12, 16
  %add18.i.17 = or i32 %shl.i.15, %shr17.i.16
  %add19.i.18 = add i32 %add18.i.17, %mul15.i.11
  %shl20.i.19 = shl i32 %add.i.12, 16
  %add21.i.20 = add i32 %shl20.i.19, %mul.i.8
  %cmp22.i.21 = icmp ult i32 %add21.i.20, %shl20.i.19
  %conv23.i.22 = zext i1 %cmp22.i.21 to i32
  %add24.i.23 = add i32 %add19.i.18, %conv23.i.22
  %add19.i = add i32 %add21.i.20, %mul15.i
  %add24.i = add i32 %add19.i, %add18.i
  %add.i.2 = add i32 %add24.i, %conv23.i
  %cmp.i.3 = icmp ult i32 %add.i.2, %add21.i.20
  %conv.i = zext i1 %cmp.i.3 to i32
  %add2.i = add i32 %add24.i.23, %conv.i
  store i32 %add21.i, i32* %z2Ptr, align 4, !tbaa !1
  store i32 %add.i.2, i32* %z1Ptr, align 4, !tbaa !1
  store i32 %add2.i, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind
define void @mul64To128(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %b0, i32 zeroext %b1, i32* nocapture %z0Ptr, i32* nocapture %z1Ptr, i32* nocapture %z2Ptr, i32* nocapture %z3Ptr) #0 {
entry:
  %shr.i = lshr i32 %a1, 16
  %shr3.i = lshr i32 %b1, 16
  %conv5.i = and i32 %a1, 65535
  %conv6.i = and i32 %b1, 65535
  %mul.i = mul nuw i32 %conv6.i, %conv5.i
  %mul9.i = mul nuw i32 %shr3.i, %conv5.i
  %mul12.i = mul nuw i32 %conv6.i, %shr.i
  %mul15.i = mul nuw i32 %shr3.i, %shr.i
  %add.i = add i32 %mul9.i, %mul12.i
  %cmp.i = icmp ult i32 %add.i, %mul12.i
  %conv16.i = zext i1 %cmp.i to i32
  %shl.i = shl nuw nsw i32 %conv16.i, 16
  %shr17.i = lshr i32 %add.i, 16
  %add18.i = or i32 %shl.i, %shr17.i
  %shl20.i = shl i32 %add.i, 16
  %add21.i = add i32 %shl20.i, %mul.i
  %cmp22.i = icmp ult i32 %add21.i, %shl20.i
  %conv23.i = zext i1 %cmp22.i to i32
  %shr3.i.60 = lshr i32 %b0, 16
  %conv6.i.62 = and i32 %b0, 65535
  %mul.i.63 = mul nuw i32 %conv6.i.62, %conv5.i
  %mul9.i.64 = mul nuw i32 %shr3.i.60, %conv5.i
  %mul12.i.65 = mul nuw i32 %conv6.i.62, %shr.i
  %mul15.i.66 = mul nuw i32 %shr3.i.60, %shr.i
  %add.i.67 = add i32 %mul9.i.64, %mul12.i.65
  %cmp.i.68 = icmp ult i32 %add.i.67, %mul12.i.65
  %conv16.i.69 = zext i1 %cmp.i.68 to i32
  %shl.i.70 = shl nuw nsw i32 %conv16.i.69, 16
  %shr17.i.71 = lshr i32 %add.i.67, 16
  %add18.i.72 = or i32 %shl.i.70, %shr17.i.71
  %shl20.i.74 = shl i32 %add.i.67, 16
  %add21.i.75 = add i32 %shl20.i.74, %mul.i.63
  %cmp22.i.76 = icmp ult i32 %add21.i.75, %shl20.i.74
  %conv23.i.77 = zext i1 %cmp22.i.76 to i32
  %add19.i = add i32 %add21.i.75, %mul15.i
  %add24.i = add i32 %add19.i, %add18.i
  %add.i.55 = add i32 %add24.i, %conv23.i
  %cmp.i.56 = icmp ult i32 %add.i.55, %add21.i.75
  %conv.i.57 = zext i1 %cmp.i.56 to i32
  %shr.i.35 = lshr i32 %a0, 16
  %conv5.i.37 = and i32 %a0, 65535
  %mul.i.39 = mul nuw i32 %conv6.i.62, %conv5.i.37
  %mul9.i.40 = mul nuw i32 %shr3.i.60, %conv5.i.37
  %mul12.i.41 = mul nuw i32 %conv6.i.62, %shr.i.35
  %mul15.i.42 = mul nuw i32 %shr3.i.60, %shr.i.35
  %add.i.43 = add i32 %mul9.i.40, %mul12.i.41
  %cmp.i.44 = icmp ult i32 %add.i.43, %mul12.i.41
  %conv16.i.45 = zext i1 %cmp.i.44 to i32
  %shl.i.46 = shl nuw nsw i32 %conv16.i.45, 16
  %shr17.i.47 = lshr i32 %add.i.43, 16
  %add18.i.48 = or i32 %shl.i.46, %shr17.i.47
  %add19.i.49 = add i32 %add18.i.48, %mul15.i.42
  %shl20.i.50 = shl i32 %add.i.43, 16
  %add21.i.51 = add i32 %shl20.i.50, %mul.i.39
  %cmp22.i.52 = icmp ult i32 %add21.i.51, %shl20.i.50
  %conv23.i.53 = zext i1 %cmp22.i.52 to i32
  %add24.i.54 = add i32 %add19.i.49, %conv23.i.53
  %add19.i.73 = add i32 %add21.i.51, %mul15.i.66
  %add24.i.78 = add i32 %add19.i.73, %add18.i.72
  %add2.i.58 = add i32 %add24.i.78, %conv23.i.77
  %add.i.31 = add i32 %add2.i.58, %conv.i.57
  %cmp.i.32 = icmp ult i32 %add.i.31, %add21.i.51
  %conv.i.33 = zext i1 %cmp.i.32 to i32
  %add2.i.34 = add i32 %add24.i.54, %conv.i.33
  %mul.i.15 = mul nuw i32 %conv6.i, %conv5.i.37
  %mul9.i.16 = mul nuw i32 %shr3.i, %conv5.i.37
  %mul12.i.17 = mul nuw i32 %conv6.i, %shr.i.35
  %mul15.i.18 = mul nuw i32 %shr3.i, %shr.i.35
  %add.i.19 = add i32 %mul9.i.16, %mul12.i.17
  %cmp.i.20 = icmp ult i32 %add.i.19, %mul12.i.17
  %conv16.i.21 = zext i1 %cmp.i.20 to i32
  %shl.i.22 = shl nuw nsw i32 %conv16.i.21, 16
  %shr17.i.23 = lshr i32 %add.i.19, 16
  %add18.i.24 = or i32 %shl.i.22, %shr17.i.23
  %add19.i.25 = add i32 %add18.i.24, %mul15.i.18
  %shl20.i.26 = shl i32 %add.i.19, 16
  %add21.i.27 = add i32 %shl20.i.26, %mul.i.15
  %cmp22.i.28 = icmp ult i32 %add21.i.27, %shl20.i.26
  %conv23.i.29 = zext i1 %cmp22.i.28 to i32
  %add24.i.30 = add i32 %add19.i.25, %conv23.i.29
  %add.i.7 = add i32 %add.i.55, %add21.i.27
  %cmp.i.8 = icmp ult i32 %add.i.7, %add21.i.27
  %conv.i.9 = zext i1 %cmp.i.8 to i32
  %add2.i.10 = add i32 %add24.i.30, %conv.i.9
  %add.i.5 = add i32 %add2.i.10, %add.i.31
  %cmp.i.6 = icmp ult i32 %add.i.5, %add.i.31
  %conv.i = zext i1 %cmp.i.6 to i32
  %add2.i = add i32 %add2.i.34, %conv.i
  store i32 %add21.i, i32* %z3Ptr, align 4, !tbaa !1
  store i32 %add.i.7, i32* %z2Ptr, align 4, !tbaa !1
  store i32 %add.i.5, i32* %z1Ptr, align 4, !tbaa !1
  store i32 %add2.i, i32* %z0Ptr, align 4, !tbaa !1
  ret void
}

; Function Attrs: inlinehint nounwind readnone
define signext i8 @eq64(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %b0, i32 zeroext %b1) #1 {
entry:
  %cmp = icmp eq i32 %a0, %b0
  %cmp1 = icmp eq i32 %a1, %b1
  %phitmp = zext i1 %cmp1 to i8
  %0 = select i1 %cmp, i8 %phitmp, i8 0
  ret i8 %0
}

; Function Attrs: inlinehint nounwind readnone
define signext i8 @le64(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %b0, i32 zeroext %b1) #1 {
entry:
  %cmp = icmp ult i32 %a0, %b0
  br i1 %cmp, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %entry
  %cmp1 = icmp eq i32 %a0, %b0
  br i1 %cmp1, label %land.rhs, label %lor.end

land.rhs:                                         ; preds = %lor.rhs
  %cmp2 = icmp ule i32 %a1, %b1
  %phitmp = zext i1 %cmp2 to i8
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %land.rhs, %entry
  %0 = phi i8 [ 1, %entry ], [ 0, %lor.rhs ], [ %phitmp, %land.rhs ]
  ret i8 %0
}

; Function Attrs: inlinehint nounwind readnone
define signext i8 @lt64(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %b0, i32 zeroext %b1) #1 {
entry:
  %cmp = icmp ult i32 %a0, %b0
  br i1 %cmp, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %entry
  %cmp1 = icmp eq i32 %a0, %b0
  br i1 %cmp1, label %land.rhs, label %lor.end

land.rhs:                                         ; preds = %lor.rhs
  %cmp2 = icmp ult i32 %a1, %b1
  %phitmp = zext i1 %cmp2 to i8
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %land.rhs, %entry
  %0 = phi i8 [ 1, %entry ], [ 0, %lor.rhs ], [ %phitmp, %land.rhs ]
  ret i8 %0
}

; Function Attrs: inlinehint nounwind readnone
define signext i8 @ne64(i32 zeroext %a0, i32 zeroext %a1, i32 zeroext %b0, i32 zeroext %b1) #1 {
entry:
  %cmp = icmp eq i32 %a0, %b0
  %cmp1 = icmp ne i32 %a1, %b1
  %phitmp = zext i1 %cmp1 to i8
  %0 = select i1 %cmp, i8 %phitmp, i8 1
  ret i8 %0
}

; Function Attrs: nounwind
define void @float_raise(i8 signext %flags) #2 {
entry:
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3 = or i8 %0, %flags
  store i8 %or3, i8* @float_exception_flags, align 1, !tbaa !5
  ret void
}

; Function Attrs: nounwind readnone
define signext i8 @float32_is_nan(i32 zeroext %a) #3 {
entry:
  %0 = trunc i32 %a to i31
  %cmp = icmp ugt i31 %0, -8388608
  %conv1 = zext i1 %cmp to i8
  ret i8 %conv1
}

; Function Attrs: nounwind readnone
define signext i8 @float32_is_signaling_nan(i32 zeroext %a) #3 {
entry:
  %and = and i32 %a, 2143289344
  %cmp = icmp eq i32 %and, 2139095040
  %and1 = and i32 %a, 4194303
  %tobool = icmp ne i32 %and1, 0
  %phitmp = zext i1 %tobool to i8
  %0 = select i1 %cmp, i8 %phitmp, i8 0
  ret i8 %0
}

; Function Attrs: nounwind readnone
define signext i8 @float64_is_nan(i64 %a.coerce) #3 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %shl4 = shl nuw nsw i64 %a.sroa.0.0.extract.shift, 1
  %shl = trunc i64 %shl4 to i32
  %cmp = icmp ugt i32 %shl, -2097153
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %entry
  %a.sroa.3.0.extract.trunc = trunc i64 %a.coerce to i32
  %tobool = icmp eq i32 %a.sroa.3.0.extract.trunc, 0
  br i1 %tobool, label %lor.rhs, label %land.end

lor.rhs:                                          ; preds = %land.rhs
  %and = and i64 %a.sroa.0.0.extract.shift, 1048575
  %tobool2 = icmp ne i64 %and, 0
  %phitmp = zext i1 %tobool2 to i8
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.rhs, %entry
  %0 = phi i8 [ 0, %entry ], [ 1, %land.rhs ], [ %phitmp, %lor.rhs ]
  ret i8 %0
}

; Function Attrs: nounwind readnone
define signext i8 @float64_is_signaling_nan(i64 %a.coerce) #3 {
entry:
  %and = and i64 %a.coerce, 9221120237041090560
  %cmp = icmp eq i64 %and, 9218868437227405312
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %entry
  %a.sroa.3.0.extract.trunc = trunc i64 %a.coerce to i32
  %tobool = icmp eq i32 %a.sroa.3.0.extract.trunc, 0
  br i1 %tobool, label %lor.rhs, label %land.end

lor.rhs:                                          ; preds = %land.rhs
  %and2 = and i64 %a.coerce, 2251795518717952
  %tobool3 = icmp ne i64 %and2, 0
  %phitmp = zext i1 %tobool3 to i8
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.rhs, %entry
  %0 = phi i8 [ 0, %entry ], [ 1, %land.rhs ], [ %phitmp, %lor.rhs ]
  ret i8 %0
}

; Function Attrs: inlinehint nounwind readnone
define zeroext i32 @extractFloat32Frac(i32 zeroext %a) #1 {
entry:
  %and = and i32 %a, 8388607
  ret i32 %and
}

; Function Attrs: inlinehint nounwind readnone
define signext i32 @extractFloat32Exp(i32 zeroext %a) #1 {
entry:
  %shr = lshr i32 %a, 23
  %and = and i32 %shr, 255
  ret i32 %and
}

; Function Attrs: inlinehint nounwind readnone
define signext i8 @extractFloat32Sign(i32 zeroext %a) #1 {
entry:
  %shr = lshr i32 %a, 31
  %conv = trunc i32 %shr to i8
  ret i8 %conv
}

; Function Attrs: inlinehint nounwind readnone
define zeroext i32 @packFloat32(i8 signext %zSign, i32 signext %zExp, i32 zeroext %zSig) #1 {
entry:
  %conv.3 = zext i8 %zSign to i32
  %shl = shl i32 %conv.3, 31
  %shl1 = shl i32 %zExp, 23
  %add = add i32 %shl, %shl1
  %add2 = add i32 %add, %zSig
  ret i32 %add2
}

; Function Attrs: inlinehint nounwind readnone
define zeroext i32 @extractFloat64Frac1(i64 %a.coerce) #1 {
entry:
  %a.sroa.1.0.extract.trunc = trunc i64 %a.coerce to i32
  ret i32 %a.sroa.1.0.extract.trunc
}

; Function Attrs: inlinehint nounwind readnone
define zeroext i32 @extractFloat64Frac0(i64 %a.coerce) #1 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %and = and i32 %a.sroa.0.0.extract.trunc, 1048575
  ret i32 %and
}

; Function Attrs: inlinehint nounwind readnone
define signext i32 @extractFloat64Exp(i64 %a.coerce) #1 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 52
  %shr = trunc i64 %a.sroa.0.0.extract.shift to i32
  %and = and i32 %shr, 2047
  ret i32 %and
}

; Function Attrs: inlinehint nounwind readnone
define signext i8 @extractFloat64Sign(i64 %a.coerce) #1 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 63
  %conv = trunc i64 %a.sroa.0.0.extract.shift to i8
  ret i8 %conv
}

; Function Attrs: inlinehint nounwind readnone
define i64 @packFloat64(i8 signext %zSign, i32 signext %zExp, i32 zeroext %zSig0, i32 zeroext %zSig1) #1 {
entry:
  %conv.6 = zext i8 %zSign to i32
  %shl = shl i32 %conv.6, 31
  %shl1 = shl i32 %zExp, 20
  %add = add i32 %shl, %shl1
  %add2 = add i32 %add, %zSig0
  %retval.sroa.2.0.insert.ext = zext i32 %zSig1 to i64
  %retval.sroa.0.0.insert.ext = zext i32 %add2 to i64
  %retval.sroa.0.0.insert.shift = shl nuw i64 %retval.sroa.0.0.insert.ext, 32
  %retval.sroa.0.0.insert.insert = or i64 %retval.sroa.0.0.insert.shift, %retval.sroa.2.0.insert.ext
  ret i64 %retval.sroa.0.0.insert.insert
}

; Function Attrs: nounwind
define zeroext i32 @int32_to_float32(i32 signext %a) #2 {
entry:
  switch i32 %a, label %if.end.3 [
    i32 0, label %cleanup
    i32 -2147483648, label %if.then.2
  ]

if.then.2:                                        ; preds = %entry
  br label %cleanup

if.end.3:                                         ; preds = %entry
  %a.lobit = lshr i32 %a, 31
  %0 = trunc i32 %a.lobit to i8
  %tobool = icmp ne i32 %a.lobit, 0
  %sub = sub nsw i32 0, %a
  %cond = select i1 %tobool, i32 %sub, i32 %a
  %cmp.i.i = icmp ult i32 %cond, 65536
  %shl.i.i = shl i32 %cond, 16
  %shl.a.i.i = select i1 %cmp.i.i, i32 %shl.i.i, i32 %cond
  %..i.i = select i1 %cmp.i.i, i8 16, i8 0
  %cmp2.i.i = icmp ult i32 %shl.a.i.i, 16777216
  br i1 %cmp2.i.i, label %if.then.4.i.i, label %normalizeRoundAndPackFloat32.exit

if.then.4.i.i:                                    ; preds = %if.end.3
  %conv5.23.i.i = zext i8 %..i.i to i32
  %add6.i.i = or i32 %conv5.23.i.i, 8
  %conv7.i.i = trunc i32 %add6.i.i to i8
  %shl8.i.i = shl i32 %shl.a.i.i, 8
  br label %normalizeRoundAndPackFloat32.exit

normalizeRoundAndPackFloat32.exit:                ; preds = %if.end.3, %if.then.4.i.i
  %a.addr.1.i.i = phi i32 [ %shl8.i.i, %if.then.4.i.i ], [ %shl.a.i.i, %if.end.3 ]
  %shiftCount.1.i.i = phi i8 [ %conv7.i.i, %if.then.4.i.i ], [ %..i.i, %if.end.3 ]
  %shr.i.i = lshr i32 %a.addr.1.i.i, 24
  %idxprom.i.i = zext i32 %shr.i.i to i64
  %arrayidx.i.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i
  %1 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !5
  %conv10.22.i.i = zext i8 %1 to i32
  %conv11.21.i.i = zext i8 %shiftCount.1.i.i to i32
  %add12.i.i = add nuw nsw i32 %conv10.22.i.i, %conv11.21.i.i
  %conv.8.i = shl i32 %add12.i.i, 24
  %sext.i = add i32 %conv.8.i, -16777216
  %conv2.i = ashr exact i32 %sext.i, 24
  %sub3.i = sub nsw i32 156, %conv2.i
  %shl.i = shl i32 %cond, %conv2.i
  %call5.i = tail call fastcc zeroext i32 @roundAndPackFloat32(i8 signext %0, i32 signext %sub3.i, i32 zeroext %shl.i) #4
  br label %cleanup

cleanup:                                          ; preds = %entry, %normalizeRoundAndPackFloat32.exit, %if.then.2
  %retval.0 = phi i32 [ -822083584, %if.then.2 ], [ %call5.i, %normalizeRoundAndPackFloat32.exit ], [ 0, %entry ]
  ret i32 %retval.0
}

; Function Attrs: nounwind readnone
define i64 @int32_to_float64(i32 signext %a) #3 {
entry:
  %cmp = icmp eq i32 %a, 0
  br i1 %cmp, label %cleanup, label %if.end

if.end:                                           ; preds = %entry
  %a.lobit = lshr i32 %a, 31
  %tobool = icmp ne i32 %a.lobit, 0
  %sub = sub nsw i32 0, %a
  %cond = select i1 %tobool, i32 %sub, i32 %a
  %cmp.i.33 = icmp ult i32 %cond, 65536
  %shl.i.34 = shl i32 %cond, 16
  %shl.a.i = select i1 %cmp.i.33, i32 %shl.i.34, i32 %cond
  %..i = select i1 %cmp.i.33, i8 16, i8 0
  %cmp2.i.35 = icmp ult i32 %shl.a.i, 16777216
  br i1 %cmp2.i.35, label %if.then.4.i.36, label %countLeadingZeros32.exit

if.then.4.i.36:                                   ; preds = %if.end
  %conv5.23.i = zext i8 %..i to i32
  %add6.i = or i32 %conv5.23.i, 8
  %conv7.i = trunc i32 %add6.i to i8
  %shl8.i = shl i32 %shl.a.i, 8
  br label %countLeadingZeros32.exit

countLeadingZeros32.exit:                         ; preds = %if.end, %if.then.4.i.36
  %a.addr.1.i = phi i32 [ %shl8.i, %if.then.4.i.36 ], [ %shl.a.i, %if.end ]
  %shiftCount.1.i = phi i8 [ %conv7.i, %if.then.4.i.36 ], [ %..i, %if.end ]
  %shr.i = lshr i32 %a.addr.1.i, 24
  %idxprom.i = zext i32 %shr.i to i64
  %arrayidx.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i
  %0 = load i8, i8* %arrayidx.i, align 1, !tbaa !5
  %conv10.22.i = zext i8 %0 to i32
  %conv11.21.i = zext i8 %shiftCount.1.i to i32
  %add12.i = add nuw nsw i32 %conv10.22.i, %conv11.21.i
  %conv5.31 = shl i32 %add12.i, 24
  %sext = add i32 %conv5.31, -184549376
  %conv8 = ashr exact i32 %sext, 24
  %cmp9 = icmp sgt i32 %sext, -16777216
  br i1 %cmp9, label %if.then.11, label %if.else

if.then.11:                                       ; preds = %countLeadingZeros32.exit
  %shl = shl i32 %cond, %conv8
  br label %if.end.15

if.else:                                          ; preds = %countLeadingZeros32.exit
  %sub14 = sub nsw i32 0, %conv8
  %and.i = and i32 %conv8, 31
  %cmp.i = icmp eq i32 %conv8, 0
  br i1 %cmp.i, label %if.end.15, label %if.else.i

if.else.i:                                        ; preds = %if.else
  %cmp2.i = icmp sgt i32 %sext, -536870912
  br i1 %cmp2.i, label %if.then.4.i, label %if.else.7.i

if.then.4.i:                                      ; preds = %if.else.i
  %shl.i.32 = shl i32 %cond, %and.i
  %shr6.i = lshr i32 %cond, %sub14
  br label %if.end.15

if.else.7.i:                                      ; preds = %if.else.i
  %cmp8.i = icmp sgt i32 %sext, -1073741824
  %and10.i = and i32 %sub14, 31
  %shr11.i = lshr i32 %cond, %and10.i
  %cond.i = select i1 %cmp8.i, i32 %shr11.i, i32 0
  br label %if.end.15

if.end.15:                                        ; preds = %if.else.7.i, %if.then.4.i, %if.else, %if.then.11
  %zSig0.0 = phi i32 [ %shl, %if.then.11 ], [ %shr6.i, %if.then.4.i ], [ %cond, %if.else ], [ 0, %if.else.7.i ]
  %zSig1.0 = phi i32 [ 0, %if.then.11 ], [ %shl.i.32, %if.then.4.i ], [ 0, %if.else ], [ %cond.i, %if.else.7.i ]
  %sub17 = sub nsw i32 1042, %conv8
  %shl.i = shl nuw i32 %a.lobit, 31
  %shl1.i = shl i32 %sub17, 20
  %add.i = add i32 %shl1.i, %shl.i
  %add2.i = add i32 %add.i, %zSig0.0
  %retval.sroa.2.0.insert.ext.i = zext i32 %zSig1.0 to i64
  %retval.sroa.0.0.insert.ext.i = zext i32 %add2.i to i64
  %retval.sroa.0.0.insert.shift.i = shl nuw i64 %retval.sroa.0.0.insert.ext.i, 32
  %retval.sroa.0.0.insert.insert.i = or i64 %retval.sroa.0.0.insert.shift.i, %retval.sroa.2.0.insert.ext.i
  br label %cleanup

cleanup:                                          ; preds = %entry, %if.end.15
  %retval.sroa.0.0 = phi i64 [ %retval.sroa.0.0.insert.insert.i, %if.end.15 ], [ 0, %entry ]
  ret i64 %retval.sroa.0.0
}

; Function Attrs: nounwind
define signext i32 @float32_to_int32(i32 zeroext %a) #2 {
entry:
  %and.i = and i32 %a, 8388607
  %shr.i.109 = lshr i32 %a, 23
  %and.i.110 = and i32 %shr.i.109, 255
  %shr.i = lshr i32 %a, 31
  %conv.i = trunc i32 %shr.i to i8
  %sub = add nsw i32 %and.i.110, -150
  %cmp = icmp sgt i32 %sub, -1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %cmp3 = icmp ugt i32 %and.i.110, 157
  br i1 %cmp3, label %if.then.4, label %if.end.11

if.then.4:                                        ; preds = %if.then
  %cmp5 = icmp eq i32 %a, -822083584
  br i1 %cmp5, label %if.end.10, label %if.then.6

if.then.6:                                        ; preds = %if.then.4
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  %tobool = icmp eq i8 %conv.i, 0
  br i1 %tobool, label %cleanup, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.then.6
  %cmp7 = icmp eq i32 %and.i.110, 255
  %tobool8 = icmp ne i32 %and.i, 0
  %or.cond = and i1 %tobool8, %cmp7
  br i1 %or.cond, label %cleanup, label %if.end.10

if.end.10:                                        ; preds = %if.then.4, %lor.lhs.false
  br label %cleanup

if.end.11:                                        ; preds = %if.then
  %or = or i32 %and.i, 8388608
  %shl = shl i32 %or, %sub
  %tobool12 = icmp eq i8 %conv.i, 0
  %sub14 = sub nsw i32 0, %shl
  %shl.sub14 = select i1 %tobool12, i32 %shl, i32 %sub14
  br label %cleanup

if.else:                                          ; preds = %entry
  %cmp16 = icmp ult i32 %and.i.110, 126
  br i1 %cmp16, label %if.then.17, label %if.else.19

if.then.17:                                       ; preds = %if.else
  %or18 = or i32 %and.i.110, %and.i
  br label %if.end.23

if.else.19:                                       ; preds = %if.else
  %or20 = or i32 %and.i, 8388608
  %fold = add nuw nsw i32 %shr.i.109, 10
  %and = and i32 %fold, 31
  %shl21 = shl i32 %or20, %and
  %sub22 = sub nsw i32 150, %and.i.110
  %shr = lshr i32 %or20, %sub22
  br label %if.end.23

if.end.23:                                        ; preds = %if.else.19, %if.then.17
  %aSigExtra.0 = phi i32 [ %or18, %if.then.17 ], [ %shl21, %if.else.19 ]
  %z.0 = phi i32 [ 0, %if.then.17 ], [ %shr, %if.else.19 ]
  %tobool24 = icmp ne i32 %aSigExtra.0, 0
  br i1 %tobool24, label %if.then.25, label %if.end.28

if.then.25:                                       ; preds = %if.end.23
  %1 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv.108 = zext i8 %1 to i32
  %or26 = or i32 %conv.108, 32
  %conv27 = trunc i32 %or26 to i8
  store i8 %conv27, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.28

if.end.28:                                        ; preds = %if.then.25, %if.end.23
  %2 = load i8, i8* @float_rounding_mode, align 1, !tbaa !5
  %cmp30 = icmp eq i8 %2, 0
  br i1 %cmp30, label %if.then.32, label %if.else.47

if.then.32:                                       ; preds = %if.end.28
  %cmp33 = icmp slt i32 %aSigExtra.0, 0
  br i1 %cmp33, label %if.then.35, label %if.end.42

if.then.35:                                       ; preds = %if.then.32
  %inc = add nsw i32 %z.0, 1
  %shl36.mask = and i32 %aSigExtra.0, 2147483647
  %cmp37 = icmp eq i32 %shl36.mask, 0
  %and40 = and i32 %inc, -2
  %and40.inc = select i1 %cmp37, i32 %and40, i32 %inc
  br label %if.end.42

if.end.42:                                        ; preds = %if.then.35, %if.then.32
  %z.1 = phi i32 [ %z.0, %if.then.32 ], [ %and40.inc, %if.then.35 ]
  %tobool43 = icmp eq i8 %conv.i, 0
  %sub45 = sub nsw i32 0, %z.1
  %z.1.sub45 = select i1 %tobool43, i32 %z.1, i32 %sub45
  ret i32 %z.1.sub45

if.else.47:                                       ; preds = %if.end.28
  %tobool50 = icmp eq i8 %conv.i, 0
  br i1 %tobool50, label %if.else.57, label %if.then.51

if.then.51:                                       ; preds = %if.else.47
  %cmp53 = icmp eq i8 %2, 1
  %and55107 = and i1 %tobool24, %cmp53
  %and55 = zext i1 %and55107 to i32
  %add = add i32 %z.0, %and55
  %sub56 = sub nsw i32 0, %add
  br label %cleanup

if.else.57:                                       ; preds = %if.else.47
  %cmp59 = icmp eq i8 %2, 2
  %and61106 = and i1 %tobool24, %cmp59
  %and61 = zext i1 %and61106 to i32
  %add62 = add i32 %and61, %z.0
  br label %cleanup

cleanup:                                          ; preds = %if.end.11, %if.then.51, %if.else.57, %lor.lhs.false, %if.then.6, %if.end.10
  %retval.0 = phi i32 [ -2147483648, %if.end.10 ], [ 2147483647, %if.then.6 ], [ 2147483647, %lor.lhs.false ], [ %sub56, %if.then.51 ], [ %add62, %if.else.57 ], [ %shl.sub14, %if.end.11 ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define signext i32 @float32_to_int32_round_to_zero(i32 zeroext %a) #2 {
entry:
  %and.i = and i32 %a, 8388607
  %shr.i.55 = lshr i32 %a, 23
  %and.i.56 = and i32 %shr.i.55, 255
  %shr.i = lshr i32 %a, 31
  %conv.i = trunc i32 %shr.i to i8
  %sub = add nsw i32 %and.i.56, -158
  %cmp = icmp sgt i32 %sub, -1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %cmp3 = icmp eq i32 %a, -822083584
  br i1 %cmp3, label %if.end.8, label %if.then.4

if.then.4:                                        ; preds = %if.then
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  %tobool = icmp eq i8 %conv.i, 0
  br i1 %tobool, label %cleanup, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.then.4
  %cmp5 = icmp eq i32 %and.i.56, 255
  %tobool6 = icmp ne i32 %and.i, 0
  %or.cond = and i1 %tobool6, %cmp5
  br i1 %or.cond, label %cleanup, label %if.end.8

if.end.8:                                         ; preds = %if.then, %lor.lhs.false
  br label %cleanup

if.else:                                          ; preds = %entry
  %cmp9 = icmp ult i32 %and.i.56, 127
  br i1 %cmp9, label %if.then.10, label %if.end.17

if.then.10:                                       ; preds = %if.else
  %or = or i32 %and.i.56, %and.i
  %tobool11 = icmp eq i32 %or, 0
  br i1 %tobool11, label %cleanup, label %if.then.12

if.then.12:                                       ; preds = %if.then.10
  %1 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv.54 = zext i8 %1 to i32
  %or13 = or i32 %conv.54, 32
  %conv14 = trunc i32 %or13 to i8
  store i8 %conv14, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.17:                                        ; preds = %if.else
  %or18 = shl nuw nsw i32 %and.i, 8
  %shl = or i32 %or18, -2147483648
  %sub19 = sub nsw i32 158, %and.i.56
  %shr = lshr i32 %shl, %sub19
  %fold = add nuw nsw i32 %shr.i.55, 2
  %and = and i32 %fold, 31
  %shl20 = shl i32 %shl, %and
  %tobool21 = icmp eq i32 %shl20, 0
  br i1 %tobool21, label %if.end.26, label %if.then.22

if.then.22:                                       ; preds = %if.end.17
  %2 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv23.53 = zext i8 %2 to i32
  %or24 = or i32 %conv23.53, 32
  %conv25 = trunc i32 %or24 to i8
  store i8 %conv25, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.26

if.end.26:                                        ; preds = %if.end.17, %if.then.22
  %tobool27 = icmp eq i8 %conv.i, 0
  %sub29 = sub nsw i32 0, %shr
  %shr.sub29 = select i1 %tobool27, i32 %shr, i32 %sub29
  br label %cleanup

cleanup:                                          ; preds = %if.then.12, %if.then.10, %lor.lhs.false, %if.then.4, %if.end.26, %if.end.8
  %retval.0 = phi i32 [ -2147483648, %if.end.8 ], [ %shr.sub29, %if.end.26 ], [ 2147483647, %if.then.4 ], [ 2147483647, %lor.lhs.false ], [ 0, %if.then.10 ], [ 0, %if.then.12 ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define i64 @float32_to_float64(i32 zeroext %a) #2 {
entry:
  %and.i = and i32 %a, 8388607
  %shr.i.44 = lshr i32 %a, 23
  %and.i.45 = and i32 %shr.i.44, 255
  %shr.i.42 = lshr i32 %a, 31
  switch i32 %and.i.45, label %if.end.14 [
    i32 255, label %if.then
    i32 0, label %if.then.9
  ]

if.then:                                          ; preds = %entry
  %tobool = icmp eq i32 %and.i, 0
  br i1 %tobool, label %if.end, label %if.then.3

if.then.3:                                        ; preds = %if.then
  %and.i.i = and i32 %a, 2143289344
  %and1.i.i = and i32 %a, 4194303
  %tobool1.i = icmp eq i32 %and1.i.i, 0
  %not.cmp.i.i = icmp ne i32 %and.i.i, 2139095040
  %tobool.i = or i1 %not.cmp.i.i, %tobool1.i
  br i1 %tobool.i, label %float32ToCommonNaN.exit, label %if.then.i

if.then.i:                                        ; preds = %if.then.3
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i = or i8 %0, 1
  store i8 %or3.i.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %float32ToCommonNaN.exit

float32ToCommonNaN.exit:                          ; preds = %if.then.3, %if.then.i
  %shl.i.40 = shl i32 %a, 9
  %retval.sroa.0.4.insert.ext.i = zext i32 %shl.i.40 to i64
  %shl.i.i.38 = shl nuw nsw i64 %retval.sroa.0.4.insert.ext.i, 20
  %1 = lshr i32 %a, 3
  %shl6.i = shl nuw i32 %shr.i.42, 31
  %or.i = or i32 %1, %shl6.i
  %or4.i = or i32 %or.i, 2146959360
  %z.sroa.0.0.insert.ext.i = zext i32 %or4.i to i64
  %z.sroa.0.0.insert.shift.i = shl nuw i64 %z.sroa.0.0.insert.ext.i, 32
  %z.sroa.0.0.insert.mask.i = and i64 %shl.i.i.38, 3758096384
  %z.sroa.0.0.insert.insert.i = or i64 %z.sroa.0.0.insert.shift.i, %z.sroa.0.0.insert.mask.i
  br label %cleanup

if.end:                                           ; preds = %if.then
  %shl.i.34 = shl nuw i32 %shr.i.42, 31
  %add.i.35 = or i32 %shl.i.34, 2146435072
  %retval.sroa.0.0.insert.ext.i.36 = zext i32 %add.i.35 to i64
  %retval.sroa.0.0.insert.shift.i.37 = shl nuw i64 %retval.sroa.0.0.insert.ext.i.36, 32
  br label %cleanup

if.then.9:                                        ; preds = %entry
  %cmp10 = icmp eq i32 %and.i, 0
  br i1 %cmp10, label %if.then.11, label %if.end.13

if.then.11:                                       ; preds = %if.then.9
  %shl.i.30 = shl nuw i32 %shr.i.42, 31
  %retval.sroa.0.0.insert.ext.i.31 = zext i32 %shl.i.30 to i64
  %retval.sroa.0.0.insert.shift.i.32 = shl nuw i64 %retval.sroa.0.0.insert.ext.i.31, 32
  br label %cleanup

if.end.13:                                        ; preds = %if.then.9
  %cmp.i.i = icmp ult i32 %and.i, 65536
  %shl.i.i = shl i32 %a, 16
  %shl.a.i.i = select i1 %cmp.i.i, i32 %shl.i.i, i32 %and.i
  %..i.i = select i1 %cmp.i.i, i8 16, i8 0
  %cmp2.i.i = icmp ult i32 %shl.a.i.i, 16777216
  br i1 %cmp2.i.i, label %if.then.4.i.i, label %normalizeFloat32Subnormal.exit

if.then.4.i.i:                                    ; preds = %if.end.13
  %conv5.23.i.i = zext i8 %..i.i to i32
  %add6.i.i = or i32 %conv5.23.i.i, 8
  %conv7.i.i = trunc i32 %add6.i.i to i8
  %shl8.i.i = shl i32 %shl.a.i.i, 8
  br label %normalizeFloat32Subnormal.exit

normalizeFloat32Subnormal.exit:                   ; preds = %if.end.13, %if.then.4.i.i
  %a.addr.1.i.i = phi i32 [ %shl8.i.i, %if.then.4.i.i ], [ %shl.a.i.i, %if.end.13 ]
  %shiftCount.1.i.i = phi i8 [ %conv7.i.i, %if.then.4.i.i ], [ %..i.i, %if.end.13 ]
  %shr.i.i = lshr i32 %a.addr.1.i.i, 24
  %idxprom.i.i = zext i32 %shr.i.i to i64
  %arrayidx.i.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i
  %2 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !5
  %conv10.22.i.i = zext i8 %2 to i32
  %conv11.21.i.i = zext i8 %shiftCount.1.i.i to i32
  %add12.i.i = add nuw nsw i32 %conv10.22.i.i, %conv11.21.i.i
  %conv.7.i = shl i32 %add12.i.i, 24
  %sext.i = add i32 %conv.7.i, -134217728
  %conv2.i = ashr exact i32 %sext.i, 24
  %shl.i.28 = shl i32 %and.i, %conv2.i
  %conv2.i.neg = sub nsw i32 0, %conv2.i
  br label %if.end.14

if.end.14:                                        ; preds = %entry, %normalizeFloat32Subnormal.exit
  %aSig.0 = phi i32 [ %and.i, %entry ], [ %shl.i.28, %normalizeFloat32Subnormal.exit ]
  %aExp.0 = phi i32 [ %and.i.45, %entry ], [ %conv2.i.neg, %normalizeFloat32Subnormal.exit ]
  %shl.i.27 = shl i32 %aSig.0, 29
  %shr6.i = lshr i32 %aSig.0, 3
  %shl.i = shl nuw i32 %shr.i.42, 31
  %add = shl nsw i32 %aExp.0, 20
  %shl1.i = or i32 %shl.i, 939524096
  %add.i = add i32 %shl1.i, %shr6.i
  %add2.i = add i32 %add.i, %add
  %retval.sroa.2.0.insert.ext.i = zext i32 %shl.i.27 to i64
  %retval.sroa.0.0.insert.ext.i = zext i32 %add2.i to i64
  %retval.sroa.0.0.insert.shift.i = shl nuw i64 %retval.sroa.0.0.insert.ext.i, 32
  %retval.sroa.0.0.insert.insert.i = or i64 %retval.sroa.0.0.insert.shift.i, %retval.sroa.2.0.insert.ext.i
  br label %cleanup

cleanup:                                          ; preds = %if.end.14, %if.then.11, %if.end, %float32ToCommonNaN.exit
  %retval.sroa.0.0 = phi i64 [ %z.sroa.0.0.insert.insert.i, %float32ToCommonNaN.exit ], [ %retval.sroa.0.0.insert.shift.i.37, %if.end ], [ %retval.sroa.0.0.insert.shift.i.32, %if.then.11 ], [ %retval.sroa.0.0.insert.insert.i, %if.end.14 ]
  ret i64 %retval.sroa.0.0
}

; Function Attrs: nounwind
define zeroext i32 @float32_round_to_int(i32 zeroext %a) #2 {
entry:
  %shr.i = lshr i32 %a, 23
  %and.i = and i32 %shr.i, 255
  %cmp = icmp ugt i32 %and.i, 149
  br i1 %cmp, label %if.then, label %if.end.5

if.then:                                          ; preds = %entry
  %cmp1 = icmp ne i32 %and.i, 255
  %and.i.114 = and i32 %a, 8388607
  %tobool = icmp eq i32 %and.i.114, 0
  %or.cond = or i1 %tobool, %cmp1
  br i1 %or.cond, label %if.else.i, label %if.then.3

if.then.3:                                        ; preds = %if.then
  %and.i.66.i = and i32 %a, 2143289344
  %and1.i.68.i = and i32 %a, 4194303
  %or.i = or i32 %a, 4194304
  %tobool.i118 = icmp eq i32 %and1.i.68.i, 0
  %not.cmp.i.67.i = icmp ne i32 %and.i.66.i, 2139095040
  %tobool.i = or i1 %not.cmp.i.67.i, %tobool.i118
  br i1 %tobool.i, label %if.else.i, label %if.then.8.i

if.then.8.i:                                      ; preds = %if.then.3
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i = or i8 %0, 1
  store i8 %or3.i.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.else.i

if.else.i:                                        ; preds = %if.then.19, %sw.bb.22, %sw.bb.25, %sw.epilog, %if.then.7, %if.end.56, %if.then.61, %if.then, %if.then.8.i, %if.then.3
  %merge = phi i32 [ %or.i, %if.then.3 ], [ %shl.i, %sw.epilog ], [ %cond28, %sw.bb.25 ], [ %cond, %sw.bb.22 ], [ %add.i, %if.then.19 ], [ %a, %if.then ], [ %a, %if.then.7 ], [ %a, %if.end.56 ], [ %and58, %if.then.61 ], [ %or.i, %if.then.8.i ]
  ret i32 %merge

if.end.5:                                         ; preds = %entry
  %cmp6 = icmp ult i32 %and.i, 127
  br i1 %cmp6, label %if.then.7, label %if.end.30

if.then.7:                                        ; preds = %if.end.5
  %shl.mask = and i32 %a, 2147483647
  %cmp8 = icmp eq i32 %shl.mask, 0
  br i1 %cmp8, label %if.else.i, label %if.end.10

if.end.10:                                        ; preds = %if.then.7
  %1 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv.106 = zext i8 %1 to i32
  %or = or i32 %conv.106, 32
  %conv11 = trunc i32 %or to i8
  store i8 %conv11, i8* @float_exception_flags, align 1, !tbaa !5
  %shr.i.111 = lshr i32 %a, 31
  %conv.i.112 = trunc i32 %shr.i.111 to i8
  %2 = load i8, i8* @float_rounding_mode, align 1, !tbaa !5
  %conv13 = sext i8 %2 to i32
  switch i32 %conv13, label %sw.epilog [
    i32 0, label %sw.bb
    i32 1, label %sw.bb.22
    i32 2, label %sw.bb.25
  ]

sw.bb:                                            ; preds = %if.end.10
  %cmp14 = icmp ne i32 %and.i, 126
  %and.i.110 = and i32 %a, 8388607
  %tobool18 = icmp eq i32 %and.i.110, 0
  %or.cond116 = or i1 %tobool18, %cmp14
  br i1 %or.cond116, label %sw.epilog, label %if.then.19

if.then.19:                                       ; preds = %sw.bb
  %shl.i.109 = shl nuw i32 %shr.i.111, 31
  %add.i = or i32 %shl.i.109, 1065353216
  br label %if.else.i

sw.bb.22:                                         ; preds = %if.end.10
  %tobool24 = icmp ne i8 %conv.i.112, 0
  %cond = select i1 %tobool24, i32 -1082130432, i32 0
  br label %if.else.i

sw.bb.25:                                         ; preds = %if.end.10
  %tobool27 = icmp ne i8 %conv.i.112, 0
  %cond28 = select i1 %tobool27, i32 -2147483648, i32 1065353216
  br label %if.else.i

sw.epilog:                                        ; preds = %sw.bb, %if.end.10
  %shl.i = shl nuw i32 %shr.i.111, 31
  br label %if.else.i

if.end.30:                                        ; preds = %if.end.5
  %sub = sub nsw i32 150, %and.i
  %shl31 = shl i32 1, %sub
  %sub32 = add i32 %shl31, -1
  %3 = load i8, i8* @float_rounding_mode, align 1, !tbaa !5
  switch i8 %3, label %if.then.45 [
    i8 0, label %if.then.36
    i8 3, label %if.end.56
  ]

if.then.36:                                       ; preds = %if.end.30
  %shr = lshr i32 %shl31, 1
  %add = add i32 %shr, %a
  %and = and i32 %add, %sub32
  %cmp37 = icmp eq i32 %and, 0
  br i1 %cmp37, label %if.then.39, label %if.end.56

if.then.39:                                       ; preds = %if.then.36
  %neg = xor i32 %shl31, -1
  %and40 = and i32 %add, %neg
  br label %if.end.56

if.then.45:                                       ; preds = %if.end.30
  %shr.i.107 = lshr i32 %a, 31
  %cmp49 = icmp eq i8 %3, 2
  %conv50 = zext i1 %cmp49 to i32
  %tobool51 = icmp eq i32 %shr.i.107, %conv50
  %add53 = select i1 %tobool51, i32 0, i32 %sub32
  %a.add53 = add i32 %add53, %a
  br label %if.end.56

if.end.56:                                        ; preds = %if.then.45, %if.end.30, %if.then.36, %if.then.39
  %z.0 = phi i32 [ %and40, %if.then.39 ], [ %add, %if.then.36 ], [ %a, %if.end.30 ], [ %a.add53, %if.then.45 ]
  %neg57 = sub i32 0, %shl31
  %and58 = and i32 %z.0, %neg57
  %cmp59 = icmp eq i32 %and58, %a
  br i1 %cmp59, label %if.else.i, label %if.then.61

if.then.61:                                       ; preds = %if.end.56
  %4 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv62.105 = zext i8 %4 to i32
  %or63 = or i32 %conv62.105, 32
  %conv64 = trunc i32 %or63 to i8
  store i8 %conv64, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.else.i
}

; Function Attrs: nounwind
define zeroext i32 @float32_add(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %shr.i = lshr i32 %a, 31
  %conv.i = trunc i32 %shr.i to i8
  %shr.i.10 = lshr i32 %b, 31
  %conv.i.11 = trunc i32 %shr.i.10 to i8
  %cmp = icmp eq i8 %conv.i, %conv.i.11
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %call4 = tail call fastcc zeroext i32 @addFloat32Sigs(i32 zeroext %a, i32 zeroext %b, i8 signext %conv.i)
  br label %cleanup

if.else:                                          ; preds = %entry
  %call5 = tail call fastcc zeroext i32 @subFloat32Sigs(i32 zeroext %a, i32 zeroext %b, i8 signext %conv.i)
  br label %cleanup

cleanup:                                          ; preds = %if.else, %if.then
  %retval.0 = phi i32 [ %call4, %if.then ], [ %call5, %if.else ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define internal fastcc zeroext i32 @addFloat32Sigs(i32 zeroext %a, i32 zeroext %b, i8 signext %zSign) #2 {
entry:
  %shr.i = lshr i32 %a, 23
  %and.i.95 = and i32 %shr.i, 255
  %shr.i.202 = lshr i32 %b, 23
  %and.i.203 = and i32 %shr.i.202, 255
  %sub = sub nsw i32 %and.i.95, %and.i.203
  %and.i = shl i32 %a, 6
  %shl = and i32 %and.i, 536870848
  %and.i.204 = shl i32 %b, 6
  %shl4 = and i32 %and.i.204, 536870848
  %cmp = icmp sgt i32 %sub, 0
  br i1 %cmp, label %if.then, label %if.else.13

if.then:                                          ; preds = %entry
  %cmp5 = icmp eq i32 %and.i.95, 255
  br i1 %cmp5, label %if.then.6, label %if.end.9

if.then.6:                                        ; preds = %if.then
  %tobool = icmp eq i32 %shl, 0
  br i1 %tobool, label %cleanup, label %if.then.7

if.then.7:                                        ; preds = %if.then.6
  %0 = trunc i32 %a to i31
  %cmp.i.i.161 = icmp ugt i31 %0, -8388608
  %and.i.66.i.162 = and i32 %a, 2143289344
  %cmp.i.67.i.163 = icmp eq i32 %and.i.66.i.162, 2139095040
  %and1.i.68.i.164 = and i32 %a, 4194303
  %tobool.i.69.i.165 = icmp ne i32 %and1.i.68.i.164, 0
  %phitmp.i.70.i.166 = zext i1 %tobool.i.69.i.165 to i8
  %1 = select i1 %cmp.i.67.i.163, i8 %phitmp.i.70.i.166, i8 0
  %2 = trunc i32 %b to i31
  %cmp.i.64.i.167 = icmp ugt i31 %2, -8388608
  %and.i.i.168 = and i32 %b, 2143289344
  %cmp.i.63.i.169 = icmp eq i32 %and.i.i.168, 2139095040
  %and1.i.i.170 = and i32 %b, 4194303
  %tobool.i.i.171 = icmp ne i32 %and1.i.i.170, 0
  %phitmp.i.i.172 = zext i1 %tobool.i.i.171 to i8
  %3 = select i1 %cmp.i.63.i.169, i8 %phitmp.i.i.172, i8 0
  %or.i.173 = or i32 %a, 4194304
  %or4.i.174 = or i32 %b, 4194304
  %conv5.71.i.175 = zext i8 %3 to i32
  %or662.i.176 = or i8 %3, %1
  %tobool.i.177 = icmp eq i8 %or662.i.176, 0
  br i1 %tobool.i.177, label %if.end.i.181, label %if.then.i.179

if.then.i.179:                                    ; preds = %if.then.7
  %4 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i.178 = or i8 %4, 1
  store i8 %or3.i.i.178, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i.181

if.end.i.181:                                     ; preds = %if.then.i.179, %if.then.7
  %tobool7.i.180 = icmp eq i8 %1, 0
  br i1 %tobool7.i.180, label %if.else.i.186, label %if.then.8.i.183

if.then.8.i.183:                                  ; preds = %if.end.i.181
  %tobool9.i.182 = icmp eq i8 %3, 0
  br i1 %tobool9.i.182, label %if.end.11.i.185, label %returnLargerSignificand.i.194

if.end.11.i.185:                                  ; preds = %if.then.8.i.183
  %cond.i.184 = select i1 %cmp.i.64.i.167, i32 %or4.i.174, i32 %or.i.173
  br label %cleanup

if.else.i.186:                                    ; preds = %if.end.i.181
  br i1 %cmp.i.i.161, label %if.then.15.i.190, label %cleanup

if.then.15.i.190:                                 ; preds = %if.else.i.186
  %5 = zext i1 %cmp.i.64.i.167 to i32
  %lnot.ext.i.187 = xor i32 %5, 1
  %or18.i.188 = or i32 %conv5.71.i.175, %lnot.ext.i.187
  %tobool19.i.189 = icmp eq i32 %or18.i.188, 0
  br i1 %tobool19.i.189, label %returnLargerSignificand.i.194, label %cleanup

returnLargerSignificand.i.194:                    ; preds = %if.then.15.i.190, %if.then.8.i.183
  %shl.i.191 = shl i32 %or.i.173, 1
  %shl22.i.192 = shl i32 %or4.i.174, 1
  %cmp.i.193 = icmp ult i32 %shl.i.191, %shl22.i.192
  br i1 %cmp.i.193, label %cleanup, label %if.end.25.i.196

if.end.25.i.196:                                  ; preds = %returnLargerSignificand.i.194
  %cmp28.i.195 = icmp ult i32 %shl22.i.192, %shl.i.191
  br i1 %cmp28.i.195, label %cleanup, label %if.end.31.i.199

if.end.31.i.199:                                  ; preds = %if.end.25.i.196
  %cmp32.i.197 = icmp ult i32 %or.i.173, %or4.i.174
  %cond37.i.198 = select i1 %cmp32.i.197, i32 %or.i.173, i32 %or4.i.174
  br label %cleanup

if.end.9:                                         ; preds = %if.then
  %cmp10 = icmp eq i32 %and.i.203, 0
  br i1 %cmp10, label %if.end.12, label %if.end.12.thread

if.end.12.thread:                                 ; preds = %if.end.9
  %or = or i32 %shl4, 536870912
  br label %if.else.i.148

if.end.12:                                        ; preds = %if.end.9
  %dec = add nsw i32 %sub, -1
  %cmp.i.146 = icmp eq i32 %dec, 0
  br i1 %cmp.i.146, label %if.end.46, label %if.else.i.148

if.else.i.148:                                    ; preds = %if.end.12.thread, %if.end.12
  %expDiff.0218 = phi i32 [ %sub, %if.end.12.thread ], [ %dec, %if.end.12 ]
  %bSig.0217 = phi i32 [ %or, %if.end.12.thread ], [ %shl4, %if.end.12 ]
  %cmp1.i.147 = icmp slt i32 %expDiff.0218, 32
  br i1 %cmp1.i.147, label %if.then.2.i.155, label %if.else.4.i.158

if.then.2.i.155:                                  ; preds = %if.else.i.148
  %shr.i.149 = lshr i32 %bSig.0217, %expDiff.0218
  %sub.i = sub nsw i32 0, %expDiff.0218
  %and.i.150 = and i32 %sub.i, 31
  %shl.i.151 = shl i32 %bSig.0217, %and.i.150
  %cmp3.i.152 = icmp ne i32 %shl.i.151, 0
  %conv.i.153 = zext i1 %cmp3.i.152 to i32
  %or.i.154 = or i32 %conv.i.153, %shr.i.149
  br label %if.end.46

if.else.4.i.158:                                  ; preds = %if.else.i.148
  %cmp5.i.156 = icmp ne i32 %bSig.0217, 0
  %conv6.i.157 = zext i1 %cmp5.i.156 to i32
  br label %if.end.46

if.else.13:                                       ; preds = %entry
  %cmp14 = icmp slt i32 %sub, 0
  br i1 %cmp14, label %if.then.15, label %if.else.30

if.then.15:                                       ; preds = %if.else.13
  %cmp16 = icmp eq i32 %and.i.203, 255
  br i1 %cmp16, label %if.then.17, label %if.end.23

if.then.17:                                       ; preds = %if.then.15
  %tobool18 = icmp eq i32 %shl4, 0
  br i1 %tobool18, label %if.end.21, label %if.then.19

if.then.19:                                       ; preds = %if.then.17
  %6 = trunc i32 %a to i31
  %cmp.i.i.105 = icmp ugt i31 %6, -8388608
  %and.i.66.i.106 = and i32 %a, 2143289344
  %cmp.i.67.i.107 = icmp eq i32 %and.i.66.i.106, 2139095040
  %and1.i.68.i.108 = and i32 %a, 4194303
  %tobool.i.69.i.109 = icmp ne i32 %and1.i.68.i.108, 0
  %phitmp.i.70.i.110 = zext i1 %tobool.i.69.i.109 to i8
  %7 = select i1 %cmp.i.67.i.107, i8 %phitmp.i.70.i.110, i8 0
  %8 = trunc i32 %b to i31
  %cmp.i.64.i.111 = icmp ugt i31 %8, -8388608
  %and.i.i.112 = and i32 %b, 2143289344
  %cmp.i.63.i.113 = icmp eq i32 %and.i.i.112, 2139095040
  %and1.i.i.114 = and i32 %b, 4194303
  %tobool.i.i.115 = icmp ne i32 %and1.i.i.114, 0
  %phitmp.i.i.116 = zext i1 %tobool.i.i.115 to i8
  %9 = select i1 %cmp.i.63.i.113, i8 %phitmp.i.i.116, i8 0
  %or.i.117 = or i32 %a, 4194304
  %or4.i.118 = or i32 %b, 4194304
  %conv5.71.i.119 = zext i8 %9 to i32
  %or662.i.120 = or i8 %9, %7
  %tobool.i.121 = icmp eq i8 %or662.i.120, 0
  br i1 %tobool.i.121, label %if.end.i.125, label %if.then.i.123

if.then.i.123:                                    ; preds = %if.then.19
  %10 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i.122 = or i8 %10, 1
  store i8 %or3.i.i.122, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i.125

if.end.i.125:                                     ; preds = %if.then.i.123, %if.then.19
  %tobool7.i.124 = icmp eq i8 %7, 0
  br i1 %tobool7.i.124, label %if.else.i.130, label %if.then.8.i.127

if.then.8.i.127:                                  ; preds = %if.end.i.125
  %tobool9.i.126 = icmp eq i8 %9, 0
  br i1 %tobool9.i.126, label %if.end.11.i.129, label %returnLargerSignificand.i.138

if.end.11.i.129:                                  ; preds = %if.then.8.i.127
  %cond.i.128 = select i1 %cmp.i.64.i.111, i32 %or4.i.118, i32 %or.i.117
  br label %cleanup

if.else.i.130:                                    ; preds = %if.end.i.125
  br i1 %cmp.i.i.105, label %if.then.15.i.134, label %cleanup

if.then.15.i.134:                                 ; preds = %if.else.i.130
  %11 = zext i1 %cmp.i.64.i.111 to i32
  %lnot.ext.i.131 = xor i32 %11, 1
  %or18.i.132 = or i32 %conv5.71.i.119, %lnot.ext.i.131
  %tobool19.i.133 = icmp eq i32 %or18.i.132, 0
  br i1 %tobool19.i.133, label %returnLargerSignificand.i.138, label %cleanup

returnLargerSignificand.i.138:                    ; preds = %if.then.15.i.134, %if.then.8.i.127
  %shl.i.135 = shl i32 %or.i.117, 1
  %shl22.i.136 = shl i32 %or4.i.118, 1
  %cmp.i.137 = icmp ult i32 %shl.i.135, %shl22.i.136
  br i1 %cmp.i.137, label %cleanup, label %if.end.25.i.140

if.end.25.i.140:                                  ; preds = %returnLargerSignificand.i.138
  %cmp28.i.139 = icmp ult i32 %shl22.i.136, %shl.i.135
  br i1 %cmp28.i.139, label %cleanup, label %if.end.31.i.143

if.end.31.i.143:                                  ; preds = %if.end.25.i.140
  %cmp32.i.141 = icmp ult i32 %or.i.117, %or4.i.118
  %cond37.i.142 = select i1 %cmp32.i.141, i32 %or.i.117, i32 %or4.i.118
  br label %cleanup

if.end.21:                                        ; preds = %if.then.17
  %conv.3.i.103 = zext i8 %zSign to i32
  %shl.i.104 = shl i32 %conv.3.i.103, 31
  %add.i = or i32 %shl.i.104, 2139095040
  br label %cleanup

if.end.23:                                        ; preds = %if.then.15
  %cmp24 = icmp eq i32 %and.i.95, 0
  %or27 = or i32 %shl, 536870912
  %aSig.0 = select i1 %cmp24, i32 %shl, i32 %or27
  %inc = zext i1 %cmp24 to i32
  %expDiff.1 = add nsw i32 %sub, %inc
  %sub29 = sub nsw i32 0, %expDiff.1
  %cmp.i.97 = icmp eq i32 %expDiff.1, 0
  br i1 %cmp.i.97, label %if.end.46, label %if.else.i.98

if.else.i.98:                                     ; preds = %if.end.23
  %cmp1.i = icmp sgt i32 %expDiff.1, -32
  br i1 %cmp1.i, label %if.then.2.i, label %if.else.4.i

if.then.2.i:                                      ; preds = %if.else.i.98
  %shr.i.99 = lshr i32 %aSig.0, %sub29
  %and.i.100 = and i32 %expDiff.1, 31
  %shl.i.101 = shl i32 %aSig.0, %and.i.100
  %cmp3.i = icmp ne i32 %shl.i.101, 0
  %conv.i = zext i1 %cmp3.i to i32
  %or.i.102 = or i32 %conv.i, %shr.i.99
  br label %if.end.46

if.else.4.i:                                      ; preds = %if.else.i.98
  %cmp5.i = icmp ne i32 %aSig.0, 0
  %conv6.i = zext i1 %cmp5.i to i32
  br label %if.end.46

if.else.30:                                       ; preds = %if.else.13
  switch i32 %and.i.95, label %if.end.42 [
    i32 255, label %if.then.32
    i32 0, label %if.then.40
  ]

if.then.32:                                       ; preds = %if.else.30
  %or33 = or i32 %shl4, %shl
  %tobool34 = icmp eq i32 %or33, 0
  br i1 %tobool34, label %cleanup, label %if.then.35

if.then.35:                                       ; preds = %if.then.32
  %12 = trunc i32 %a to i31
  %cmp.i.i = icmp ugt i31 %12, -8388608
  %and.i.66.i = and i32 %a, 2143289344
  %cmp.i.67.i = icmp eq i32 %and.i.66.i, 2139095040
  %and1.i.68.i = and i32 %a, 4194303
  %tobool.i.69.i = icmp ne i32 %and1.i.68.i, 0
  %phitmp.i.70.i = zext i1 %tobool.i.69.i to i8
  %13 = select i1 %cmp.i.67.i, i8 %phitmp.i.70.i, i8 0
  %14 = trunc i32 %b to i31
  %cmp.i.64.i = icmp ugt i31 %14, -8388608
  %and.i.i = and i32 %b, 2143289344
  %cmp.i.63.i = icmp eq i32 %and.i.i, 2139095040
  %and1.i.i = and i32 %b, 4194303
  %tobool.i.i = icmp ne i32 %and1.i.i, 0
  %phitmp.i.i = zext i1 %tobool.i.i to i8
  %15 = select i1 %cmp.i.63.i, i8 %phitmp.i.i, i8 0
  %or.i = or i32 %a, 4194304
  %or4.i = or i32 %b, 4194304
  %conv5.71.i = zext i8 %15 to i32
  %or662.i = or i8 %15, %13
  %tobool.i = icmp eq i8 %or662.i, 0
  br i1 %tobool.i, label %if.end.i, label %if.then.i

if.then.i:                                        ; preds = %if.then.35
  %16 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i = or i8 %16, 1
  store i8 %or3.i.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i

if.end.i:                                         ; preds = %if.then.i, %if.then.35
  %tobool7.i = icmp eq i8 %13, 0
  br i1 %tobool7.i, label %if.else.i, label %if.then.8.i

if.then.8.i:                                      ; preds = %if.end.i
  %tobool9.i = icmp eq i8 %15, 0
  br i1 %tobool9.i, label %if.end.11.i, label %returnLargerSignificand.i

if.end.11.i:                                      ; preds = %if.then.8.i
  %cond.i = select i1 %cmp.i.64.i, i32 %or4.i, i32 %or.i
  br label %cleanup

if.else.i:                                        ; preds = %if.end.i
  br i1 %cmp.i.i, label %if.then.15.i, label %cleanup

if.then.15.i:                                     ; preds = %if.else.i
  %17 = zext i1 %cmp.i.64.i to i32
  %lnot.ext.i = xor i32 %17, 1
  %or18.i = or i32 %conv5.71.i, %lnot.ext.i
  %tobool19.i = icmp eq i32 %or18.i, 0
  br i1 %tobool19.i, label %returnLargerSignificand.i, label %cleanup

returnLargerSignificand.i:                        ; preds = %if.then.15.i, %if.then.8.i
  %shl.i.96 = shl i32 %or.i, 1
  %shl22.i = shl i32 %or4.i, 1
  %cmp.i = icmp ult i32 %shl.i.96, %shl22.i
  br i1 %cmp.i, label %cleanup, label %if.end.25.i

if.end.25.i:                                      ; preds = %returnLargerSignificand.i
  %cmp28.i = icmp ult i32 %shl22.i, %shl.i.96
  br i1 %cmp28.i, label %cleanup, label %if.end.31.i

if.end.31.i:                                      ; preds = %if.end.25.i
  %cmp32.i = icmp ult i32 %or.i, %or4.i
  %cond37.i = select i1 %cmp32.i, i32 %or.i, i32 %or4.i
  br label %cleanup

if.then.40:                                       ; preds = %if.else.30
  %add = add nuw nsw i32 %shl4, %shl
  %shr = lshr exact i32 %add, 6
  %conv.3.i = zext i8 %zSign to i32
  %shl.i = shl i32 %conv.3.i, 31
  %add2.i = or i32 %shr, %shl.i
  br label %cleanup

if.end.42:                                        ; preds = %if.else.30
  %add43 = or i32 %shl, 1073741824
  %add44 = add nuw i32 %add43, %shl4
  br label %roundAndPack

if.end.46:                                        ; preds = %if.else.4.i, %if.then.2.i, %if.end.23, %if.else.4.i.158, %if.then.2.i.155, %if.end.12
  %aSig.1 = phi i32 [ %shl, %if.end.12 ], [ %shl, %if.then.2.i.155 ], [ %shl, %if.else.4.i.158 ], [ %or.i.102, %if.then.2.i ], [ %conv6.i, %if.else.4.i ], [ %aSig.0, %if.end.23 ]
  %bSig.1 = phi i32 [ %shl4, %if.end.12 ], [ %or.i.154, %if.then.2.i.155 ], [ %conv6.i.157, %if.else.4.i.158 ], [ %shl4, %if.then.2.i ], [ %shl4, %if.else.4.i ], [ %shl4, %if.end.23 ]
  %zExp.0 = phi i32 [ %and.i.95, %if.end.12 ], [ %and.i.95, %if.then.2.i.155 ], [ %and.i.95, %if.else.4.i.158 ], [ %and.i.203, %if.then.2.i ], [ %and.i.203, %if.else.4.i ], [ %and.i.203, %if.end.23 ]
  %or47 = or i32 %aSig.1, 536870912
  %add48 = add i32 %or47, %bSig.1
  %shl49 = shl i32 %add48, 1
  %cmp51 = icmp slt i32 %shl49, 0
  %not.cmp51 = xor i1 %cmp51, true
  %dec50 = sext i1 %not.cmp51 to i32
  %zExp.0.dec50 = add nsw i32 %dec50, %zExp.0
  %add48.shl49 = select i1 %cmp51, i32 %add48, i32 %shl49
  br label %roundAndPack

roundAndPack:                                     ; preds = %if.end.46, %if.end.42
  %zExp.1 = phi i32 [ %and.i.95, %if.end.42 ], [ %zExp.0.dec50, %if.end.46 ]
  %zSig.0 = phi i32 [ %add44, %if.end.42 ], [ %add48.shl49, %if.end.46 ]
  %call56 = tail call fastcc zeroext i32 @roundAndPackFloat32(i8 signext %zSign, i32 signext %zExp.1, i32 zeroext %zSig.0)
  br label %cleanup

cleanup:                                          ; preds = %if.end.31.i, %if.end.25.i, %returnLargerSignificand.i, %if.then.15.i, %if.else.i, %if.end.11.i, %if.end.31.i.143, %if.end.25.i.140, %returnLargerSignificand.i.138, %if.then.15.i.134, %if.else.i.130, %if.end.11.i.129, %if.end.31.i.199, %if.end.25.i.196, %returnLargerSignificand.i.194, %if.then.15.i.190, %if.else.i.186, %if.end.11.i.185, %if.then.32, %if.then.6, %roundAndPack, %if.then.40, %if.end.21
  %retval.0 = phi i32 [ %call56, %roundAndPack ], [ %add.i, %if.end.21 ], [ %add2.i, %if.then.40 ], [ %a, %if.then.6 ], [ %a, %if.then.32 ], [ %cond37.i.198, %if.end.31.i.199 ], [ %cond.i.184, %if.end.11.i.185 ], [ %or.i.173, %if.then.15.i.190 ], [ %or4.i.174, %returnLargerSignificand.i.194 ], [ %or.i.173, %if.end.25.i.196 ], [ %or4.i.174, %if.else.i.186 ], [ %cond37.i.142, %if.end.31.i.143 ], [ %cond.i.128, %if.end.11.i.129 ], [ %or.i.117, %if.then.15.i.134 ], [ %or4.i.118, %returnLargerSignificand.i.138 ], [ %or.i.117, %if.end.25.i.140 ], [ %or4.i.118, %if.else.i.130 ], [ %cond37.i, %if.end.31.i ], [ %cond.i, %if.end.11.i ], [ %or.i, %if.then.15.i ], [ %or4.i, %returnLargerSignificand.i ], [ %or.i, %if.end.25.i ], [ %or4.i, %if.else.i ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define internal fastcc zeroext i32 @subFloat32Sigs(i32 zeroext %a, i32 zeroext %b, i8 signext %zSign) #2 {
entry:
  %shr.i = lshr i32 %a, 23
  %and.i.104 = and i32 %shr.i, 255
  %shr.i.213 = lshr i32 %b, 23
  %and.i.214 = and i32 %shr.i.213, 255
  %sub = sub nsw i32 %and.i.104, %and.i.214
  %and.i = shl i32 %a, 7
  %shl = and i32 %and.i, 1073741696
  %and.i.215 = shl i32 %b, 7
  %shl4 = and i32 %and.i.215, 1073741696
  %cmp = icmp sgt i32 %sub, 0
  br i1 %cmp, label %aExpBigger, label %if.end

if.end:                                           ; preds = %entry
  %cmp5 = icmp slt i32 %sub, 0
  br i1 %cmp5, label %bExpBigger, label %if.end.7

if.end.7:                                         ; preds = %if.end
  switch i32 %and.i.104, label %if.end.16 [
    i32 255, label %if.then.9
    i32 0, label %if.then.15
  ]

if.then.9:                                        ; preds = %if.end.7
  %or = or i32 %shl4, %shl
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %if.end.12, label %if.then.10

if.then.10:                                       ; preds = %if.then.9
  %0 = trunc i32 %a to i31
  %cmp.i.i.172 = icmp ugt i31 %0, -8388608
  %and.i.66.i.173 = and i32 %a, 2143289344
  %cmp.i.67.i.174 = icmp eq i32 %and.i.66.i.173, 2139095040
  %and1.i.68.i.175 = and i32 %a, 4194303
  %tobool.i.69.i.176 = icmp ne i32 %and1.i.68.i.175, 0
  %phitmp.i.70.i.177 = zext i1 %tobool.i.69.i.176 to i8
  %1 = select i1 %cmp.i.67.i.174, i8 %phitmp.i.70.i.177, i8 0
  %2 = trunc i32 %b to i31
  %cmp.i.64.i.178 = icmp ugt i31 %2, -8388608
  %and.i.i.179 = and i32 %b, 2143289344
  %cmp.i.63.i.180 = icmp eq i32 %and.i.i.179, 2139095040
  %and1.i.i.181 = and i32 %b, 4194303
  %tobool.i.i.182 = icmp ne i32 %and1.i.i.181, 0
  %phitmp.i.i.183 = zext i1 %tobool.i.i.182 to i8
  %3 = select i1 %cmp.i.63.i.180, i8 %phitmp.i.i.183, i8 0
  %or.i.184 = or i32 %a, 4194304
  %or4.i.185 = or i32 %b, 4194304
  %conv5.71.i.186 = zext i8 %3 to i32
  %or662.i.187 = or i8 %3, %1
  %tobool.i.188 = icmp eq i8 %or662.i.187, 0
  br i1 %tobool.i.188, label %if.end.i.192, label %if.then.i.190

if.then.i.190:                                    ; preds = %if.then.10
  %4 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i.189 = or i8 %4, 1
  store i8 %or3.i.i.189, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i.192

if.end.i.192:                                     ; preds = %if.then.i.190, %if.then.10
  %tobool7.i.191 = icmp eq i8 %1, 0
  br i1 %tobool7.i.191, label %if.else.i.197, label %if.then.8.i.194

if.then.8.i.194:                                  ; preds = %if.end.i.192
  %tobool9.i.193 = icmp eq i8 %3, 0
  br i1 %tobool9.i.193, label %if.end.11.i.196, label %returnLargerSignificand.i.205

if.end.11.i.196:                                  ; preds = %if.then.8.i.194
  %cond.i.195 = select i1 %cmp.i.64.i.178, i32 %or4.i.185, i32 %or.i.184
  br label %cleanup

if.else.i.197:                                    ; preds = %if.end.i.192
  br i1 %cmp.i.i.172, label %if.then.15.i.201, label %cleanup

if.then.15.i.201:                                 ; preds = %if.else.i.197
  %5 = zext i1 %cmp.i.64.i.178 to i32
  %lnot.ext.i.198 = xor i32 %5, 1
  %or18.i.199 = or i32 %conv5.71.i.186, %lnot.ext.i.198
  %tobool19.i.200 = icmp eq i32 %or18.i.199, 0
  br i1 %tobool19.i.200, label %returnLargerSignificand.i.205, label %cleanup

returnLargerSignificand.i.205:                    ; preds = %if.then.15.i.201, %if.then.8.i.194
  %shl.i.202 = shl i32 %or.i.184, 1
  %shl22.i.203 = shl i32 %or4.i.185, 1
  %cmp.i.204 = icmp ult i32 %shl.i.202, %shl22.i.203
  br i1 %cmp.i.204, label %cleanup, label %if.end.25.i.207

if.end.25.i.207:                                  ; preds = %returnLargerSignificand.i.205
  %cmp28.i.206 = icmp ult i32 %shl22.i.203, %shl.i.202
  br i1 %cmp28.i.206, label %cleanup, label %if.end.31.i.210

if.end.31.i.210:                                  ; preds = %if.end.25.i.207
  %cmp32.i.208 = icmp ult i32 %or.i.184, %or4.i.185
  %cond37.i.209 = select i1 %cmp32.i.208, i32 %or.i.184, i32 %or4.i.185
  br label %cleanup

if.end.12:                                        ; preds = %if.then.9
  %6 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %6, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.then.15:                                       ; preds = %if.end.7
  br label %if.end.16

if.end.16:                                        ; preds = %if.end.7, %if.then.15
  %aExp.0 = phi i32 [ 1, %if.then.15 ], [ %and.i.104, %if.end.7 ]
  %bExp.0 = phi i32 [ 1, %if.then.15 ], [ %and.i.214, %if.end.7 ]
  %cmp17 = icmp ult i32 %shl4, %shl
  br i1 %cmp17, label %aBigger, label %if.end.19

if.end.19:                                        ; preds = %if.end.16
  %cmp20 = icmp ult i32 %shl, %shl4
  br i1 %cmp20, label %bBigger, label %if.end.22

if.end.22:                                        ; preds = %if.end.19
  %7 = load i8, i8* @float_rounding_mode, align 1, !tbaa !5
  %cmp23 = icmp eq i8 %7, 1
  %conv.3.i.170 = zext i1 %cmp23 to i32
  %shl.i.171 = shl nuw i32 %conv.3.i.170, 31
  br label %cleanup

bExpBigger:                                       ; preds = %if.end
  %cmp27 = icmp eq i32 %and.i.214, 255
  br i1 %cmp27, label %if.then.29, label %if.end.37

if.then.29:                                       ; preds = %bExpBigger
  %tobool30 = icmp eq i32 %shl4, 0
  br i1 %tobool30, label %if.end.33, label %if.then.31

if.then.31:                                       ; preds = %if.then.29
  %8 = trunc i32 %a to i31
  %cmp.i.i.129 = icmp ugt i31 %8, -8388608
  %and.i.66.i.130 = and i32 %a, 2143289344
  %cmp.i.67.i.131 = icmp eq i32 %and.i.66.i.130, 2139095040
  %and1.i.68.i.132 = and i32 %a, 4194303
  %tobool.i.69.i.133 = icmp ne i32 %and1.i.68.i.132, 0
  %phitmp.i.70.i.134 = zext i1 %tobool.i.69.i.133 to i8
  %9 = select i1 %cmp.i.67.i.131, i8 %phitmp.i.70.i.134, i8 0
  %10 = trunc i32 %b to i31
  %cmp.i.64.i.135 = icmp ugt i31 %10, -8388608
  %and.i.i.136 = and i32 %b, 2143289344
  %cmp.i.63.i.137 = icmp eq i32 %and.i.i.136, 2139095040
  %and1.i.i.138 = and i32 %b, 4194303
  %tobool.i.i.139 = icmp ne i32 %and1.i.i.138, 0
  %phitmp.i.i.140 = zext i1 %tobool.i.i.139 to i8
  %11 = select i1 %cmp.i.63.i.137, i8 %phitmp.i.i.140, i8 0
  %or.i.141 = or i32 %a, 4194304
  %or4.i.142 = or i32 %b, 4194304
  %conv5.71.i.143 = zext i8 %11 to i32
  %or662.i.144 = or i8 %11, %9
  %tobool.i.145 = icmp eq i8 %or662.i.144, 0
  br i1 %tobool.i.145, label %if.end.i.149, label %if.then.i.147

if.then.i.147:                                    ; preds = %if.then.31
  %12 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i.146 = or i8 %12, 1
  store i8 %or3.i.i.146, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i.149

if.end.i.149:                                     ; preds = %if.then.i.147, %if.then.31
  %tobool7.i.148 = icmp eq i8 %9, 0
  br i1 %tobool7.i.148, label %if.else.i.154, label %if.then.8.i.151

if.then.8.i.151:                                  ; preds = %if.end.i.149
  %tobool9.i.150 = icmp eq i8 %11, 0
  br i1 %tobool9.i.150, label %if.end.11.i.153, label %returnLargerSignificand.i.162

if.end.11.i.153:                                  ; preds = %if.then.8.i.151
  %cond.i.152 = select i1 %cmp.i.64.i.135, i32 %or4.i.142, i32 %or.i.141
  br label %cleanup

if.else.i.154:                                    ; preds = %if.end.i.149
  br i1 %cmp.i.i.129, label %if.then.15.i.158, label %cleanup

if.then.15.i.158:                                 ; preds = %if.else.i.154
  %13 = zext i1 %cmp.i.64.i.135 to i32
  %lnot.ext.i.155 = xor i32 %13, 1
  %or18.i.156 = or i32 %conv5.71.i.143, %lnot.ext.i.155
  %tobool19.i.157 = icmp eq i32 %or18.i.156, 0
  br i1 %tobool19.i.157, label %returnLargerSignificand.i.162, label %cleanup

returnLargerSignificand.i.162:                    ; preds = %if.then.15.i.158, %if.then.8.i.151
  %shl.i.159 = shl i32 %or.i.141, 1
  %shl22.i.160 = shl i32 %or4.i.142, 1
  %cmp.i.161 = icmp ult i32 %shl.i.159, %shl22.i.160
  br i1 %cmp.i.161, label %cleanup, label %if.end.25.i.164

if.end.25.i.164:                                  ; preds = %returnLargerSignificand.i.162
  %cmp28.i.163 = icmp ult i32 %shl22.i.160, %shl.i.159
  br i1 %cmp28.i.163, label %cleanup, label %if.end.31.i.167

if.end.31.i.167:                                  ; preds = %if.end.25.i.164
  %cmp32.i.165 = icmp ult i32 %or.i.141, %or4.i.142
  %cond37.i.166 = select i1 %cmp32.i.165, i32 %or.i.141, i32 %or4.i.142
  br label %cleanup

if.end.33:                                        ; preds = %if.then.29
  %conv34.103 = zext i8 %zSign to i32
  %xor = shl i32 %conv34.103, 31
  %add.i = add i32 %xor, -8388608
  br label %cleanup

if.end.37:                                        ; preds = %bExpBigger
  %cmp38 = icmp eq i32 %and.i.104, 0
  %or41 = or i32 %shl, 1073741824
  %aSig.0 = select i1 %cmp38, i32 %shl, i32 %or41
  %inc = zext i1 %cmp38 to i32
  %expDiff.0 = add nsw i32 %sub, %inc
  %sub43 = sub nsw i32 0, %expDiff.0
  %cmp.i.113 = icmp eq i32 %expDiff.0, 0
  br i1 %cmp.i.113, label %shift32RightJamming.exit127, label %if.else.i.115

if.else.i.115:                                    ; preds = %if.end.37
  %cmp1.i.114 = icmp sgt i32 %expDiff.0, -32
  br i1 %cmp1.i.114, label %if.then.2.i.122, label %if.else.4.i.125

if.then.2.i.122:                                  ; preds = %if.else.i.115
  %shr.i.116 = lshr i32 %aSig.0, %sub43
  %and.i.117 = and i32 %expDiff.0, 31
  %shl.i.118 = shl i32 %aSig.0, %and.i.117
  %cmp3.i.119 = icmp ne i32 %shl.i.118, 0
  %conv.i.120 = zext i1 %cmp3.i.119 to i32
  %or.i.121 = or i32 %conv.i.120, %shr.i.116
  br label %shift32RightJamming.exit127

if.else.4.i.125:                                  ; preds = %if.else.i.115
  %cmp5.i.123 = icmp ne i32 %aSig.0, 0
  %conv6.i.124 = zext i1 %cmp5.i.123 to i32
  br label %shift32RightJamming.exit127

shift32RightJamming.exit127:                      ; preds = %if.end.37, %if.then.2.i.122, %if.else.4.i.125
  %z.0.i.126 = phi i32 [ %or.i.121, %if.then.2.i.122 ], [ %conv6.i.124, %if.else.4.i.125 ], [ %aSig.0, %if.end.37 ]
  %or44 = or i32 %shl4, 1073741824
  br label %bBigger

bBigger:                                          ; preds = %if.end.19, %shift32RightJamming.exit127
  %aSig.1 = phi i32 [ %z.0.i.126, %shift32RightJamming.exit127 ], [ %shl, %if.end.19 ]
  %bSig.0 = phi i32 [ %or44, %shift32RightJamming.exit127 ], [ %shl4, %if.end.19 ]
  %bExp.1 = phi i32 [ %and.i.214, %shift32RightJamming.exit127 ], [ %bExp.0, %if.end.19 ]
  %sub45 = sub i32 %bSig.0, %aSig.1
  %conv46.102 = zext i8 %zSign to i32
  %xor47 = xor i32 %conv46.102, 1
  %conv48 = trunc i32 %xor47 to i8
  br label %normalizeRoundAndPack

aExpBigger:                                       ; preds = %entry
  %cmp49 = icmp eq i32 %and.i.104, 255
  br i1 %cmp49, label %if.then.51, label %if.end.56

if.then.51:                                       ; preds = %aExpBigger
  %tobool52 = icmp eq i32 %shl, 0
  br i1 %tobool52, label %cleanup, label %if.then.53

if.then.53:                                       ; preds = %if.then.51
  %14 = trunc i32 %a to i31
  %cmp.i.i.108 = icmp ugt i31 %14, -8388608
  %and.i.66.i = and i32 %a, 2143289344
  %cmp.i.67.i = icmp eq i32 %and.i.66.i, 2139095040
  %and1.i.68.i = and i32 %a, 4194303
  %tobool.i.69.i = icmp ne i32 %and1.i.68.i, 0
  %phitmp.i.70.i = zext i1 %tobool.i.69.i to i8
  %15 = select i1 %cmp.i.67.i, i8 %phitmp.i.70.i, i8 0
  %16 = trunc i32 %b to i31
  %cmp.i.64.i = icmp ugt i31 %16, -8388608
  %and.i.i = and i32 %b, 2143289344
  %cmp.i.63.i = icmp eq i32 %and.i.i, 2139095040
  %and1.i.i = and i32 %b, 4194303
  %tobool.i.i = icmp ne i32 %and1.i.i, 0
  %phitmp.i.i = zext i1 %tobool.i.i to i8
  %17 = select i1 %cmp.i.63.i, i8 %phitmp.i.i, i8 0
  %or.i.109 = or i32 %a, 4194304
  %or4.i = or i32 %b, 4194304
  %conv5.71.i = zext i8 %17 to i32
  %or662.i = or i8 %17, %15
  %tobool.i = icmp eq i8 %or662.i, 0
  br i1 %tobool.i, label %if.end.i, label %if.then.i

if.then.i:                                        ; preds = %if.then.53
  %18 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i = or i8 %18, 1
  store i8 %or3.i.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i

if.end.i:                                         ; preds = %if.then.i, %if.then.53
  %tobool7.i = icmp eq i8 %15, 0
  br i1 %tobool7.i, label %if.else.i.110, label %if.then.8.i

if.then.8.i:                                      ; preds = %if.end.i
  %tobool9.i = icmp eq i8 %17, 0
  br i1 %tobool9.i, label %if.end.11.i, label %returnLargerSignificand.i

if.end.11.i:                                      ; preds = %if.then.8.i
  %cond.i = select i1 %cmp.i.64.i, i32 %or4.i, i32 %or.i.109
  br label %cleanup

if.else.i.110:                                    ; preds = %if.end.i
  br i1 %cmp.i.i.108, label %if.then.15.i, label %cleanup

if.then.15.i:                                     ; preds = %if.else.i.110
  %19 = zext i1 %cmp.i.64.i to i32
  %lnot.ext.i = xor i32 %19, 1
  %or18.i = or i32 %conv5.71.i, %lnot.ext.i
  %tobool19.i = icmp eq i32 %or18.i, 0
  br i1 %tobool19.i, label %returnLargerSignificand.i, label %cleanup

returnLargerSignificand.i:                        ; preds = %if.then.15.i, %if.then.8.i
  %shl.i.111 = shl i32 %or.i.109, 1
  %shl22.i = shl i32 %or4.i, 1
  %cmp.i.112 = icmp ult i32 %shl.i.111, %shl22.i
  br i1 %cmp.i.112, label %cleanup, label %if.end.25.i

if.end.25.i:                                      ; preds = %returnLargerSignificand.i
  %cmp28.i = icmp ult i32 %shl22.i, %shl.i.111
  br i1 %cmp28.i, label %cleanup, label %if.end.31.i

if.end.31.i:                                      ; preds = %if.end.25.i
  %cmp32.i = icmp ult i32 %or.i.109, %or4.i
  %cond37.i = select i1 %cmp32.i, i32 %or.i.109, i32 %or4.i
  br label %cleanup

if.end.56:                                        ; preds = %aExpBigger
  %cmp57 = icmp eq i32 %and.i.214, 0
  br i1 %cmp57, label %if.end.62, label %if.end.62.thread

if.end.62.thread:                                 ; preds = %if.end.56
  %or61 = or i32 %shl4, 1073741824
  br label %if.else.i

if.end.62:                                        ; preds = %if.end.56
  %dec = add nsw i32 %sub, -1
  %cmp.i = icmp eq i32 %dec, 0
  br i1 %cmp.i, label %shift32RightJamming.exit, label %if.else.i

if.else.i:                                        ; preds = %if.end.62.thread, %if.end.62
  %expDiff.1233 = phi i32 [ %sub, %if.end.62.thread ], [ %dec, %if.end.62 ]
  %bSig.1232 = phi i32 [ %or61, %if.end.62.thread ], [ %shl4, %if.end.62 ]
  %cmp1.i = icmp slt i32 %expDiff.1233, 32
  br i1 %cmp1.i, label %if.then.2.i, label %if.else.4.i

if.then.2.i:                                      ; preds = %if.else.i
  %shr.i.105 = lshr i32 %bSig.1232, %expDiff.1233
  %sub.i = sub nsw i32 0, %expDiff.1233
  %and.i.106 = and i32 %sub.i, 31
  %shl.i.107 = shl i32 %bSig.1232, %and.i.106
  %cmp3.i = icmp ne i32 %shl.i.107, 0
  %conv.i = zext i1 %cmp3.i to i32
  %or.i = or i32 %conv.i, %shr.i.105
  br label %shift32RightJamming.exit

if.else.4.i:                                      ; preds = %if.else.i
  %cmp5.i = icmp ne i32 %bSig.1232, 0
  %conv6.i = zext i1 %cmp5.i to i32
  br label %shift32RightJamming.exit

shift32RightJamming.exit:                         ; preds = %if.end.62, %if.then.2.i, %if.else.4.i
  %z.0.i = phi i32 [ %or.i, %if.then.2.i ], [ %conv6.i, %if.else.4.i ], [ %shl4, %if.end.62 ]
  %or63 = or i32 %shl, 1073741824
  br label %aBigger

aBigger:                                          ; preds = %if.end.16, %shift32RightJamming.exit
  %aSig.2 = phi i32 [ %or63, %shift32RightJamming.exit ], [ %shl, %if.end.16 ]
  %bSig.2 = phi i32 [ %z.0.i, %shift32RightJamming.exit ], [ %shl4, %if.end.16 ]
  %aExp.1 = phi i32 [ %and.i.104, %shift32RightJamming.exit ], [ %aExp.0, %if.end.16 ]
  %sub64 = sub i32 %aSig.2, %bSig.2
  br label %normalizeRoundAndPack

normalizeRoundAndPack:                            ; preds = %aBigger, %bBigger
  %zSign.addr.0 = phi i8 [ %zSign, %aBigger ], [ %conv48, %bBigger ]
  %zExp.0 = phi i32 [ %aExp.1, %aBigger ], [ %bExp.1, %bBigger ]
  %zSig.0 = phi i32 [ %sub64, %aBigger ], [ %sub45, %bBigger ]
  %dec65 = add nsw i32 %zExp.0, -1
  %cmp.i.i = icmp ult i32 %zSig.0, 65536
  %shl.i.i = shl i32 %zSig.0, 16
  %shl.a.i.i = select i1 %cmp.i.i, i32 %shl.i.i, i32 %zSig.0
  %..i.i = select i1 %cmp.i.i, i8 16, i8 0
  %cmp2.i.i = icmp ult i32 %shl.a.i.i, 16777216
  br i1 %cmp2.i.i, label %if.then.4.i.i, label %normalizeRoundAndPackFloat32.exit

if.then.4.i.i:                                    ; preds = %normalizeRoundAndPack
  %conv5.23.i.i = zext i8 %..i.i to i32
  %add6.i.i = or i32 %conv5.23.i.i, 8
  %conv7.i.i = trunc i32 %add6.i.i to i8
  %shl8.i.i = shl i32 %shl.a.i.i, 8
  br label %normalizeRoundAndPackFloat32.exit

normalizeRoundAndPackFloat32.exit:                ; preds = %normalizeRoundAndPack, %if.then.4.i.i
  %a.addr.1.i.i = phi i32 [ %shl8.i.i, %if.then.4.i.i ], [ %shl.a.i.i, %normalizeRoundAndPack ]
  %shiftCount.1.i.i = phi i8 [ %conv7.i.i, %if.then.4.i.i ], [ %..i.i, %normalizeRoundAndPack ]
  %shr.i.i = lshr i32 %a.addr.1.i.i, 24
  %idxprom.i.i = zext i32 %shr.i.i to i64
  %arrayidx.i.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i
  %20 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !5
  %conv10.22.i.i = zext i8 %20 to i32
  %conv11.21.i.i = zext i8 %shiftCount.1.i.i to i32
  %add12.i.i = add nuw nsw i32 %conv10.22.i.i, %conv11.21.i.i
  %conv.8.i = shl i32 %add12.i.i, 24
  %sext.i = add i32 %conv.8.i, -16777216
  %conv2.i = ashr exact i32 %sext.i, 24
  %sub3.i = sub nsw i32 %dec65, %conv2.i
  %shl.i = shl i32 %zSig.0, %conv2.i
  %call5.i = tail call fastcc zeroext i32 @roundAndPackFloat32(i8 signext %zSign.addr.0, i32 signext %sub3.i, i32 zeroext %shl.i) #4
  br label %cleanup

cleanup:                                          ; preds = %if.end.31.i, %if.end.25.i, %returnLargerSignificand.i, %if.then.15.i, %if.else.i.110, %if.end.11.i, %if.end.31.i.167, %if.end.25.i.164, %returnLargerSignificand.i.162, %if.then.15.i.158, %if.else.i.154, %if.end.11.i.153, %if.end.31.i.210, %if.end.25.i.207, %returnLargerSignificand.i.205, %if.then.15.i.201, %if.else.i.197, %if.end.11.i.196, %if.then.51, %normalizeRoundAndPackFloat32.exit, %if.end.33, %if.end.22, %if.end.12
  %retval.0 = phi i32 [ %call5.i, %normalizeRoundAndPackFloat32.exit ], [ %add.i, %if.end.33 ], [ -4194304, %if.end.12 ], [ %shl.i.171, %if.end.22 ], [ %a, %if.then.51 ], [ %cond37.i.209, %if.end.31.i.210 ], [ %cond.i.195, %if.end.11.i.196 ], [ %or.i.184, %if.then.15.i.201 ], [ %or4.i.185, %returnLargerSignificand.i.205 ], [ %or.i.184, %if.end.25.i.207 ], [ %or4.i.185, %if.else.i.197 ], [ %cond37.i.166, %if.end.31.i.167 ], [ %cond.i.152, %if.end.11.i.153 ], [ %or.i.141, %if.then.15.i.158 ], [ %or4.i.142, %returnLargerSignificand.i.162 ], [ %or.i.141, %if.end.25.i.164 ], [ %or4.i.142, %if.else.i.154 ], [ %cond37.i, %if.end.31.i ], [ %cond.i, %if.end.11.i ], [ %or.i.109, %if.then.15.i ], [ %or4.i, %returnLargerSignificand.i ], [ %or.i.109, %if.end.25.i ], [ %or4.i, %if.else.i.110 ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define zeroext i32 @float32_sub(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %shr.i = lshr i32 %a, 31
  %conv.i = trunc i32 %shr.i to i8
  %shr.i.10 = lshr i32 %b, 31
  %conv.i.11 = trunc i32 %shr.i.10 to i8
  %cmp = icmp eq i8 %conv.i, %conv.i.11
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %call4 = tail call fastcc zeroext i32 @subFloat32Sigs(i32 zeroext %a, i32 zeroext %b, i8 signext %conv.i)
  br label %cleanup

if.else:                                          ; preds = %entry
  %call5 = tail call fastcc zeroext i32 @addFloat32Sigs(i32 zeroext %a, i32 zeroext %b, i8 signext %conv.i)
  br label %cleanup

cleanup:                                          ; preds = %if.else, %if.then
  %retval.0 = phi i32 [ %call4, %if.then ], [ %call5, %if.else ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define zeroext i32 @float32_mul(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 8388607
  %shr.i = lshr i32 %a, 23
  %and.i.89 = and i32 %shr.i, 255
  %and.i.173 = and i32 %b, 8388607
  %shr.i.171 = lshr i32 %b, 23
  %and.i.172 = and i32 %shr.i.171, 255
  %shr.i.174194 = xor i32 %b, %a
  %xor88193 = lshr i32 %shr.i.174194, 31
  %xor88 = trunc i32 %xor88193 to i8
  %cmp = icmp eq i32 %and.i.89, 255
  br i1 %cmp, label %if.then, label %if.end.19

if.then:                                          ; preds = %entry
  %tobool = icmp eq i32 %and.i, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then.12

lor.lhs.false:                                    ; preds = %if.then
  %cmp9 = icmp eq i32 %and.i.172, 255
  %tobool11 = icmp ne i32 %and.i.173, 0
  %or.cond = and i1 %tobool11, %cmp9
  br i1 %or.cond, label %if.then.12, label %if.end

if.then.12:                                       ; preds = %if.then, %lor.lhs.false
  %0 = trunc i32 %a to i31
  %cmp.i.i.129 = icmp ugt i31 %0, -8388608
  %and.i.66.i.130 = and i32 %a, 2143289344
  %cmp.i.67.i.131 = icmp eq i32 %and.i.66.i.130, 2139095040
  %and1.i.68.i.132 = and i32 %a, 4194303
  %tobool.i.69.i.133 = icmp ne i32 %and1.i.68.i.132, 0
  %phitmp.i.70.i.134 = zext i1 %tobool.i.69.i.133 to i8
  %1 = select i1 %cmp.i.67.i.131, i8 %phitmp.i.70.i.134, i8 0
  %2 = trunc i32 %b to i31
  %cmp.i.64.i.135 = icmp ugt i31 %2, -8388608
  %and.i.i.136 = and i32 %b, 2143289344
  %cmp.i.63.i.137 = icmp eq i32 %and.i.i.136, 2139095040
  %and1.i.i.138 = and i32 %b, 4194303
  %tobool.i.i.139 = icmp ne i32 %and1.i.i.138, 0
  %phitmp.i.i.140 = zext i1 %tobool.i.i.139 to i8
  %3 = select i1 %cmp.i.63.i.137, i8 %phitmp.i.i.140, i8 0
  %or.i.141 = or i32 %a, 4194304
  %or4.i.142 = or i32 %b, 4194304
  %conv5.71.i.143 = zext i8 %3 to i32
  %or662.i.144 = or i8 %3, %1
  %tobool.i.145 = icmp eq i8 %or662.i.144, 0
  br i1 %tobool.i.145, label %if.end.i.149, label %if.then.i.147

if.then.i.147:                                    ; preds = %if.then.12
  %4 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i.146 = or i8 %4, 1
  store i8 %or3.i.i.146, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i.149

if.end.i.149:                                     ; preds = %if.then.i.147, %if.then.12
  %tobool7.i.148 = icmp eq i8 %1, 0
  br i1 %tobool7.i.148, label %if.else.i.154, label %if.then.8.i.151

if.then.8.i.151:                                  ; preds = %if.end.i.149
  %tobool9.i.150 = icmp eq i8 %3, 0
  br i1 %tobool9.i.150, label %if.end.11.i.153, label %returnLargerSignificand.i.162

if.end.11.i.153:                                  ; preds = %if.then.8.i.151
  %cond.i.152 = select i1 %cmp.i.64.i.135, i32 %or4.i.142, i32 %or.i.141
  br label %cleanup

if.else.i.154:                                    ; preds = %if.end.i.149
  br i1 %cmp.i.i.129, label %if.then.15.i.158, label %cleanup

if.then.15.i.158:                                 ; preds = %if.else.i.154
  %5 = zext i1 %cmp.i.64.i.135 to i32
  %lnot.ext.i.155 = xor i32 %5, 1
  %or18.i.156 = or i32 %conv5.71.i.143, %lnot.ext.i.155
  %tobool19.i.157 = icmp eq i32 %or18.i.156, 0
  br i1 %tobool19.i.157, label %returnLargerSignificand.i.162, label %cleanup

returnLargerSignificand.i.162:                    ; preds = %if.then.15.i.158, %if.then.8.i.151
  %shl.i.159 = shl i32 %or.i.141, 1
  %shl22.i.160 = shl i32 %or4.i.142, 1
  %cmp.i.161 = icmp ult i32 %shl.i.159, %shl22.i.160
  br i1 %cmp.i.161, label %cleanup, label %if.end.25.i.164

if.end.25.i.164:                                  ; preds = %returnLargerSignificand.i.162
  %cmp28.i.163 = icmp ult i32 %shl22.i.160, %shl.i.159
  br i1 %cmp28.i.163, label %cleanup, label %if.end.31.i.167

if.end.31.i.167:                                  ; preds = %if.end.25.i.164
  %cmp32.i.165 = icmp ult i32 %or.i.141, %or4.i.142
  %cond37.i.166 = select i1 %cmp32.i.165, i32 %or.i.141, i32 %or4.i.142
  br label %cleanup

if.end:                                           ; preds = %lor.lhs.false
  %or = or i32 %and.i.172, %and.i.173
  %cmp14 = icmp eq i32 %or, 0
  br i1 %cmp14, label %if.then.16, label %if.end.17

if.then.16:                                       ; preds = %if.end
  %6 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.128 = or i8 %6, 1
  store i8 %or3.i.128, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.17:                                        ; preds = %if.end
  %shl.i.126 = shl nuw i32 %xor88193, 31
  %add.i.127 = or i32 %shl.i.126, 2139095040
  br label %cleanup

if.end.19:                                        ; preds = %entry
  %cmp20 = icmp eq i32 %and.i.172, 255
  br i1 %cmp20, label %if.then.22, label %if.end.33

if.then.22:                                       ; preds = %if.end.19
  %tobool23 = icmp eq i32 %and.i.173, 0
  br i1 %tobool23, label %if.end.26, label %if.then.24

if.then.24:                                       ; preds = %if.then.22
  %7 = trunc i32 %a to i31
  %cmp.i.i.122 = icmp ugt i31 %7, -8388608
  %and.i.66.i = and i32 %a, 2143289344
  %cmp.i.67.i = icmp eq i32 %and.i.66.i, 2139095040
  %and1.i.68.i = and i32 %a, 4194303
  %tobool.i.69.i = icmp ne i32 %and1.i.68.i, 0
  %phitmp.i.70.i = zext i1 %tobool.i.69.i to i8
  %8 = select i1 %cmp.i.67.i, i8 %phitmp.i.70.i, i8 0
  %9 = trunc i32 %b to i31
  %cmp.i.64.i = icmp ugt i31 %9, -8388608
  %and.i.i = and i32 %b, 2143289344
  %cmp.i.63.i = icmp eq i32 %and.i.i, 2139095040
  %and1.i.i = and i32 %b, 4194303
  %tobool.i.i = icmp ne i32 %and1.i.i, 0
  %phitmp.i.i = zext i1 %tobool.i.i to i8
  %10 = select i1 %cmp.i.63.i, i8 %phitmp.i.i, i8 0
  %or.i = or i32 %a, 4194304
  %or4.i = or i32 %b, 4194304
  %conv5.71.i = zext i8 %10 to i32
  %or662.i = or i8 %10, %8
  %tobool.i = icmp eq i8 %or662.i, 0
  br i1 %tobool.i, label %if.end.i, label %if.then.i

if.then.i:                                        ; preds = %if.then.24
  %11 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i = or i8 %11, 1
  store i8 %or3.i.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i

if.end.i:                                         ; preds = %if.then.i, %if.then.24
  %tobool7.i = icmp eq i8 %8, 0
  br i1 %tobool7.i, label %if.else.i, label %if.then.8.i

if.then.8.i:                                      ; preds = %if.end.i
  %tobool9.i = icmp eq i8 %10, 0
  br i1 %tobool9.i, label %if.end.11.i, label %returnLargerSignificand.i

if.end.11.i:                                      ; preds = %if.then.8.i
  %cond.i = select i1 %cmp.i.64.i, i32 %or4.i, i32 %or.i
  br label %cleanup

if.else.i:                                        ; preds = %if.end.i
  br i1 %cmp.i.i.122, label %if.then.15.i, label %cleanup

if.then.15.i:                                     ; preds = %if.else.i
  %12 = zext i1 %cmp.i.64.i to i32
  %lnot.ext.i = xor i32 %12, 1
  %or18.i = or i32 %conv5.71.i, %lnot.ext.i
  %tobool19.i = icmp eq i32 %or18.i, 0
  br i1 %tobool19.i, label %returnLargerSignificand.i, label %cleanup

returnLargerSignificand.i:                        ; preds = %if.then.15.i, %if.then.8.i
  %shl.i.123 = shl i32 %or.i, 1
  %shl22.i = shl i32 %or4.i, 1
  %cmp.i.124 = icmp ult i32 %shl.i.123, %shl22.i
  br i1 %cmp.i.124, label %cleanup, label %if.end.25.i

if.end.25.i:                                      ; preds = %returnLargerSignificand.i
  %cmp28.i = icmp ult i32 %shl22.i, %shl.i.123
  br i1 %cmp28.i, label %cleanup, label %if.end.31.i

if.end.31.i:                                      ; preds = %if.end.25.i
  %cmp32.i = icmp ult i32 %or.i, %or4.i
  %cond37.i = select i1 %cmp32.i, i32 %or.i, i32 %or4.i
  br label %cleanup

if.end.26:                                        ; preds = %if.then.22
  %or27 = or i32 %and.i.89, %and.i
  %cmp28 = icmp eq i32 %or27, 0
  br i1 %cmp28, label %if.then.30, label %if.end.31

if.then.30:                                       ; preds = %if.end.26
  %13 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %13, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.31:                                        ; preds = %if.end.26
  %shl.i.120 = shl nuw i32 %xor88193, 31
  %add.i.121 = or i32 %shl.i.120, 2139095040
  br label %cleanup

if.end.33:                                        ; preds = %if.end.19
  %cmp34 = icmp eq i32 %and.i.89, 0
  br i1 %cmp34, label %if.then.36, label %if.end.42

if.then.36:                                       ; preds = %if.end.33
  %cmp37 = icmp eq i32 %and.i, 0
  br i1 %cmp37, label %if.then.39, label %if.end.41

if.then.39:                                       ; preds = %if.then.36
  %shl.i.118 = shl nuw i32 %xor88193, 31
  br label %cleanup

if.end.41:                                        ; preds = %if.then.36
  %cmp.i.i.93 = icmp ult i32 %and.i, 65536
  %shl.i.i.94 = shl i32 %a, 16
  %shl.a.i.i.95 = select i1 %cmp.i.i.93, i32 %shl.i.i.94, i32 %and.i
  %..i.i.96 = select i1 %cmp.i.i.93, i8 16, i8 0
  %cmp2.i.i.97 = icmp ult i32 %shl.a.i.i.95, 16777216
  br i1 %cmp2.i.i.97, label %if.then.4.i.i.102, label %normalizeFloat32Subnormal.exit116

if.then.4.i.i.102:                                ; preds = %if.end.41
  %conv5.23.i.i.98 = zext i8 %..i.i.96 to i32
  %add6.i.i.99 = or i32 %conv5.23.i.i.98, 8
  %conv7.i.i.100 = trunc i32 %add6.i.i.99 to i8
  %shl8.i.i.101 = shl i32 %shl.a.i.i.95, 8
  br label %normalizeFloat32Subnormal.exit116

normalizeFloat32Subnormal.exit116:                ; preds = %if.end.41, %if.then.4.i.i.102
  %a.addr.1.i.i.103 = phi i32 [ %shl8.i.i.101, %if.then.4.i.i.102 ], [ %shl.a.i.i.95, %if.end.41 ]
  %shiftCount.1.i.i.104 = phi i8 [ %conv7.i.i.100, %if.then.4.i.i.102 ], [ %..i.i.96, %if.end.41 ]
  %shr.i.i.105 = lshr i32 %a.addr.1.i.i.103, 24
  %idxprom.i.i.106 = zext i32 %shr.i.i.105 to i64
  %arrayidx.i.i.107 = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i.106
  %14 = load i8, i8* %arrayidx.i.i.107, align 1, !tbaa !5
  %conv10.22.i.i.108 = zext i8 %14 to i32
  %conv11.21.i.i.109 = zext i8 %shiftCount.1.i.i.104 to i32
  %add12.i.i.110 = add nuw nsw i32 %conv10.22.i.i.108, %conv11.21.i.i.109
  %conv.7.i.111 = shl i32 %add12.i.i.110, 24
  %sext.i.112 = add i32 %conv.7.i.111, -134217728
  %conv2.i.113 = ashr exact i32 %sext.i.112, 24
  %shl.i.114 = shl i32 %and.i, %conv2.i.113
  %sub4.i.115 = sub nsw i32 1, %conv2.i.113
  br label %if.end.42

if.end.42:                                        ; preds = %normalizeFloat32Subnormal.exit116, %if.end.33
  %aSig.0 = phi i32 [ %shl.i.114, %normalizeFloat32Subnormal.exit116 ], [ %and.i, %if.end.33 ]
  %aExp.0 = phi i32 [ %sub4.i.115, %normalizeFloat32Subnormal.exit116 ], [ %and.i.89, %if.end.33 ]
  %cmp43 = icmp eq i32 %and.i.172, 0
  br i1 %cmp43, label %if.then.45, label %if.end.51

if.then.45:                                       ; preds = %if.end.42
  %cmp46 = icmp eq i32 %and.i.173, 0
  br i1 %cmp46, label %if.then.48, label %if.end.50

if.then.48:                                       ; preds = %if.then.45
  %shl.i.92 = shl nuw i32 %xor88193, 31
  br label %cleanup

if.end.50:                                        ; preds = %if.then.45
  %cmp.i.i = icmp ult i32 %and.i.173, 65536
  %shl.i.i = shl i32 %b, 16
  %shl.a.i.i = select i1 %cmp.i.i, i32 %shl.i.i, i32 %and.i.173
  %..i.i = select i1 %cmp.i.i, i8 16, i8 0
  %cmp2.i.i = icmp ult i32 %shl.a.i.i, 16777216
  br i1 %cmp2.i.i, label %if.then.4.i.i, label %normalizeFloat32Subnormal.exit

if.then.4.i.i:                                    ; preds = %if.end.50
  %conv5.23.i.i = zext i8 %..i.i to i32
  %add6.i.i = or i32 %conv5.23.i.i, 8
  %conv7.i.i = trunc i32 %add6.i.i to i8
  %shl8.i.i = shl i32 %shl.a.i.i, 8
  br label %normalizeFloat32Subnormal.exit

normalizeFloat32Subnormal.exit:                   ; preds = %if.end.50, %if.then.4.i.i
  %a.addr.1.i.i = phi i32 [ %shl8.i.i, %if.then.4.i.i ], [ %shl.a.i.i, %if.end.50 ]
  %shiftCount.1.i.i = phi i8 [ %conv7.i.i, %if.then.4.i.i ], [ %..i.i, %if.end.50 ]
  %shr.i.i = lshr i32 %a.addr.1.i.i, 24
  %idxprom.i.i = zext i32 %shr.i.i to i64
  %arrayidx.i.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i
  %15 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !5
  %conv10.22.i.i = zext i8 %15 to i32
  %conv11.21.i.i = zext i8 %shiftCount.1.i.i to i32
  %add12.i.i = add nuw nsw i32 %conv10.22.i.i, %conv11.21.i.i
  %conv.7.i = shl i32 %add12.i.i, 24
  %sext.i = add i32 %conv.7.i, -134217728
  %conv2.i = ashr exact i32 %sext.i, 24
  %shl.i.91 = shl i32 %and.i.173, %conv2.i
  %sub4.i = sub nsw i32 1, %conv2.i
  br label %if.end.51

if.end.51:                                        ; preds = %normalizeFloat32Subnormal.exit, %if.end.42
  %bExp.0 = phi i32 [ %sub4.i, %normalizeFloat32Subnormal.exit ], [ %and.i.172, %if.end.42 ]
  %bSig.0 = phi i32 [ %shl.i.91, %normalizeFloat32Subnormal.exit ], [ %and.i.173, %if.end.42 ]
  %add = add nsw i32 %bExp.0, %aExp.0
  %or52 = shl i32 %aSig.0, 7
  %or53 = shl i32 %bSig.0, 8
  %16 = lshr i32 %aSig.0, 9
  %shl = and i32 %16, 49151
  %shr.i.90 = or i32 %shl, 16384
  %17 = lshr i32 %bSig.0, 8
  %shl54 = and i32 %17, 32767
  %shr3.i = or i32 %shl54, 32768
  %conv5.i = and i32 %or52, 65408
  %conv6.i = and i32 %or53, 65280
  %mul.i = mul nuw i32 %conv6.i, %conv5.i
  %mul9.i = mul nuw i32 %shr3.i, %conv5.i
  %mul12.i = mul nuw i32 %conv6.i, %shr.i.90
  %mul15.i = mul nuw i32 %shr3.i, %shr.i.90
  %add.i = add i32 %mul9.i, %mul12.i
  %cmp.i = icmp ult i32 %add.i, %mul12.i
  %conv16.i = zext i1 %cmp.i to i32
  %shl.i = shl nuw nsw i32 %conv16.i, 16
  %shr17.i = lshr i32 %add.i, 16
  %add18.i = or i32 %shl.i, %shr17.i
  %add19.i = add i32 %add18.i, %mul15.i
  %shl20.i = shl i32 %add.i, 16
  %add21.i = add i32 %shl20.i, %mul.i
  %cmp22.i = icmp ult i32 %add21.i, %shl20.i
  %conv23.i = zext i1 %cmp22.i to i32
  %add24.i = add i32 %add19.i, %conv23.i
  %cmp55 = icmp ne i32 %add21.i, 0
  %conv56 = zext i1 %cmp55 to i32
  %or57 = or i32 %add24.i, %conv56
  %shl58 = shl i32 %or57, 1
  %cmp59 = icmp sgt i32 %shl58, -1
  %shl58.or57 = select i1 %cmp59, i32 %shl58, i32 %or57
  %18 = lshr i32 %add24.i, 30
  %19 = and i32 %18, 1
  %20 = or i32 %19, -128
  %dec.sub = add nsw i32 %add, %20
  %call64 = tail call fastcc zeroext i32 @roundAndPackFloat32(i8 signext %xor88, i32 signext %dec.sub, i32 zeroext %shl58.or57)
  br label %cleanup

cleanup:                                          ; preds = %if.end.31.i, %if.end.25.i, %returnLargerSignificand.i, %if.then.15.i, %if.else.i, %if.end.11.i, %if.end.31.i.167, %if.end.25.i.164, %returnLargerSignificand.i.162, %if.then.15.i.158, %if.else.i.154, %if.end.11.i.153, %if.end.51, %if.then.48, %if.then.39, %if.end.31, %if.then.30, %if.end.17, %if.then.16
  %retval.0 = phi i32 [ -4194304, %if.then.16 ], [ %add.i.127, %if.end.17 ], [ -4194304, %if.then.30 ], [ %add.i.121, %if.end.31 ], [ %shl.i.118, %if.then.39 ], [ %shl.i.92, %if.then.48 ], [ %call64, %if.end.51 ], [ %cond37.i.166, %if.end.31.i.167 ], [ %cond.i.152, %if.end.11.i.153 ], [ %or.i.141, %if.then.15.i.158 ], [ %or4.i.142, %returnLargerSignificand.i.162 ], [ %or.i.141, %if.end.25.i.164 ], [ %or4.i.142, %if.else.i.154 ], [ %cond37.i, %if.end.31.i ], [ %cond.i, %if.end.11.i ], [ %or.i, %if.then.15.i ], [ %or4.i, %returnLargerSignificand.i ], [ %or.i, %if.end.25.i ], [ %or4.i, %if.else.i ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define internal fastcc zeroext i32 @roundAndPackFloat32(i8 signext %zSign, i32 signext %zExp, i32 zeroext %zSig) #2 {
entry:
  %0 = load i8, i8* @float_rounding_mode, align 1, !tbaa !5
  %cmp = icmp eq i8 %0, 0
  br i1 %cmp, label %if.end.21, label %if.then

if.then:                                          ; preds = %entry
  %cmp4 = icmp eq i8 %0, 3
  br i1 %cmp4, label %if.end.21, label %if.else

if.else:                                          ; preds = %if.then
  %tobool7 = icmp eq i8 %zSign, 0
  br i1 %tobool7, label %if.else.13, label %if.then.8

if.then.8:                                        ; preds = %if.else
  %cmp10 = icmp eq i8 %0, 2
  %. = select i1 %cmp10, i8 0, i8 127
  br label %if.end.21

if.else.13:                                       ; preds = %if.else
  %cmp15 = icmp eq i8 %0, 1
  %.111 = select i1 %cmp15, i8 0, i8 127
  br label %if.end.21

if.end.21:                                        ; preds = %if.else.13, %if.then.8, %if.then, %entry
  %roundIncrement.0 = phi i8 [ 64, %entry ], [ 0, %if.then ], [ %., %if.then.8 ], [ %.111, %if.else.13 ]
  %and = and i32 %zSig, 127
  %conv22 = trunc i32 %and to i8
  %conv24 = and i32 %zExp, 65535
  %cmp25 = icmp ugt i32 %conv24, 252
  br i1 %cmp25, label %if.then.27, label %if.end.65

if.then.27:                                       ; preds = %if.end.21
  %cmp28 = icmp sgt i32 %zExp, 253
  br i1 %cmp28, label %if.then.35, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.then.27
  %cmp30 = icmp eq i32 %zExp, 253
  br i1 %cmp30, label %land.lhs.true, label %if.end.39

land.lhs.true:                                    ; preds = %lor.lhs.false
  %conv32.109 = zext i8 %roundIncrement.0 to i32
  %add = add i32 %conv32.109, %zSig
  %cmp33 = icmp slt i32 %add, 0
  br i1 %cmp33, label %if.then.35, label %if.end.65

if.then.35:                                       ; preds = %land.lhs.true, %if.then.27
  %1 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %1, 40
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  %conv.3.i.115 = zext i8 %zSign to i32
  %shl.i.116 = shl i32 %conv.3.i.115, 31
  %add.i.117 = or i32 %shl.i.116, 2139095040
  %cmp37 = icmp eq i8 %roundIncrement.0, 0
  %conv38 = zext i1 %cmp37 to i32
  %sub = sub i32 %add.i.117, %conv38
  br label %cleanup

if.end.39:                                        ; preds = %lor.lhs.false
  %cmp40 = icmp slt i32 %zExp, 0
  br i1 %cmp40, label %if.then.42, label %if.end.65

if.then.42:                                       ; preds = %if.end.39
  %2 = load i8, i8* @float_detect_tininess, align 1, !tbaa !5
  %cmp44 = icmp eq i8 %2, 1
  %cmp47 = icmp slt i32 %zExp, -1
  %or.cond = or i1 %cmp47, %cmp44
  br i1 %or.cond, label %if.else.i, label %lor.rhs

lor.rhs:                                          ; preds = %if.then.42
  %conv49.107 = zext i8 %roundIncrement.0 to i32
  %add50 = add i32 %conv49.107, %zSig
  %phitmp124 = icmp slt i32 %add50, 0
  br label %if.else.i

if.else.i:                                        ; preds = %if.then.42, %lor.rhs
  %3 = phi i1 [ false, %if.then.42 ], [ %phitmp124, %lor.rhs ]
  %cmp1.i = icmp sgt i32 %zExp, -32
  br i1 %cmp1.i, label %if.then.2.i, label %if.else.4.i

if.then.2.i:                                      ; preds = %if.else.i
  %sub54 = sub nsw i32 0, %zExp
  %shr.i = lshr i32 %zSig, %sub54
  %and.i = and i32 %zExp, 31
  %shl.i.114 = shl i32 %zSig, %and.i
  %cmp3.i = icmp ne i32 %shl.i.114, 0
  %conv.i = zext i1 %cmp3.i to i32
  %or.i = or i32 %conv.i, %shr.i
  br label %shift32RightJamming.exit

if.else.4.i:                                      ; preds = %if.else.i
  %cmp5.i = icmp ne i32 %zSig, 0
  %conv6.i = zext i1 %cmp5.i to i32
  br label %shift32RightJamming.exit

shift32RightJamming.exit:                         ; preds = %if.then.2.i, %if.else.4.i
  %z.0.i = phi i32 [ %or.i, %if.then.2.i ], [ %conv6.i, %if.else.4.i ]
  %and55 = and i32 %z.0.i, 127
  %conv56 = trunc i32 %and55 to i8
  %tobool61 = icmp eq i32 %and55, 0
  %or.cond112 = or i1 %3, %tobool61
  br i1 %or.cond112, label %if.end.65, label %if.then.62

if.then.62:                                       ; preds = %shift32RightJamming.exit
  %4 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.113 = or i8 %4, 16
  store i8 %or3.i.113, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.65

if.end.65:                                        ; preds = %land.lhs.true, %shift32RightJamming.exit, %if.end.39, %if.then.62, %if.end.21
  %zSig.addr.0 = phi i32 [ %z.0.i, %shift32RightJamming.exit ], [ %z.0.i, %if.then.62 ], [ %zSig, %if.end.39 ], [ %zSig, %if.end.21 ], [ %zSig, %land.lhs.true ]
  %zExp.addr.0 = phi i32 [ 0, %shift32RightJamming.exit ], [ 0, %if.then.62 ], [ %zExp, %if.end.39 ], [ %zExp, %if.end.21 ], [ 253, %land.lhs.true ]
  %roundBits.0 = phi i8 [ %conv56, %shift32RightJamming.exit ], [ %conv56, %if.then.62 ], [ %conv22, %if.end.39 ], [ %conv22, %if.end.21 ], [ %conv22, %land.lhs.true ]
  %tobool66 = icmp eq i8 %roundBits.0, 0
  br i1 %tobool66, label %if.end.70, label %if.then.67

if.then.67:                                       ; preds = %if.end.65
  %5 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv68.106 = zext i8 %5 to i32
  %or = or i32 %conv68.106, 32
  %conv69 = trunc i32 %or to i8
  store i8 %conv69, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.70

if.end.70:                                        ; preds = %if.end.65, %if.then.67
  %conv71.104 = zext i8 %roundIncrement.0 to i32
  %add72 = add i32 %zSig.addr.0, %conv71.104
  %shr = lshr i32 %add72, 7
  %cmp74 = icmp eq i8 %roundBits.0, 64
  %and77105 = and i1 %cmp, %cmp74
  %and77 = zext i1 %and77105 to i32
  %neg = xor i32 %and77, -1
  %and78 = and i32 %shr, %neg
  %cmp79 = icmp eq i32 %and78, 0
  %conv.3.i = zext i8 %zSign to i32
  %shl.i = shl i32 %conv.3.i, 31
  %zExp.addr.0.op = shl i32 %zExp.addr.0, 23
  %shl1.i = select i1 %cmp79, i32 0, i32 %zExp.addr.0.op
  %add.i = or i32 %and78, %shl.i
  %add2.i = add i32 %add.i, %shl1.i
  br label %cleanup

cleanup:                                          ; preds = %if.end.70, %if.then.35
  %retval.0 = phi i32 [ %sub, %if.then.35 ], [ %add2.i, %if.end.70 ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define zeroext i32 @float32_div(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 8388607
  %shr.i = lshr i32 %a, 23
  %and.i.105 = and i32 %shr.i, 255
  %and.i.243 = and i32 %b, 8388607
  %shr.i.241 = lshr i32 %b, 23
  %and.i.242 = and i32 %shr.i.241, 255
  %shr.i.244273 = xor i32 %b, %a
  %xor104272 = lshr i32 %shr.i.244273, 31
  %xor104 = trunc i32 %xor104272 to i8
  %cmp = icmp eq i32 %and.i.105, 255
  br i1 %cmp, label %if.then, label %if.end.20

if.then:                                          ; preds = %entry
  %tobool = icmp eq i32 %and.i, 0
  br i1 %tobool, label %if.end, label %if.then.9

if.then.9:                                        ; preds = %if.then
  %0 = trunc i32 %a to i31
  %cmp.i.i.198 = icmp ugt i31 %0, -8388608
  %and.i.66.i.199 = and i32 %a, 2143289344
  %cmp.i.67.i.200 = icmp eq i32 %and.i.66.i.199, 2139095040
  %and1.i.68.i.201 = and i32 %a, 4194303
  %tobool.i.69.i.202 = icmp ne i32 %and1.i.68.i.201, 0
  %phitmp.i.70.i.203 = zext i1 %tobool.i.69.i.202 to i8
  %1 = select i1 %cmp.i.67.i.200, i8 %phitmp.i.70.i.203, i8 0
  %2 = trunc i32 %b to i31
  %cmp.i.64.i.204 = icmp ugt i31 %2, -8388608
  %and.i.i.205 = and i32 %b, 2143289344
  %cmp.i.63.i.206 = icmp eq i32 %and.i.i.205, 2139095040
  %and1.i.i.207 = and i32 %b, 4194303
  %tobool.i.i.208 = icmp ne i32 %and1.i.i.207, 0
  %phitmp.i.i.209 = zext i1 %tobool.i.i.208 to i8
  %3 = select i1 %cmp.i.63.i.206, i8 %phitmp.i.i.209, i8 0
  %or.i.210 = or i32 %a, 4194304
  %or4.i.211 = or i32 %b, 4194304
  %conv5.71.i.212 = zext i8 %3 to i32
  %or662.i.213 = or i8 %3, %1
  %tobool.i.214 = icmp eq i8 %or662.i.213, 0
  br i1 %tobool.i.214, label %if.end.i.218, label %if.then.i.216

if.then.i.216:                                    ; preds = %if.then.9
  %4 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i.215 = or i8 %4, 1
  store i8 %or3.i.i.215, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i.218

if.end.i.218:                                     ; preds = %if.then.i.216, %if.then.9
  %tobool7.i.217 = icmp eq i8 %1, 0
  br i1 %tobool7.i.217, label %if.else.i.223, label %if.then.8.i.220

if.then.8.i.220:                                  ; preds = %if.end.i.218
  %tobool9.i.219 = icmp eq i8 %3, 0
  br i1 %tobool9.i.219, label %if.end.11.i.222, label %returnLargerSignificand.i.231

if.end.11.i.222:                                  ; preds = %if.then.8.i.220
  %cond.i.221 = select i1 %cmp.i.64.i.204, i32 %or4.i.211, i32 %or.i.210
  br label %cleanup

if.else.i.223:                                    ; preds = %if.end.i.218
  br i1 %cmp.i.i.198, label %if.then.15.i.227, label %cleanup

if.then.15.i.227:                                 ; preds = %if.else.i.223
  %5 = zext i1 %cmp.i.64.i.204 to i32
  %lnot.ext.i.224 = xor i32 %5, 1
  %or18.i.225 = or i32 %conv5.71.i.212, %lnot.ext.i.224
  %tobool19.i.226 = icmp eq i32 %or18.i.225, 0
  br i1 %tobool19.i.226, label %returnLargerSignificand.i.231, label %cleanup

returnLargerSignificand.i.231:                    ; preds = %if.then.15.i.227, %if.then.8.i.220
  %shl.i.228 = shl i32 %or.i.210, 1
  %shl22.i.229 = shl i32 %or4.i.211, 1
  %cmp.i.230 = icmp ult i32 %shl.i.228, %shl22.i.229
  br i1 %cmp.i.230, label %cleanup, label %if.end.25.i.233

if.end.25.i.233:                                  ; preds = %returnLargerSignificand.i.231
  %cmp28.i.232 = icmp ult i32 %shl22.i.229, %shl.i.228
  br i1 %cmp28.i.232, label %cleanup, label %if.end.31.i.236

if.end.31.i.236:                                  ; preds = %if.end.25.i.233
  %cmp32.i.234 = icmp ult i32 %or.i.210, %or4.i.211
  %cond37.i.235 = select i1 %cmp32.i.234, i32 %or.i.210, i32 %or4.i.211
  br label %cleanup

if.end:                                           ; preds = %if.then
  %cmp11 = icmp eq i32 %and.i.242, 255
  br i1 %cmp11, label %if.then.13, label %if.end.18

if.then.13:                                       ; preds = %if.end
  %tobool14 = icmp eq i32 %and.i.243, 0
  br i1 %tobool14, label %if.end.17, label %if.then.15

if.then.15:                                       ; preds = %if.then.13
  %6 = trunc i32 %a to i31
  %cmp.i.i.157 = icmp ugt i31 %6, -8388608
  %and.i.66.i.158 = and i32 %a, 2143289344
  %cmp.i.67.i.159 = icmp eq i32 %and.i.66.i.158, 2139095040
  %and1.i.68.i.160 = and i32 %a, 4194303
  %tobool.i.69.i.161 = icmp ne i32 %and1.i.68.i.160, 0
  %phitmp.i.70.i.162 = zext i1 %tobool.i.69.i.161 to i8
  %7 = select i1 %cmp.i.67.i.159, i8 %phitmp.i.70.i.162, i8 0
  %8 = trunc i32 %b to i31
  %cmp.i.64.i.163 = icmp ugt i31 %8, -8388608
  %and.i.i.164 = and i32 %b, 2143289344
  %cmp.i.63.i.165 = icmp eq i32 %and.i.i.164, 2139095040
  %and1.i.i.166 = and i32 %b, 4194303
  %tobool.i.i.167 = icmp ne i32 %and1.i.i.166, 0
  %phitmp.i.i.168 = zext i1 %tobool.i.i.167 to i8
  %9 = select i1 %cmp.i.63.i.165, i8 %phitmp.i.i.168, i8 0
  %or.i.169 = or i32 %a, 4194304
  %or4.i.170 = or i32 %b, 4194304
  %conv5.71.i.171 = zext i8 %9 to i32
  %or662.i.172 = or i8 %9, %7
  %tobool.i.173 = icmp eq i8 %or662.i.172, 0
  br i1 %tobool.i.173, label %if.end.i.177, label %if.then.i.175

if.then.i.175:                                    ; preds = %if.then.15
  %10 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i.174 = or i8 %10, 1
  store i8 %or3.i.i.174, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i.177

if.end.i.177:                                     ; preds = %if.then.i.175, %if.then.15
  %tobool7.i.176 = icmp eq i8 %7, 0
  br i1 %tobool7.i.176, label %if.else.i.182, label %if.then.8.i.179

if.then.8.i.179:                                  ; preds = %if.end.i.177
  %tobool9.i.178 = icmp eq i8 %9, 0
  br i1 %tobool9.i.178, label %if.end.11.i.181, label %returnLargerSignificand.i.190

if.end.11.i.181:                                  ; preds = %if.then.8.i.179
  %cond.i.180 = select i1 %cmp.i.64.i.163, i32 %or4.i.170, i32 %or.i.169
  br label %cleanup

if.else.i.182:                                    ; preds = %if.end.i.177
  br i1 %cmp.i.i.157, label %if.then.15.i.186, label %cleanup

if.then.15.i.186:                                 ; preds = %if.else.i.182
  %11 = zext i1 %cmp.i.64.i.163 to i32
  %lnot.ext.i.183 = xor i32 %11, 1
  %or18.i.184 = or i32 %conv5.71.i.171, %lnot.ext.i.183
  %tobool19.i.185 = icmp eq i32 %or18.i.184, 0
  br i1 %tobool19.i.185, label %returnLargerSignificand.i.190, label %cleanup

returnLargerSignificand.i.190:                    ; preds = %if.then.15.i.186, %if.then.8.i.179
  %shl.i.187 = shl i32 %or.i.169, 1
  %shl22.i.188 = shl i32 %or4.i.170, 1
  %cmp.i.189 = icmp ult i32 %shl.i.187, %shl22.i.188
  br i1 %cmp.i.189, label %cleanup, label %if.end.25.i.192

if.end.25.i.192:                                  ; preds = %returnLargerSignificand.i.190
  %cmp28.i.191 = icmp ult i32 %shl22.i.188, %shl.i.187
  br i1 %cmp28.i.191, label %cleanup, label %if.end.31.i.195

if.end.31.i.195:                                  ; preds = %if.end.25.i.192
  %cmp32.i.193 = icmp ult i32 %or.i.169, %or4.i.170
  %cond37.i.194 = select i1 %cmp32.i.193, i32 %or.i.169, i32 %or4.i.170
  br label %cleanup

if.end.17:                                        ; preds = %if.then.13
  %12 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.156 = or i8 %12, 1
  store i8 %or3.i.156, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.18:                                        ; preds = %if.end
  %shl.i.154 = shl nuw i32 %xor104272, 31
  %add.i.155 = or i32 %shl.i.154, 2139095040
  br label %cleanup

if.end.20:                                        ; preds = %entry
  switch i32 %and.i.242, label %if.end.42 [
    i32 255, label %if.then.23
    i32 0, label %if.then.32
  ]

if.then.23:                                       ; preds = %if.end.20
  %tobool24 = icmp eq i32 %and.i.243, 0
  br i1 %tobool24, label %if.end.27, label %if.then.25

if.then.25:                                       ; preds = %if.then.23
  %13 = trunc i32 %a to i31
  %cmp.i.i.146 = icmp ugt i31 %13, -8388608
  %and.i.66.i = and i32 %a, 2143289344
  %cmp.i.67.i = icmp eq i32 %and.i.66.i, 2139095040
  %and1.i.68.i = and i32 %a, 4194303
  %tobool.i.69.i = icmp ne i32 %and1.i.68.i, 0
  %phitmp.i.70.i = zext i1 %tobool.i.69.i to i8
  %14 = select i1 %cmp.i.67.i, i8 %phitmp.i.70.i, i8 0
  %15 = trunc i32 %b to i31
  %cmp.i.64.i = icmp ugt i31 %15, -8388608
  %and.i.i = and i32 %b, 2143289344
  %cmp.i.63.i = icmp eq i32 %and.i.i, 2139095040
  %and1.i.i = and i32 %b, 4194303
  %tobool.i.i = icmp ne i32 %and1.i.i, 0
  %phitmp.i.i = zext i1 %tobool.i.i to i8
  %16 = select i1 %cmp.i.63.i, i8 %phitmp.i.i, i8 0
  %or.i.147 = or i32 %a, 4194304
  %or4.i = or i32 %b, 4194304
  %conv5.71.i = zext i8 %16 to i32
  %or662.i = or i8 %16, %14
  %tobool.i = icmp eq i8 %or662.i, 0
  br i1 %tobool.i, label %if.end.i.148, label %if.then.i

if.then.i:                                        ; preds = %if.then.25
  %17 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i = or i8 %17, 1
  store i8 %or3.i.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i.148

if.end.i.148:                                     ; preds = %if.then.i, %if.then.25
  %tobool7.i = icmp eq i8 %14, 0
  br i1 %tobool7.i, label %if.else.i, label %if.then.8.i

if.then.8.i:                                      ; preds = %if.end.i.148
  %tobool9.i = icmp eq i8 %16, 0
  br i1 %tobool9.i, label %if.end.11.i, label %returnLargerSignificand.i

if.end.11.i:                                      ; preds = %if.then.8.i
  %cond.i.149 = select i1 %cmp.i.64.i, i32 %or4.i, i32 %or.i.147
  br label %cleanup

if.else.i:                                        ; preds = %if.end.i.148
  br i1 %cmp.i.i.146, label %if.then.15.i, label %cleanup

if.then.15.i:                                     ; preds = %if.else.i
  %18 = zext i1 %cmp.i.64.i to i32
  %lnot.ext.i = xor i32 %18, 1
  %or18.i = or i32 %conv5.71.i, %lnot.ext.i
  %tobool19.i = icmp eq i32 %or18.i, 0
  br i1 %tobool19.i, label %returnLargerSignificand.i, label %cleanup

returnLargerSignificand.i:                        ; preds = %if.then.15.i, %if.then.8.i
  %shl.i.150 = shl i32 %or.i.147, 1
  %shl22.i = shl i32 %or4.i, 1
  %cmp.i.151 = icmp ult i32 %shl.i.150, %shl22.i
  br i1 %cmp.i.151, label %cleanup, label %if.end.25.i

if.end.25.i:                                      ; preds = %returnLargerSignificand.i
  %cmp28.i = icmp ult i32 %shl22.i, %shl.i.150
  br i1 %cmp28.i, label %cleanup, label %if.end.31.i

if.end.31.i:                                      ; preds = %if.end.25.i
  %cmp32.i = icmp ult i32 %or.i.147, %or4.i
  %cond37.i = select i1 %cmp32.i, i32 %or.i.147, i32 %or4.i
  br label %cleanup

if.end.27:                                        ; preds = %if.then.23
  %shl.i.145 = shl nuw i32 %xor104272, 31
  br label %cleanup

if.then.32:                                       ; preds = %if.end.20
  %cmp33 = icmp eq i32 %and.i.243, 0
  br i1 %cmp33, label %if.then.35, label %if.end.41

if.then.35:                                       ; preds = %if.then.32
  %or = or i32 %and.i.105, %and.i
  %cmp36 = icmp eq i32 %or, 0
  %19 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  br i1 %cmp36, label %if.then.38, label %if.end.39

if.then.38:                                       ; preds = %if.then.35
  %or3.i.143 = or i8 %19, 1
  store i8 %or3.i.143, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.39:                                        ; preds = %if.then.35
  %or3.i = or i8 %19, 4
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  %shl.i.141 = shl nuw i32 %xor104272, 31
  %add.i.142 = or i32 %shl.i.141, 2139095040
  br label %cleanup

if.end.41:                                        ; preds = %if.then.32
  %cmp.i.i.116 = icmp ult i32 %and.i.243, 65536
  %shl.i.i.117 = shl i32 %b, 16
  %shl.a.i.i.118 = select i1 %cmp.i.i.116, i32 %shl.i.i.117, i32 %and.i.243
  %..i.i.119 = select i1 %cmp.i.i.116, i8 16, i8 0
  %cmp2.i.i.120 = icmp ult i32 %shl.a.i.i.118, 16777216
  br i1 %cmp2.i.i.120, label %if.then.4.i.i.125, label %normalizeFloat32Subnormal.exit139

if.then.4.i.i.125:                                ; preds = %if.end.41
  %conv5.23.i.i.121 = zext i8 %..i.i.119 to i32
  %add6.i.i.122 = or i32 %conv5.23.i.i.121, 8
  %conv7.i.i.123 = trunc i32 %add6.i.i.122 to i8
  %shl8.i.i.124 = shl i32 %shl.a.i.i.118, 8
  br label %normalizeFloat32Subnormal.exit139

normalizeFloat32Subnormal.exit139:                ; preds = %if.end.41, %if.then.4.i.i.125
  %a.addr.1.i.i.126 = phi i32 [ %shl8.i.i.124, %if.then.4.i.i.125 ], [ %shl.a.i.i.118, %if.end.41 ]
  %shiftCount.1.i.i.127 = phi i8 [ %conv7.i.i.123, %if.then.4.i.i.125 ], [ %..i.i.119, %if.end.41 ]
  %shr.i.i.128 = lshr i32 %a.addr.1.i.i.126, 24
  %idxprom.i.i.129 = zext i32 %shr.i.i.128 to i64
  %arrayidx.i.i.130 = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i.129
  %20 = load i8, i8* %arrayidx.i.i.130, align 1, !tbaa !5
  %conv10.22.i.i.131 = zext i8 %20 to i32
  %conv11.21.i.i.132 = zext i8 %shiftCount.1.i.i.127 to i32
  %add12.i.i.133 = add nuw nsw i32 %conv10.22.i.i.131, %conv11.21.i.i.132
  %conv.7.i.134 = shl i32 %add12.i.i.133, 24
  %sext.i.135 = add i32 %conv.7.i.134, -134217728
  %conv2.i.136 = ashr exact i32 %sext.i.135, 24
  %shl.i.137 = shl i32 %and.i.243, %conv2.i.136
  %sub4.i.138 = sub nsw i32 1, %conv2.i.136
  br label %if.end.42

if.end.42:                                        ; preds = %if.end.20, %normalizeFloat32Subnormal.exit139
  %bSig.0 = phi i32 [ %and.i.243, %if.end.20 ], [ %shl.i.137, %normalizeFloat32Subnormal.exit139 ]
  %bExp.0 = phi i32 [ %and.i.242, %if.end.20 ], [ %sub4.i.138, %normalizeFloat32Subnormal.exit139 ]
  %cmp43 = icmp eq i32 %and.i.105, 0
  br i1 %cmp43, label %if.then.45, label %if.end.51

if.then.45:                                       ; preds = %if.end.42
  %cmp46 = icmp eq i32 %and.i, 0
  br i1 %cmp46, label %if.then.48, label %if.end.50

if.then.48:                                       ; preds = %if.then.45
  %shl.i.115 = shl nuw i32 %xor104272, 31
  br label %cleanup

if.end.50:                                        ; preds = %if.then.45
  %cmp.i.i = icmp ult i32 %and.i, 65536
  %shl.i.i = shl i32 %a, 16
  %shl.a.i.i = select i1 %cmp.i.i, i32 %shl.i.i, i32 %and.i
  %..i.i = select i1 %cmp.i.i, i8 16, i8 0
  %cmp2.i.i = icmp ult i32 %shl.a.i.i, 16777216
  br i1 %cmp2.i.i, label %if.then.4.i.i, label %normalizeFloat32Subnormal.exit

if.then.4.i.i:                                    ; preds = %if.end.50
  %conv5.23.i.i = zext i8 %..i.i to i32
  %add6.i.i = or i32 %conv5.23.i.i, 8
  %conv7.i.i = trunc i32 %add6.i.i to i8
  %shl8.i.i = shl i32 %shl.a.i.i, 8
  br label %normalizeFloat32Subnormal.exit

normalizeFloat32Subnormal.exit:                   ; preds = %if.end.50, %if.then.4.i.i
  %a.addr.1.i.i = phi i32 [ %shl8.i.i, %if.then.4.i.i ], [ %shl.a.i.i, %if.end.50 ]
  %shiftCount.1.i.i = phi i8 [ %conv7.i.i, %if.then.4.i.i ], [ %..i.i, %if.end.50 ]
  %shr.i.i = lshr i32 %a.addr.1.i.i, 24
  %idxprom.i.i = zext i32 %shr.i.i to i64
  %arrayidx.i.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i
  %21 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !5
  %conv10.22.i.i = zext i8 %21 to i32
  %conv11.21.i.i = zext i8 %shiftCount.1.i.i to i32
  %add12.i.i = add nuw nsw i32 %conv10.22.i.i, %conv11.21.i.i
  %conv.7.i = shl i32 %add12.i.i, 24
  %sext.i = add i32 %conv.7.i, -134217728
  %conv2.i = ashr exact i32 %sext.i, 24
  %shl.i.114 = shl i32 %and.i, %conv2.i
  %sub4.i = sub nsw i32 1, %conv2.i
  br label %if.end.51

if.end.51:                                        ; preds = %normalizeFloat32Subnormal.exit, %if.end.42
  %aSig.0 = phi i32 [ %shl.i.114, %normalizeFloat32Subnormal.exit ], [ %and.i, %if.end.42 ]
  %aExp.0 = phi i32 [ %sub4.i, %normalizeFloat32Subnormal.exit ], [ %and.i.105, %if.end.42 ]
  %sub = sub nsw i32 %aExp.0, %bExp.0
  %or52 = shl i32 %aSig.0, 7
  %shl = or i32 %or52, 1073741824
  %or53 = shl i32 %bSig.0, 8
  %shl54 = or i32 %or53, -2147483648
  %add55 = shl i32 %shl, 1
  %cmp56 = icmp ugt i32 %shl54, %add55
  %22 = zext i1 %cmp56 to i32
  %shr = xor i32 %22, 1
  %aSig.1 = lshr exact i32 %shl, %shr
  %zExp.0.v = select i1 %cmp56, i32 125, i32 126
  %zExp.0 = add nsw i32 %sub, %zExp.0.v
  %cmp.i.110 = icmp ugt i32 %shl54, %aSig.1
  br i1 %cmp.i.110, label %if.end.i, label %if.end.69

if.end.i:                                         ; preds = %if.end.51
  %shr.i.111 = lshr i32 %shl54, 16
  %shl.i.112 = shl nuw i32 %shr.i.111, 16
  %cmp1.i = icmp ugt i32 %shl.i.112, %aSig.1
  br i1 %cmp1.i, label %cond.false.i, label %cond.end.i

cond.false.i:                                     ; preds = %if.end.i
  %div.i = udiv i32 %aSig.1, %shr.i.111
  %shl2.i = shl i32 %div.i, 16
  br label %cond.end.i

cond.end.i:                                       ; preds = %cond.false.i, %if.end.i
  %cond.i = phi i32 [ %shl2.i, %cond.false.i ], [ -65536, %if.end.i ]
  %shr3.i.i = lshr exact i32 %cond.i, 16
  %conv5.i.i = and i32 %or53, 65280
  %mul9.i.i = mul nuw i32 %shr3.i.i, %conv5.i.i
  %mul15.i.i = mul nuw i32 %shr3.i.i, %shr.i.111
  %shr17.i.i = lshr i32 %mul9.i.i, 16
  %shl20.i.i = shl i32 %mul9.i.i, 16
  %sub.i.i = sub i32 0, %shl20.i.i
  %cmp.i.39.i = icmp ne i32 %shl20.i.i, 0
  %conv.neg.i.i = sext i1 %cmp.i.39.i to i32
  %add24.i.neg.i = sub i32 %aSig.1, %mul15.i.i
  %sub1.i.i = sub i32 %add24.i.neg.i, %shr17.i.i
  %sub2.i.i = add i32 %sub1.i.i, %conv.neg.i.i
  %cmp3.45.i = icmp slt i32 %sub2.i.i, 0
  br i1 %cmp3.45.i, label %while.body.lr.ph.i, label %while.end.i

while.body.lr.ph.i:                               ; preds = %cond.end.i
  %shl4.i = shl i32 %bSig.0, 24
  br label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %while.body.lr.ph.i
  %z.048.i = phi i32 [ %cond.i, %while.body.lr.ph.i ], [ %sub.i.113, %while.body.i ]
  %rem0.047.i = phi i32 [ %sub2.i.i, %while.body.lr.ph.i ], [ %add2.i.i, %while.body.i ]
  %rem1.046.i = phi i32 [ %sub.i.i, %while.body.lr.ph.i ], [ %add.i.37.i, %while.body.i ]
  %sub.i.113 = add i32 %z.048.i, -65536
  %add.i.37.i = add i32 %rem1.046.i, %shl4.i
  %add1.i.i = add i32 %rem0.047.i, %shr.i.111
  %cmp.i.38.i = icmp ult i32 %add.i.37.i, %rem1.046.i
  %conv.i.i = zext i1 %cmp.i.38.i to i32
  %add2.i.i = add i32 %add1.i.i, %conv.i.i
  %cmp3.i = icmp slt i32 %add2.i.i, 0
  br i1 %cmp3.i, label %while.body.i, label %while.end.i.loopexit

while.end.i.loopexit:                             ; preds = %while.body.i
  %add2.i.i.lcssa = phi i32 [ %add2.i.i, %while.body.i ]
  %add.i.37.i.lcssa = phi i32 [ %add.i.37.i, %while.body.i ]
  %sub.i.113.lcssa = phi i32 [ %sub.i.113, %while.body.i ]
  br label %while.end.i

while.end.i:                                      ; preds = %while.end.i.loopexit, %cond.end.i
  %z.0.lcssa.i = phi i32 [ %cond.i, %cond.end.i ], [ %sub.i.113.lcssa, %while.end.i.loopexit ]
  %rem0.0.lcssa.i = phi i32 [ %sub2.i.i, %cond.end.i ], [ %add2.i.i.lcssa, %while.end.i.loopexit ]
  %rem1.0.lcssa.i = phi i32 [ %sub.i.i, %cond.end.i ], [ %add.i.37.i.lcssa, %while.end.i.loopexit ]
  %shl5.i = shl i32 %rem0.0.lcssa.i, 16
  %shr6.i = lshr i32 %rem1.0.lcssa.i, 16
  %or.i = or i32 %shr6.i, %shl5.i
  %cmp8.i = icmp ugt i32 %shl.i.112, %or.i
  br i1 %cmp8.i, label %cond.false.10.i, label %estimateDiv64To32.exit

cond.false.10.i:                                  ; preds = %while.end.i
  %div11.i = udiv i32 %or.i, %shr.i.111
  br label %estimateDiv64To32.exit

estimateDiv64To32.exit:                           ; preds = %while.end.i, %cond.false.10.i
  %cond13.i = phi i32 [ %div11.i, %cond.false.10.i ], [ 65535, %while.end.i ]
  %or14.i = or i32 %cond13.i, %z.0.lcssa.i
  %and = and i32 %or14.i, 63
  %cmp61 = icmp ult i32 %and, 3
  br i1 %cmp61, label %if.then.63, label %if.end.69

if.then.63:                                       ; preds = %estimateDiv64To32.exit
  %shr3.i = lshr i32 %or14.i, 16
  %conv6.i = and i32 %or14.i, 65535
  %mul.i = mul nuw i32 %conv6.i, %conv5.i.i
  %mul9.i = mul nuw i32 %shr3.i, %conv5.i.i
  %mul12.i = mul nuw i32 %conv6.i, %shr.i.111
  %mul15.i = mul nuw i32 %shr3.i, %shr.i.111
  %add.i.108 = add i32 %mul9.i, %mul12.i
  %cmp.i.109 = icmp ult i32 %add.i.108, %mul12.i
  %conv16.i = zext i1 %cmp.i.109 to i32
  %shl.i = shl nuw nsw i32 %conv16.i, 16
  %shr17.i = lshr i32 %add.i.108, 16
  %add18.i = or i32 %shl.i, %shr17.i
  %shl20.i = shl i32 %add.i.108, 16
  %add21.i = add i32 %shl20.i, %mul.i
  %cmp22.i = icmp ult i32 %add21.i, %shl20.i
  %sub.i = sub i32 0, %add21.i
  %conv23.i.neg = sext i1 %cmp22.i to i32
  %cmp.i.106 = icmp ne i32 %add21.i, 0
  %conv.neg.i = sext i1 %cmp.i.106 to i32
  %add19.i.neg = sub i32 %aSig.1, %mul15.i
  %add24.i.neg = sub i32 %add19.i.neg, %add18.i
  %sub1.i = add i32 %add24.i.neg, %conv23.i.neg
  %sub2.i = add i32 %sub1.i, %conv.neg.i
  %cmp64.274 = icmp slt i32 %sub2.i, 0
  br i1 %cmp64.274, label %while.body.preheader, label %while.end

while.body.preheader:                             ; preds = %if.then.63
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %zSig.0277 = phi i32 [ %dec, %while.body ], [ %or14.i, %while.body.preheader ]
  %rem1.0276 = phi i32 [ %add.i, %while.body ], [ %sub.i, %while.body.preheader ]
  %rem0.0275 = phi i32 [ %add2.i, %while.body ], [ %sub2.i, %while.body.preheader ]
  %dec = add i32 %zSig.0277, -1
  %add.i = add i32 %rem1.0276, %shl54
  %cmp.i = icmp ult i32 %add.i, %rem1.0276
  %conv.i = zext i1 %cmp.i to i32
  %add2.i = add i32 %conv.i, %rem0.0275
  %cmp64 = icmp slt i32 %add2.i, 0
  br i1 %cmp64, label %while.body, label %while.end.loopexit

while.end.loopexit:                               ; preds = %while.body
  %add.i.lcssa = phi i32 [ %add.i, %while.body ]
  %dec.lcssa = phi i32 [ %dec, %while.body ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %if.then.63
  %zSig.0.lcssa = phi i32 [ %or14.i, %if.then.63 ], [ %dec.lcssa, %while.end.loopexit ]
  %rem1.0.lcssa = phi i32 [ %sub.i, %if.then.63 ], [ %add.i.lcssa, %while.end.loopexit ]
  %cmp66 = icmp ne i32 %rem1.0.lcssa, 0
  %conv67 = zext i1 %cmp66 to i32
  %or68 = or i32 %conv67, %zSig.0.lcssa
  br label %if.end.69

if.end.69:                                        ; preds = %if.end.51, %while.end, %estimateDiv64To32.exit
  %zSig.1 = phi i32 [ %or68, %while.end ], [ %or14.i, %estimateDiv64To32.exit ], [ -1, %if.end.51 ]
  %call70 = tail call fastcc zeroext i32 @roundAndPackFloat32(i8 signext %xor104, i32 signext %zExp.0, i32 zeroext %zSig.1)
  br label %cleanup

cleanup:                                          ; preds = %if.end.31.i, %if.end.25.i, %returnLargerSignificand.i, %if.then.15.i, %if.else.i, %if.end.11.i, %if.end.31.i.195, %if.end.25.i.192, %returnLargerSignificand.i.190, %if.then.15.i.186, %if.else.i.182, %if.end.11.i.181, %if.end.31.i.236, %if.end.25.i.233, %returnLargerSignificand.i.231, %if.then.15.i.227, %if.else.i.223, %if.end.11.i.222, %if.end.69, %if.then.48, %if.end.39, %if.then.38, %if.end.27, %if.end.18, %if.end.17
  %retval.0 = phi i32 [ -4194304, %if.end.17 ], [ %add.i.155, %if.end.18 ], [ %shl.i.145, %if.end.27 ], [ -4194304, %if.then.38 ], [ %add.i.142, %if.end.39 ], [ %shl.i.115, %if.then.48 ], [ %call70, %if.end.69 ], [ %cond37.i.235, %if.end.31.i.236 ], [ %cond.i.221, %if.end.11.i.222 ], [ %or.i.210, %if.then.15.i.227 ], [ %or4.i.211, %returnLargerSignificand.i.231 ], [ %or.i.210, %if.end.25.i.233 ], [ %or4.i.211, %if.else.i.223 ], [ %cond37.i.194, %if.end.31.i.195 ], [ %cond.i.180, %if.end.11.i.181 ], [ %or.i.169, %if.then.15.i.186 ], [ %or4.i.170, %returnLargerSignificand.i.190 ], [ %or.i.169, %if.end.25.i.192 ], [ %or4.i.170, %if.else.i.182 ], [ %cond37.i, %if.end.31.i ], [ %cond.i.149, %if.end.11.i ], [ %or.i.147, %if.then.15.i ], [ %or4.i, %returnLargerSignificand.i ], [ %or.i.147, %if.end.25.i ], [ %or4.i, %if.else.i ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define zeroext i32 @float32_rem(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 8388607
  %shr.i = lshr i32 %a, 23
  %and.i.148 = and i32 %shr.i, 255
  %shr.i.299 = lshr i32 %a, 31
  %and.i.298 = and i32 %b, 8388607
  %shr.i.296 = lshr i32 %b, 23
  %and.i.297 = and i32 %shr.i.296, 255
  %cmp = icmp eq i32 %and.i.148, 255
  br i1 %cmp, label %if.then, label %if.end.10

if.then:                                          ; preds = %entry
  %tobool = icmp eq i32 %and.i, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then.8

lor.lhs.false:                                    ; preds = %if.then
  %cmp6 = icmp eq i32 %and.i.297, 255
  %tobool7 = icmp ne i32 %and.i.298, 0
  %or.cond = and i1 %tobool7, %cmp6
  br i1 %or.cond, label %if.then.8, label %if.end

if.then.8:                                        ; preds = %if.then, %lor.lhs.false
  %0 = trunc i32 %a to i31
  %cmp.i.i.255 = icmp ugt i31 %0, -8388608
  %and.i.66.i.256 = and i32 %a, 2143289344
  %cmp.i.67.i.257 = icmp eq i32 %and.i.66.i.256, 2139095040
  %and1.i.68.i.258 = and i32 %a, 4194303
  %tobool.i.69.i.259 = icmp ne i32 %and1.i.68.i.258, 0
  %phitmp.i.70.i.260 = zext i1 %tobool.i.69.i.259 to i8
  %1 = select i1 %cmp.i.67.i.257, i8 %phitmp.i.70.i.260, i8 0
  %2 = trunc i32 %b to i31
  %cmp.i.64.i.261 = icmp ugt i31 %2, -8388608
  %and.i.i.262 = and i32 %b, 2143289344
  %cmp.i.63.i.263 = icmp eq i32 %and.i.i.262, 2139095040
  %and1.i.i.264 = and i32 %b, 4194303
  %tobool.i.i.265 = icmp ne i32 %and1.i.i.264, 0
  %phitmp.i.i.266 = zext i1 %tobool.i.i.265 to i8
  %3 = select i1 %cmp.i.63.i.263, i8 %phitmp.i.i.266, i8 0
  %or.i.267 = or i32 %a, 4194304
  %or4.i.268 = or i32 %b, 4194304
  %conv5.71.i.269 = zext i8 %3 to i32
  %or662.i.270 = or i8 %3, %1
  %tobool.i.271 = icmp eq i8 %or662.i.270, 0
  br i1 %tobool.i.271, label %if.end.i.275, label %if.then.i.273

if.then.i.273:                                    ; preds = %if.then.8
  %4 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i.272 = or i8 %4, 1
  store i8 %or3.i.i.272, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i.275

if.end.i.275:                                     ; preds = %if.then.i.273, %if.then.8
  %tobool7.i.274 = icmp eq i8 %1, 0
  br i1 %tobool7.i.274, label %if.else.i.280, label %if.then.8.i.277

if.then.8.i.277:                                  ; preds = %if.end.i.275
  %tobool9.i.276 = icmp eq i8 %3, 0
  br i1 %tobool9.i.276, label %if.end.11.i.279, label %returnLargerSignificand.i.288

if.end.11.i.279:                                  ; preds = %if.then.8.i.277
  %cond.i.278 = select i1 %cmp.i.64.i.261, i32 %or4.i.268, i32 %or.i.267
  br label %cleanup

if.else.i.280:                                    ; preds = %if.end.i.275
  br i1 %cmp.i.i.255, label %if.then.15.i.284, label %cleanup

if.then.15.i.284:                                 ; preds = %if.else.i.280
  %5 = zext i1 %cmp.i.64.i.261 to i32
  %lnot.ext.i.281 = xor i32 %5, 1
  %or18.i.282 = or i32 %conv5.71.i.269, %lnot.ext.i.281
  %tobool19.i.283 = icmp eq i32 %or18.i.282, 0
  br i1 %tobool19.i.283, label %returnLargerSignificand.i.288, label %cleanup

returnLargerSignificand.i.288:                    ; preds = %if.then.15.i.284, %if.then.8.i.277
  %shl.i.285 = shl i32 %or.i.267, 1
  %shl22.i.286 = shl i32 %or4.i.268, 1
  %cmp.i.287 = icmp ult i32 %shl.i.285, %shl22.i.286
  br i1 %cmp.i.287, label %cleanup, label %if.end.25.i.290

if.end.25.i.290:                                  ; preds = %returnLargerSignificand.i.288
  %cmp28.i.289 = icmp ult i32 %shl22.i.286, %shl.i.285
  br i1 %cmp28.i.289, label %cleanup, label %if.end.31.i.293

if.end.31.i.293:                                  ; preds = %if.end.25.i.290
  %cmp32.i.291 = icmp ult i32 %or.i.267, %or4.i.268
  %cond37.i.292 = select i1 %cmp32.i.291, i32 %or.i.267, i32 %or4.i.268
  br label %cleanup

if.end:                                           ; preds = %lor.lhs.false
  %6 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.254 = or i8 %6, 1
  store i8 %or3.i.254, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.10:                                        ; preds = %entry
  switch i32 %and.i.297, label %if.end.23 [
    i32 255, label %if.then.12
    i32 0, label %if.then.19
  ]

if.then.12:                                       ; preds = %if.end.10
  %tobool13 = icmp eq i32 %and.i.298, 0
  br i1 %tobool13, label %cleanup, label %if.then.14

if.then.14:                                       ; preds = %if.then.12
  %7 = trunc i32 %a to i31
  %cmp.i.i.247 = icmp ugt i31 %7, -8388608
  %and.i.66.i = and i32 %a, 2143289344
  %cmp.i.67.i = icmp eq i32 %and.i.66.i, 2139095040
  %and1.i.68.i = and i32 %a, 4194303
  %tobool.i.69.i = icmp ne i32 %and1.i.68.i, 0
  %phitmp.i.70.i = zext i1 %tobool.i.69.i to i8
  %8 = select i1 %cmp.i.67.i, i8 %phitmp.i.70.i, i8 0
  %9 = trunc i32 %b to i31
  %cmp.i.64.i = icmp ugt i31 %9, -8388608
  %and.i.i = and i32 %b, 2143289344
  %cmp.i.63.i = icmp eq i32 %and.i.i, 2139095040
  %and1.i.i = and i32 %b, 4194303
  %tobool.i.i = icmp ne i32 %and1.i.i, 0
  %phitmp.i.i = zext i1 %tobool.i.i to i8
  %10 = select i1 %cmp.i.63.i, i8 %phitmp.i.i, i8 0
  %or.i.248 = or i32 %a, 4194304
  %or4.i = or i32 %b, 4194304
  %conv5.71.i = zext i8 %10 to i32
  %or662.i = or i8 %10, %8
  %tobool.i = icmp eq i8 %or662.i, 0
  br i1 %tobool.i, label %if.end.i.249, label %if.then.i

if.then.i:                                        ; preds = %if.then.14
  %11 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i = or i8 %11, 1
  store i8 %or3.i.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.i.249

if.end.i.249:                                     ; preds = %if.then.i, %if.then.14
  %tobool7.i = icmp eq i8 %8, 0
  br i1 %tobool7.i, label %if.else.i, label %if.then.8.i

if.then.8.i:                                      ; preds = %if.end.i.249
  %tobool9.i = icmp eq i8 %10, 0
  br i1 %tobool9.i, label %if.end.11.i, label %returnLargerSignificand.i

if.end.11.i:                                      ; preds = %if.then.8.i
  %cond.i.250 = select i1 %cmp.i.64.i, i32 %or4.i, i32 %or.i.248
  br label %cleanup

if.else.i:                                        ; preds = %if.end.i.249
  br i1 %cmp.i.i.247, label %if.then.15.i, label %cleanup

if.then.15.i:                                     ; preds = %if.else.i
  %12 = zext i1 %cmp.i.64.i to i32
  %lnot.ext.i = xor i32 %12, 1
  %or18.i = or i32 %conv5.71.i, %lnot.ext.i
  %tobool19.i = icmp eq i32 %or18.i, 0
  br i1 %tobool19.i, label %returnLargerSignificand.i, label %cleanup

returnLargerSignificand.i:                        ; preds = %if.then.15.i, %if.then.8.i
  %shl.i.251 = shl i32 %or.i.248, 1
  %shl22.i = shl i32 %or4.i, 1
  %cmp.i.252 = icmp ult i32 %shl.i.251, %shl22.i
  br i1 %cmp.i.252, label %cleanup, label %if.end.25.i

if.end.25.i:                                      ; preds = %returnLargerSignificand.i
  %cmp28.i = icmp ult i32 %shl22.i, %shl.i.251
  br i1 %cmp28.i, label %cleanup, label %if.end.31.i

if.end.31.i:                                      ; preds = %if.end.25.i
  %cmp32.i = icmp ult i32 %or.i.248, %or4.i
  %cond37.i = select i1 %cmp32.i, i32 %or.i.248, i32 %or4.i
  br label %cleanup

if.then.19:                                       ; preds = %if.end.10
  %cmp20 = icmp eq i32 %and.i.298, 0
  br i1 %cmp20, label %if.then.21, label %if.end.22

if.then.21:                                       ; preds = %if.then.19
  %13 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %13, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.22:                                        ; preds = %if.then.19
  %cmp.i.i.223 = icmp ult i32 %and.i.298, 65536
  %shl.i.i.224 = shl i32 %b, 16
  %shl.a.i.i.225 = select i1 %cmp.i.i.223, i32 %shl.i.i.224, i32 %and.i.298
  %..i.i.226 = select i1 %cmp.i.i.223, i8 16, i8 0
  %cmp2.i.i.227 = icmp ult i32 %shl.a.i.i.225, 16777216
  br i1 %cmp2.i.i.227, label %if.then.4.i.i.232, label %normalizeFloat32Subnormal.exit246

if.then.4.i.i.232:                                ; preds = %if.end.22
  %conv5.23.i.i.228 = zext i8 %..i.i.226 to i32
  %add6.i.i.229 = or i32 %conv5.23.i.i.228, 8
  %conv7.i.i.230 = trunc i32 %add6.i.i.229 to i8
  %shl8.i.i.231 = shl i32 %shl.a.i.i.225, 8
  br label %normalizeFloat32Subnormal.exit246

normalizeFloat32Subnormal.exit246:                ; preds = %if.end.22, %if.then.4.i.i.232
  %a.addr.1.i.i.233 = phi i32 [ %shl8.i.i.231, %if.then.4.i.i.232 ], [ %shl.a.i.i.225, %if.end.22 ]
  %shiftCount.1.i.i.234 = phi i8 [ %conv7.i.i.230, %if.then.4.i.i.232 ], [ %..i.i.226, %if.end.22 ]
  %shr.i.i.235 = lshr i32 %a.addr.1.i.i.233, 24
  %idxprom.i.i.236 = zext i32 %shr.i.i.235 to i64
  %arrayidx.i.i.237 = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i.236
  %14 = load i8, i8* %arrayidx.i.i.237, align 1, !tbaa !5
  %conv10.22.i.i.238 = zext i8 %14 to i32
  %conv11.21.i.i.239 = zext i8 %shiftCount.1.i.i.234 to i32
  %add12.i.i.240 = add nuw nsw i32 %conv10.22.i.i.238, %conv11.21.i.i.239
  %conv.7.i.241 = shl i32 %add12.i.i.240, 24
  %sext.i.242 = add i32 %conv.7.i.241, -134217728
  %conv2.i.243 = ashr exact i32 %sext.i.242, 24
  %shl.i.244 = shl i32 %and.i.298, %conv2.i.243
  %sub4.i.245 = sub nsw i32 1, %conv2.i.243
  br label %if.end.23

if.end.23:                                        ; preds = %if.end.10, %normalizeFloat32Subnormal.exit246
  %bExp.0 = phi i32 [ %and.i.297, %if.end.10 ], [ %sub4.i.245, %normalizeFloat32Subnormal.exit246 ]
  %bSig.0 = phi i32 [ %and.i.298, %if.end.10 ], [ %shl.i.244, %normalizeFloat32Subnormal.exit246 ]
  %cmp24 = icmp eq i32 %and.i.148, 0
  br i1 %cmp24, label %if.then.25, label %if.end.29

if.then.25:                                       ; preds = %if.end.23
  %cmp26 = icmp eq i32 %and.i, 0
  br i1 %cmp26, label %cleanup, label %if.end.28

if.end.28:                                        ; preds = %if.then.25
  %cmp.i.i.202 = icmp ult i32 %and.i, 65536
  %shl.i.i.203 = shl i32 %a, 16
  %shl.a.i.i.204 = select i1 %cmp.i.i.202, i32 %shl.i.i.203, i32 %and.i
  %..i.i.205 = select i1 %cmp.i.i.202, i8 16, i8 0
  %cmp2.i.i.206 = icmp ult i32 %shl.a.i.i.204, 16777216
  br i1 %cmp2.i.i.206, label %if.then.4.i.i.211, label %normalizeFloat32Subnormal.exit

if.then.4.i.i.211:                                ; preds = %if.end.28
  %conv5.23.i.i.207 = zext i8 %..i.i.205 to i32
  %add6.i.i.208 = or i32 %conv5.23.i.i.207, 8
  %conv7.i.i.209 = trunc i32 %add6.i.i.208 to i8
  %shl8.i.i.210 = shl i32 %shl.a.i.i.204, 8
  br label %normalizeFloat32Subnormal.exit

normalizeFloat32Subnormal.exit:                   ; preds = %if.end.28, %if.then.4.i.i.211
  %a.addr.1.i.i.212 = phi i32 [ %shl8.i.i.210, %if.then.4.i.i.211 ], [ %shl.a.i.i.204, %if.end.28 ]
  %shiftCount.1.i.i.213 = phi i8 [ %conv7.i.i.209, %if.then.4.i.i.211 ], [ %..i.i.205, %if.end.28 ]
  %shr.i.i.214 = lshr i32 %a.addr.1.i.i.212, 24
  %idxprom.i.i.215 = zext i32 %shr.i.i.214 to i64
  %arrayidx.i.i.216 = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i.215
  %15 = load i8, i8* %arrayidx.i.i.216, align 1, !tbaa !5
  %conv10.22.i.i.217 = zext i8 %15 to i32
  %conv11.21.i.i.218 = zext i8 %shiftCount.1.i.i.213 to i32
  %add12.i.i.219 = add nuw nsw i32 %conv10.22.i.i.217, %conv11.21.i.i.218
  %conv.7.i = shl i32 %add12.i.i.219, 24
  %sext.i.220 = add i32 %conv.7.i, -134217728
  %conv2.i.221 = ashr exact i32 %sext.i.220, 24
  %shl.i.222 = shl i32 %and.i, %conv2.i.221
  %sub4.i = sub nsw i32 1, %conv2.i.221
  br label %if.end.29

if.end.29:                                        ; preds = %normalizeFloat32Subnormal.exit, %if.end.23
  %aExp.0 = phi i32 [ %sub4.i, %normalizeFloat32Subnormal.exit ], [ %and.i.148, %if.end.23 ]
  %aSig.0 = phi i32 [ %shl.i.222, %normalizeFloat32Subnormal.exit ], [ %and.i, %if.end.23 ]
  %sub = sub nsw i32 %aExp.0, %bExp.0
  %or = shl i32 %aSig.0, 8
  %shl = or i32 %or, -2147483648
  %or30 = shl i32 %bSig.0, 8
  %shl31 = or i32 %or30, -2147483648
  %cmp32 = icmp slt i32 %sub, 0
  br i1 %cmp32, label %if.then.33, label %if.end.37

if.then.33:                                       ; preds = %if.end.29
  %cmp34 = icmp slt i32 %sub, -1
  br i1 %cmp34, label %cleanup, label %while.end.thread

while.end.thread:                                 ; preds = %if.then.33
  %shr = lshr exact i32 %shl, 1
  br label %if.else

if.end.37:                                        ; preds = %if.end.29
  %cmp38 = icmp uge i32 %shl, %shl31
  %conv = zext i1 %cmp38 to i32
  %sub41 = select i1 %cmp38, i32 %shl31, i32 0
  %sub41.aSig.1 = sub i32 %shl, %sub41
  %sub43 = add nsw i32 %sub, -32
  %cmp44.330 = icmp sgt i32 %sub, 32
  br i1 %cmp44.330, label %while.body.lr.ph, label %while.end

while.body.lr.ph:                                 ; preds = %if.end.37
  %shr.i.152 = lshr i32 %shl31, 16
  %shl.i.153 = shl nuw i32 %shr.i.152, 16
  %conv5.i.i.161 = and i32 %or30, 65280
  %shl4.i.174 = shl i32 %bSig.0, 24
  %shr50 = lshr exact i32 %shl31, 2
  %mul = sub nsw i32 0, %shr50
  br label %while.body

while.body:                                       ; preds = %while.body.lr.ph, %estimateDiv64To32.exit201
  %expDiff.0332 = phi i32 [ %sub43, %while.body.lr.ph ], [ %sub52, %estimateDiv64To32.exit201 ]
  %aSig.3331 = phi i32 [ %sub41.aSig.1, %while.body.lr.ph ], [ %sub51, %estimateDiv64To32.exit201 ]
  %cmp.i.151 = icmp ugt i32 %shl31, %aSig.3331
  br i1 %cmp.i.151, label %if.end.i.155, label %estimateDiv64To32.exit201

if.end.i.155:                                     ; preds = %while.body
  %cmp1.i.154 = icmp ugt i32 %shl.i.153, %aSig.3331
  br i1 %cmp1.i.154, label %cond.false.i.158, label %cond.end.i.173

cond.false.i.158:                                 ; preds = %if.end.i.155
  %div.i.156 = udiv i32 %aSig.3331, %shr.i.152
  %shl2.i.157 = shl i32 %div.i.156, 16
  br label %cond.end.i.173

cond.end.i.173:                                   ; preds = %cond.false.i.158, %if.end.i.155
  %cond.i.159 = phi i32 [ %shl2.i.157, %cond.false.i.158 ], [ -65536, %if.end.i.155 ]
  %shr3.i.i.160 = lshr exact i32 %cond.i.159, 16
  %mul9.i.i.162 = mul nuw i32 %shr3.i.i.160, %conv5.i.i.161
  %mul15.i.i.163 = mul nuw i32 %shr3.i.i.160, %shr.i.152
  %shr17.i.i.164 = lshr i32 %mul9.i.i.162, 16
  %shl20.i.i.165 = shl i32 %mul9.i.i.162, 16
  %sub.i.i.166 = sub i32 0, %shl20.i.i.165
  %cmp.i.39.i.167 = icmp ne i32 %shl20.i.i.165, 0
  %conv.neg.i.i.168 = sext i1 %cmp.i.39.i.167 to i32
  %add24.i.neg.i.169 = sub i32 %aSig.3331, %mul15.i.i.163
  %sub1.i.i.170 = sub i32 %add24.i.neg.i.169, %shr17.i.i.164
  %sub2.i.i.171 = add i32 %sub1.i.i.170, %conv.neg.i.i.168
  %cmp3.45.i.172 = icmp slt i32 %sub2.i.i.171, 0
  br i1 %cmp3.45.i.172, label %while.body.i.186.preheader, label %while.end.i.194

while.body.i.186.preheader:                       ; preds = %cond.end.i.173
  br label %while.body.i.186

while.body.i.186:                                 ; preds = %while.body.i.186.preheader, %while.body.i.186
  %z.048.i.176 = phi i32 [ %sub.i.179, %while.body.i.186 ], [ %cond.i.159, %while.body.i.186.preheader ]
  %rem0.047.i.177 = phi i32 [ %add2.i.i.184, %while.body.i.186 ], [ %sub2.i.i.171, %while.body.i.186.preheader ]
  %rem1.046.i.178 = phi i32 [ %add.i.37.i.180, %while.body.i.186 ], [ %sub.i.i.166, %while.body.i.186.preheader ]
  %sub.i.179 = add i32 %z.048.i.176, -65536
  %add.i.37.i.180 = add i32 %rem1.046.i.178, %shl4.i.174
  %add1.i.i.181 = add i32 %rem0.047.i.177, %shr.i.152
  %cmp.i.38.i.182 = icmp ult i32 %add.i.37.i.180, %rem1.046.i.178
  %conv.i.i.183 = zext i1 %cmp.i.38.i.182 to i32
  %add2.i.i.184 = add i32 %add1.i.i.181, %conv.i.i.183
  %cmp3.i.185 = icmp slt i32 %add2.i.i.184, 0
  br i1 %cmp3.i.185, label %while.body.i.186, label %while.end.i.194.loopexit

while.end.i.194.loopexit:                         ; preds = %while.body.i.186
  %add2.i.i.184.lcssa = phi i32 [ %add2.i.i.184, %while.body.i.186 ]
  %add.i.37.i.180.lcssa = phi i32 [ %add.i.37.i.180, %while.body.i.186 ]
  %sub.i.179.lcssa = phi i32 [ %sub.i.179, %while.body.i.186 ]
  br label %while.end.i.194

while.end.i.194:                                  ; preds = %while.end.i.194.loopexit, %cond.end.i.173
  %z.0.lcssa.i.187 = phi i32 [ %cond.i.159, %cond.end.i.173 ], [ %sub.i.179.lcssa, %while.end.i.194.loopexit ]
  %rem0.0.lcssa.i.188 = phi i32 [ %sub2.i.i.171, %cond.end.i.173 ], [ %add2.i.i.184.lcssa, %while.end.i.194.loopexit ]
  %rem1.0.lcssa.i.189 = phi i32 [ %sub.i.i.166, %cond.end.i.173 ], [ %add.i.37.i.180.lcssa, %while.end.i.194.loopexit ]
  %shl5.i.190 = shl i32 %rem0.0.lcssa.i.188, 16
  %shr6.i.191 = lshr i32 %rem1.0.lcssa.i.189, 16
  %or.i.192 = or i32 %shr6.i.191, %shl5.i.190
  %cmp8.i.193 = icmp ugt i32 %shl.i.153, %or.i.192
  br i1 %cmp8.i.193, label %cond.false.10.i.196, label %cond.end.12.i.199

cond.false.10.i.196:                              ; preds = %while.end.i.194
  %div11.i.195 = udiv i32 %or.i.192, %shr.i.152
  br label %cond.end.12.i.199

cond.end.12.i.199:                                ; preds = %cond.false.10.i.196, %while.end.i.194
  %cond13.i.197 = phi i32 [ %div11.i.195, %cond.false.10.i.196 ], [ 65535, %while.end.i.194 ]
  %or14.i.198 = or i32 %cond13.i.197, %z.0.lcssa.i.187
  br label %estimateDiv64To32.exit201

estimateDiv64To32.exit201:                        ; preds = %while.body, %cond.end.12.i.199
  %retval.0.i.200 = phi i32 [ %or14.i.198, %cond.end.12.i.199 ], [ -1, %while.body ]
  %cmp47 = icmp ugt i32 %retval.0.i.200, 2
  %sub49 = add i32 %retval.0.i.200, -2
  %cond = select i1 %cmp47, i32 %sub49, i32 0
  %sub51 = mul i32 %cond, %mul
  %sub52 = add nsw i32 %expDiff.0332, -30
  %cmp44 = icmp sgt i32 %expDiff.0332, 30
  br i1 %cmp44, label %while.body, label %while.end.loopexit

while.end.loopexit:                               ; preds = %estimateDiv64To32.exit201
  %sub52.lcssa = phi i32 [ %sub52, %estimateDiv64To32.exit201 ]
  %sub51.lcssa = phi i32 [ %sub51, %estimateDiv64To32.exit201 ]
  %cond.lcssa = phi i32 [ %cond, %estimateDiv64To32.exit201 ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %if.end.37
  %expDiff.0.lcssa = phi i32 [ %sub43, %if.end.37 ], [ %sub52.lcssa, %while.end.loopexit ]
  %q.0.lcssa = phi i32 [ %conv, %if.end.37 ], [ %cond.lcssa, %while.end.loopexit ]
  %aSig.3.lcssa = phi i32 [ %sub41.aSig.1, %if.end.37 ], [ %sub51.lcssa, %while.end.loopexit ]
  %cmp53 = icmp sgt i32 %expDiff.0.lcssa, -32
  br i1 %cmp53, label %if.then.55, label %if.else

if.then.55:                                       ; preds = %while.end
  %cmp.i = icmp ugt i32 %shl31, %aSig.3.lcssa
  br i1 %cmp.i, label %if.end.i, label %estimateDiv64To32.exit

if.end.i:                                         ; preds = %if.then.55
  %shr.i.149 = lshr i32 %shl31, 16
  %shl.i.150 = shl nuw i32 %shr.i.149, 16
  %cmp1.i = icmp ugt i32 %shl.i.150, %aSig.3.lcssa
  br i1 %cmp1.i, label %cond.false.i, label %cond.end.i

cond.false.i:                                     ; preds = %if.end.i
  %div.i = udiv i32 %aSig.3.lcssa, %shr.i.149
  %shl2.i = shl i32 %div.i, 16
  br label %cond.end.i

cond.end.i:                                       ; preds = %cond.false.i, %if.end.i
  %cond.i = phi i32 [ %shl2.i, %cond.false.i ], [ -65536, %if.end.i ]
  %shr3.i.i = lshr exact i32 %cond.i, 16
  %conv5.i.i = and i32 %or30, 65280
  %mul9.i.i = mul nuw i32 %shr3.i.i, %conv5.i.i
  %mul15.i.i = mul nuw i32 %shr3.i.i, %shr.i.149
  %shr17.i.i = lshr i32 %mul9.i.i, 16
  %shl20.i.i = shl i32 %mul9.i.i, 16
  %sub.i.i = sub i32 0, %shl20.i.i
  %cmp.i.39.i = icmp ne i32 %shl20.i.i, 0
  %conv.neg.i.i = sext i1 %cmp.i.39.i to i32
  %add24.i.neg.i = sub i32 %aSig.3.lcssa, %mul15.i.i
  %sub1.i.i = sub i32 %add24.i.neg.i, %shr17.i.i
  %sub2.i.i = add i32 %sub1.i.i, %conv.neg.i.i
  %cmp3.45.i = icmp slt i32 %sub2.i.i, 0
  br i1 %cmp3.45.i, label %while.body.lr.ph.i, label %while.end.i

while.body.lr.ph.i:                               ; preds = %cond.end.i
  %shl4.i = shl i32 %bSig.0, 24
  br label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %while.body.lr.ph.i
  %z.048.i = phi i32 [ %cond.i, %while.body.lr.ph.i ], [ %sub.i, %while.body.i ]
  %rem0.047.i = phi i32 [ %sub2.i.i, %while.body.lr.ph.i ], [ %add2.i.i, %while.body.i ]
  %rem1.046.i = phi i32 [ %sub.i.i, %while.body.lr.ph.i ], [ %add.i.37.i, %while.body.i ]
  %sub.i = add i32 %z.048.i, -65536
  %add.i.37.i = add i32 %rem1.046.i, %shl4.i
  %add1.i.i = add i32 %rem0.047.i, %shr.i.149
  %cmp.i.38.i = icmp ult i32 %add.i.37.i, %rem1.046.i
  %conv.i.i = zext i1 %cmp.i.38.i to i32
  %add2.i.i = add i32 %add1.i.i, %conv.i.i
  %cmp3.i = icmp slt i32 %add2.i.i, 0
  br i1 %cmp3.i, label %while.body.i, label %while.end.i.loopexit

while.end.i.loopexit:                             ; preds = %while.body.i
  %add2.i.i.lcssa = phi i32 [ %add2.i.i, %while.body.i ]
  %add.i.37.i.lcssa = phi i32 [ %add.i.37.i, %while.body.i ]
  %sub.i.lcssa = phi i32 [ %sub.i, %while.body.i ]
  br label %while.end.i

while.end.i:                                      ; preds = %while.end.i.loopexit, %cond.end.i
  %z.0.lcssa.i = phi i32 [ %cond.i, %cond.end.i ], [ %sub.i.lcssa, %while.end.i.loopexit ]
  %rem0.0.lcssa.i = phi i32 [ %sub2.i.i, %cond.end.i ], [ %add2.i.i.lcssa, %while.end.i.loopexit ]
  %rem1.0.lcssa.i = phi i32 [ %sub.i.i, %cond.end.i ], [ %add.i.37.i.lcssa, %while.end.i.loopexit ]
  %shl5.i = shl i32 %rem0.0.lcssa.i, 16
  %shr6.i = lshr i32 %rem1.0.lcssa.i, 16
  %or.i = or i32 %shr6.i, %shl5.i
  %cmp8.i = icmp ugt i32 %shl.i.150, %or.i
  br i1 %cmp8.i, label %cond.false.10.i, label %cond.end.12.i

cond.false.10.i:                                  ; preds = %while.end.i
  %div11.i = udiv i32 %or.i, %shr.i.149
  br label %cond.end.12.i

cond.end.12.i:                                    ; preds = %cond.false.10.i, %while.end.i
  %cond13.i = phi i32 [ %div11.i, %cond.false.10.i ], [ 65535, %while.end.i ]
  %or14.i = or i32 %cond13.i, %z.0.lcssa.i
  br label %estimateDiv64To32.exit

estimateDiv64To32.exit:                           ; preds = %if.then.55, %cond.end.12.i
  %retval.0.i = phi i32 [ %or14.i, %cond.end.12.i ], [ -1, %if.then.55 ]
  %cmp57 = icmp ugt i32 %retval.0.i, 2
  %sub60 = add i32 %retval.0.i, -2
  %cond63 = select i1 %cmp57, i32 %sub60, i32 0
  %sub64 = sub i32 0, %expDiff.0.lcssa
  %shr65 = lshr i32 %cond63, %sub64
  %shr66 = lshr exact i32 %shl31, 2
  %shr67 = lshr i32 %aSig.3.lcssa, 1
  %sub68 = add nsw i32 %expDiff.0.lcssa, 31
  %shl69 = shl i32 %shr67, %sub68
  %mul70 = mul i32 %shr65, %shr66
  %sub71 = sub i32 %shl69, %mul70
  br label %do.body.preheader

if.else:                                          ; preds = %while.end.thread, %while.end
  %aSig.3.lcssa343 = phi i32 [ %shr, %while.end.thread ], [ %aSig.3.lcssa, %while.end ]
  %q.0.lcssa342 = phi i32 [ 0, %while.end.thread ], [ %q.0.lcssa, %while.end ]
  %shr72 = lshr i32 %aSig.3.lcssa343, 2
  %shr73 = lshr exact i32 %shl31, 2
  br label %do.body.preheader

do.body.preheader:                                ; preds = %if.else, %estimateDiv64To32.exit
  %aSig.4.ph = phi i32 [ %shr72, %if.else ], [ %sub71, %estimateDiv64To32.exit ]
  %bSig.1.ph = phi i32 [ %shr73, %if.else ], [ %shr66, %estimateDiv64To32.exit ]
  %q.1.ph = phi i32 [ %q.0.lcssa342, %if.else ], [ %shr65, %estimateDiv64To32.exit ]
  br label %do.body

do.body:                                          ; preds = %do.body.preheader, %do.body
  %aSig.4 = phi i32 [ %sub75, %do.body ], [ %aSig.4.ph, %do.body.preheader ]
  %q.1 = phi i32 [ %inc, %do.body ], [ %q.1.ph, %do.body.preheader ]
  %inc = add i32 %q.1, 1
  %sub75 = sub i32 %aSig.4, %bSig.1.ph
  %cmp76 = icmp sgt i32 %sub75, -1
  br i1 %cmp76, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  %sub75.lcssa = phi i32 [ %sub75, %do.body ]
  %inc.lcssa = phi i32 [ %inc, %do.body ]
  %aSig.4.lcssa = phi i32 [ %aSig.4, %do.body ]
  %add78 = add i32 %sub75.lcssa, %aSig.4.lcssa
  %cmp79 = icmp slt i32 %add78, 0
  br i1 %cmp79, label %if.then.86, label %lor.lhs.false.81

lor.lhs.false.81:                                 ; preds = %do.end
  %cmp82 = icmp ne i32 %add78, 0
  %and = and i32 %inc.lcssa, 1
  %tobool85 = icmp eq i32 %and, 0
  %or.cond147 = or i1 %cmp82, %tobool85
  br i1 %or.cond147, label %if.end.87, label %if.then.86

if.then.86:                                       ; preds = %lor.lhs.false.81, %do.end
  br label %if.end.87

if.end.87:                                        ; preds = %lor.lhs.false.81, %if.then.86
  %aSig.5 = phi i32 [ %aSig.4.lcssa, %if.then.86 ], [ %sub75.lcssa, %lor.lhs.false.81 ]
  %.lobit = lshr i32 %aSig.5, 31
  %tobool91 = icmp eq i32 %.lobit, 0
  %sub93 = sub i32 0, %aSig.5
  %aSig.5.sub93 = select i1 %tobool91, i32 %aSig.5, i32 %sub93
  %xor = xor i32 %.lobit, %shr.i.299
  %conv97 = trunc i32 %xor to i8
  %cmp.i.i = icmp ult i32 %aSig.5.sub93, 65536
  %shl.i.i = shl i32 %aSig.5.sub93, 16
  %shl.a.i.i = select i1 %cmp.i.i, i32 %shl.i.i, i32 %aSig.5.sub93
  %..i.i = select i1 %cmp.i.i, i8 16, i8 0
  %cmp2.i.i = icmp ult i32 %shl.a.i.i, 16777216
  br i1 %cmp2.i.i, label %if.then.4.i.i, label %normalizeRoundAndPackFloat32.exit

if.then.4.i.i:                                    ; preds = %if.end.87
  %conv5.23.i.i = zext i8 %..i.i to i32
  %add6.i.i = or i32 %conv5.23.i.i, 8
  %conv7.i.i = trunc i32 %add6.i.i to i8
  %shl8.i.i = shl i32 %shl.a.i.i, 8
  br label %normalizeRoundAndPackFloat32.exit

normalizeRoundAndPackFloat32.exit:                ; preds = %if.end.87, %if.then.4.i.i
  %a.addr.1.i.i = phi i32 [ %shl8.i.i, %if.then.4.i.i ], [ %shl.a.i.i, %if.end.87 ]
  %shiftCount.1.i.i = phi i8 [ %conv7.i.i, %if.then.4.i.i ], [ %..i.i, %if.end.87 ]
  %shr.i.i = lshr i32 %a.addr.1.i.i, 24
  %idxprom.i.i = zext i32 %shr.i.i to i64
  %arrayidx.i.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i
  %16 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !5
  %conv10.22.i.i = zext i8 %16 to i32
  %conv11.21.i.i = zext i8 %shiftCount.1.i.i to i32
  %add12.i.i = add nuw nsw i32 %conv10.22.i.i, %conv11.21.i.i
  %conv.8.i = shl i32 %add12.i.i, 24
  %sext.i = add i32 %conv.8.i, -16777216
  %conv2.i = ashr exact i32 %sext.i, 24
  %sub3.i = sub nsw i32 %bExp.0, %conv2.i
  %shl.i = shl i32 %aSig.5.sub93, %conv2.i
  %call5.i = tail call fastcc zeroext i32 @roundAndPackFloat32(i8 signext %conv97, i32 signext %sub3.i, i32 zeroext %shl.i) #4
  br label %cleanup

cleanup:                                          ; preds = %if.end.31.i, %if.end.25.i, %returnLargerSignificand.i, %if.then.15.i, %if.else.i, %if.end.11.i, %if.end.31.i.293, %if.end.25.i.290, %returnLargerSignificand.i.288, %if.then.15.i.284, %if.else.i.280, %if.end.11.i.279, %if.then.33, %if.then.25, %if.then.12, %normalizeRoundAndPackFloat32.exit, %if.then.21, %if.end
  %retval.0 = phi i32 [ -4194304, %if.end ], [ -4194304, %if.then.21 ], [ %call5.i, %normalizeRoundAndPackFloat32.exit ], [ %a, %if.then.12 ], [ %a, %if.then.25 ], [ %a, %if.then.33 ], [ %cond37.i.292, %if.end.31.i.293 ], [ %cond.i.278, %if.end.11.i.279 ], [ %or.i.267, %if.then.15.i.284 ], [ %or4.i.268, %returnLargerSignificand.i.288 ], [ %or.i.267, %if.end.25.i.290 ], [ %or4.i.268, %if.else.i.280 ], [ %cond37.i, %if.end.31.i ], [ %cond.i.250, %if.end.11.i ], [ %or.i.248, %if.then.15.i ], [ %or4.i, %returnLargerSignificand.i ], [ %or.i.248, %if.end.25.i ], [ %or4.i, %if.else.i ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define zeroext i32 @float32_sqrt(i32 zeroext %a) #2 {
entry:
  %and.i = and i32 %a, 8388607
  %shr.i = lshr i32 %a, 23
  %and.i.53 = and i32 %shr.i, 255
  %shr.i.91 = lshr i32 %a, 31
  %conv.i.92 = trunc i32 %shr.i.91 to i8
  %cmp = icmp eq i32 %and.i.53, 255
  br i1 %cmp, label %if.then, label %if.end.8

if.then:                                          ; preds = %entry
  %tobool = icmp eq i32 %and.i, 0
  br i1 %tobool, label %if.end, label %if.then.3

if.then.3:                                        ; preds = %if.then
  %and.i.66.i = and i32 %a, 2143289344
  %and1.i.68.i = and i32 %a, 4194303
  %or.i.85 = or i32 %a, 4194304
  %tobool.i.86116 = icmp eq i32 %and1.i.68.i, 0
  %not.cmp.i.67.i = icmp ne i32 %and.i.66.i, 2139095040
  %tobool.i.86 = or i1 %not.cmp.i.67.i, %tobool.i.86116
  br i1 %tobool.i.86, label %if.else.i.89, label %if.then.8.i

if.then.8.i:                                      ; preds = %if.then.3
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i = or i8 %0, 1
  store i8 %or3.i.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.else.i.89:                                     ; preds = %if.then.3
  %1 = trunc i32 %a to i31
  %cmp.i.i.84 = icmp ugt i31 %1, -8388608
  %or.i.85. = select i1 %cmp.i.i.84, i32 %or.i.85, i32 4194304
  ret i32 %or.i.85.

if.end:                                           ; preds = %if.then
  %tobool5 = icmp eq i8 %conv.i.92, 0
  br i1 %tobool5, label %cleanup, label %if.end.7

if.end.7:                                         ; preds = %if.end
  %2 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.83 = or i8 %2, 1
  store i8 %or3.i.83, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.8:                                         ; preds = %entry
  %tobool9 = icmp eq i8 %conv.i.92, 0
  br i1 %tobool9, label %if.end.14, label %if.then.10

if.then.10:                                       ; preds = %if.end.8
  %or = or i32 %and.i.53, %and.i
  %cmp11 = icmp eq i32 %or, 0
  br i1 %cmp11, label %cleanup, label %if.end.13

if.end.13:                                        ; preds = %if.then.10
  %3 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %3, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.14:                                        ; preds = %if.end.8
  %cmp15 = icmp eq i32 %and.i.53, 0
  br i1 %cmp15, label %if.then.16, label %if.end.20

if.then.16:                                       ; preds = %if.end.14
  %cmp17 = icmp eq i32 %and.i, 0
  br i1 %cmp17, label %cleanup, label %if.end.19

if.end.19:                                        ; preds = %if.then.16
  %cmp.i.i = icmp ult i32 %and.i, 65536
  %shl.i.i = shl i32 %a, 16
  %shl.a.i.i = select i1 %cmp.i.i, i32 %shl.i.i, i32 %and.i
  %..i.i = select i1 %cmp.i.i, i8 16, i8 0
  %cmp2.i.i = icmp ult i32 %shl.a.i.i, 16777216
  br i1 %cmp2.i.i, label %if.then.4.i.i, label %normalizeFloat32Subnormal.exit

if.then.4.i.i:                                    ; preds = %if.end.19
  %conv5.23.i.i = zext i8 %..i.i to i32
  %add6.i.i = or i32 %conv5.23.i.i, 8
  %conv7.i.i = trunc i32 %add6.i.i to i8
  %shl8.i.i = shl i32 %shl.a.i.i, 8
  br label %normalizeFloat32Subnormal.exit

normalizeFloat32Subnormal.exit:                   ; preds = %if.end.19, %if.then.4.i.i
  %a.addr.1.i.i = phi i32 [ %shl8.i.i, %if.then.4.i.i ], [ %shl.a.i.i, %if.end.19 ]
  %shiftCount.1.i.i = phi i8 [ %conv7.i.i, %if.then.4.i.i ], [ %..i.i, %if.end.19 ]
  %shr.i.i = lshr i32 %a.addr.1.i.i, 24
  %idxprom.i.i = zext i32 %shr.i.i to i64
  %arrayidx.i.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i
  %4 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !5
  %conv10.22.i.i = zext i8 %4 to i32
  %conv11.21.i.i = zext i8 %shiftCount.1.i.i to i32
  %add12.i.i = add nuw nsw i32 %conv10.22.i.i, %conv11.21.i.i
  %conv.7.i = shl i32 %add12.i.i, 24
  %sext.i = add i32 %conv.7.i, -134217728
  %conv2.i = ashr exact i32 %sext.i, 24
  %shl.i.82 = shl i32 %and.i, %conv2.i
  %sub4.i = sub nsw i32 1, %conv2.i
  br label %if.end.20

if.end.20:                                        ; preds = %normalizeFloat32Subnormal.exit, %if.end.14
  %aExp.0 = phi i32 [ %sub4.i, %normalizeFloat32Subnormal.exit ], [ %and.i.53, %if.end.14 ]
  %aSig.0 = phi i32 [ %shl.i.82, %normalizeFloat32Subnormal.exit ], [ %and.i, %if.end.14 ]
  %sub = add nsw i32 %aExp.0, -127
  %shr = ashr i32 %sub, 1
  %add = add nsw i32 %shr, 126
  %or21 = shl i32 %aSig.0, 8
  %shl = or i32 %or21, -2147483648
  %5 = lshr i32 %aSig.0, 19
  %and.i.64 = and i32 %5, 15
  %and1.i = and i32 %aExp.0, 1
  %tobool.i = icmp eq i32 %and1.i, 0
  %shr2.i = lshr i32 %shl, 17
  br i1 %tobool.i, label %if.else.i, label %if.then.i

if.then.i:                                        ; preds = %if.end.20
  %conv.i.65 = zext i32 %and.i.64 to i64
  %add.i.66 = add nuw nsw i32 %shr2.i, 16384
  %arrayidx.i = getelementptr inbounds [16 x i16], [16 x i16]* @estimateSqrt32.sqrtOddAdjustments, i64 0, i64 %conv.i.65
  %6 = load i16, i16* %arrayidx.i, align 2, !tbaa !6
  %conv3.i = zext i16 %6 to i32
  %sub.i.67 = sub nsw i32 %add.i.66, %conv3.i
  %div.i = udiv i32 %shl, %sub.i.67
  %shl.i.68 = shl i32 %div.i, 14
  %shl4.i = shl i32 %sub.i.67, 15
  %add5.i = add i32 %shl4.i, %shl.i.68
  %shr6.i = lshr exact i32 %shl, 1
  br label %if.end.21.i

if.else.i:                                        ; preds = %if.end.20
  %add8.i = or i32 %shr2.i, 32768
  %idxprom9.43.i = zext i32 %and.i.64 to i64
  %arrayidx10.i = getelementptr inbounds [16 x i16], [16 x i16]* @estimateSqrt32.sqrtEvenAdjustments, i64 0, i64 %idxprom9.43.i
  %7 = load i16, i16* %arrayidx10.i, align 2, !tbaa !6
  %conv11.i = zext i16 %7 to i32
  %sub12.i = sub nsw i32 %add8.i, %conv11.i
  %div13.i = udiv i32 %shl, %sub12.i
  %add14.i = add i32 %sub12.i, %div13.i
  %cmp.i.69 = icmp ugt i32 %add14.i, 131071
  %shl16.i = shl i32 %add14.i, 15
  %cond.i = select i1 %cmp.i.69, i32 -32768, i32 %shl16.i
  %cmp17.i = icmp ugt i32 %cond.i, %shl
  br i1 %cmp17.i, label %if.end.21.i, label %if.then.19.i

if.then.19.i:                                     ; preds = %if.else.i
  %shr20.i = ashr exact i32 %shl, 1
  br label %estimateSqrt32.exit

if.end.21.i:                                      ; preds = %if.else.i, %if.then.i
  %a.addr.0.i = phi i32 [ %shr6.i, %if.then.i ], [ %shl, %if.else.i ]
  %z.0.i = phi i32 [ %add5.i, %if.then.i ], [ %cond.i, %if.else.i ]
  %cmp.i.71 = icmp ugt i32 %z.0.i, %a.addr.0.i
  br i1 %cmp.i.71, label %if.end.i, label %estimateDiv64To32.exit

if.end.i:                                         ; preds = %if.end.21.i
  %shr.i.72 = lshr i32 %z.0.i, 16
  %shl.i.73 = shl nuw i32 %shr.i.72, 16
  %cmp1.i = icmp ugt i32 %shl.i.73, %a.addr.0.i
  br i1 %cmp1.i, label %cond.false.i, label %cond.end.i

cond.false.i:                                     ; preds = %if.end.i
  %div.i.74 = udiv i32 %a.addr.0.i, %shr.i.72
  %shl2.i = shl i32 %div.i.74, 16
  br label %cond.end.i

cond.end.i:                                       ; preds = %cond.false.i, %if.end.i
  %cond.i.75 = phi i32 [ %shl2.i, %cond.false.i ], [ -65536, %if.end.i ]
  %shr3.i.i = lshr exact i32 %cond.i.75, 16
  %conv5.i.i = and i32 %z.0.i, 65535
  %mul9.i.i = mul nuw i32 %shr3.i.i, %conv5.i.i
  %mul15.i.i = mul nuw i32 %shr3.i.i, %shr.i.72
  %shr17.i.i = lshr i32 %mul9.i.i, 16
  %shl20.i.i = shl i32 %mul9.i.i, 16
  %sub.i.i = sub i32 0, %shl20.i.i
  %cmp.i.39.i = icmp ne i32 %shl20.i.i, 0
  %conv.neg.i.i = sext i1 %cmp.i.39.i to i32
  %add24.i.neg.i = sub i32 %a.addr.0.i, %mul15.i.i
  %sub1.i.i = sub i32 %add24.i.neg.i, %shr17.i.i
  %sub2.i.i = add i32 %sub1.i.i, %conv.neg.i.i
  %cmp3.45.i = icmp slt i32 %sub2.i.i, 0
  br i1 %cmp3.45.i, label %while.body.lr.ph.i, label %while.end.i

while.body.lr.ph.i:                               ; preds = %cond.end.i
  %shl4.i.76 = shl i32 %z.0.i, 16
  br label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %while.body.lr.ph.i
  %z.048.i = phi i32 [ %cond.i.75, %while.body.lr.ph.i ], [ %sub.i.77, %while.body.i ]
  %rem0.047.i = phi i32 [ %sub2.i.i, %while.body.lr.ph.i ], [ %add2.i.i, %while.body.i ]
  %rem1.046.i = phi i32 [ %sub.i.i, %while.body.lr.ph.i ], [ %add.i.37.i, %while.body.i ]
  %sub.i.77 = add i32 %z.048.i, -65536
  %add.i.37.i = add i32 %rem1.046.i, %shl4.i.76
  %add1.i.i = add i32 %rem0.047.i, %shr.i.72
  %cmp.i.38.i = icmp ult i32 %add.i.37.i, %rem1.046.i
  %conv.i.i = zext i1 %cmp.i.38.i to i32
  %add2.i.i = add i32 %add1.i.i, %conv.i.i
  %cmp3.i.78 = icmp slt i32 %add2.i.i, 0
  br i1 %cmp3.i.78, label %while.body.i, label %while.end.i.loopexit

while.end.i.loopexit:                             ; preds = %while.body.i
  %add2.i.i.lcssa = phi i32 [ %add2.i.i, %while.body.i ]
  %add.i.37.i.lcssa = phi i32 [ %add.i.37.i, %while.body.i ]
  %sub.i.77.lcssa = phi i32 [ %sub.i.77, %while.body.i ]
  br label %while.end.i

while.end.i:                                      ; preds = %while.end.i.loopexit, %cond.end.i
  %z.0.lcssa.i = phi i32 [ %cond.i.75, %cond.end.i ], [ %sub.i.77.lcssa, %while.end.i.loopexit ]
  %rem0.0.lcssa.i = phi i32 [ %sub2.i.i, %cond.end.i ], [ %add2.i.i.lcssa, %while.end.i.loopexit ]
  %rem1.0.lcssa.i = phi i32 [ %sub.i.i, %cond.end.i ], [ %add.i.37.i.lcssa, %while.end.i.loopexit ]
  %shl5.i = shl i32 %rem0.0.lcssa.i, 16
  %shr6.i.79 = lshr i32 %rem1.0.lcssa.i, 16
  %or.i.80 = or i32 %shr6.i.79, %shl5.i
  %cmp8.i = icmp ugt i32 %shl.i.73, %or.i.80
  br i1 %cmp8.i, label %cond.false.10.i, label %cond.end.12.i

cond.false.10.i:                                  ; preds = %while.end.i
  %div11.i = udiv i32 %or.i.80, %shr.i.72
  br label %cond.end.12.i

cond.end.12.i:                                    ; preds = %cond.false.10.i, %while.end.i
  %cond13.i = phi i32 [ %div11.i, %cond.false.10.i ], [ 65535, %while.end.i ]
  %or14.i = or i32 %cond13.i, %z.0.lcssa.i
  %phitmp = lshr i32 %or14.i, 1
  br label %estimateDiv64To32.exit

estimateDiv64To32.exit:                           ; preds = %if.end.21.i, %cond.end.12.i
  %retval.0.i.81 = phi i32 [ %phitmp, %cond.end.12.i ], [ 2147483647, %if.end.21.i ]
  %shr23.i = lshr i32 %z.0.i, 1
  %add24.i.70 = add nuw i32 %retval.0.i.81, %shr23.i
  br label %estimateSqrt32.exit

estimateSqrt32.exit:                              ; preds = %if.then.19.i, %estimateDiv64To32.exit
  %retval.0.i = phi i32 [ %add24.i.70, %estimateDiv64To32.exit ], [ %shr20.i, %if.then.19.i ]
  %add23 = add i32 %retval.0.i, 2
  %and = and i32 %add23, 126
  %cmp24 = icmp ult i32 %and, 6
  br i1 %cmp24, label %if.then.25, label %if.end.36

if.then.25:                                       ; preds = %estimateSqrt32.exit
  %cmp26 = icmp ugt i32 %retval.0.i, -3
  br i1 %cmp26, label %roundAndPack, label %if.else

if.else:                                          ; preds = %if.then.25
  %shr29 = lshr i32 %shl, %and1.i
  %shr.i.59 = lshr i32 %add23, 16
  %conv5.i = and i32 %add23, 65535
  %mul.i = mul nuw i32 %conv5.i, %conv5.i
  %mul9.i = mul nuw i32 %shr.i.59, %conv5.i
  %mul15.i = mul nuw i32 %shr.i.59, %shr.i.59
  %add.i.60 = shl i32 %mul9.i, 1
  %cmp.i.61 = icmp ult i32 %add.i.60, %mul9.i
  %conv16.i = zext i1 %cmp.i.61 to i32
  %shl.i.62 = shl nuw nsw i32 %conv16.i, 16
  %8 = lshr i32 %mul9.i, 15
  %shr17.i = and i32 %8, 65535
  %add18.i = or i32 %shl.i.62, %shr17.i
  %shl20.i = shl i32 %mul9.i, 17
  %add21.i = add i32 %shl20.i, %mul.i
  %cmp22.i = icmp ult i32 %add21.i, %shl20.i
  %sub.i = sub i32 0, %add21.i
  %conv23.i.neg = sext i1 %cmp22.i to i32
  %cmp.i.58 = icmp ne i32 %add21.i, 0
  %conv.neg.i = sext i1 %cmp.i.58 to i32
  %add19.i.neg = sub i32 %shr29, %mul15.i
  %add24.i.neg = add i32 %add19.i.neg, %conv23.i.neg
  %sub1.i = add i32 %add24.i.neg, %conv.neg.i
  %sub2.i = sub i32 %sub1.i, %add18.i
  %cmp30.117 = icmp slt i32 %sub2.i, 0
  br i1 %cmp30.117, label %while.body.preheader, label %while.end

while.body.preheader:                             ; preds = %if.else
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %rem1.0120 = phi i32 [ %add.i, %while.body ], [ %sub.i, %while.body.preheader ]
  %rem0.0119 = phi i32 [ %add2.i, %while.body ], [ %sub2.i, %while.body.preheader ]
  %zSig.0118 = phi i32 [ %dec, %while.body ], [ %add23, %while.body.preheader ]
  %dec = add i32 %zSig.0118, -1
  %shl.i.56 = shl i32 %dec, 1
  %shr.i.57 = lshr i32 %dec, 31
  %or31 = or i32 %shl.i.56, 1
  %add.i = add i32 %or31, %rem1.0120
  %add1.i = add i32 %shr.i.57, %rem0.0119
  %cmp.i = icmp ult i32 %add.i, %rem1.0120
  %conv.i.55 = zext i1 %cmp.i to i32
  %add2.i = add i32 %add1.i, %conv.i.55
  %cmp30 = icmp slt i32 %add2.i, 0
  br i1 %cmp30, label %while.body, label %while.end.loopexit

while.end.loopexit:                               ; preds = %while.body
  %add2.i.lcssa = phi i32 [ %add2.i, %while.body ]
  %add.i.lcssa = phi i32 [ %add.i, %while.body ]
  %dec.lcssa = phi i32 [ %dec, %while.body ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %if.else
  %rem1.0.lcssa = phi i32 [ %sub.i, %if.else ], [ %add.i.lcssa, %while.end.loopexit ]
  %rem0.0.lcssa = phi i32 [ %sub2.i, %if.else ], [ %add2.i.lcssa, %while.end.loopexit ]
  %zSig.0.lcssa = phi i32 [ %add23, %if.else ], [ %dec.lcssa, %while.end.loopexit ]
  %or32 = or i32 %rem1.0.lcssa, %rem0.0.lcssa
  %cmp33 = icmp ne i32 %or32, 0
  %conv = zext i1 %cmp33 to i32
  %or34 = or i32 %conv, %zSig.0.lcssa
  br label %if.end.36

if.end.36:                                        ; preds = %while.end, %estimateSqrt32.exit
  %zSig.1 = phi i32 [ %or34, %while.end ], [ %add23, %estimateSqrt32.exit ]
  %shr.i.54 = lshr i32 %zSig.1, 1
  %shl.i.mask = and i32 %zSig.1, 1
  %or.i = or i32 %shl.i.mask, %shr.i.54
  br label %roundAndPack

roundAndPack:                                     ; preds = %if.then.25, %if.end.36
  %zSig.2 = phi i32 [ %or.i, %if.end.36 ], [ 2147483647, %if.then.25 ]
  %call37 = tail call fastcc zeroext i32 @roundAndPackFloat32(i8 signext 0, i32 signext %add, i32 zeroext %zSig.2)
  br label %cleanup

cleanup:                                          ; preds = %if.then.8.i, %if.then.16, %if.then.10, %if.end, %roundAndPack, %if.end.13, %if.end.7
  %retval.0 = phi i32 [ -4194304, %if.end.7 ], [ -4194304, %if.end.13 ], [ %call37, %roundAndPack ], [ %a, %if.end ], [ %a, %if.then.10 ], [ 0, %if.then.16 ], [ %or.i.85, %if.then.8.i ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float32_eq(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 2139095040
  %cmp = icmp ne i32 %and.i, 2139095040
  %and.i.37 = and i32 %a, 8388607
  %tobool = icmp eq i32 %and.i.37, 0
  %or.cond = or i1 %cmp, %tobool
  br i1 %or.cond, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %and.i.36 = and i32 %b, 2139095040
  %cmp3 = icmp ne i32 %and.i.36, 2139095040
  %and.i.34 = and i32 %b, 8388607
  %tobool6 = icmp eq i32 %and.i.34, 0
  %or.cond38 = or i1 %cmp3, %tobool6
  br i1 %or.cond38, label %if.end.14, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  %and.i.29 = and i32 %a, 2143289344
  %and1.i.31 = and i32 %a, 4194303
  %tobool839 = icmp eq i32 %and1.i.31, 0
  %not.cmp.i.30 = icmp ne i32 %and.i.29, 2139095040
  %tobool8 = or i1 %not.cmp.i.30, %tobool839
  br i1 %tobool8, label %lor.lhs.false.9, label %if.then.13

lor.lhs.false.9:                                  ; preds = %if.then
  %and.i.28 = and i32 %b, 2143289344
  %and1.i = and i32 %b, 4194303
  %tobool1240 = icmp eq i32 %and1.i, 0
  %not.cmp.i = icmp ne i32 %and.i.28, 2139095040
  %tobool12 = or i1 %not.cmp.i, %tobool1240
  br i1 %tobool12, label %return, label %if.then.13

if.then.13:                                       ; preds = %lor.lhs.false.9, %if.then
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %return

if.end.14:                                        ; preds = %lor.lhs.false
  %cmp15 = icmp eq i32 %a, %b
  br i1 %cmp15, label %return, label %lor.rhs

lor.rhs:                                          ; preds = %if.end.14
  %or = or i32 %b, %a
  %shl.mask = and i32 %or, 2147483647
  %cmp17 = icmp eq i32 %shl.mask, 0
  %phitmp = zext i1 %cmp17 to i8
  br label %return

return:                                           ; preds = %if.end.14, %lor.rhs, %if.then.13, %lor.lhs.false.9
  %retval.0 = phi i8 [ 0, %lor.lhs.false.9 ], [ 0, %if.then.13 ], [ 1, %if.end.14 ], [ %phitmp, %lor.rhs ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float32_le(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 2139095040
  %cmp = icmp ne i32 %and.i, 2139095040
  %and.i.49 = and i32 %a, 8388607
  %tobool = icmp eq i32 %and.i.49, 0
  %or.cond = or i1 %cmp, %tobool
  br i1 %or.cond, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %and.i.48 = and i32 %b, 2139095040
  %cmp3 = icmp ne i32 %and.i.48, 2139095040
  %and.i.46 = and i32 %b, 8388607
  %tobool6 = icmp eq i32 %and.i.46, 0
  %or.cond50 = or i1 %cmp3, %tobool6
  br i1 %or.cond50, label %if.end, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end:                                           ; preds = %lor.lhs.false
  %shr.i.44 = lshr i32 %a, 31
  %conv.i.45 = trunc i32 %shr.i.44 to i8
  %shr.i.43 = lshr i32 %b, 31
  %conv.i = trunc i32 %shr.i.43 to i8
  %cmp10 = icmp eq i8 %conv.i.45, %conv.i
  br i1 %cmp10, label %if.end.18, label %if.then.12

if.then.12:                                       ; preds = %if.end
  %tobool14 = icmp eq i8 %conv.i.45, 0
  br i1 %tobool14, label %lor.rhs, label %cleanup

lor.rhs:                                          ; preds = %if.then.12
  %or = or i32 %b, %a
  %shl.mask = and i32 %or, 2147483647
  %cmp15 = icmp eq i32 %shl.mask, 0
  %phitmp42 = zext i1 %cmp15 to i8
  br label %cleanup

if.end.18:                                        ; preds = %if.end
  %cmp19 = icmp eq i32 %a, %b
  %cmp23 = icmp ult i32 %a, %b
  %conv24 = zext i1 %cmp23 to i32
  %tobool25 = icmp ne i32 %shr.i.44, %conv24
  %phitmp = zext i1 %tobool25 to i8
  %1 = select i1 %cmp19, i8 1, i8 %phitmp
  br label %cleanup

cleanup:                                          ; preds = %if.end.18, %lor.rhs, %if.then.12, %if.then
  %retval.0 = phi i8 [ 0, %if.then ], [ 1, %if.then.12 ], [ %phitmp42, %lor.rhs ], [ %1, %if.end.18 ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float32_lt(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 2139095040
  %cmp = icmp ne i32 %and.i, 2139095040
  %and.i.49 = and i32 %a, 8388607
  %tobool = icmp eq i32 %and.i.49, 0
  %or.cond = or i1 %cmp, %tobool
  br i1 %or.cond, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %and.i.48 = and i32 %b, 2139095040
  %cmp3 = icmp ne i32 %and.i.48, 2139095040
  %and.i.46 = and i32 %b, 8388607
  %tobool6 = icmp eq i32 %and.i.46, 0
  %or.cond50 = or i1 %cmp3, %tobool6
  br i1 %or.cond50, label %if.end, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end:                                           ; preds = %lor.lhs.false
  %shr.i.44 = lshr i32 %a, 31
  %conv.i.45 = trunc i32 %shr.i.44 to i8
  %shr.i.43 = lshr i32 %b, 31
  %conv.i = trunc i32 %shr.i.43 to i8
  %cmp10 = icmp eq i8 %conv.i.45, %conv.i
  br i1 %cmp10, label %if.end.18, label %if.then.12

if.then.12:                                       ; preds = %if.end
  %tobool14 = icmp eq i8 %conv.i.45, 0
  br i1 %tobool14, label %cleanup, label %land.rhs

land.rhs:                                         ; preds = %if.then.12
  %or = or i32 %b, %a
  %shl.mask = and i32 %or, 2147483647
  %cmp15 = icmp ne i32 %shl.mask, 0
  %phitmp42 = zext i1 %cmp15 to i8
  br label %cleanup

if.end.18:                                        ; preds = %if.end
  %cmp19 = icmp eq i32 %a, %b
  %cmp23 = icmp ult i32 %a, %b
  %conv24 = zext i1 %cmp23 to i32
  %tobool25 = icmp ne i32 %shr.i.44, %conv24
  %phitmp = zext i1 %tobool25 to i8
  %1 = select i1 %cmp19, i8 0, i8 %phitmp
  br label %cleanup

cleanup:                                          ; preds = %if.end.18, %land.rhs, %if.then.12, %if.then
  %retval.0 = phi i8 [ 0, %if.then ], [ 0, %if.then.12 ], [ %phitmp42, %land.rhs ], [ %1, %if.end.18 ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float32_eq_signaling(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 2139095040
  %cmp = icmp ne i32 %and.i, 2139095040
  %and.i.18 = and i32 %a, 8388607
  %tobool = icmp eq i32 %and.i.18, 0
  %or.cond = or i1 %cmp, %tobool
  br i1 %or.cond, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %and.i.17 = and i32 %b, 2139095040
  %cmp3 = icmp ne i32 %and.i.17, 2139095040
  %and.i.15 = and i32 %b, 8388607
  %tobool6 = icmp eq i32 %and.i.15, 0
  %or.cond19 = or i1 %cmp3, %tobool6
  br i1 %or.cond19, label %if.end, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %return

if.end:                                           ; preds = %lor.lhs.false
  %cmp7 = icmp eq i32 %a, %b
  br i1 %cmp7, label %return, label %lor.rhs

lor.rhs:                                          ; preds = %if.end
  %or = or i32 %b, %a
  %shl.mask = and i32 %or, 2147483647
  %cmp8 = icmp eq i32 %shl.mask, 0
  %phitmp = zext i1 %cmp8 to i8
  br label %return

return:                                           ; preds = %if.end, %lor.rhs, %if.then
  %retval.0 = phi i8 [ 0, %if.then ], [ 1, %if.end ], [ %phitmp, %lor.rhs ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float32_le_quiet(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 2139095040
  %cmp = icmp ne i32 %and.i, 2139095040
  %and.i.70 = and i32 %a, 8388607
  %tobool = icmp eq i32 %and.i.70, 0
  %or.cond = or i1 %cmp, %tobool
  br i1 %or.cond, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %and.i.69 = and i32 %b, 2139095040
  %cmp3 = icmp ne i32 %and.i.69, 2139095040
  %and.i.67 = and i32 %b, 8388607
  %tobool6 = icmp eq i32 %and.i.67, 0
  %or.cond71 = or i1 %cmp3, %tobool6
  br i1 %or.cond71, label %if.end.14, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  %and.i.62 = and i32 %a, 2143289344
  %and1.i.64 = and i32 %a, 4194303
  %tobool872 = icmp eq i32 %and1.i.64, 0
  %not.cmp.i.63 = icmp ne i32 %and.i.62, 2139095040
  %tobool8 = or i1 %not.cmp.i.63, %tobool872
  br i1 %tobool8, label %lor.lhs.false.9, label %if.then.13

lor.lhs.false.9:                                  ; preds = %if.then
  %and.i.61 = and i32 %b, 2143289344
  %and1.i = and i32 %b, 4194303
  %tobool1273 = icmp eq i32 %and1.i, 0
  %not.cmp.i = icmp ne i32 %and.i.61, 2139095040
  %tobool12 = or i1 %not.cmp.i, %tobool1273
  br i1 %tobool12, label %cleanup, label %if.then.13

if.then.13:                                       ; preds = %lor.lhs.false.9, %if.then
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.14:                                        ; preds = %lor.lhs.false
  %shr.i.59 = lshr i32 %a, 31
  %conv.i.60 = trunc i32 %shr.i.59 to i8
  %shr.i.58 = lshr i32 %b, 31
  %conv.i = trunc i32 %shr.i.58 to i8
  %cmp19 = icmp eq i8 %conv.i.60, %conv.i
  br i1 %cmp19, label %if.end.27, label %if.then.21

if.then.21:                                       ; preds = %if.end.14
  %tobool23 = icmp eq i8 %conv.i.60, 0
  br i1 %tobool23, label %lor.rhs, label %cleanup

lor.rhs:                                          ; preds = %if.then.21
  %or = or i32 %b, %a
  %shl.mask = and i32 %or, 2147483647
  %cmp24 = icmp eq i32 %shl.mask, 0
  %phitmp57 = zext i1 %cmp24 to i8
  br label %cleanup

if.end.27:                                        ; preds = %if.end.14
  %cmp28 = icmp eq i32 %a, %b
  %cmp32 = icmp ult i32 %a, %b
  %conv33 = zext i1 %cmp32 to i32
  %tobool34 = icmp ne i32 %shr.i.59, %conv33
  %phitmp = zext i1 %tobool34 to i8
  %1 = select i1 %cmp28, i8 1, i8 %phitmp
  br label %cleanup

cleanup:                                          ; preds = %if.end.27, %lor.rhs, %if.then.21, %if.then.13, %lor.lhs.false.9
  %retval.0 = phi i8 [ 0, %lor.lhs.false.9 ], [ 0, %if.then.13 ], [ 1, %if.then.21 ], [ %phitmp57, %lor.rhs ], [ %1, %if.end.27 ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float32_lt_quiet(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 2139095040
  %cmp = icmp ne i32 %and.i, 2139095040
  %and.i.66 = and i32 %a, 8388607
  %tobool = icmp eq i32 %and.i.66, 0
  %or.cond = or i1 %cmp, %tobool
  br i1 %or.cond, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %and.i.65 = and i32 %b, 2139095040
  %cmp3 = icmp ne i32 %and.i.65, 2139095040
  %and.i.63 = and i32 %b, 8388607
  %tobool6 = icmp eq i32 %and.i.63, 0
  %or.cond67 = or i1 %cmp3, %tobool6
  br i1 %or.cond67, label %if.end.14, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  %and.i.58 = and i32 %a, 2143289344
  %and1.i.60 = and i32 %a, 4194303
  %tobool868 = icmp eq i32 %and1.i.60, 0
  %not.cmp.i.59 = icmp ne i32 %and.i.58, 2139095040
  %tobool8 = or i1 %not.cmp.i.59, %tobool868
  br i1 %tobool8, label %lor.lhs.false.9, label %if.then.13

lor.lhs.false.9:                                  ; preds = %if.then
  %and.i.57 = and i32 %b, 2143289344
  %and1.i = and i32 %b, 4194303
  %tobool1269 = icmp eq i32 %and1.i, 0
  %not.cmp.i = icmp ne i32 %and.i.57, 2139095040
  %tobool12 = or i1 %not.cmp.i, %tobool1269
  br i1 %tobool12, label %cleanup, label %if.then.13

if.then.13:                                       ; preds = %lor.lhs.false.9, %if.then
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.14:                                        ; preds = %lor.lhs.false
  %shr.i.55 = lshr i32 %a, 31
  %conv.i.56 = trunc i32 %shr.i.55 to i8
  %shr.i.54 = lshr i32 %b, 31
  %conv.i = trunc i32 %shr.i.54 to i8
  %cmp19 = icmp eq i8 %conv.i.56, %conv.i
  br i1 %cmp19, label %if.end.27, label %if.then.21

if.then.21:                                       ; preds = %if.end.14
  %tobool23 = icmp eq i8 %conv.i.56, 0
  br i1 %tobool23, label %cleanup, label %land.rhs

land.rhs:                                         ; preds = %if.then.21
  %or = or i32 %b, %a
  %shl.mask = and i32 %or, 2147483647
  %cmp24 = icmp ne i32 %shl.mask, 0
  %phitmp53 = zext i1 %cmp24 to i8
  br label %cleanup

if.end.27:                                        ; preds = %if.end.14
  %cmp28 = icmp eq i32 %a, %b
  %cmp32 = icmp ult i32 %a, %b
  %conv33 = zext i1 %cmp32 to i32
  %tobool34 = icmp ne i32 %shr.i.55, %conv33
  %phitmp = zext i1 %tobool34 to i8
  %1 = select i1 %cmp28, i8 0, i8 %phitmp
  br label %cleanup

cleanup:                                          ; preds = %if.end.27, %land.rhs, %if.then.21, %if.then.13, %lor.lhs.false.9
  %retval.0 = phi i8 [ 0, %lor.lhs.false.9 ], [ 0, %if.then.13 ], [ 0, %if.then.21 ], [ %phitmp53, %land.rhs ], [ %1, %if.end.27 ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i32 @float64_to_int32(i64 %a.coerce) #2 {
entry:
  %a.sroa.1.0.extract.trunc.i = trunc i64 %a.coerce to i32
  %a.sroa.0.0.extract.shift.i.122 = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc.i = trunc i64 %a.sroa.0.0.extract.shift.i.122 to i32
  %and.i.123 = and i32 %a.sroa.0.0.extract.trunc.i, 1048575
  %a.sroa.0.0.extract.shift.i.119 = lshr i64 %a.coerce, 52
  %shr.i.120 = trunc i64 %a.sroa.0.0.extract.shift.i.119 to i32
  %and.i.121 = and i32 %shr.i.120, 2047
  %a.sroa.0.0.extract.shift.i = lshr i64 %a.coerce, 63
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i to i8
  %sub = add nsw i32 %and.i.121, -1043
  %cmp = icmp sgt i32 %sub, -1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %cmp4 = icmp ugt i32 %and.i.121, 1054
  br i1 %cmp4, label %if.then.5, label %if.end.8

if.then.5:                                        ; preds = %if.then
  %cmp6 = icmp ne i32 %and.i.121, 2047
  %or = or i32 %and.i.123, %a.sroa.1.0.extract.trunc.i
  %tobool = icmp eq i32 %or, 0
  %or.cond118 = or i1 %cmp6, %tobool
  %call3. = select i1 %or.cond118, i8 %conv.i, i8 0
  br label %invalid

if.end.8:                                         ; preds = %if.then
  %or9 = or i32 %and.i.123, 1048576
  %shl.i = shl i32 %a.sroa.1.0.extract.trunc.i, %sub
  %cmp.i = icmp eq i32 %sub, 0
  br i1 %cmp.i, label %shortShift64Left.exit, label %cond.false.i

cond.false.i:                                     ; preds = %if.end.8
  %shl1.i = shl i32 %or9, %sub
  %sub.i = sub nsw i32 1043, %shr.i.120
  %and.i = and i32 %sub.i, 31
  %shr.i = lshr i32 %a.sroa.1.0.extract.trunc.i, %and.i
  %or.i = or i32 %shr.i, %shl1.i
  br label %shortShift64Left.exit

shortShift64Left.exit:                            ; preds = %if.end.8, %cond.false.i
  %cond.i = phi i32 [ %or.i, %cond.false.i ], [ %or9, %if.end.8 ]
  %cmp10 = icmp ugt i32 %cond.i, -2147483648
  br i1 %cmp10, label %invalid, label %if.end.24

if.else:                                          ; preds = %entry
  %cmp13 = icmp ne i32 %a.sroa.1.0.extract.trunc.i, 0
  %conv = zext i1 %cmp13 to i32
  %cmp14 = icmp ult i32 %and.i.121, 1022
  br i1 %cmp14, label %if.then.16, label %if.else.19

if.then.16:                                       ; preds = %if.else
  %or17 = or i32 %and.i.121, %and.i.123
  %or18 = or i32 %or17, %conv
  br label %if.end.24

if.else.19:                                       ; preds = %if.else
  %or20 = or i32 %and.i.123, 1048576
  %fold = add nuw nsw i32 %shr.i.120, 13
  %and = and i32 %fold, 31
  %shl = shl i32 %or20, %and
  %or21 = or i32 %shl, %conv
  %sub22 = sub nsw i32 1043, %and.i.121
  %shr = lshr i32 %or20, %sub22
  br label %if.end.24

if.end.24:                                        ; preds = %if.then.16, %if.else.19, %shortShift64Left.exit
  %absZ.0 = phi i32 [ %cond.i, %shortShift64Left.exit ], [ 0, %if.then.16 ], [ %shr, %if.else.19 ]
  %aSigExtra.0 = phi i32 [ %shl.i, %shortShift64Left.exit ], [ %or18, %if.then.16 ], [ %or21, %if.else.19 ]
  %0 = load i8, i8* @float_rounding_mode, align 1, !tbaa !5
  %cmp26 = icmp eq i8 %0, 0
  br i1 %cmp26, label %if.then.28, label %if.else.42

if.then.28:                                       ; preds = %if.end.24
  %cmp29 = icmp slt i32 %aSigExtra.0, 0
  br i1 %cmp29, label %if.then.31, label %if.end.38

if.then.31:                                       ; preds = %if.then.28
  %inc = add i32 %absZ.0, 1
  %shl32.mask = and i32 %aSigExtra.0, 2147483647
  %cmp33 = icmp eq i32 %shl32.mask, 0
  %and36 = and i32 %inc, -2
  %and36.inc = select i1 %cmp33, i32 %and36, i32 %inc
  br label %if.end.38

if.end.38:                                        ; preds = %if.then.31, %if.then.28
  %absZ.1 = phi i32 [ %absZ.0, %if.then.28 ], [ %and36.inc, %if.then.31 ]
  %tobool40 = icmp ne i8 %conv.i, 0
  %sub41 = sub i32 0, %absZ.1
  %cond = select i1 %tobool40, i32 %sub41, i32 %absZ.1
  br label %if.end.59

if.else.42:                                       ; preds = %if.end.24
  %cmp43 = icmp ne i32 %aSigExtra.0, 0
  %conv44 = zext i1 %cmp43 to i32
  %tobool45 = icmp eq i8 %conv.i, 0
  br i1 %tobool45, label %if.else.52, label %if.then.46

if.then.46:                                       ; preds = %if.else.42
  %cmp48 = icmp eq i8 %0, 1
  %and50117 = and i1 %cmp43, %cmp48
  %and50 = zext i1 %and50117 to i32
  %add = add i32 %absZ.0, %and50
  %sub51 = sub i32 0, %add
  br label %if.end.59

if.else.52:                                       ; preds = %if.else.42
  %cmp54 = icmp eq i8 %0, 2
  %and56115 = and i1 %cmp43, %cmp54
  %and56 = zext i1 %and56115 to i32
  %add57 = add i32 %and56, %absZ.0
  br label %if.end.59

if.end.59:                                        ; preds = %if.then.46, %if.else.52, %if.end.38
  %aSigExtra.1 = phi i32 [ %aSigExtra.0, %if.end.38 ], [ %conv44, %if.else.52 ], [ %conv44, %if.then.46 ]
  %z.0 = phi i32 [ %cond, %if.end.38 ], [ %add57, %if.else.52 ], [ %sub51, %if.then.46 ]
  %1 = trunc i64 %a.sroa.0.0.extract.shift.i to i32
  %z.0.lobit = lshr i32 %z.0, 31
  %tobool63 = icmp ne i32 %1, %z.0.lobit
  %tobool65 = icmp ne i32 %z.0, 0
  %or.cond = and i1 %tobool65, %tobool63
  br i1 %or.cond, label %invalid, label %if.end.70

invalid:                                          ; preds = %if.then.5, %if.end.59, %shortShift64Left.exit
  %aSign.0 = phi i8 [ %conv.i, %shortShift64Left.exit ], [ %conv.i, %if.end.59 ], [ %call3., %if.then.5 ]
  %2 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %2, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  %tobool68 = icmp ne i8 %aSign.0, 0
  %cond69 = select i1 %tobool68, i32 -2147483648, i32 2147483647
  br label %cleanup

if.end.70:                                        ; preds = %if.end.59
  %tobool71 = icmp eq i32 %aSigExtra.1, 0
  br i1 %tobool71, label %cleanup, label %if.then.72

if.then.72:                                       ; preds = %if.end.70
  %3 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv73.116 = zext i8 %3 to i32
  %or74 = or i32 %conv73.116, 32
  %conv75 = trunc i32 %or74 to i8
  store i8 %conv75, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

cleanup:                                          ; preds = %if.then.72, %if.end.70, %invalid
  %retval.0 = phi i32 [ %cond69, %invalid ], [ %z.0, %if.end.70 ], [ %z.0, %if.then.72 ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define signext i32 @float64_to_int32_round_to_zero(i64 %a.coerce) #2 {
entry:
  %a.sroa.1.0.extract.trunc.i = trunc i64 %a.coerce to i32
  %a.sroa.0.0.extract.shift.i.83 = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc.i = trunc i64 %a.sroa.0.0.extract.shift.i.83 to i32
  %and.i.84 = and i32 %a.sroa.0.0.extract.trunc.i, 1048575
  %a.sroa.0.0.extract.shift.i.80 = lshr i64 %a.coerce, 52
  %shr.i.81 = trunc i64 %a.sroa.0.0.extract.shift.i.80 to i32
  %and.i.82 = and i32 %shr.i.81, 2047
  %a.sroa.0.0.extract.shift.i = lshr i64 %a.coerce, 63
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i to i8
  %sub = add nsw i32 %and.i.82, -1043
  %cmp = icmp sgt i32 %sub, -1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %cmp4 = icmp ugt i32 %and.i.82, 1054
  br i1 %cmp4, label %if.then.5, label %if.end.8

if.then.5:                                        ; preds = %if.then
  %cmp6 = icmp ne i32 %and.i.82, 2047
  %or = or i32 %and.i.84, %a.sroa.1.0.extract.trunc.i
  %tobool = icmp eq i32 %or, 0
  %or.cond79 = or i1 %cmp6, %tobool
  %call3. = select i1 %or.cond79, i8 %conv.i, i8 0
  br label %invalid

if.end.8:                                         ; preds = %if.then
  %or9 = or i32 %and.i.84, 1048576
  %shl.i = shl i32 %a.sroa.1.0.extract.trunc.i, %sub
  %cmp.i = icmp eq i32 %sub, 0
  br i1 %cmp.i, label %if.end.23, label %cond.false.i

cond.false.i:                                     ; preds = %if.end.8
  %shl1.i = shl i32 %or9, %sub
  %sub.i = sub nsw i32 1043, %shr.i.81
  %and.i = and i32 %sub.i, 31
  %shr.i = lshr i32 %a.sroa.1.0.extract.trunc.i, %and.i
  %or.i = or i32 %shr.i, %shl1.i
  br label %if.end.23

if.else:                                          ; preds = %entry
  %cmp10 = icmp ult i32 %and.i.82, 1023
  br i1 %cmp10, label %if.then.11, label %if.end.19

if.then.11:                                       ; preds = %if.else
  %or12 = or i32 %and.i.84, %a.sroa.1.0.extract.trunc.i
  %or13 = or i32 %or12, %and.i.82
  %tobool14 = icmp eq i32 %or13, 0
  br i1 %tobool14, label %cleanup, label %if.then.15

if.then.15:                                       ; preds = %if.then.11
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv.78 = zext i8 %0 to i32
  %or16 = or i32 %conv.78, 32
  %conv17 = trunc i32 %or16 to i8
  store i8 %conv17, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.19:                                        ; preds = %if.else
  %or20 = or i32 %and.i.84, 1048576
  %fold = add nuw nsw i32 %shr.i.81, 13
  %and = and i32 %fold, 31
  %shl = shl i32 %or20, %and
  %or21 = or i32 %shl, %a.sroa.1.0.extract.trunc.i
  %sub22 = sub nsw i32 1043, %and.i.82
  %shr = lshr i32 %or20, %sub22
  br label %if.end.23

if.end.23:                                        ; preds = %cond.false.i, %if.end.8, %if.end.19
  %absZ.0 = phi i32 [ %shr, %if.end.19 ], [ %or.i, %cond.false.i ], [ %or9, %if.end.8 ]
  %aSigExtra.0 = phi i32 [ %or21, %if.end.19 ], [ %shl.i, %cond.false.i ], [ %shl.i, %if.end.8 ]
  %1 = trunc i64 %a.sroa.0.0.extract.shift.i to i32
  %tobool25 = icmp ne i8 %conv.i, 0
  %sub26 = sub i32 0, %absZ.0
  %cond = select i1 %tobool25, i32 %sub26, i32 %absZ.0
  %cond.lobit = lshr i32 %cond, 31
  %tobool30 = icmp ne i32 %1, %cond.lobit
  %tobool32 = icmp ne i32 %absZ.0, 0
  %or.cond = and i1 %tobool32, %tobool30
  br i1 %or.cond, label %invalid, label %if.end.37

invalid:                                          ; preds = %if.then.5, %if.end.23
  %aSign.0 = phi i8 [ %conv.i, %if.end.23 ], [ %call3., %if.then.5 ]
  %2 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %2, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  %tobool35 = icmp ne i8 %aSign.0, 0
  %cond36 = select i1 %tobool35, i32 -2147483648, i32 2147483647
  br label %cleanup

if.end.37:                                        ; preds = %if.end.23
  %tobool38 = icmp eq i32 %aSigExtra.0, 0
  br i1 %tobool38, label %cleanup, label %if.then.39

if.then.39:                                       ; preds = %if.end.37
  %3 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv40.77 = zext i8 %3 to i32
  %or41 = or i32 %conv40.77, 32
  %conv42 = trunc i32 %or41 to i8
  store i8 %conv42, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

cleanup:                                          ; preds = %if.then.39, %if.end.37, %if.then.15, %if.then.11, %invalid
  %retval.0 = phi i32 [ %cond36, %invalid ], [ 0, %if.then.11 ], [ 0, %if.then.15 ], [ %cond, %if.end.37 ], [ %cond, %if.then.39 ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define zeroext i32 @float64_to_float32(i64 %a.coerce) #2 {
entry:
  %a.sroa.1.0.extract.trunc.i = trunc i64 %a.coerce to i32
  %a.sroa.0.0.extract.shift.i = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc.i = trunc i64 %a.sroa.0.0.extract.shift.i to i32
  %and.i = and i32 %a.sroa.0.0.extract.trunc.i, 1048575
  %a.sroa.0.0.extract.shift.i.38 = lshr i64 %a.coerce, 52
  %shr.i.39 = trunc i64 %a.sroa.0.0.extract.shift.i.38 to i32
  %and.i.40 = and i32 %shr.i.39, 2047
  %a.sroa.0.0.extract.shift.i.37 = lshr i64 %a.coerce, 63
  %cmp = icmp eq i32 %and.i.40, 2047
  br i1 %cmp, label %if.then, label %if.end.8

if.then:                                          ; preds = %entry
  %or = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %if.end, label %if.then.4

if.then.4:                                        ; preds = %if.then
  %a.sroa.0.0.insert.shift.i = shl nuw i64 %a.sroa.0.0.extract.shift.i, 32
  %and.i.i = and i64 %a.sroa.0.0.insert.shift.i, 9221120237041090560
  %cmp.i.i = icmp eq i64 %and.i.i, 9218868437227405312
  br i1 %cmp.i.i, label %land.rhs.i.i, label %float64ToCommonNaN.exit

land.rhs.i.i:                                     ; preds = %if.then.4
  %tobool.i.i = icmp eq i32 %a.sroa.1.0.extract.trunc.i, 0
  %and2.i.i = and i64 %a.sroa.0.0.insert.shift.i, 2251795518717952
  %tobool3.i.i = icmp eq i64 %and2.i.i, 0
  %or.cond.i = and i1 %tobool.i.i, %tobool3.i.i
  br i1 %or.cond.i, label %float64ToCommonNaN.exit, label %if.then.i

if.then.i:                                        ; preds = %land.rhs.i.i
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.i = or i8 %0, 1
  store i8 %or3.i.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %float64ToCommonNaN.exit

float64ToCommonNaN.exit:                          ; preds = %if.then.4, %land.rhs.i.i, %if.then.i
  %shl1.i19.i = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i, 12
  %shl1.i.i = trunc i64 %shl1.i19.i to i32
  %shr.i.i = lshr i32 %a.sroa.1.0.extract.trunc.i, 20
  %or.i.i = or i32 %shl1.i.i, %shr.i.i
  %shl8.i = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i.37, 31
  %shl.i.33 = trunc i64 %shl8.i to i32
  %shr.i.34 = lshr i32 %or.i.i, 9
  %or.i.35 = or i32 %shl.i.33, %shr.i.34
  %or1.i = or i32 %or.i.35, 2143289344
  br label %cleanup

if.end:                                           ; preds = %if.then
  %shl.i.3144 = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i.37, 31
  %shl.i.31 = trunc i64 %shl.i.3144 to i32
  %add.i = or i32 %shl.i.31, 2139095040
  br label %cleanup

if.end.8:                                         ; preds = %entry
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i.37 to i8
  %shl.i = shl nuw nsw i32 %and.i, 10
  %shr.i = lshr i32 %a.sroa.1.0.extract.trunc.i, 22
  %or.i = or i32 %shl.i, %shr.i
  %shl7.i.mask = and i32 %a.sroa.1.0.extract.trunc.i, 4194303
  %cmp8.i = icmp ne i32 %shl7.i.mask, 0
  %conv9.i = zext i1 %cmp8.i to i32
  %or10.i = or i32 %or.i, %conv9.i
  %tobool9 = icmp eq i32 %and.i.40, 0
  %or11 = or i32 %or10.i, 1073741824
  %or10.i.or11 = select i1 %tobool9, i32 %or10.i, i32 %or11
  %sub = add nsw i32 %and.i.40, -897
  %call13 = tail call fastcc zeroext i32 @roundAndPackFloat32(i8 signext %conv.i, i32 signext %sub, i32 zeroext %or10.i.or11)
  br label %cleanup

cleanup:                                          ; preds = %if.end.8, %if.end, %float64ToCommonNaN.exit
  %retval.0 = phi i32 [ %or1.i, %float64ToCommonNaN.exit ], [ %add.i, %if.end ], [ %call13, %if.end.8 ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
define i64 @float64_round_to_int(i64 %a.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %a.sroa.15.0.extract.trunc = trunc i64 %a.coerce to i32
  %a.sroa.0.0.insert.shift240 = shl nuw i64 %a.sroa.0.0.extract.shift, 32
  %a.sroa.0.0.insert.mask241 = and i64 %a.coerce, 4294967295
  %a.sroa.0.0.insert.insert242 = or i64 %a.sroa.0.0.insert.shift240, %a.sroa.0.0.insert.mask241
  %a.sroa.0.0.extract.shift.i = lshr i64 %a.coerce, 52
  %shr.i = trunc i64 %a.sroa.0.0.extract.shift.i to i32
  %and.i = and i32 %shr.i, 2047
  %cmp = icmp ugt i32 %and.i, 1042
  br i1 %cmp, label %if.then, label %if.else.62

if.then:                                          ; preds = %entry
  %cmp1 = icmp ugt i32 %and.i, 1074
  br i1 %cmp1, label %if.then.2, label %if.end.8

if.then.2:                                        ; preds = %if.then
  %cmp3 = icmp eq i32 %and.i, 2047
  br i1 %cmp3, label %land.lhs.true, label %cleanup

land.lhs.true:                                    ; preds = %if.then.2
  %and.i.322 = and i32 %a.sroa.0.0.extract.trunc, 1048575
  %or = or i32 %and.i.322, %a.sroa.15.0.extract.trunc
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %cleanup, label %if.then.6

if.then.6:                                        ; preds = %land.lhs.true
  %call7 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.sroa.0.0.insert.insert242, i64 %a.sroa.0.0.insert.insert242)
  %retval.sroa.0.0.extract.shift = lshr i64 %call7, 32
  %retval.sroa.0.0.extract.trunc = trunc i64 %retval.sroa.0.0.extract.shift to i32
  %retval.sroa.11.0.extract.trunc = trunc i64 %call7 to i32
  br label %cleanup

if.end.8:                                         ; preds = %if.then
  %sub = sub nsw i32 1074, %and.i
  %shl9 = shl i32 2, %sub
  %sub10 = add i32 %shl9, -1
  %0 = load i8, i8* @float_rounding_mode, align 1, !tbaa !5
  switch i8 %0, label %if.then.44 [
    i8 0, label %if.then.13
    i8 3, label %if.end.58
  ]

if.then.13:                                       ; preds = %if.end.8
  %tobool14 = icmp ult i32 %sub, 31
  br i1 %tobool14, label %if.then.15, label %if.else

if.then.15:                                       ; preds = %if.then.13
  %shr = lshr i32 %shl9, 1
  %add.i.316 = add i32 %shr, %a.sroa.15.0.extract.trunc
  %cmp.i.317 = icmp ult i32 %add.i.316, %a.sroa.15.0.extract.trunc
  %conv.i.318 = zext i1 %cmp.i.317 to i32
  %add2.i.319 = add i32 %conv.i.318, %a.sroa.0.0.extract.trunc
  %and = and i32 %add.i.316, %sub10
  %cmp19 = icmp eq i32 %and, 0
  br i1 %cmp19, label %if.then.21, label %if.end.58

if.then.21:                                       ; preds = %if.then.15
  %neg = xor i32 %shl9, -1
  %and23 = and i32 %add.i.316, %neg
  br label %if.end.58

if.else:                                          ; preds = %if.then.13
  %cmp26 = icmp slt i32 %a.sroa.15.0.extract.trunc, 0
  br i1 %cmp26, label %if.then.28, label %if.end.58

if.then.28:                                       ; preds = %if.else
  %inc = add i32 %a.sroa.0.0.extract.trunc, 1
  %shl31.mask = and i32 %a.sroa.15.0.extract.trunc, 2147483647
  %cmp32 = icmp eq i32 %shl31.mask, 0
  %and36 = and i32 %inc, -2
  %and36.inc = select i1 %cmp32, i32 %and36, i32 %inc
  br label %if.end.58

if.then.44:                                       ; preds = %if.end.8
  %a.sroa.0.0.extract.shift.i.314 = lshr i64 %a.coerce, 63
  %conv.i.315 = trunc i64 %a.sroa.0.0.extract.shift.i.314 to i32
  %cmp48 = icmp eq i8 %0, 2
  %conv49 = zext i1 %cmp48 to i32
  %tobool50 = icmp eq i32 %conv.i.315, %conv49
  br i1 %tobool50, label %if.end.58, label %if.then.51

if.then.51:                                       ; preds = %if.then.44
  %add.i.312 = add i32 %sub10, %a.sroa.15.0.extract.trunc
  %cmp.i = icmp ult i32 %add.i.312, %a.sroa.15.0.extract.trunc
  %conv.i.313 = zext i1 %cmp.i to i32
  %add2.i = add i32 %conv.i.313, %a.sroa.0.0.extract.trunc
  br label %if.end.58

if.end.58:                                        ; preds = %if.then.28, %if.end.8, %if.then.44, %if.then.51, %if.then.21, %if.then.15, %if.else
  %z.sroa.21.0 = phi i32 [ %a.sroa.15.0.extract.trunc, %if.then.44 ], [ %add.i.312, %if.then.51 ], [ %a.sroa.15.0.extract.trunc, %if.end.8 ], [ %and23, %if.then.21 ], [ %add.i.316, %if.then.15 ], [ %a.sroa.15.0.extract.trunc, %if.else ], [ %a.sroa.15.0.extract.trunc, %if.then.28 ]
  %z.sroa.0.0 = phi i32 [ %a.sroa.0.0.extract.trunc, %if.then.44 ], [ %add2.i, %if.then.51 ], [ %a.sroa.0.0.extract.trunc, %if.end.8 ], [ %add2.i.319, %if.then.21 ], [ %add2.i.319, %if.then.15 ], [ %a.sroa.0.0.extract.trunc, %if.else ], [ %and36.inc, %if.then.28 ]
  %neg59 = sub i32 0, %shl9
  %and61 = and i32 %z.sroa.21.0, %neg59
  br label %if.end.153

if.else.62:                                       ; preds = %entry
  %cmp63 = icmp ult i32 %and.i, 1023
  br i1 %cmp63, label %if.then.65, label %if.end.103

if.then.65:                                       ; preds = %if.else.62
  %shl67299 = shl nuw nsw i64 %a.sroa.0.0.extract.shift, 1
  %or69301 = or i64 %shl67299, %a.coerce
  %or69 = trunc i64 %or69301 to i32
  %cmp70 = icmp eq i32 %or69, 0
  br i1 %cmp70, label %cleanup, label %if.end.73

if.end.73:                                        ; preds = %if.then.65
  %1 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv74.302 = zext i8 %1 to i32
  %or75 = or i32 %conv74.302, 32
  %conv76 = trunc i32 %or75 to i8
  store i8 %conv76, i8* @float_exception_flags, align 1, !tbaa !5
  %a.sroa.0.0.extract.shift.i.310 = lshr i64 %a.coerce, 63
  %conv.i.311 = trunc i64 %a.sroa.0.0.extract.shift.i.310 to i8
  %2 = load i8, i8* @float_rounding_mode, align 1, !tbaa !5
  %conv78 = sext i8 %2 to i32
  switch i32 %conv78, label %sw.epilog [
    i32 0, label %sw.bb
    i32 1, label %sw.bb.89
    i32 2, label %sw.bb.94
  ]

sw.bb:                                            ; preds = %if.end.73
  %cmp79 = icmp eq i32 %and.i, 1022
  br i1 %cmp79, label %land.lhs.true.81, label %sw.epilog

land.lhs.true.81:                                 ; preds = %sw.bb
  %and.i.309 = and i32 %a.sroa.0.0.extract.trunc, 1048575
  %or84 = or i32 %and.i.309, %a.sroa.15.0.extract.trunc
  %tobool85 = icmp eq i32 %or84, 0
  br i1 %tobool85, label %sw.epilog, label %if.then.86

if.then.86:                                       ; preds = %land.lhs.true.81
  %shl.i.305350 = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i.310, 31
  %add.i = or i64 %shl.i.305350, 1072693248
  %retval.sroa.0.0.extract.trunc280 = trunc i64 %add.i to i32
  br label %cleanup

sw.bb.89:                                         ; preds = %if.end.73
  %tobool91 = icmp eq i8 %conv.i.311, 0
  %retval.sroa.0.0 = select i1 %tobool91, i32 0, i32 -1074790400
  br label %cleanup

sw.bb.94:                                         ; preds = %if.end.73
  %tobool96 = icmp eq i8 %conv.i.311, 0
  %retval.sroa.0.1 = select i1 %tobool96, i32 1072693248, i32 -2147483648
  br label %cleanup

sw.epilog:                                        ; preds = %land.lhs.true.81, %sw.bb, %if.end.73
  %shl.i349 = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i.310, 31
  %retval.sroa.0.0.extract.trunc290 = trunc i64 %shl.i349 to i32
  br label %cleanup

if.end.103:                                       ; preds = %if.else.62
  %sub104 = sub nsw i32 1043, %and.i
  %shl105 = shl i32 1, %sub104
  %sub106 = add i32 %shl105, -1
  %3 = load i8, i8* @float_rounding_mode, align 1, !tbaa !5
  switch i8 %3, label %if.then.131 [
    i8 0, label %if.then.113
    i8 3, label %if.end.149
  ]

if.then.113:                                      ; preds = %if.end.103
  %shr114 = lshr i32 %shl105, 1
  %add = add i32 %shr114, %a.sroa.0.0.extract.trunc
  %and117 = and i32 %add, %sub106
  %or119 = or i32 %and117, %a.sroa.15.0.extract.trunc
  %cmp120 = icmp eq i32 %or119, 0
  br i1 %cmp120, label %if.then.122, label %if.end.149

if.then.122:                                      ; preds = %if.then.113
  %neg123 = xor i32 %shl105, -1
  %and125 = and i32 %add, %neg123
  br label %if.end.149

if.then.131:                                      ; preds = %if.end.103
  %a.sroa.0.0.extract.shift.i.303 = lshr i64 %a.coerce, 63
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i.303 to i32
  %cmp135 = icmp eq i8 %3, 2
  %conv136 = zext i1 %cmp135 to i32
  %tobool138 = icmp eq i32 %conv.i, %conv136
  br i1 %tobool138, label %if.end.149, label %if.then.139

if.then.139:                                      ; preds = %if.then.131
  %cmp141 = icmp ne i32 %a.sroa.15.0.extract.trunc, 0
  %conv142 = zext i1 %cmp141 to i32
  %or144 = or i32 %conv142, %a.sroa.0.0.extract.trunc
  %add146 = add i32 %sub106, %or144
  br label %if.end.149

if.end.149:                                       ; preds = %if.end.103, %if.then.131, %if.then.139, %if.then.113, %if.then.122
  %z.sroa.0.1 = phi i32 [ %a.sroa.0.0.extract.trunc, %if.then.131 ], [ %add146, %if.then.139 ], [ %a.sroa.0.0.extract.trunc, %if.end.103 ], [ %and125, %if.then.122 ], [ %add, %if.then.113 ]
  %neg150 = sub i32 0, %shl105
  %and152 = and i32 %z.sroa.0.1, %neg150
  br label %if.end.153

if.end.153:                                       ; preds = %if.end.149, %if.end.58
  %z.sroa.21.1 = phi i32 [ %and61, %if.end.58 ], [ 0, %if.end.149 ]
  %z.sroa.0.2 = phi i32 [ %z.sroa.0.0, %if.end.58 ], [ %and152, %if.end.149 ]
  %cmp156 = icmp eq i32 %z.sroa.21.1, %a.sroa.15.0.extract.trunc
  %cmp160 = icmp eq i32 %z.sroa.0.2, %a.sroa.0.0.extract.trunc
  %or.cond = and i1 %cmp156, %cmp160
  br i1 %or.cond, label %cleanup, label %if.then.162

if.then.162:                                      ; preds = %if.end.153
  %4 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv163.298 = zext i8 %4 to i32
  %or164 = or i32 %conv163.298, 32
  %conv165 = trunc i32 %or164 to i8
  store i8 %conv165, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

cleanup:                                          ; preds = %if.end.153, %if.then.162, %if.then.65, %if.then.2, %land.lhs.true, %sw.epilog, %sw.bb.94, %sw.bb.89, %if.then.86, %if.then.6
  %retval.sroa.0.2 = phi i32 [ %retval.sroa.0.0.extract.trunc, %if.then.6 ], [ %retval.sroa.0.0.extract.trunc290, %sw.epilog ], [ %retval.sroa.0.1, %sw.bb.94 ], [ %retval.sroa.0.0, %sw.bb.89 ], [ %retval.sroa.0.0.extract.trunc280, %if.then.86 ], [ %a.sroa.0.0.extract.trunc, %land.lhs.true ], [ %a.sroa.0.0.extract.trunc, %if.then.2 ], [ %a.sroa.0.0.extract.trunc, %if.then.65 ], [ %z.sroa.0.2, %if.then.162 ], [ %a.sroa.0.0.extract.trunc, %if.end.153 ]
  %retval.sroa.11.2 = phi i32 [ %retval.sroa.11.0.extract.trunc, %if.then.6 ], [ 0, %sw.epilog ], [ 0, %sw.bb.94 ], [ 0, %sw.bb.89 ], [ 0, %if.then.86 ], [ %a.sroa.15.0.extract.trunc, %land.lhs.true ], [ %a.sroa.15.0.extract.trunc, %if.then.2 ], [ %a.sroa.15.0.extract.trunc, %if.then.65 ], [ %z.sroa.21.1, %if.then.162 ], [ %a.sroa.15.0.extract.trunc, %if.end.153 ]
  %retval.sroa.11.0.insert.ext = zext i32 %retval.sroa.11.2 to i64
  %retval.sroa.0.0.insert.ext = zext i32 %retval.sroa.0.2 to i64
  %retval.sroa.0.0.insert.shift = shl nuw i64 %retval.sroa.0.0.insert.ext, 32
  %retval.sroa.0.0.insert.insert = or i64 %retval.sroa.11.0.insert.ext, %retval.sroa.0.0.insert.shift
  ret i64 %retval.sroa.0.0.insert.insert
}

; Function Attrs: nounwind
define internal fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %a.sroa.12.0.extract.trunc = trunc i64 %a.coerce to i32
  %b.sroa.0.0.extract.shift = lshr i64 %b.coerce, 32
  %b.sroa.0.0.extract.trunc = trunc i64 %b.sroa.0.0.extract.shift to i32
  %b.sroa.12.0.extract.trunc = trunc i64 %b.coerce to i32
  %a.sroa.0.0.insert.shift = shl nuw i64 %a.sroa.0.0.extract.shift, 32
  %shl4.i = shl nuw nsw i64 %a.sroa.0.0.extract.shift, 1
  %shl.i = trunc i64 %shl4.i to i32
  %cmp.i = icmp ugt i32 %shl.i, -2097153
  br i1 %cmp.i, label %land.rhs.i, label %float64_is_nan.exit

land.rhs.i:                                       ; preds = %entry
  %tobool.i = icmp eq i32 %a.sroa.12.0.extract.trunc, 0
  br i1 %tobool.i, label %lor.rhs.i, label %float64_is_nan.exit

lor.rhs.i:                                        ; preds = %land.rhs.i
  %and.i = and i64 %a.sroa.0.0.extract.shift, 1048575
  %tobool2.i = icmp ne i64 %and.i, 0
  %phitmp.i = zext i1 %tobool2.i to i8
  br label %float64_is_nan.exit

float64_is_nan.exit:                              ; preds = %entry, %land.rhs.i, %lor.rhs.i
  %0 = phi i8 [ 0, %entry ], [ 1, %land.rhs.i ], [ %phitmp.i, %lor.rhs.i ]
  %and.i.142 = and i64 %a.sroa.0.0.insert.shift, 9221120237041090560
  %cmp.i.143 = icmp eq i64 %and.i.142, 9218868437227405312
  br i1 %cmp.i.143, label %land.rhs.i.146, label %float64_is_signaling_nan.exit151

land.rhs.i.146:                                   ; preds = %float64_is_nan.exit
  %tobool.i.145 = icmp eq i32 %a.sroa.12.0.extract.trunc, 0
  br i1 %tobool.i.145, label %lor.rhs.i.150, label %float64_is_signaling_nan.exit151

lor.rhs.i.150:                                    ; preds = %land.rhs.i.146
  %and2.i.147 = and i64 %a.sroa.0.0.insert.shift, 2251795518717952
  %tobool3.i.148 = icmp ne i64 %and2.i.147, 0
  %phitmp.i.149 = zext i1 %tobool3.i.148 to i8
  br label %float64_is_signaling_nan.exit151

float64_is_signaling_nan.exit151:                 ; preds = %float64_is_nan.exit, %land.rhs.i.146, %lor.rhs.i.150
  %1 = phi i8 [ 0, %float64_is_nan.exit ], [ 1, %land.rhs.i.146 ], [ %phitmp.i.149, %lor.rhs.i.150 ]
  %b.sroa.0.0.insert.shift = shl nuw i64 %b.sroa.0.0.extract.shift, 32
  %shl4.i.131 = shl nuw nsw i64 %b.sroa.0.0.extract.shift, 1
  %shl.i.132 = trunc i64 %shl4.i.131 to i32
  %cmp.i.133 = icmp ugt i32 %shl.i.132, -2097153
  br i1 %cmp.i.133, label %land.rhs.i.136, label %float64_is_nan.exit141

land.rhs.i.136:                                   ; preds = %float64_is_signaling_nan.exit151
  %tobool.i.135 = icmp eq i32 %b.sroa.12.0.extract.trunc, 0
  br i1 %tobool.i.135, label %lor.rhs.i.140, label %float64_is_nan.exit141

lor.rhs.i.140:                                    ; preds = %land.rhs.i.136
  %and.i.137 = and i64 %b.sroa.0.0.extract.shift, 1048575
  %tobool2.i.138 = icmp ne i64 %and.i.137, 0
  %phitmp.i.139 = zext i1 %tobool2.i.138 to i8
  br label %float64_is_nan.exit141

float64_is_nan.exit141:                           ; preds = %float64_is_signaling_nan.exit151, %land.rhs.i.136, %lor.rhs.i.140
  %2 = phi i8 [ 0, %float64_is_signaling_nan.exit151 ], [ 1, %land.rhs.i.136 ], [ %phitmp.i.139, %lor.rhs.i.140 ]
  %and.i.123 = and i64 %b.sroa.0.0.insert.shift, 9221120237041090560
  %cmp.i.124 = icmp eq i64 %and.i.123, 9218868437227405312
  br i1 %cmp.i.124, label %land.rhs.i.127, label %float64_is_signaling_nan.exit

land.rhs.i.127:                                   ; preds = %float64_is_nan.exit141
  %tobool.i.126 = icmp eq i32 %b.sroa.12.0.extract.trunc, 0
  br i1 %tobool.i.126, label %lor.rhs.i.129, label %float64_is_signaling_nan.exit

lor.rhs.i.129:                                    ; preds = %land.rhs.i.127
  %and2.i = and i64 %b.sroa.0.0.insert.shift, 2251795518717952
  %tobool3.i = icmp ne i64 %and2.i, 0
  %phitmp.i.128 = zext i1 %tobool3.i to i8
  br label %float64_is_signaling_nan.exit

float64_is_signaling_nan.exit:                    ; preds = %float64_is_nan.exit141, %land.rhs.i.127, %lor.rhs.i.129
  %3 = phi i8 [ 0, %float64_is_nan.exit141 ], [ 1, %land.rhs.i.127 ], [ %phitmp.i.128, %lor.rhs.i.129 ]
  %or = or i32 %a.sroa.0.0.extract.trunc, 524288
  %or5 = or i32 %b.sroa.0.0.extract.trunc, 524288
  %or7109 = or i8 %3, %1
  %tobool = icmp eq i8 %or7109, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %float64_is_signaling_nan.exit
  %4 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %4, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end

if.end:                                           ; preds = %float64_is_signaling_nan.exit, %if.then
  %tobool8 = icmp eq i8 %1, 0
  br i1 %tobool8, label %if.else, label %if.then.9

if.then.9:                                        ; preds = %if.end
  %tobool10 = icmp eq i8 %3, 0
  br i1 %tobool10, label %if.end.12, label %returnLargerSignificand

if.end.12:                                        ; preds = %if.then.9
  %tobool14 = icmp eq i8 %2, 0
  %or.or5 = select i1 %tobool14, i32 %or, i32 %or5
  %a.coerce.b.coerce = select i1 %tobool14, i64 %a.coerce, i64 %b.coerce
  br label %cleanup

if.else:                                          ; preds = %if.end
  %tobool15 = icmp eq i8 %0, 0
  br i1 %tobool15, label %cleanup, label %if.then.16

if.then.16:                                       ; preds = %if.else
  %5 = xor i8 %2, 1
  %or19159 = or i8 %3, %5
  %tobool20 = icmp eq i8 %or19159, 0
  br i1 %tobool20, label %returnLargerSignificand, label %cleanup

returnLargerSignificand:                          ; preds = %if.then.9, %if.then.16
  %shl = shl i32 %or, 1
  %shl25 = shl i32 %or5, 1
  %cmp.i.116 = icmp ult i32 %shl, %shl25
  br i1 %cmp.i.116, label %cleanup, label %lor.rhs.i.118

lor.rhs.i.118:                                    ; preds = %returnLargerSignificand
  %cmp1.i.117 = icmp eq i32 %shl, %shl25
  %cmp2.i.119 = icmp ult i32 %a.sroa.12.0.extract.trunc, %b.sroa.12.0.extract.trunc
  %or.cond = and i1 %cmp2.i.119, %cmp1.i.117
  br i1 %or.cond, label %cleanup, label %if.end.30

if.end.30:                                        ; preds = %lor.rhs.i.118
  %cmp.i.112 = icmp ult i32 %shl25, %shl
  %cmp2.i = icmp ult i32 %b.sroa.12.0.extract.trunc, %a.sroa.12.0.extract.trunc
  %or.cond160 = and i1 %cmp2.i, %cmp1.i.117
  %or.cond161 = or i1 %cmp.i.112, %or.cond160
  br i1 %or.cond161, label %cleanup, label %if.end.40

if.end.40:                                        ; preds = %if.end.30
  %cmp = icmp ult i32 %or, %or5
  %or.or5110 = select i1 %cmp, i32 %or, i32 %or5
  %a.coerce.b.coerce111 = select i1 %cmp, i64 %a.coerce, i64 %b.coerce
  br label %cleanup

cleanup:                                          ; preds = %lor.rhs.i.118, %if.end.30, %returnLargerSignificand, %if.else, %if.then.16, %if.end.40, %if.end.12
  %retval.sroa.0.2 = phi i32 [ %or.or5110, %if.end.40 ], [ %or.or5, %if.end.12 ], [ %or, %if.then.16 ], [ %or5, %if.else ], [ %or5, %returnLargerSignificand ], [ %or, %if.end.30 ], [ %or5, %lor.rhs.i.118 ]
  %retval.sroa.9.2 = phi i64 [ %a.coerce.b.coerce111, %if.end.40 ], [ %a.coerce.b.coerce, %if.end.12 ], [ %a.coerce, %if.then.16 ], [ %b.coerce, %if.else ], [ %b.coerce, %returnLargerSignificand ], [ %a.coerce, %if.end.30 ], [ %b.coerce, %lor.rhs.i.118 ]
  %retval.sroa.0.0.insert.ext = zext i32 %retval.sroa.0.2 to i64
  %retval.sroa.0.0.insert.shift = shl nuw i64 %retval.sroa.0.0.insert.ext, 32
  %retval.sroa.0.0.insert.mask = and i64 %retval.sroa.9.2, 4294967295
  %retval.sroa.0.0.insert.insert = or i64 %retval.sroa.0.0.insert.mask, %retval.sroa.0.0.insert.shift
  ret i64 %retval.sroa.0.0.insert.insert
}

; Function Attrs: nounwind
define i64 @float64_add(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift.i = lshr i64 %a.coerce, 63
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i to i8
  %a.sroa.0.0.extract.shift.i.10 = lshr i64 %b.coerce, 63
  %conv.i.11 = trunc i64 %a.sroa.0.0.extract.shift.i.10 to i8
  %cmp = icmp eq i8 %conv.i, %conv.i.11
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %call4 = tail call fastcc i64 @addFloat64Sigs(i64 %a.coerce, i64 %b.coerce, i8 signext %conv.i)
  br label %cleanup

if.else:                                          ; preds = %entry
  %call5 = tail call fastcc i64 @subFloat64Sigs(i64 %a.coerce, i64 %b.coerce, i8 signext %conv.i)
  br label %cleanup

cleanup:                                          ; preds = %if.else, %if.then
  %retval.sroa.0.0 = phi i64 [ %call4, %if.then ], [ %call5, %if.else ]
  ret i64 %retval.sroa.0.0
}

; Function Attrs: nounwind
define internal fastcc i64 @addFloat64Sigs(i64 %a.coerce, i64 %b.coerce, i8 signext %zSign) #2 {
entry:
  %a.sroa.1.0.extract.trunc.i = trunc i64 %a.coerce to i32
  %a.sroa.0.0.extract.shift.i = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc.i = trunc i64 %a.sroa.0.0.extract.shift.i to i32
  %and.i = and i32 %a.sroa.0.0.extract.trunc.i, 1048575
  %a.sroa.0.0.extract.shift.i.109 = lshr i64 %a.coerce, 52
  %shr.i.110 = trunc i64 %a.sroa.0.0.extract.shift.i.109 to i32
  %and.i.111 = and i32 %shr.i.110, 2047
  %a.sroa.1.0.extract.trunc.i.127 = trunc i64 %b.coerce to i32
  %a.sroa.0.0.extract.shift.i.163 = lshr i64 %b.coerce, 32
  %a.sroa.0.0.extract.trunc.i.164 = trunc i64 %a.sroa.0.0.extract.shift.i.163 to i32
  %and.i.165 = and i32 %a.sroa.0.0.extract.trunc.i.164, 1048575
  %a.sroa.0.0.extract.shift.i.166 = lshr i64 %b.coerce, 52
  %shr.i.167 = trunc i64 %a.sroa.0.0.extract.shift.i.166 to i32
  %and.i.168 = and i32 %shr.i.167, 2047
  %sub = sub nsw i32 %and.i.111, %and.i.168
  %cmp = icmp sgt i32 %sub, 0
  br i1 %cmp, label %if.then, label %if.else.15

if.then:                                          ; preds = %entry
  %cmp6 = icmp eq i32 %and.i.111, 2047
  br i1 %cmp6, label %if.then.7, label %if.end.10

if.then.7:                                        ; preds = %if.then
  %or = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %cleanup, label %if.then.8

if.then.8:                                        ; preds = %if.then.7
  %call9 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  br label %cleanup

if.end.10:                                        ; preds = %if.then
  %cmp11 = icmp eq i32 %and.i.168, 0
  br i1 %cmp11, label %if.end.14, label %if.end.14.thread

if.end.14.thread:                                 ; preds = %if.end.10
  %or13 = or i32 %and.i.165, 1048576
  br label %if.else.i.131

if.end.14:                                        ; preds = %if.end.10
  %dec = add nsw i32 %sub, -1
  %cmp.i.129 = icmp eq i32 %dec, 0
  br i1 %cmp.i.129, label %if.end.50, label %if.else.i.131

if.else.i.131:                                    ; preds = %if.end.14.thread, %if.end.14
  %.pn = phi i32 [ 0, %if.end.14.thread ], [ 1, %if.end.14 ]
  %expDiff.0203 = phi i32 [ %sub, %if.end.14.thread ], [ %dec, %if.end.14 ]
  %bSig0.0202 = phi i32 [ %or13, %if.end.14.thread ], [ %and.i.165, %if.end.14 ]
  %and.i.128204.in = sub nsw i32 %.pn, %sub
  %and.i.128204 = and i32 %and.i.128204.in, 31
  %cmp2.i.130 = icmp slt i32 %expDiff.0203, 32
  br i1 %cmp2.i.130, label %if.then.4.i.137, label %if.else.9.i.139

if.then.4.i.137:                                  ; preds = %if.else.i.131
  %shl.i.132 = shl i32 %a.sroa.1.0.extract.trunc.i.127, %and.i.128204
  %shl7.i.133 = shl i32 %bSig0.0202, %and.i.128204
  %shr.i.134 = lshr i32 %a.sroa.1.0.extract.trunc.i.127, %expDiff.0203
  %or.i.135 = or i32 %shl7.i.133, %shr.i.134
  %shr8.i.136 = lshr i32 %bSig0.0202, %expDiff.0203
  br label %if.end.28.i.158

if.else.9.i.139:                                  ; preds = %if.else.i.131
  %cmp10.i.138 = icmp eq i32 %expDiff.0203, 32
  br i1 %cmp10.i.138, label %if.end.28.i.158, label %if.else.13.i.141

if.else.13.i.141:                                 ; preds = %if.else.9.i.139
  %cmp15.i.140 = icmp slt i32 %expDiff.0203, 64
  br i1 %cmp15.i.140, label %if.then.17.i.145, label %if.else.22.i.150

if.then.17.i.145:                                 ; preds = %if.else.13.i.141
  %shl19.i.142 = shl i32 %bSig0.0202, %and.i.128204
  %and20.i.143 = and i32 %expDiff.0203, 31
  %shr21.i.144 = lshr i32 %bSig0.0202, %and20.i.143
  br label %if.end.28.i.158

if.else.22.i.150:                                 ; preds = %if.else.13.i.141
  %cmp23.i.146 = icmp eq i32 %expDiff.0203, 64
  %cmp25.i.147 = icmp ne i32 %bSig0.0202, 0
  %conv26.i.148 = zext i1 %cmp25.i.147 to i32
  %cond.i.149 = select i1 %cmp23.i.146, i32 %bSig0.0202, i32 %conv26.i.148
  br label %if.end.28.i.158

if.end.28.i.158:                                  ; preds = %if.else.22.i.150, %if.then.17.i.145, %if.else.9.i.139, %if.then.4.i.137
  %z0.0.i.151 = phi i32 [ %shr8.i.136, %if.then.4.i.137 ], [ 0, %if.else.9.i.139 ], [ 0, %if.then.17.i.145 ], [ 0, %if.else.22.i.150 ]
  %z1.1.i.152 = phi i32 [ %or.i.135, %if.then.4.i.137 ], [ %bSig0.0202, %if.else.9.i.139 ], [ %shr21.i.144, %if.then.17.i.145 ], [ 0, %if.else.22.i.150 ]
  %z2.1.i.153 = phi i32 [ %shl.i.132, %if.then.4.i.137 ], [ %a.sroa.1.0.extract.trunc.i.127, %if.else.9.i.139 ], [ %shl19.i.142, %if.then.17.i.145 ], [ %cond.i.149, %if.else.22.i.150 ]
  %a2.addr.1.i.154 = phi i32 [ 0, %if.then.4.i.137 ], [ 0, %if.else.9.i.139 ], [ %a.sroa.1.0.extract.trunc.i.127, %if.then.17.i.145 ], [ %a.sroa.1.0.extract.trunc.i.127, %if.else.22.i.150 ]
  %cmp29.i.155 = icmp ne i32 %a2.addr.1.i.154, 0
  %conv30.i.156 = zext i1 %cmp29.i.155 to i32
  %or31.i.157 = or i32 %conv30.i.156, %z2.1.i.153
  br label %if.end.50

if.else.15:                                       ; preds = %entry
  %cmp16 = icmp slt i32 %sub, 0
  br i1 %cmp16, label %if.then.17, label %if.else.33

if.then.17:                                       ; preds = %if.else.15
  %cmp18 = icmp eq i32 %and.i.168, 2047
  br i1 %cmp18, label %if.then.19, label %if.end.26

if.then.19:                                       ; preds = %if.then.17
  %or20 = or i32 %and.i.165, %a.sroa.1.0.extract.trunc.i.127
  %tobool21 = icmp eq i32 %or20, 0
  br i1 %tobool21, label %if.end.24, label %if.then.22

if.then.22:                                       ; preds = %if.then.19
  %call23 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  br label %cleanup

if.end.24:                                        ; preds = %if.then.19
  %conv.6.i.122 = zext i8 %zSign to i64
  %shl.i.123 = shl i64 %conv.6.i.122, 63
  %retval.sroa.0.0.insert.ext.i.125 = or i64 %shl.i.123, 9218868437227405312
  br label %cleanup

if.end.26:                                        ; preds = %if.then.17
  %cmp27 = icmp eq i32 %and.i.111, 0
  %or30 = or i32 %and.i, 1048576
  %aSig0.0 = select i1 %cmp27, i32 %and.i, i32 %or30
  %inc = zext i1 %cmp27 to i32
  %expDiff.1 = add nsw i32 %sub, %inc
  %sub32 = sub nsw i32 0, %expDiff.1
  %and.i.112 = and i32 %expDiff.1, 31
  %cmp.i.113 = icmp eq i32 %expDiff.1, 0
  br i1 %cmp.i.113, label %if.end.50, label %if.else.i

if.else.i:                                        ; preds = %if.end.26
  %cmp2.i = icmp sgt i32 %expDiff.1, -32
  br i1 %cmp2.i, label %if.then.4.i, label %if.else.9.i

if.then.4.i:                                      ; preds = %if.else.i
  %shl.i.114 = shl i32 %a.sroa.1.0.extract.trunc.i, %and.i.112
  %shl7.i.115 = shl i32 %aSig0.0, %and.i.112
  %shr.i.116 = lshr i32 %a.sroa.1.0.extract.trunc.i, %sub32
  %or.i.117 = or i32 %shl7.i.115, %shr.i.116
  %shr8.i.118 = lshr i32 %aSig0.0, %sub32
  br label %if.end.28.i

if.else.9.i:                                      ; preds = %if.else.i
  %cmp10.i = icmp eq i32 %sub32, 32
  br i1 %cmp10.i, label %if.end.28.i, label %if.else.13.i

if.else.13.i:                                     ; preds = %if.else.9.i
  %cmp15.i = icmp sgt i32 %expDiff.1, -64
  br i1 %cmp15.i, label %if.then.17.i, label %if.else.22.i

if.then.17.i:                                     ; preds = %if.else.13.i
  %shl19.i = shl i32 %aSig0.0, %and.i.112
  %and20.i = and i32 %sub32, 31
  %shr21.i = lshr i32 %aSig0.0, %and20.i
  br label %if.end.28.i

if.else.22.i:                                     ; preds = %if.else.13.i
  %cmp23.i = icmp eq i32 %sub32, 64
  %cmp25.i = icmp ne i32 %aSig0.0, 0
  %conv26.i = zext i1 %cmp25.i to i32
  %cond.i = select i1 %cmp23.i, i32 %aSig0.0, i32 %conv26.i
  br label %if.end.28.i

if.end.28.i:                                      ; preds = %if.else.22.i, %if.then.17.i, %if.else.9.i, %if.then.4.i
  %z0.0.i = phi i32 [ %shr8.i.118, %if.then.4.i ], [ 0, %if.else.9.i ], [ 0, %if.then.17.i ], [ 0, %if.else.22.i ]
  %z1.1.i = phi i32 [ %or.i.117, %if.then.4.i ], [ %aSig0.0, %if.else.9.i ], [ %shr21.i, %if.then.17.i ], [ 0, %if.else.22.i ]
  %z2.1.i = phi i32 [ %shl.i.114, %if.then.4.i ], [ %a.sroa.1.0.extract.trunc.i, %if.else.9.i ], [ %shl19.i, %if.then.17.i ], [ %cond.i, %if.else.22.i ]
  %a2.addr.1.i = phi i32 [ 0, %if.then.4.i ], [ 0, %if.else.9.i ], [ %a.sroa.1.0.extract.trunc.i, %if.then.17.i ], [ %a.sroa.1.0.extract.trunc.i, %if.else.22.i ]
  %cmp29.i.119 = icmp ne i32 %a2.addr.1.i, 0
  %conv30.i.120 = zext i1 %cmp29.i.119 to i32
  %or31.i.121 = or i32 %conv30.i.120, %z2.1.i
  br label %if.end.50

if.else.33:                                       ; preds = %if.else.15
  %cmp34 = icmp eq i32 %and.i.111, 2047
  br i1 %cmp34, label %if.then.35, label %if.end.43

if.then.35:                                       ; preds = %if.else.33
  %or36205 = or i64 %b.coerce, %a.coerce
  %or36 = trunc i64 %or36205 to i32
  %or37 = or i32 %or36, %and.i
  %or38 = or i32 %or37, %and.i.165
  %tobool39 = icmp eq i32 %or38, 0
  br i1 %tobool39, label %cleanup, label %if.then.40

if.then.40:                                       ; preds = %if.then.35
  %call41 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  br label %cleanup

if.end.43:                                        ; preds = %if.else.33
  %add.i.104 = add i32 %a.sroa.1.0.extract.trunc.i.127, %a.sroa.1.0.extract.trunc.i
  %add1.i.105 = add nuw nsw i32 %and.i.165, %and.i
  %cmp.i.106 = icmp ult i32 %add.i.104, %a.sroa.1.0.extract.trunc.i
  %conv.i.107 = zext i1 %cmp.i.106 to i32
  %add2.i.108 = add nuw nsw i32 %add1.i.105, %conv.i.107
  %cmp44 = icmp eq i32 %and.i.111, 0
  br i1 %cmp44, label %if.then.45, label %if.end.47

if.then.45:                                       ; preds = %if.end.43
  %conv.6.i = zext i8 %zSign to i32
  %shl.i.102 = shl i32 %conv.6.i, 31
  %add2.i.103 = or i32 %add2.i.108, %shl.i.102
  %retval.sroa.2.0.insert.ext.i = zext i32 %add.i.104 to i64
  %retval.sroa.0.0.insert.ext.i = zext i32 %add2.i.103 to i64
  %retval.sroa.0.0.insert.shift.i = shl nuw i64 %retval.sroa.0.0.insert.ext.i, 32
  %retval.sroa.0.0.insert.insert.i = or i64 %retval.sroa.0.0.insert.shift.i, %retval.sroa.2.0.insert.ext.i
  br label %cleanup

if.end.47:                                        ; preds = %if.end.43
  %or48 = or i32 %add2.i.108, 2097152
  br label %shiftRight1

if.end.50:                                        ; preds = %if.end.28.i, %if.end.26, %if.end.28.i.158, %if.end.14
  %aSig0.1 = phi i32 [ %and.i, %if.end.14 ], [ %and.i, %if.end.28.i.158 ], [ %z0.0.i, %if.end.28.i ], [ %aSig0.0, %if.end.26 ]
  %aSig1.0 = phi i32 [ %a.sroa.1.0.extract.trunc.i, %if.end.14 ], [ %a.sroa.1.0.extract.trunc.i, %if.end.28.i.158 ], [ %z1.1.i, %if.end.28.i ], [ %a.sroa.1.0.extract.trunc.i, %if.end.26 ]
  %bSig0.1 = phi i32 [ %and.i.165, %if.end.14 ], [ %z0.0.i.151, %if.end.28.i.158 ], [ %and.i.165, %if.end.28.i ], [ %and.i.165, %if.end.26 ]
  %bSig1.0 = phi i32 [ %a.sroa.1.0.extract.trunc.i.127, %if.end.14 ], [ %z1.1.i.152, %if.end.28.i.158 ], [ %a.sroa.1.0.extract.trunc.i.127, %if.end.28.i ], [ %a.sroa.1.0.extract.trunc.i.127, %if.end.26 ]
  %zSig2.0 = phi i32 [ 0, %if.end.14 ], [ %or31.i.157, %if.end.28.i.158 ], [ %or31.i.121, %if.end.28.i ], [ 0, %if.end.26 ]
  %zExp.0 = phi i32 [ %and.i.111, %if.end.14 ], [ %and.i.111, %if.end.28.i.158 ], [ %and.i.168, %if.end.28.i ], [ %and.i.168, %if.end.26 ]
  %or51 = or i32 %aSig0.1, 1048576
  %add.i = add i32 %bSig1.0, %aSig1.0
  %add1.i = add i32 %bSig0.1, %or51
  %cmp.i = icmp ult i32 %add.i, %aSig1.0
  %conv.i = zext i1 %cmp.i to i32
  %add2.i = add i32 %add1.i, %conv.i
  %dec52 = add nsw i32 %zExp.0, -1
  %cmp53 = icmp ult i32 %add2.i, 2097152
  br i1 %cmp53, label %roundAndPack, label %shiftRight1

shiftRight1:                                      ; preds = %if.end.50, %if.end.47
  %zSig0.0 = phi i32 [ %add2.i, %if.end.50 ], [ %or48, %if.end.47 ]
  %zSig1.0 = phi i32 [ %add.i, %if.end.50 ], [ %add.i.104, %if.end.47 ]
  %zSig2.1 = phi i32 [ %zSig2.0, %if.end.50 ], [ 0, %if.end.47 ]
  %zExp.1 = phi i32 [ %zExp.0, %if.end.50 ], [ %and.i.111, %if.end.47 ]
  %shl.i = shl i32 %zSig1.0, 31
  %shl7.i = shl i32 %zSig0.0, 31
  %shr.i = lshr i32 %zSig1.0, 1
  %or.i = or i32 %shr.i, %shl7.i
  %shr8.i = lshr i32 %zSig0.0, 1
  %cmp29.i = icmp ne i32 %zSig2.1, 0
  %conv30.i = zext i1 %cmp29.i to i32
  %or31.i = or i32 %conv30.i, %shl.i
  br label %roundAndPack

roundAndPack:                                     ; preds = %if.end.50, %shiftRight1
  %zSig0.1 = phi i32 [ %add2.i, %if.end.50 ], [ %shr8.i, %shiftRight1 ]
  %zSig1.1 = phi i32 [ %add.i, %if.end.50 ], [ %or.i, %shiftRight1 ]
  %zSig2.2 = phi i32 [ %zSig2.0, %if.end.50 ], [ %or31.i, %shiftRight1 ]
  %zExp.2 = phi i32 [ %dec52, %if.end.50 ], [ %zExp.1, %shiftRight1 ]
  %call57 = tail call fastcc i64 @roundAndPackFloat64(i8 signext %zSign, i32 signext %zExp.2, i32 zeroext %zSig0.1, i32 zeroext %zSig1.1, i32 zeroext %zSig2.2)
  br label %cleanup

cleanup:                                          ; preds = %if.then.35, %if.then.7, %roundAndPack, %if.then.45, %if.then.40, %if.end.24, %if.then.22, %if.then.8
  %retval.sroa.0.0 = phi i64 [ %call9, %if.then.8 ], [ %call57, %roundAndPack ], [ %call23, %if.then.22 ], [ %retval.sroa.0.0.insert.ext.i.125, %if.end.24 ], [ %call41, %if.then.40 ], [ %retval.sroa.0.0.insert.insert.i, %if.then.45 ], [ %a.coerce, %if.then.7 ], [ %a.coerce, %if.then.35 ]
  ret i64 %retval.sroa.0.0
}

; Function Attrs: nounwind
define internal fastcc i64 @subFloat64Sigs(i64 %a.coerce, i64 %b.coerce, i8 signext %zSign) #2 {
entry:
  %a.sroa.1.0.extract.trunc.i = trunc i64 %a.coerce to i32
  %a.sroa.0.0.extract.shift.i.143 = lshr i64 %a.coerce, 52
  %shr.i.144 = trunc i64 %a.sroa.0.0.extract.shift.i.143 to i32
  %and.i.145 = and i32 %shr.i.144, 2047
  %a.sroa.1.0.extract.trunc.i.188 = trunc i64 %b.coerce to i32
  %a.sroa.0.0.extract.shift.i.203 = lshr i64 %b.coerce, 52
  %shr.i.204 = trunc i64 %a.sroa.0.0.extract.shift.i.203 to i32
  %and.i.205 = and i32 %shr.i.204, 2047
  %sub = sub nsw i32 %and.i.145, %and.i.205
  %shl.i.199 = shl i32 %a.sroa.1.0.extract.trunc.i, 10
  %0 = lshr i64 %a.coerce, 22
  %and.i = trunc i64 %0 to i32
  %shl1.i.200 = and i32 %and.i, 1073740800
  %shr.i.201 = lshr i32 %a.sroa.1.0.extract.trunc.i, 22
  %or.i.202 = or i32 %shl1.i.200, %shr.i.201
  %shl.i.196 = shl i32 %a.sroa.1.0.extract.trunc.i.188, 10
  %1 = lshr i64 %b.coerce, 22
  %and.i.195 = trunc i64 %1 to i32
  %shl1.i = and i32 %and.i.195, 1073740800
  %shr.i.197 = lshr i32 %a.sroa.1.0.extract.trunc.i.188, 22
  %or.i.198 = or i32 %shl1.i, %shr.i.197
  %cmp = icmp sgt i32 %sub, 0
  br i1 %cmp, label %aExpBigger, label %if.end

if.end:                                           ; preds = %entry
  %cmp6 = icmp slt i32 %sub, 0
  br i1 %cmp6, label %bExpBigger, label %if.end.8

if.end.8:                                         ; preds = %if.end
  switch i32 %and.i.145, label %if.end.19 [
    i32 2047, label %if.then.10
    i32 0, label %if.then.18
  ]

if.then.10:                                       ; preds = %if.end.8
  %or = or i32 %shl.i.196, %shl.i.199
  %or11 = or i32 %or, %or.i.202
  %or12 = or i32 %or11, %or.i.198
  %tobool = icmp eq i32 %or12, 0
  br i1 %tobool, label %if.end.15, label %if.then.13

if.then.13:                                       ; preds = %if.then.10
  %call14 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  %retval.sroa.0.0.extract.shift = and i64 %call14, -4294967296
  br label %cleanup

if.end.15:                                        ; preds = %if.then.10
  %2 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %2, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.then.18:                                       ; preds = %if.end.8
  br label %if.end.19

if.end.19:                                        ; preds = %if.end.8, %if.then.18
  %aExp.0 = phi i32 [ 1, %if.then.18 ], [ %and.i.145, %if.end.8 ]
  %bExp.0 = phi i32 [ 1, %if.then.18 ], [ %and.i.205, %if.end.8 ]
  %cmp20 = icmp ult i32 %or.i.198, %or.i.202
  br i1 %cmp20, label %aBigger, label %if.end.22

if.end.22:                                        ; preds = %if.end.19
  %cmp23 = icmp ult i32 %or.i.202, %or.i.198
  br i1 %cmp23, label %bBigger, label %if.end.25

if.end.25:                                        ; preds = %if.end.22
  %cmp26 = icmp ult i32 %shl.i.196, %shl.i.199
  br i1 %cmp26, label %aBigger, label %if.end.28

if.end.28:                                        ; preds = %if.end.25
  %cmp29 = icmp ult i32 %shl.i.199, %shl.i.196
  br i1 %cmp29, label %bBigger, label %if.end.31

if.end.31:                                        ; preds = %if.end.28
  %3 = load i8, i8* @float_rounding_mode, align 1, !tbaa !5
  %cmp32 = icmp eq i8 %3, 1
  %conv.6.i.189 = zext i1 %cmp32 to i64
  %shl.i.190 = shl nuw i64 %conv.6.i.189, 63
  br label %cleanup

bExpBigger:                                       ; preds = %if.end
  %cmp36 = icmp eq i32 %and.i.205, 2047
  br i1 %cmp36, label %if.then.38, label %if.end.47

if.then.38:                                       ; preds = %bExpBigger
  %or39 = or i32 %or.i.198, %shl.i.196
  %tobool40 = icmp eq i32 %or39, 0
  br i1 %tobool40, label %if.end.43, label %if.then.41

if.then.41:                                       ; preds = %if.then.38
  %call42 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  %retval.sroa.0.0.extract.shift122 = and i64 %call42, -4294967296
  br label %cleanup

if.end.43:                                        ; preds = %if.then.38
  %conv44.139 = zext i8 %zSign to i64
  %xor = shl i64 %conv44.139, 63
  %retval.sroa.0.0.insert.ext.i = add i64 %xor, -4503599627370496
  br label %cleanup

if.end.47:                                        ; preds = %bExpBigger
  %cmp48 = icmp eq i32 %and.i.145, 0
  %or51 = or i32 %or.i.202, 1073741824
  %aSig0.0 = select i1 %cmp48, i32 %or.i.202, i32 %or51
  %inc = zext i1 %cmp48 to i32
  %expDiff.0 = add nsw i32 %sub, %inc
  %sub53 = sub nsw i32 0, %expDiff.0
  %and.i.151 = and i32 %expDiff.0, 31
  %cmp.i.152 = icmp eq i32 %expDiff.0, 0
  br i1 %cmp.i.152, label %shift64RightJamming.exit186, label %if.else.i.154

if.else.i.154:                                    ; preds = %if.end.47
  %cmp2.i.153 = icmp sgt i32 %expDiff.0, -32
  br i1 %cmp2.i.153, label %if.then.4.i.163, label %if.else.12.i.165

if.then.4.i.163:                                  ; preds = %if.else.i.154
  %shl.i.155 = shl i32 %aSig0.0, %and.i.151
  %shr.i.156 = lshr i32 %shl.i.199, %sub53
  %or.i.157 = or i32 %shl.i.155, %shr.i.156
  %shl7.i.158 = shl i32 %shl.i.199, %and.i.151
  %cmp8.i.159 = icmp ne i32 %shl7.i.158, 0
  %conv9.i.160 = zext i1 %cmp8.i.159 to i32
  %or10.i.161 = or i32 %or.i.157, %conv9.i.160
  %shr11.i.162 = lshr i32 %aSig0.0, %sub53
  br label %shift64RightJamming.exit186

if.else.12.i.165:                                 ; preds = %if.else.i.154
  %cmp13.i.164 = icmp eq i32 %sub53, 32
  br i1 %cmp13.i.164, label %if.then.15.i.169, label %if.else.19.i.171

if.then.15.i.169:                                 ; preds = %if.else.12.i.165
  %cmp16.i.166 = icmp ne i32 %shl.i.199, 0
  %conv17.i.167 = zext i1 %cmp16.i.166 to i32
  %or18.i.168 = or i32 %aSig0.0, %conv17.i.167
  br label %shift64RightJamming.exit186

if.else.19.i.171:                                 ; preds = %if.else.12.i.165
  %cmp20.i.170 = icmp sgt i32 %expDiff.0, -64
  br i1 %cmp20.i.170, label %if.then.22.i.179, label %if.else.31.i.183

if.then.22.i.179:                                 ; preds = %if.else.19.i.171
  %and23.i.172 = and i32 %sub53, 31
  %shr24.i.173 = lshr i32 %aSig0.0, %and23.i.172
  %shl26.i.174 = shl i32 %aSig0.0, %and.i.151
  %or27.i.175 = or i32 %shl26.i.174, %shl.i.199
  %cmp28.i.176 = icmp ne i32 %or27.i.175, 0
  %conv29.i.177 = zext i1 %cmp28.i.176 to i32
  %or30.i.178 = or i32 %conv29.i.177, %shr24.i.173
  br label %shift64RightJamming.exit186

if.else.31.i.183:                                 ; preds = %if.else.19.i.171
  %or32.i.180 = or i32 %aSig0.0, %shl.i.199
  %cmp33.i.181 = icmp ne i32 %or32.i.180, 0
  %conv34.i.182 = zext i1 %cmp33.i.181 to i32
  br label %shift64RightJamming.exit186

shift64RightJamming.exit186:                      ; preds = %if.end.47, %if.then.4.i.163, %if.then.15.i.169, %if.then.22.i.179, %if.else.31.i.183
  %z1.1.i.184 = phi i32 [ %or10.i.161, %if.then.4.i.163 ], [ %shl.i.199, %if.end.47 ], [ %or18.i.168, %if.then.15.i.169 ], [ %or30.i.178, %if.then.22.i.179 ], [ %conv34.i.182, %if.else.31.i.183 ]
  %z0.0.i.185 = phi i32 [ %shr11.i.162, %if.then.4.i.163 ], [ %aSig0.0, %if.end.47 ], [ 0, %if.then.15.i.169 ], [ 0, %if.then.22.i.179 ], [ 0, %if.else.31.i.183 ]
  %or54 = or i32 %or.i.198, 1073741824
  br label %bBigger

bBigger:                                          ; preds = %if.end.28, %if.end.22, %shift64RightJamming.exit186
  %aSig0.1 = phi i32 [ %z0.0.i.185, %shift64RightJamming.exit186 ], [ %or.i.202, %if.end.22 ], [ %or.i.202, %if.end.28 ]
  %aSig1.0 = phi i32 [ %z1.1.i.184, %shift64RightJamming.exit186 ], [ %shl.i.199, %if.end.22 ], [ %shl.i.199, %if.end.28 ]
  %bSig0.0 = phi i32 [ %or54, %shift64RightJamming.exit186 ], [ %or.i.198, %if.end.22 ], [ %or.i.198, %if.end.28 ]
  %bExp.1 = phi i32 [ %and.i.205, %shift64RightJamming.exit186 ], [ %bExp.0, %if.end.22 ], [ %bExp.0, %if.end.28 ]
  %sub.i.146 = sub i32 %shl.i.196, %aSig1.0
  %sub1.i.147 = sub i32 %bSig0.0, %aSig0.1
  %cmp.i.148 = icmp ult i32 %shl.i.196, %aSig1.0
  %conv.neg.i.149 = sext i1 %cmp.i.148 to i32
  %sub2.i.150 = add i32 %sub1.i.147, %conv.neg.i.149
  %conv55.138 = zext i8 %zSign to i32
  %xor56 = xor i32 %conv55.138, 1
  %conv57 = trunc i32 %xor56 to i8
  br label %normalizeRoundAndPack

aExpBigger:                                       ; preds = %entry
  %cmp58 = icmp eq i32 %and.i.145, 2047
  br i1 %cmp58, label %if.then.60, label %if.end.66

if.then.60:                                       ; preds = %aExpBigger
  %or61 = or i32 %or.i.202, %shl.i.199
  %tobool62 = icmp eq i32 %or61, 0
  br i1 %tobool62, label %if.end.65, label %if.then.63

if.then.63:                                       ; preds = %if.then.60
  %call64 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  %retval.sroa.0.0.extract.shift126 = and i64 %call64, -4294967296
  br label %cleanup

if.end.65:                                        ; preds = %if.then.60
  %retval.sroa.0.0.extract.shift130 = and i64 %a.coerce, -4294967296
  br label %cleanup

if.end.66:                                        ; preds = %aExpBigger
  %cmp67 = icmp eq i32 %and.i.205, 0
  br i1 %cmp67, label %if.end.72, label %if.end.72.thread

if.end.72.thread:                                 ; preds = %if.end.66
  %or71 = or i32 %or.i.198, 1073741824
  br label %if.else.i

if.end.72:                                        ; preds = %if.end.66
  %dec = add nsw i32 %sub, -1
  %cmp.i.142 = icmp eq i32 %dec, 0
  br i1 %cmp.i.142, label %shift64RightJamming.exit, label %if.else.i

if.else.i:                                        ; preds = %if.end.72.thread, %if.end.72
  %.pn = phi i32 [ 0, %if.end.72.thread ], [ 1, %if.end.72 ]
  %expDiff.1244 = phi i32 [ %sub, %if.end.72.thread ], [ %dec, %if.end.72 ]
  %bSig0.1243 = phi i32 [ %or71, %if.end.72.thread ], [ %or.i.198, %if.end.72 ]
  %and.i.141245.in = sub nsw i32 %.pn, %sub
  %and.i.141245 = and i32 %and.i.141245.in, 31
  %cmp2.i = icmp slt i32 %expDiff.1244, 32
  br i1 %cmp2.i, label %if.then.4.i, label %if.else.12.i

if.then.4.i:                                      ; preds = %if.else.i
  %shl.i = shl i32 %bSig0.1243, %and.i.141245
  %shr.i = lshr i32 %shl.i.196, %expDiff.1244
  %or.i = or i32 %shl.i, %shr.i
  %shl7.i = shl i32 %shl.i.196, %and.i.141245
  %cmp8.i = icmp ne i32 %shl7.i, 0
  %conv9.i = zext i1 %cmp8.i to i32
  %or10.i = or i32 %or.i, %conv9.i
  %shr11.i = lshr i32 %bSig0.1243, %expDiff.1244
  br label %shift64RightJamming.exit

if.else.12.i:                                     ; preds = %if.else.i
  %cmp13.i = icmp eq i32 %expDiff.1244, 32
  br i1 %cmp13.i, label %if.then.15.i, label %if.else.19.i

if.then.15.i:                                     ; preds = %if.else.12.i
  %cmp16.i = icmp ne i32 %shl.i.196, 0
  %conv17.i = zext i1 %cmp16.i to i32
  %or18.i = or i32 %bSig0.1243, %conv17.i
  br label %shift64RightJamming.exit

if.else.19.i:                                     ; preds = %if.else.12.i
  %cmp20.i = icmp slt i32 %expDiff.1244, 64
  br i1 %cmp20.i, label %if.then.22.i, label %if.else.31.i

if.then.22.i:                                     ; preds = %if.else.19.i
  %and23.i = and i32 %expDiff.1244, 31
  %shr24.i = lshr i32 %bSig0.1243, %and23.i
  %shl26.i = shl i32 %bSig0.1243, %and.i.141245
  %or27.i = or i32 %shl26.i, %shl.i.196
  %cmp28.i = icmp ne i32 %or27.i, 0
  %conv29.i = zext i1 %cmp28.i to i32
  %or30.i = or i32 %conv29.i, %shr24.i
  br label %shift64RightJamming.exit

if.else.31.i:                                     ; preds = %if.else.19.i
  %or32.i = or i32 %bSig0.1243, %shl.i.196
  %cmp33.i = icmp ne i32 %or32.i, 0
  %conv34.i = zext i1 %cmp33.i to i32
  br label %shift64RightJamming.exit

shift64RightJamming.exit:                         ; preds = %if.end.72, %if.then.4.i, %if.then.15.i, %if.then.22.i, %if.else.31.i
  %z1.1.i = phi i32 [ %or10.i, %if.then.4.i ], [ %shl.i.196, %if.end.72 ], [ %or18.i, %if.then.15.i ], [ %or30.i, %if.then.22.i ], [ %conv34.i, %if.else.31.i ]
  %z0.0.i = phi i32 [ %shr11.i, %if.then.4.i ], [ %or.i.198, %if.end.72 ], [ 0, %if.then.15.i ], [ 0, %if.then.22.i ], [ 0, %if.else.31.i ]
  %or73 = or i32 %or.i.202, 1073741824
  br label %aBigger

aBigger:                                          ; preds = %if.end.25, %if.end.19, %shift64RightJamming.exit
  %aSig0.2 = phi i32 [ %or73, %shift64RightJamming.exit ], [ %or.i.202, %if.end.19 ], [ %or.i.202, %if.end.25 ]
  %bSig0.2 = phi i32 [ %z0.0.i, %shift64RightJamming.exit ], [ %or.i.198, %if.end.19 ], [ %or.i.198, %if.end.25 ]
  %bSig1.0 = phi i32 [ %z1.1.i, %shift64RightJamming.exit ], [ %shl.i.196, %if.end.19 ], [ %shl.i.196, %if.end.25 ]
  %aExp.1 = phi i32 [ %and.i.145, %shift64RightJamming.exit ], [ %aExp.0, %if.end.19 ], [ %aExp.0, %if.end.25 ]
  %sub.i = sub i32 %shl.i.199, %bSig1.0
  %sub1.i = sub i32 %aSig0.2, %bSig0.2
  %cmp.i = icmp ult i32 %shl.i.199, %bSig1.0
  %conv.neg.i = sext i1 %cmp.i to i32
  %sub2.i = add i32 %sub1.i, %conv.neg.i
  br label %normalizeRoundAndPack

normalizeRoundAndPack:                            ; preds = %aBigger, %bBigger
  %zSig0.0 = phi i32 [ %sub2.i, %aBigger ], [ %sub2.i.150, %bBigger ]
  %zSig1.0 = phi i32 [ %sub.i, %aBigger ], [ %sub.i.146, %bBigger ]
  %zSign.addr.0 = phi i8 [ %zSign, %aBigger ], [ %conv57, %bBigger ]
  %zExp.0 = phi i32 [ %aExp.1, %aBigger ], [ %bExp.1, %bBigger ]
  %sub75 = add nsw i32 %zExp.0, -11
  %call76 = tail call fastcc i64 @normalizeRoundAndPackFloat64(i8 signext %zSign.addr.0, i32 signext %sub75, i32 zeroext %zSig0.0, i32 zeroext %zSig1.0)
  %retval.sroa.0.0.extract.shift128 = and i64 %call76, -4294967296
  br label %cleanup

cleanup:                                          ; preds = %normalizeRoundAndPack, %if.end.65, %if.then.63, %if.end.43, %if.then.41, %if.end.31, %if.end.15, %if.then.13
  %retval.sroa.0.0 = phi i64 [ %retval.sroa.0.0.extract.shift126, %if.then.63 ], [ %retval.sroa.0.0.extract.shift130, %if.end.65 ], [ %retval.sroa.0.0.extract.shift128, %normalizeRoundAndPack ], [ %retval.sroa.0.0.extract.shift122, %if.then.41 ], [ %retval.sroa.0.0.insert.ext.i, %if.end.43 ], [ %retval.sroa.0.0.extract.shift, %if.then.13 ], [ -2251799813685248, %if.end.15 ], [ %shl.i.190, %if.end.31 ]
  %retval.sroa.9.0 = phi i64 [ %call64, %if.then.63 ], [ %a.coerce, %if.end.65 ], [ %call76, %normalizeRoundAndPack ], [ %call42, %if.then.41 ], [ %retval.sroa.0.0.insert.ext.i, %if.end.43 ], [ %call14, %if.then.13 ], [ 0, %if.end.15 ], [ %shl.i.190, %if.end.31 ]
  %retval.sroa.0.0.insert.mask = and i64 %retval.sroa.9.0, 4294967295
  %retval.sroa.0.0.insert.insert = or i64 %retval.sroa.0.0.insert.mask, %retval.sroa.0.0
  ret i64 %retval.sroa.0.0.insert.insert
}

; Function Attrs: nounwind
define i64 @float64_sub(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift.i = lshr i64 %a.coerce, 63
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i to i8
  %a.sroa.0.0.extract.shift.i.10 = lshr i64 %b.coerce, 63
  %conv.i.11 = trunc i64 %a.sroa.0.0.extract.shift.i.10 to i8
  %cmp = icmp eq i8 %conv.i, %conv.i.11
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %call4 = tail call fastcc i64 @subFloat64Sigs(i64 %a.coerce, i64 %b.coerce, i8 signext %conv.i)
  br label %cleanup

if.else:                                          ; preds = %entry
  %call5 = tail call fastcc i64 @addFloat64Sigs(i64 %a.coerce, i64 %b.coerce, i8 signext %conv.i)
  br label %cleanup

cleanup:                                          ; preds = %if.else, %if.then
  %retval.sroa.0.0 = phi i64 [ %call4, %if.then ], [ %call5, %if.else ]
  ret i64 %retval.sroa.0.0
}

; Function Attrs: nounwind
define i64 @float64_mul(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.1.0.extract.trunc.i = trunc i64 %a.coerce to i32
  %a.sroa.0.0.extract.shift.i = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc.i = trunc i64 %a.sroa.0.0.extract.shift.i to i32
  %and.i = and i32 %a.sroa.0.0.extract.trunc.i, 1048575
  %a.sroa.0.0.extract.shift.i.214 = lshr i64 %a.coerce, 52
  %shr.i.215 = trunc i64 %a.sroa.0.0.extract.shift.i.214 to i32
  %and.i.216 = and i32 %shr.i.215, 2047
  %a.sroa.1.0.extract.trunc.i.232 = trunc i64 %b.coerce to i32
  %a.sroa.0.0.extract.shift.i.229 = lshr i64 %b.coerce, 32
  %a.sroa.0.0.extract.trunc.i.230 = trunc i64 %a.sroa.0.0.extract.shift.i.229 to i32
  %and.i.231 = and i32 %a.sroa.0.0.extract.trunc.i.230, 1048575
  %a.sroa.0.0.extract.shift.i.226 = lshr i64 %b.coerce, 52
  %shr.i.227 = trunc i64 %a.sroa.0.0.extract.shift.i.226 to i32
  %and.i.228 = and i32 %shr.i.227, 2047
  %a.sroa.0.0.extract.shift.i.222273 = xor i64 %b.coerce, %a.coerce
  %xor121272 = lshr i64 %a.sroa.0.0.extract.shift.i.222273, 63
  %xor121 = trunc i64 %xor121272 to i8
  %cmp = icmp eq i32 %and.i.216, 2047
  br i1 %cmp, label %if.then, label %if.end.24

if.then:                                          ; preds = %entry
  %or = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then.15

lor.lhs.false:                                    ; preds = %if.then
  %cmp11 = icmp ne i32 %and.i.228, 2047
  %or13 = or i32 %and.i.231, %a.sroa.1.0.extract.trunc.i.232
  %tobool14 = icmp eq i32 %or13, 0
  %or.cond = or i1 %cmp11, %tobool14
  br i1 %or.cond, label %if.end, label %if.then.15

if.then.15:                                       ; preds = %lor.lhs.false, %if.then
  %call16 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  %retval.sroa.0.0.extract.shift = and i64 %call16, -4294967296
  br label %cleanup

if.end:                                           ; preds = %lor.lhs.false
  %or18 = or i32 %or13, %and.i.228
  %cmp19 = icmp eq i32 %or18, 0
  br i1 %cmp19, label %invalid, label %if.end.22

if.end.22:                                        ; preds = %if.end
  %shl.i.218281 = shl nuw i64 %xor121272, 63
  %add.i.219 = or i64 %shl.i.218281, 9218868437227405312
  br label %cleanup

if.end.24:                                        ; preds = %entry
  %cmp25 = icmp eq i32 %and.i.228, 2047
  br i1 %cmp25, label %if.then.27, label %if.end.40

if.then.27:                                       ; preds = %if.end.24
  %or28 = or i32 %and.i.231, %a.sroa.1.0.extract.trunc.i.232
  %tobool29 = icmp eq i32 %or28, 0
  br i1 %tobool29, label %if.end.32, label %if.then.30

if.then.30:                                       ; preds = %if.then.27
  %call31 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  %retval.sroa.0.0.extract.shift105 = and i64 %call31, -4294967296
  br label %cleanup

if.end.32:                                        ; preds = %if.then.27
  %or33 = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %or34 = or i32 %or33, %and.i.216
  %cmp35 = icmp eq i32 %or34, 0
  br i1 %cmp35, label %invalid, label %if.end.38

invalid:                                          ; preds = %if.end.32, %if.end
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.38:                                        ; preds = %if.end.32
  %shl.i.210280 = shl nuw i64 %xor121272, 63
  %add.i.211 = or i64 %shl.i.210280, 9218868437227405312
  br label %cleanup

if.end.40:                                        ; preds = %if.end.24
  %cmp41 = icmp eq i32 %and.i.216, 0
  br i1 %cmp41, label %if.then.43, label %if.end.50

if.then.43:                                       ; preds = %if.end.40
  %or44 = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %cmp45 = icmp eq i32 %or44, 0
  br i1 %cmp45, label %if.then.47, label %if.end.49

if.then.47:                                       ; preds = %if.then.43
  %shl.i.206279 = shl nuw i64 %xor121272, 63
  br label %cleanup

if.end.49:                                        ; preds = %if.then.43
  %cmp.i.134 = icmp eq i32 %and.i, 0
  br i1 %cmp.i.134, label %if.then.i.140, label %if.else.14.i.174

if.then.i.140:                                    ; preds = %if.end.49
  %cmp.i.i.135 = icmp ult i32 %a.sroa.1.0.extract.trunc.i, 65536
  %shl.i.i.136 = shl i32 %a.sroa.1.0.extract.trunc.i, 16
  %shl.a.i.i.137 = select i1 %cmp.i.i.135, i32 %shl.i.i.136, i32 %a.sroa.1.0.extract.trunc.i
  %..i.i.138 = select i1 %cmp.i.i.135, i8 16, i8 0
  %cmp2.i.i.139 = icmp ult i32 %shl.a.i.i.137, 16777216
  br i1 %cmp2.i.i.139, label %if.then.4.i.i.145, label %countLeadingZeros32.exit.i.158

if.then.4.i.i.145:                                ; preds = %if.then.i.140
  %conv5.23.i.i.141 = zext i8 %..i.i.138 to i32
  %add6.i.i.142 = or i32 %conv5.23.i.i.141, 8
  %conv7.i.i.143 = trunc i32 %add6.i.i.142 to i8
  %shl8.i.i.144 = shl i32 %shl.a.i.i.137, 8
  br label %countLeadingZeros32.exit.i.158

countLeadingZeros32.exit.i.158:                   ; preds = %if.then.4.i.i.145, %if.then.i.140
  %a.addr.1.i.i.146 = phi i32 [ %shl8.i.i.144, %if.then.4.i.i.145 ], [ %shl.a.i.i.137, %if.then.i.140 ]
  %shiftCount.1.i.i.147 = phi i8 [ %conv7.i.i.143, %if.then.4.i.i.145 ], [ %..i.i.138, %if.then.i.140 ]
  %shr.i.i.148 = lshr i32 %a.addr.1.i.i.146, 24
  %idxprom.i.i.149 = zext i32 %shr.i.i.148 to i64
  %arrayidx.i.i.150 = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i.149
  %1 = load i8, i8* %arrayidx.i.i.150, align 1, !tbaa !5
  %conv10.22.i.i.151 = zext i8 %1 to i32
  %conv11.21.i.i.152 = zext i8 %shiftCount.1.i.i.147 to i32
  %add12.i.i.153 = add nuw nsw i32 %conv10.22.i.i.151, %conv11.21.i.i.152
  %conv.39.i.154 = shl i32 %add12.i.i.153, 24
  %sext40.i.155 = add i32 %conv.39.i.154, -184549376
  %conv2.i.156 = ashr exact i32 %sext40.i.155, 24
  %cmp3.i.157 = icmp slt i32 %sext40.i.155, 0
  br i1 %cmp3.i.157, label %if.then.5.i.163, label %if.else.i.165

if.then.5.i.163:                                  ; preds = %countLeadingZeros32.exit.i.158
  %sub7.i.159 = sub nsw i32 0, %conv2.i.156
  %shr.i.160 = lshr i32 %a.sroa.1.0.extract.trunc.i, %sub7.i.159
  %and.i.161 = and i32 %conv2.i.156, 31
  %shl.i.162 = shl i32 %a.sroa.1.0.extract.trunc.i, %and.i.161
  br label %if.end.i.168

if.else.i.165:                                    ; preds = %countLeadingZeros32.exit.i.158
  %shl10.i.164 = shl i32 %a.sroa.1.0.extract.trunc.i, %conv2.i.156
  br label %if.end.i.168

if.end.i.168:                                     ; preds = %if.else.i.165, %if.then.5.i.163
  %aSig0.0 = phi i32 [ %shr.i.160, %if.then.5.i.163 ], [ %shl10.i.164, %if.else.i.165 ]
  %storemerge.41.i.166 = phi i32 [ %shl.i.162, %if.then.5.i.163 ], [ 0, %if.else.i.165 ]
  %sub13.i.167 = sub nsw i32 -31, %conv2.i.156
  br label %if.end.50

if.else.14.i.174:                                 ; preds = %if.end.49
  %cmp.i.45.i.169 = icmp ult i32 %and.i, 65536
  %shl.i.46.i.170277 = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i, 16
  %shl.i.46.i.170 = trunc i64 %shl.i.46.i.170277 to i32
  %shl.a.i.47.i.171 = select i1 %cmp.i.45.i.169, i32 %shl.i.46.i.170, i32 %and.i
  %..i.48.i.172 = select i1 %cmp.i.45.i.169, i8 16, i8 0
  %cmp2.i.49.i.173 = icmp ult i32 %shl.a.i.47.i.171, 16777216
  br i1 %cmp2.i.49.i.173, label %if.then.4.i.54.i.179, label %countLeadingZeros32.exit64.i.193

if.then.4.i.54.i.179:                             ; preds = %if.else.14.i.174
  %conv5.23.i.50.i.175 = zext i8 %..i.48.i.172 to i32
  %add6.i.51.i.176 = or i32 %conv5.23.i.50.i.175, 8
  %conv7.i.52.i.177 = trunc i32 %add6.i.51.i.176 to i8
  %shl8.i.53.i.178 = shl i32 %shl.a.i.47.i.171, 8
  br label %countLeadingZeros32.exit64.i.193

countLeadingZeros32.exit64.i.193:                 ; preds = %if.then.4.i.54.i.179, %if.else.14.i.174
  %a.addr.1.i.55.i.180 = phi i32 [ %shl8.i.53.i.178, %if.then.4.i.54.i.179 ], [ %shl.a.i.47.i.171, %if.else.14.i.174 ]
  %shiftCount.1.i.56.i.181 = phi i8 [ %conv7.i.52.i.177, %if.then.4.i.54.i.179 ], [ %..i.48.i.172, %if.else.14.i.174 ]
  %shr.i.57.i.182 = lshr i32 %a.addr.1.i.55.i.180, 24
  %idxprom.i.58.i.183 = zext i32 %shr.i.57.i.182 to i64
  %arrayidx.i.59.i.184 = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.58.i.183
  %2 = load i8, i8* %arrayidx.i.59.i.184, align 1, !tbaa !5
  %conv10.22.i.60.i.185 = zext i8 %2 to i32
  %conv11.21.i.61.i.186 = zext i8 %shiftCount.1.i.56.i.181 to i32
  %add12.i.62.i.187 = add nuw nsw i32 %conv10.22.i.60.i.185, %conv11.21.i.61.i.186
  %conv16.38.i.188 = shl i32 %add12.i.62.i.187, 24
  %sext.i.189 = add i32 %conv16.38.i.188, -184549376
  %conv19.i.190 = ashr exact i32 %sext.i.189, 24
  %shl.i.42.i.191 = shl i32 %a.sroa.1.0.extract.trunc.i, %conv19.i.190
  %cmp.i.43.i.192 = icmp eq i32 %conv19.i.190, 0
  br i1 %cmp.i.43.i.192, label %shortShift64Left.exit.i.202, label %cond.false.i.i.199

cond.false.i.i.199:                               ; preds = %countLeadingZeros32.exit64.i.193
  %shl1.i.i.194 = shl i32 %and.i, %conv19.i.190
  %sub.i.i.195 = sub nsw i32 0, %conv19.i.190
  %and.i.i.196 = and i32 %sub.i.i.195, 31
  %shr.i.44.i.197 = lshr i32 %a.sroa.1.0.extract.trunc.i, %and.i.i.196
  %or.i.i.198 = or i32 %shr.i.44.i.197, %shl1.i.i.194
  br label %shortShift64Left.exit.i.202

shortShift64Left.exit.i.202:                      ; preds = %cond.false.i.i.199, %countLeadingZeros32.exit64.i.193
  %cond.i.i.200 = phi i32 [ %or.i.i.198, %cond.false.i.i.199 ], [ %and.i, %countLeadingZeros32.exit64.i.193 ]
  %sub21.i.201 = sub nsw i32 1, %conv19.i.190
  br label %if.end.50

if.end.50:                                        ; preds = %shortShift64Left.exit.i.202, %if.end.i.168, %if.end.40
  %aSig0.2 = phi i32 [ %and.i, %if.end.40 ], [ %aSig0.0, %if.end.i.168 ], [ %cond.i.i.200, %shortShift64Left.exit.i.202 ]
  %aSig1.1 = phi i32 [ %a.sroa.1.0.extract.trunc.i, %if.end.40 ], [ %storemerge.41.i.166, %if.end.i.168 ], [ %shl.i.42.i.191, %shortShift64Left.exit.i.202 ]
  %aExp.0 = phi i32 [ %and.i.216, %if.end.40 ], [ %sub13.i.167, %if.end.i.168 ], [ %sub21.i.201, %shortShift64Left.exit.i.202 ]
  %cmp51 = icmp eq i32 %and.i.228, 0
  br i1 %cmp51, label %if.then.53, label %if.end.60

if.then.53:                                       ; preds = %if.end.50
  %or54 = or i32 %and.i.231, %a.sroa.1.0.extract.trunc.i.232
  %cmp55 = icmp eq i32 %or54, 0
  br i1 %cmp55, label %if.then.57, label %if.end.59

if.then.57:                                       ; preds = %if.then.53
  %shl.i.133276 = shl nuw i64 %xor121272, 63
  br label %cleanup

if.end.59:                                        ; preds = %if.then.53
  %cmp.i.125 = icmp eq i32 %and.i.231, 0
  br i1 %cmp.i.125, label %if.then.i, label %if.else.14.i

if.then.i:                                        ; preds = %if.end.59
  %cmp.i.i.126 = icmp ult i32 %a.sroa.1.0.extract.trunc.i.232, 65536
  %shl.i.i.127 = shl i32 %a.sroa.1.0.extract.trunc.i.232, 16
  %shl.a.i.i = select i1 %cmp.i.i.126, i32 %shl.i.i.127, i32 %a.sroa.1.0.extract.trunc.i.232
  %..i.i = select i1 %cmp.i.i.126, i8 16, i8 0
  %cmp2.i.i = icmp ult i32 %shl.a.i.i, 16777216
  br i1 %cmp2.i.i, label %if.then.4.i.i, label %countLeadingZeros32.exit.i

if.then.4.i.i:                                    ; preds = %if.then.i
  %conv5.23.i.i = zext i8 %..i.i to i32
  %add6.i.i = or i32 %conv5.23.i.i, 8
  %conv7.i.i = trunc i32 %add6.i.i to i8
  %shl8.i.i = shl i32 %shl.a.i.i, 8
  br label %countLeadingZeros32.exit.i

countLeadingZeros32.exit.i:                       ; preds = %if.then.4.i.i, %if.then.i
  %a.addr.1.i.i = phi i32 [ %shl8.i.i, %if.then.4.i.i ], [ %shl.a.i.i, %if.then.i ]
  %shiftCount.1.i.i = phi i8 [ %conv7.i.i, %if.then.4.i.i ], [ %..i.i, %if.then.i ]
  %shr.i.i.128 = lshr i32 %a.addr.1.i.i, 24
  %idxprom.i.i = zext i32 %shr.i.i.128 to i64
  %arrayidx.i.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i
  %3 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !5
  %conv10.22.i.i = zext i8 %3 to i32
  %conv11.21.i.i = zext i8 %shiftCount.1.i.i to i32
  %add12.i.i = add nuw nsw i32 %conv10.22.i.i, %conv11.21.i.i
  %conv.39.i = shl i32 %add12.i.i, 24
  %sext40.i = add i32 %conv.39.i, -184549376
  %conv2.i = ashr exact i32 %sext40.i, 24
  %cmp3.i = icmp slt i32 %sext40.i, 0
  br i1 %cmp3.i, label %if.then.5.i, label %if.else.i

if.then.5.i:                                      ; preds = %countLeadingZeros32.exit.i
  %sub7.i = sub nsw i32 0, %conv2.i
  %shr.i.129 = lshr i32 %a.sroa.1.0.extract.trunc.i.232, %sub7.i
  %and.i.130 = and i32 %conv2.i, 31
  %shl.i.131 = shl i32 %a.sroa.1.0.extract.trunc.i.232, %and.i.130
  br label %if.end.i

if.else.i:                                        ; preds = %countLeadingZeros32.exit.i
  %shl10.i = shl i32 %a.sroa.1.0.extract.trunc.i.232, %conv2.i
  br label %if.end.i

if.end.i:                                         ; preds = %if.else.i, %if.then.5.i
  %bSig0.0 = phi i32 [ %shr.i.129, %if.then.5.i ], [ %shl10.i, %if.else.i ]
  %storemerge.41.i = phi i32 [ %shl.i.131, %if.then.5.i ], [ 0, %if.else.i ]
  %sub13.i = sub nsw i32 -31, %conv2.i
  br label %if.end.60

if.else.14.i:                                     ; preds = %if.end.59
  %cmp.i.45.i = icmp ult i32 %and.i.231, 65536
  %shl.i.46.i.132274 = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i.229, 16
  %shl.i.46.i.132 = trunc i64 %shl.i.46.i.132274 to i32
  %shl.a.i.47.i = select i1 %cmp.i.45.i, i32 %shl.i.46.i.132, i32 %and.i.231
  %..i.48.i = select i1 %cmp.i.45.i, i8 16, i8 0
  %cmp2.i.49.i = icmp ult i32 %shl.a.i.47.i, 16777216
  br i1 %cmp2.i.49.i, label %if.then.4.i.54.i, label %countLeadingZeros32.exit64.i

if.then.4.i.54.i:                                 ; preds = %if.else.14.i
  %conv5.23.i.50.i = zext i8 %..i.48.i to i32
  %add6.i.51.i = or i32 %conv5.23.i.50.i, 8
  %conv7.i.52.i = trunc i32 %add6.i.51.i to i8
  %shl8.i.53.i = shl i32 %shl.a.i.47.i, 8
  br label %countLeadingZeros32.exit64.i

countLeadingZeros32.exit64.i:                     ; preds = %if.then.4.i.54.i, %if.else.14.i
  %a.addr.1.i.55.i = phi i32 [ %shl8.i.53.i, %if.then.4.i.54.i ], [ %shl.a.i.47.i, %if.else.14.i ]
  %shiftCount.1.i.56.i = phi i8 [ %conv7.i.52.i, %if.then.4.i.54.i ], [ %..i.48.i, %if.else.14.i ]
  %shr.i.57.i = lshr i32 %a.addr.1.i.55.i, 24
  %idxprom.i.58.i = zext i32 %shr.i.57.i to i64
  %arrayidx.i.59.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.58.i
  %4 = load i8, i8* %arrayidx.i.59.i, align 1, !tbaa !5
  %conv10.22.i.60.i = zext i8 %4 to i32
  %conv11.21.i.61.i = zext i8 %shiftCount.1.i.56.i to i32
  %add12.i.62.i = add nuw nsw i32 %conv10.22.i.60.i, %conv11.21.i.61.i
  %conv16.38.i = shl i32 %add12.i.62.i, 24
  %sext.i = add i32 %conv16.38.i, -184549376
  %conv19.i = ashr exact i32 %sext.i, 24
  %shl.i.42.i = shl i32 %a.sroa.1.0.extract.trunc.i.232, %conv19.i
  %cmp.i.43.i = icmp eq i32 %conv19.i, 0
  br i1 %cmp.i.43.i, label %shortShift64Left.exit.i, label %cond.false.i.i

cond.false.i.i:                                   ; preds = %countLeadingZeros32.exit64.i
  %shl1.i.i = shl i32 %and.i.231, %conv19.i
  %sub.i.i = sub nsw i32 0, %conv19.i
  %and.i.i = and i32 %sub.i.i, 31
  %shr.i.44.i = lshr i32 %a.sroa.1.0.extract.trunc.i.232, %and.i.i
  %or.i.i = or i32 %shr.i.44.i, %shl1.i.i
  br label %shortShift64Left.exit.i

shortShift64Left.exit.i:                          ; preds = %cond.false.i.i, %countLeadingZeros32.exit64.i
  %cond.i.i = phi i32 [ %or.i.i, %cond.false.i.i ], [ %and.i.231, %countLeadingZeros32.exit64.i ]
  %sub21.i = sub nsw i32 1, %conv19.i
  br label %if.end.60

if.end.60:                                        ; preds = %shortShift64Left.exit.i, %if.end.i, %if.end.50
  %bExp.0 = phi i32 [ %and.i.228, %if.end.50 ], [ %sub21.i, %shortShift64Left.exit.i ], [ %sub13.i, %if.end.i ]
  %bSig0.2 = phi i32 [ %and.i.231, %if.end.50 ], [ %cond.i.i, %shortShift64Left.exit.i ], [ %bSig0.0, %if.end.i ]
  %bSig1.1 = phi i32 [ %a.sroa.1.0.extract.trunc.i.232, %if.end.50 ], [ %shl.i.42.i, %shortShift64Left.exit.i ], [ %storemerge.41.i, %if.end.i ]
  %add = add nsw i32 %bExp.0, %aExp.0
  %sub = add nsw i32 %add, -1024
  %or61 = or i32 %aSig0.2, 1048576
  %shl.i.122 = shl i32 %bSig1.1, 12
  %shl1.i = shl i32 %bSig0.2, 12
  %shr.i.123 = lshr i32 %bSig1.1, 20
  %shr.i.i = lshr i32 %aSig1.1, 16
  %5 = lshr i32 %bSig1.1, 4
  %shr3.i.i = and i32 %5, 65535
  %conv5.i.i = and i32 %aSig1.1, 65535
  %conv6.i.i = and i32 %shl.i.122, 61440
  %mul.i.i = mul nuw i32 %conv6.i.i, %conv5.i.i
  %mul9.i.i = mul nuw i32 %shr3.i.i, %conv5.i.i
  %mul12.i.i = mul nuw i32 %conv6.i.i, %shr.i.i
  %mul15.i.i = mul nuw i32 %shr3.i.i, %shr.i.i
  %add.i.i = add i32 %mul9.i.i, %mul12.i.i
  %cmp.i.i = icmp ult i32 %add.i.i, %mul12.i.i
  %conv16.i.i = zext i1 %cmp.i.i to i32
  %shl.i.i = shl nuw nsw i32 %conv16.i.i, 16
  %shr17.i.i = lshr i32 %add.i.i, 16
  %add18.i.i = or i32 %shl.i.i, %shr17.i.i
  %shl20.i.i = shl i32 %add.i.i, 16
  %add21.i.i = add i32 %shl20.i.i, %mul.i.i
  %cmp22.i.i = icmp ult i32 %add21.i.i, %shl20.i.i
  %conv23.i.i = zext i1 %cmp22.i.i to i32
  %6 = lshr i32 %bSig0.2, 4
  %shr3.i.60.i = and i32 %6, 65535
  %shl1.i.masked = and i32 %shl1.i, 61440
  %conv6.i.62.i = or i32 %shr.i.123, %shl1.i.masked
  %mul.i.63.i = mul nuw i32 %conv6.i.62.i, %conv5.i.i
  %mul9.i.64.i = mul nuw i32 %shr3.i.60.i, %conv5.i.i
  %mul12.i.65.i = mul nuw i32 %conv6.i.62.i, %shr.i.i
  %mul15.i.66.i = mul nuw i32 %shr3.i.60.i, %shr.i.i
  %add.i.67.i = add i32 %mul12.i.65.i, %mul9.i.64.i
  %cmp.i.68.i = icmp ult i32 %add.i.67.i, %mul12.i.65.i
  %conv16.i.69.i = zext i1 %cmp.i.68.i to i32
  %shl.i.70.i = shl nuw nsw i32 %conv16.i.69.i, 16
  %shr17.i.71.i = lshr i32 %add.i.67.i, 16
  %add18.i.72.i = or i32 %shl.i.70.i, %shr17.i.71.i
  %shl20.i.74.i = shl i32 %add.i.67.i, 16
  %add21.i.75.i = add i32 %shl20.i.74.i, %mul.i.63.i
  %cmp22.i.76.i = icmp ult i32 %add21.i.75.i, %shl20.i.74.i
  %conv23.i.77.i = zext i1 %cmp22.i.76.i to i32
  %add19.i.i = add i32 %add21.i.75.i, %mul15.i.i
  %add24.i.i = add i32 %add19.i.i, %add18.i.i
  %add.i.55.i = add i32 %add24.i.i, %conv23.i.i
  %cmp.i.56.i = icmp ult i32 %add.i.55.i, %add21.i.75.i
  %conv.i.57.i = zext i1 %cmp.i.56.i to i32
  %shr.i.35.i = lshr i32 %or61, 16
  %conv5.i.37.i = and i32 %aSig0.2, 65535
  %mul.i.39.i = mul nuw i32 %conv6.i.62.i, %conv5.i.37.i
  %mul9.i.40.i = mul nuw i32 %shr3.i.60.i, %conv5.i.37.i
  %mul12.i.41.i = mul nuw i32 %conv6.i.62.i, %shr.i.35.i
  %mul15.i.42.i = mul nuw i32 %shr3.i.60.i, %shr.i.35.i
  %add.i.43.i = add i32 %mul12.i.41.i, %mul9.i.40.i
  %cmp.i.44.i = icmp ult i32 %add.i.43.i, %mul12.i.41.i
  %conv16.i.45.i = zext i1 %cmp.i.44.i to i32
  %shl.i.46.i = shl nuw nsw i32 %conv16.i.45.i, 16
  %shr17.i.47.i = lshr i32 %add.i.43.i, 16
  %add18.i.48.i = or i32 %shl.i.46.i, %shr17.i.47.i
  %shl20.i.50.i = shl i32 %add.i.43.i, 16
  %add21.i.51.i = add i32 %shl20.i.50.i, %mul.i.39.i
  %cmp22.i.52.i = icmp ult i32 %add21.i.51.i, %shl20.i.50.i
  %conv23.i.53.i = zext i1 %cmp22.i.52.i to i32
  %add19.i.73.i = add i32 %add21.i.51.i, %mul15.i.66.i
  %add24.i.78.i = add i32 %add19.i.73.i, %add18.i.72.i
  %add2.i.58.i = add i32 %add24.i.78.i, %conv23.i.77.i
  %add.i.31.i = add i32 %add2.i.58.i, %conv.i.57.i
  %cmp.i.32.i = icmp ult i32 %add.i.31.i, %add21.i.51.i
  %conv.i.33.i = zext i1 %cmp.i.32.i to i32
  %mul.i.15.i = mul nuw i32 %conv6.i.i, %conv5.i.37.i
  %mul9.i.16.i = mul nuw i32 %shr3.i.i, %conv5.i.37.i
  %mul12.i.17.i = mul nuw i32 %conv6.i.i, %shr.i.35.i
  %mul15.i.18.i = mul nuw i32 %shr3.i.i, %shr.i.35.i
  %add.i.19.i = add i32 %mul9.i.16.i, %mul12.i.17.i
  %cmp.i.20.i = icmp ult i32 %add.i.19.i, %mul12.i.17.i
  %conv16.i.21.i = zext i1 %cmp.i.20.i to i32
  %shl.i.22.i = shl nuw nsw i32 %conv16.i.21.i, 16
  %shr17.i.23.i = lshr i32 %add.i.19.i, 16
  %add18.i.24.i = or i32 %shl.i.22.i, %shr17.i.23.i
  %add19.i.25.i = add i32 %add18.i.24.i, %mul15.i.18.i
  %shl20.i.26.i = shl i32 %add.i.19.i, 16
  %add21.i.27.i = add i32 %shl20.i.26.i, %mul.i.15.i
  %cmp22.i.28.i = icmp ult i32 %add21.i.27.i, %shl20.i.26.i
  %conv23.i.29.i = zext i1 %cmp22.i.28.i to i32
  %add24.i.30.i = add i32 %add19.i.25.i, %conv23.i.29.i
  %add.i.7.i = add i32 %add.i.55.i, %add21.i.27.i
  %cmp.i.8.i = icmp ult i32 %add.i.7.i, %add21.i.27.i
  %conv.i.9.i = zext i1 %cmp.i.8.i to i32
  %add2.i.10.i = add i32 %add24.i.30.i, %conv.i.9.i
  %add.i.5.i = add i32 %add2.i.10.i, %add.i.31.i
  %cmp.i.6.i = icmp ult i32 %add.i.5.i, %add.i.31.i
  %conv.i.i = zext i1 %cmp.i.6.i to i32
  %add.i = add i32 %add.i.5.i, %aSig1.1
  %cmp.i = icmp ult i32 %add.i, %add.i.5.i
  %conv.i = zext i1 %cmp.i to i32
  %add19.i.49.i = add i32 %mul15.i.42.i, %or61
  %add24.i.54.i = add i32 %add19.i.49.i, %add18.i.48.i
  %add2.i.34.i = add i32 %add24.i.54.i, %conv23.i.53.i
  %add2.i.i = add i32 %add2.i.34.i, %conv.i.33.i
  %add1.i = add i32 %add2.i.i, %conv.i.i
  %add2.i = add i32 %add1.i, %conv.i
  %cmp62 = icmp ne i32 %add21.i.i, 0
  %conv63 = zext i1 %cmp62 to i32
  %or64 = or i32 %add.i.7.i, %conv63
  %cmp65 = icmp ugt i32 %add2.i, 2097151
  br i1 %cmp65, label %if.then.67, label %if.end.68

if.then.67:                                       ; preds = %if.end.60
  %shl.i = shl i32 %add.i, 31
  %shl7.i = shl i32 %add2.i, 31
  %shr.i = lshr i32 %add.i, 1
  %or.i = or i32 %shl7.i, %shr.i
  %shr8.i = lshr i32 %add2.i, 1
  %cmp29.i = icmp ne i32 %or64, 0
  %conv30.i = zext i1 %cmp29.i to i32
  %or31.i = or i32 %shl.i, %conv30.i
  %inc = add nsw i32 %add, -1023
  br label %if.end.68

if.end.68:                                        ; preds = %if.then.67, %if.end.60
  %zSig0.0 = phi i32 [ %shr8.i, %if.then.67 ], [ %add2.i, %if.end.60 ]
  %zSig1.0 = phi i32 [ %or.i, %if.then.67 ], [ %add.i, %if.end.60 ]
  %zSig2.0 = phi i32 [ %or31.i, %if.then.67 ], [ %or64, %if.end.60 ]
  %zExp.0 = phi i32 [ %inc, %if.then.67 ], [ %sub, %if.end.60 ]
  %call69 = tail call fastcc i64 @roundAndPackFloat64(i8 signext %xor121, i32 signext %zExp.0, i32 zeroext %zSig0.0, i32 zeroext %zSig1.0, i32 zeroext %zSig2.0)
  %retval.sroa.0.0.extract.shift113 = and i64 %call69, -4294967296
  br label %cleanup

cleanup:                                          ; preds = %if.end.68, %if.then.57, %if.then.47, %if.end.38, %invalid, %if.then.30, %if.end.22, %if.then.15
  %retval.sroa.0.0 = phi i64 [ %retval.sroa.0.0.extract.shift, %if.then.15 ], [ -2251799813685248, %invalid ], [ %add.i.219, %if.end.22 ], [ %retval.sroa.0.0.extract.shift105, %if.then.30 ], [ %add.i.211, %if.end.38 ], [ %shl.i.206279, %if.then.47 ], [ %shl.i.133276, %if.then.57 ], [ %retval.sroa.0.0.extract.shift113, %if.end.68 ]
  %retval.sroa.9.0 = phi i64 [ %call16, %if.then.15 ], [ 0, %invalid ], [ %add.i.219, %if.end.22 ], [ %call31, %if.then.30 ], [ %add.i.211, %if.end.38 ], [ %shl.i.206279, %if.then.47 ], [ %shl.i.133276, %if.then.57 ], [ %call69, %if.end.68 ]
  %retval.sroa.0.0.insert.mask = and i64 %retval.sroa.9.0, 4294967295
  %retval.sroa.0.0.insert.insert = or i64 %retval.sroa.0.0.insert.mask, %retval.sroa.0.0
  ret i64 %retval.sroa.0.0.insert.insert
}

; Function Attrs: nounwind
define internal fastcc i64 @roundAndPackFloat64(i8 signext %zSign, i32 signext %zExp, i32 zeroext %zSig0, i32 zeroext %zSig1, i32 zeroext %zSig2) #2 {
entry:
  %0 = load i8, i8* @float_rounding_mode, align 1, !tbaa !5
  %cmp = icmp eq i8 %0, 0
  %zSig2.lobit = lshr i32 %zSig2, 31
  %1 = trunc i32 %zSig2.lobit to i8
  br i1 %cmp, label %if.end.27, label %if.then

if.then:                                          ; preds = %entry
  %cmp7 = icmp eq i8 %0, 3
  br i1 %cmp7, label %if.end.27, label %if.else

if.else:                                          ; preds = %if.then
  %tobool10 = icmp eq i8 %zSign, 0
  br i1 %tobool10, label %if.else.17, label %if.then.11

if.then.11:                                       ; preds = %if.else
  %cmp13 = icmp eq i8 %0, 1
  %tobool15 = icmp ne i32 %zSig2, 0
  %2 = and i1 %tobool15, %cmp13
  %conv16 = zext i1 %2 to i8
  br label %if.end.27

if.else.17:                                       ; preds = %if.else
  %cmp19 = icmp eq i8 %0, 2
  %tobool22 = icmp ne i32 %zSig2, 0
  %3 = and i1 %tobool22, %cmp19
  %conv25 = zext i1 %3 to i8
  br label %if.end.27

if.end.27:                                        ; preds = %if.then, %if.else.17, %if.then.11, %entry
  %increment.0 = phi i8 [ %1, %entry ], [ %conv16, %if.then.11 ], [ %conv25, %if.else.17 ], [ 0, %if.then ]
  %conv29 = and i32 %zExp, 65535
  %cmp30 = icmp ugt i32 %conv29, 2044
  br i1 %cmp30, label %if.then.32, label %if.end.113

if.then.32:                                       ; preds = %if.end.27
  %cmp33 = icmp sgt i32 %zExp, 2045
  br i1 %cmp33, label %if.then.42, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.then.32
  %cmp35 = icmp eq i32 %zExp, 2045
  br i1 %cmp35, label %land.lhs.true, label %if.end.63

land.lhs.true:                                    ; preds = %lor.lhs.false
  %tobool38204 = icmp ne i32 %zSig1, -1
  %not.cmp.i = icmp ne i32 %zSig0, 2097151
  %tobool38 = or i1 %not.cmp.i, %tobool38204
  %tobool41 = icmp eq i8 %increment.0, 0
  %or.cond = or i1 %tobool38, %tobool41
  br i1 %or.cond, label %if.end.113, label %if.then.42

if.then.42:                                       ; preds = %land.lhs.true, %if.then.32
  %4 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.187 = or i8 %4, 40
  store i8 %or3.i.187, i8* @float_exception_flags, align 1, !tbaa !5
  %cmp44 = icmp eq i8 %0, 3
  br i1 %cmp44, label %if.then.59, label %lor.lhs.false.46

lor.lhs.false.46:                                 ; preds = %if.then.42
  %tobool48 = icmp ne i8 %zSign, 0
  %cmp51 = icmp eq i8 %0, 2
  %or.cond164 = and i1 %tobool48, %cmp51
  br i1 %or.cond164, label %if.then.59, label %lor.lhs.false.53

lor.lhs.false.53:                                 ; preds = %lor.lhs.false.46
  %tobool54 = icmp eq i8 %zSign, 0
  %cmp57 = icmp eq i8 %0, 1
  %or.cond165 = and i1 %tobool54, %cmp57
  br i1 %or.cond165, label %if.then.59, label %if.end.61

if.then.59:                                       ; preds = %lor.lhs.false.53, %lor.lhs.false.46, %if.then.42
  %conv.6.i.180 = zext i8 %zSign to i64
  %shl.i.181 = shl i64 %conv.6.i.180, 63
  %retval.sroa.0.0.insert.insert.i.186 = or i64 %shl.i.181, 9218868437227405311
  br label %cleanup

if.end.61:                                        ; preds = %lor.lhs.false.53
  %conv.6.i.175 = zext i8 %zSign to i64
  %shl.i.176 = shl i64 %conv.6.i.175, 63
  %retval.sroa.0.0.insert.ext.i.178 = or i64 %shl.i.176, 9218868437227405312
  br label %cleanup

if.end.63:                                        ; preds = %lor.lhs.false
  %cmp64 = icmp slt i32 %zExp, 0
  br i1 %cmp64, label %if.then.66, label %if.end.113

if.then.66:                                       ; preds = %if.end.63
  %5 = load i8, i8* @float_detect_tininess, align 1, !tbaa !5
  %notlhs = icmp ne i8 %5, 1
  %notrhs = icmp sgt i32 %zExp, -2
  %or.cond.not = and i1 %notrhs, %notlhs
  %tobool74 = icmp ne i8 %increment.0, 0
  %or.cond136 = and i1 %tobool74, %or.cond.not
  %or.cond136.not = xor i1 %or.cond136, true
  %cmp.i.171 = icmp ult i32 %zSig0, 2097151
  %or.cond205 = or i1 %cmp.i.171, %or.cond136.not
  br i1 %or.cond205, label %if.else.i, label %lor.rhs.i

lor.rhs.i:                                        ; preds = %if.then.66
  %cmp1.i.172 = icmp eq i32 %zSig0, 2097151
  %cmp2.i.173 = icmp ne i32 %zSig1, -1
  %cmp2.i.173. = and i1 %cmp1.i.172, %cmp2.i.173
  br label %if.else.i

if.else.i:                                        ; preds = %if.then.66, %lor.rhs.i
  %6 = phi i1 [ true, %if.then.66 ], [ %cmp2.i.173., %lor.rhs.i ]
  %sub = sub nsw i32 0, %zExp
  %and.i = and i32 %zExp, 31
  %cmp2.i = icmp sgt i32 %zExp, -32
  br i1 %cmp2.i, label %if.then.4.i, label %if.else.9.i

if.then.4.i:                                      ; preds = %if.else.i
  %shl.i.170 = shl i32 %zSig1, %and.i
  %shl7.i = shl i32 %zSig0, %and.i
  %shr.i = lshr i32 %zSig1, %sub
  %or.i = or i32 %shr.i, %shl7.i
  %shr8.i = lshr i32 %zSig0, %sub
  br label %shift64ExtraRightJamming.exit

if.else.9.i:                                      ; preds = %if.else.i
  %cmp10.i = icmp eq i32 %sub, 32
  br i1 %cmp10.i, label %shift64ExtraRightJamming.exit, label %if.else.13.i

if.else.13.i:                                     ; preds = %if.else.9.i
  %or14.i = or i32 %zSig2, %zSig1
  %cmp15.i = icmp sgt i32 %zExp, -64
  br i1 %cmp15.i, label %if.then.17.i, label %if.else.22.i

if.then.17.i:                                     ; preds = %if.else.13.i
  %shl19.i = shl i32 %zSig0, %and.i
  %and20.i = and i32 %sub, 31
  %shr21.i = lshr i32 %zSig0, %and20.i
  br label %shift64ExtraRightJamming.exit

if.else.22.i:                                     ; preds = %if.else.13.i
  %cmp23.i = icmp eq i32 %sub, 64
  %cmp25.i = icmp ne i32 %zSig0, 0
  %conv26.i = zext i1 %cmp25.i to i32
  %cond.i = select i1 %cmp23.i, i32 %zSig0, i32 %conv26.i
  br label %shift64ExtraRightJamming.exit

shift64ExtraRightJamming.exit:                    ; preds = %if.then.4.i, %if.else.9.i, %if.then.17.i, %if.else.22.i
  %z0.0.i = phi i32 [ %shr8.i, %if.then.4.i ], [ 0, %if.else.9.i ], [ 0, %if.then.17.i ], [ 0, %if.else.22.i ]
  %z1.1.i = phi i32 [ %or.i, %if.then.4.i ], [ %zSig0, %if.else.9.i ], [ %shr21.i, %if.then.17.i ], [ 0, %if.else.22.i ]
  %z2.1.i = phi i32 [ %shl.i.170, %if.then.4.i ], [ %zSig1, %if.else.9.i ], [ %shl19.i, %if.then.17.i ], [ %cond.i, %if.else.22.i ]
  %a2.addr.1.i = phi i32 [ %zSig2, %if.then.4.i ], [ %zSig2, %if.else.9.i ], [ %or14.i, %if.then.17.i ], [ %or14.i, %if.else.22.i ]
  %cmp29.i = icmp ne i32 %a2.addr.1.i, 0
  %conv30.i = zext i1 %cmp29.i to i32
  %or31.i = or i32 %conv30.i, %z2.1.i
  %tobool82 = icmp ne i32 %or31.i, 0
  %or.cond137 = and i1 %6, %tobool82
  br i1 %or.cond137, label %if.then.83, label %if.end.84

if.then.83:                                       ; preds = %shift64ExtraRightJamming.exit
  %7 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %7, 16
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.84

if.end.84:                                        ; preds = %if.then.83, %shift64ExtraRightJamming.exit
  br i1 %cmp, label %if.then.86, label %if.else.90

if.then.86:                                       ; preds = %if.end.84
  %.lobit = lshr i32 %z2.1.i, 31
  %8 = trunc i32 %.lobit to i8
  br label %if.end.113

if.else.90:                                       ; preds = %if.end.84
  %tobool91 = icmp eq i8 %zSign, 0
  br i1 %tobool91, label %if.else.101, label %if.then.92

if.then.92:                                       ; preds = %if.else.90
  %cmp94 = icmp eq i8 %0, 1
  %9 = and i1 %cmp94, %tobool82
  %conv100 = zext i1 %9 to i8
  br label %if.end.113

if.else.101:                                      ; preds = %if.else.90
  %cmp103 = icmp eq i8 %0, 2
  %10 = and i1 %cmp103, %tobool82
  %conv109 = zext i1 %10 to i8
  br label %if.end.113

if.end.113:                                       ; preds = %land.lhs.true, %if.end.63, %if.then.92, %if.else.101, %if.then.86, %if.end.27
  %zSig0.addr.0 = phi i32 [ %z0.0.i, %if.then.86 ], [ %z0.0.i, %if.else.101 ], [ %z0.0.i, %if.then.92 ], [ %zSig0, %if.end.63 ], [ %zSig0, %if.end.27 ], [ %zSig0, %land.lhs.true ]
  %zSig1.addr.0 = phi i32 [ %z1.1.i, %if.then.86 ], [ %z1.1.i, %if.else.101 ], [ %z1.1.i, %if.then.92 ], [ %zSig1, %if.end.63 ], [ %zSig1, %if.end.27 ], [ %zSig1, %land.lhs.true ]
  %zSig2.addr.0 = phi i32 [ %or31.i, %if.then.86 ], [ %or31.i, %if.else.101 ], [ %or31.i, %if.then.92 ], [ %zSig2, %if.end.63 ], [ %zSig2, %if.end.27 ], [ %zSig2, %land.lhs.true ]
  %zExp.addr.0 = phi i32 [ 0, %if.then.86 ], [ 0, %if.else.101 ], [ 0, %if.then.92 ], [ %zExp, %if.end.63 ], [ %zExp, %if.end.27 ], [ 2045, %land.lhs.true ]
  %increment.1 = phi i8 [ %8, %if.then.86 ], [ %conv109, %if.else.101 ], [ %conv100, %if.then.92 ], [ %increment.0, %if.end.63 ], [ %increment.0, %if.end.27 ], [ %increment.0, %land.lhs.true ]
  %tobool114 = icmp eq i32 %zSig2.addr.0, 0
  br i1 %tobool114, label %if.end.118, label %if.then.115

if.then.115:                                      ; preds = %if.end.113
  %11 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %conv116.161 = zext i8 %11 to i32
  %or = or i32 %conv116.161, 32
  %conv117 = trunc i32 %or to i8
  store i8 %conv117, i8* @float_exception_flags, align 1, !tbaa !5
  br label %if.end.118

if.end.118:                                       ; preds = %if.end.113, %if.then.115
  %tobool119 = icmp eq i8 %increment.1, 0
  br i1 %tobool119, label %if.else.125, label %if.then.120

if.then.120:                                      ; preds = %if.end.118
  %add.i.166 = add i32 %zSig1.addr.0, 1
  %cmp.i.167 = icmp eq i32 %zSig1.addr.0, -1
  %conv.i = zext i1 %cmp.i.167 to i32
  %add2.i.168 = add i32 %conv.i, %zSig0.addr.0
  %add.mask = and i32 %zSig2.addr.0, 2147483647
  %cmp121 = icmp eq i32 %add.mask, 0
  %and160 = and i1 %cmp, %cmp121
  %and = zext i1 %and160 to i32
  %neg = xor i32 %and, -1
  %and124 = and i32 %add.i.166, %neg
  br label %if.end.131

if.else.125:                                      ; preds = %if.end.118
  %or126 = or i32 %zSig1.addr.0, %zSig0.addr.0
  %cmp127 = icmp eq i32 %or126, 0
  %.zExp.addr.0 = select i1 %cmp127, i32 0, i32 %zExp.addr.0
  br label %if.end.131

if.end.131:                                       ; preds = %if.else.125, %if.then.120
  %zSig0.addr.1 = phi i32 [ %zSig0.addr.0, %if.else.125 ], [ %add2.i.168, %if.then.120 ]
  %zSig1.addr.1 = phi i32 [ %zSig1.addr.0, %if.else.125 ], [ %and124, %if.then.120 ]
  %zExp.addr.1 = phi i32 [ %.zExp.addr.0, %if.else.125 ], [ %zExp.addr.0, %if.then.120 ]
  %conv.6.i = zext i8 %zSign to i32
  %shl.i = shl i32 %conv.6.i, 31
  %shl1.i = shl i32 %zExp.addr.1, 20
  %add.i = add i32 %zSig0.addr.1, %shl.i
  %add2.i = add i32 %add.i, %shl1.i
  %retval.sroa.2.0.insert.ext.i = zext i32 %zSig1.addr.1 to i64
  %retval.sroa.0.0.insert.ext.i = zext i32 %add2.i to i64
  %retval.sroa.0.0.insert.shift.i = shl nuw i64 %retval.sroa.0.0.insert.ext.i, 32
  %retval.sroa.0.0.insert.insert.i = or i64 %retval.sroa.0.0.insert.shift.i, %retval.sroa.2.0.insert.ext.i
  br label %cleanup

cleanup:                                          ; preds = %if.end.131, %if.end.61, %if.then.59
  %retval.sroa.0.0 = phi i64 [ %retval.sroa.0.0.insert.insert.i.186, %if.then.59 ], [ %retval.sroa.0.0.insert.ext.i.178, %if.end.61 ], [ %retval.sroa.0.0.insert.insert.i, %if.end.131 ]
  ret i64 %retval.sroa.0.0
}

; Function Attrs: nounwind
define i64 @float64_div(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.1.0.extract.trunc.i = trunc i64 %a.coerce to i32
  %a.sroa.0.0.extract.shift.i = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc.i = trunc i64 %a.sroa.0.0.extract.shift.i to i32
  %and.i = and i32 %a.sroa.0.0.extract.trunc.i, 1048575
  %a.sroa.0.0.extract.shift.i.395 = lshr i64 %a.coerce, 52
  %shr.i.396 = trunc i64 %a.sroa.0.0.extract.shift.i.395 to i32
  %and.i.397 = and i32 %shr.i.396, 2047
  %a.sroa.1.0.extract.trunc.i.404 = trunc i64 %b.coerce to i32
  %a.sroa.0.0.extract.shift.i.410 = lshr i64 %b.coerce, 32
  %a.sroa.0.0.extract.trunc.i.411 = trunc i64 %a.sroa.0.0.extract.shift.i.410 to i32
  %and.i.412 = and i32 %a.sroa.0.0.extract.trunc.i.411, 1048575
  %a.sroa.0.0.extract.shift.i.407 = lshr i64 %b.coerce, 52
  %shr.i.408 = trunc i64 %a.sroa.0.0.extract.shift.i.407 to i32
  %and.i.409 = and i32 %shr.i.408, 2047
  %a.sroa.0.0.extract.shift.i.403489 = xor i64 %b.coerce, %a.coerce
  %xor149488 = lshr i64 %a.sroa.0.0.extract.shift.i.403489, 63
  %xor149 = trunc i64 %xor149488 to i8
  %cmp = icmp eq i32 %and.i.397, 2047
  br i1 %cmp, label %if.then, label %if.end.23

if.then:                                          ; preds = %entry
  %or = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %if.end, label %if.then.11

if.then.11:                                       ; preds = %if.then
  %call12 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  %retval.sroa.0.0.extract.shift = and i64 %call12, -4294967296
  br label %cleanup

if.end:                                           ; preds = %if.then
  %cmp13 = icmp eq i32 %and.i.409, 2047
  br i1 %cmp13, label %if.then.15, label %if.end.21

if.then.15:                                       ; preds = %if.end
  %or16 = or i32 %and.i.412, %a.sroa.1.0.extract.trunc.i.404
  %tobool17 = icmp eq i32 %or16, 0
  br i1 %tobool17, label %invalid, label %if.then.18

if.then.18:                                       ; preds = %if.then.15
  %call19 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  %retval.sroa.0.0.extract.shift128 = and i64 %call19, -4294967296
  br label %cleanup

if.end.21:                                        ; preds = %if.end
  %shl.i.399497 = shl nuw i64 %xor149488, 63
  %add.i.400 = or i64 %shl.i.399497, 9218868437227405312
  br label %cleanup

if.end.23:                                        ; preds = %entry
  switch i32 %and.i.409, label %if.end.49 [
    i32 2047, label %if.then.26
    i32 0, label %if.then.36
  ]

if.then.26:                                       ; preds = %if.end.23
  %or27 = or i32 %and.i.412, %a.sroa.1.0.extract.trunc.i.404
  %tobool28 = icmp eq i32 %or27, 0
  br i1 %tobool28, label %if.end.31, label %if.then.29

if.then.29:                                       ; preds = %if.then.26
  %call30 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  %retval.sroa.0.0.extract.shift132 = and i64 %call30, -4294967296
  br label %cleanup

if.end.31:                                        ; preds = %if.then.26
  %shl.i.392496 = shl nuw i64 %xor149488, 63
  br label %cleanup

if.then.36:                                       ; preds = %if.end.23
  %or37 = or i32 %and.i.412, %a.sroa.1.0.extract.trunc.i.404
  %cmp38 = icmp eq i32 %or37, 0
  br i1 %cmp38, label %if.then.40, label %if.end.48

if.then.40:                                       ; preds = %if.then.36
  %or41 = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %or42 = or i32 %or41, %and.i.397
  %cmp43 = icmp eq i32 %or42, 0
  br i1 %cmp43, label %invalid, label %if.end.46

invalid:                                          ; preds = %if.then.15, %if.then.40
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i.390 = or i8 %0, 1
  store i8 %or3.i.390, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.46:                                        ; preds = %if.then.40
  %1 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %1, 4
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  %shl.i.386495 = shl nuw i64 %xor149488, 63
  %add.i.387 = or i64 %shl.i.386495, 9218868437227405312
  br label %cleanup

if.end.48:                                        ; preds = %if.then.36
  %cmp.i.314 = icmp eq i32 %and.i.412, 0
  br i1 %cmp.i.314, label %if.then.i.320, label %if.else.14.i.354

if.then.i.320:                                    ; preds = %if.end.48
  %cmp.i.i.315 = icmp ult i32 %a.sroa.1.0.extract.trunc.i.404, 65536
  %shl.i.i.316 = shl i32 %a.sroa.1.0.extract.trunc.i.404, 16
  %shl.a.i.i.317 = select i1 %cmp.i.i.315, i32 %shl.i.i.316, i32 %a.sroa.1.0.extract.trunc.i.404
  %..i.i.318 = select i1 %cmp.i.i.315, i8 16, i8 0
  %cmp2.i.i.319 = icmp ult i32 %shl.a.i.i.317, 16777216
  br i1 %cmp2.i.i.319, label %if.then.4.i.i.325, label %countLeadingZeros32.exit.i.338

if.then.4.i.i.325:                                ; preds = %if.then.i.320
  %conv5.23.i.i.321 = zext i8 %..i.i.318 to i32
  %add6.i.i.322 = or i32 %conv5.23.i.i.321, 8
  %conv7.i.i.323 = trunc i32 %add6.i.i.322 to i8
  %shl8.i.i.324 = shl i32 %shl.a.i.i.317, 8
  br label %countLeadingZeros32.exit.i.338

countLeadingZeros32.exit.i.338:                   ; preds = %if.then.4.i.i.325, %if.then.i.320
  %a.addr.1.i.i.326 = phi i32 [ %shl8.i.i.324, %if.then.4.i.i.325 ], [ %shl.a.i.i.317, %if.then.i.320 ]
  %shiftCount.1.i.i.327 = phi i8 [ %conv7.i.i.323, %if.then.4.i.i.325 ], [ %..i.i.318, %if.then.i.320 ]
  %shr.i.i.328 = lshr i32 %a.addr.1.i.i.326, 24
  %idxprom.i.i.329 = zext i32 %shr.i.i.328 to i64
  %arrayidx.i.i.330 = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i.329
  %2 = load i8, i8* %arrayidx.i.i.330, align 1, !tbaa !5
  %conv10.22.i.i.331 = zext i8 %2 to i32
  %conv11.21.i.i.332 = zext i8 %shiftCount.1.i.i.327 to i32
  %add12.i.i.333 = add nuw nsw i32 %conv10.22.i.i.331, %conv11.21.i.i.332
  %conv.39.i.334 = shl i32 %add12.i.i.333, 24
  %sext40.i.335 = add i32 %conv.39.i.334, -184549376
  %conv2.i.336 = ashr exact i32 %sext40.i.335, 24
  %cmp3.i.337 = icmp slt i32 %sext40.i.335, 0
  br i1 %cmp3.i.337, label %if.then.5.i.343, label %if.else.i.345

if.then.5.i.343:                                  ; preds = %countLeadingZeros32.exit.i.338
  %sub7.i.339 = sub nsw i32 0, %conv2.i.336
  %shr.i.340 = lshr i32 %a.sroa.1.0.extract.trunc.i.404, %sub7.i.339
  %and.i.341 = and i32 %conv2.i.336, 31
  %shl.i.342 = shl i32 %a.sroa.1.0.extract.trunc.i.404, %and.i.341
  br label %if.end.i.348

if.else.i.345:                                    ; preds = %countLeadingZeros32.exit.i.338
  %shl10.i.344 = shl i32 %a.sroa.1.0.extract.trunc.i.404, %conv2.i.336
  br label %if.end.i.348

if.end.i.348:                                     ; preds = %if.else.i.345, %if.then.5.i.343
  %bSig0.0 = phi i32 [ %shr.i.340, %if.then.5.i.343 ], [ %shl10.i.344, %if.else.i.345 ]
  %storemerge.41.i.346 = phi i32 [ %shl.i.342, %if.then.5.i.343 ], [ 0, %if.else.i.345 ]
  %sub13.i.347 = sub nsw i32 -31, %conv2.i.336
  br label %if.end.49

if.else.14.i.354:                                 ; preds = %if.end.48
  %cmp.i.45.i.349 = icmp ult i32 %and.i.412, 65536
  %shl.i.46.i.350490 = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i.410, 16
  %shl.i.46.i.350 = trunc i64 %shl.i.46.i.350490 to i32
  %shl.a.i.47.i.351 = select i1 %cmp.i.45.i.349, i32 %shl.i.46.i.350, i32 %and.i.412
  %..i.48.i.352 = select i1 %cmp.i.45.i.349, i8 16, i8 0
  %cmp2.i.49.i.353 = icmp ult i32 %shl.a.i.47.i.351, 16777216
  br i1 %cmp2.i.49.i.353, label %if.then.4.i.54.i.359, label %countLeadingZeros32.exit64.i.373

if.then.4.i.54.i.359:                             ; preds = %if.else.14.i.354
  %conv5.23.i.50.i.355 = zext i8 %..i.48.i.352 to i32
  %add6.i.51.i.356 = or i32 %conv5.23.i.50.i.355, 8
  %conv7.i.52.i.357 = trunc i32 %add6.i.51.i.356 to i8
  %shl8.i.53.i.358 = shl i32 %shl.a.i.47.i.351, 8
  br label %countLeadingZeros32.exit64.i.373

countLeadingZeros32.exit64.i.373:                 ; preds = %if.then.4.i.54.i.359, %if.else.14.i.354
  %a.addr.1.i.55.i.360 = phi i32 [ %shl8.i.53.i.358, %if.then.4.i.54.i.359 ], [ %shl.a.i.47.i.351, %if.else.14.i.354 ]
  %shiftCount.1.i.56.i.361 = phi i8 [ %conv7.i.52.i.357, %if.then.4.i.54.i.359 ], [ %..i.48.i.352, %if.else.14.i.354 ]
  %shr.i.57.i.362 = lshr i32 %a.addr.1.i.55.i.360, 24
  %idxprom.i.58.i.363 = zext i32 %shr.i.57.i.362 to i64
  %arrayidx.i.59.i.364 = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.58.i.363
  %3 = load i8, i8* %arrayidx.i.59.i.364, align 1, !tbaa !5
  %conv10.22.i.60.i.365 = zext i8 %3 to i32
  %conv11.21.i.61.i.366 = zext i8 %shiftCount.1.i.56.i.361 to i32
  %add12.i.62.i.367 = add nuw nsw i32 %conv10.22.i.60.i.365, %conv11.21.i.61.i.366
  %conv16.38.i.368 = shl i32 %add12.i.62.i.367, 24
  %sext.i.369 = add i32 %conv16.38.i.368, -184549376
  %conv19.i.370 = ashr exact i32 %sext.i.369, 24
  %shl.i.42.i.371 = shl i32 %a.sroa.1.0.extract.trunc.i.404, %conv19.i.370
  %cmp.i.43.i.372 = icmp eq i32 %conv19.i.370, 0
  br i1 %cmp.i.43.i.372, label %shortShift64Left.exit.i.382, label %cond.false.i.i.379

cond.false.i.i.379:                               ; preds = %countLeadingZeros32.exit64.i.373
  %shl1.i.i.374 = shl i32 %and.i.412, %conv19.i.370
  %sub.i.i.375 = sub nsw i32 0, %conv19.i.370
  %and.i.i.376 = and i32 %sub.i.i.375, 31
  %shr.i.44.i.377 = lshr i32 %a.sroa.1.0.extract.trunc.i.404, %and.i.i.376
  %or.i.i.378 = or i32 %shr.i.44.i.377, %shl1.i.i.374
  br label %shortShift64Left.exit.i.382

shortShift64Left.exit.i.382:                      ; preds = %cond.false.i.i.379, %countLeadingZeros32.exit64.i.373
  %cond.i.i.380 = phi i32 [ %or.i.i.378, %cond.false.i.i.379 ], [ %and.i.412, %countLeadingZeros32.exit64.i.373 ]
  %sub21.i.381 = sub nsw i32 1, %conv19.i.370
  br label %if.end.49

if.end.49:                                        ; preds = %shortShift64Left.exit.i.382, %if.end.i.348, %if.end.23
  %bSig0.2 = phi i32 [ %and.i.412, %if.end.23 ], [ %bSig0.0, %if.end.i.348 ], [ %cond.i.i.380, %shortShift64Left.exit.i.382 ]
  %bSig1.1 = phi i32 [ %a.sroa.1.0.extract.trunc.i.404, %if.end.23 ], [ %storemerge.41.i.346, %if.end.i.348 ], [ %shl.i.42.i.371, %shortShift64Left.exit.i.382 ]
  %bExp.0 = phi i32 [ %and.i.409, %if.end.23 ], [ %sub13.i.347, %if.end.i.348 ], [ %sub21.i.381, %shortShift64Left.exit.i.382 ]
  %cmp50 = icmp eq i32 %and.i.397, 0
  br i1 %cmp50, label %if.then.52, label %if.end.59

if.then.52:                                       ; preds = %if.end.49
  %or53 = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %cmp54 = icmp eq i32 %or53, 0
  br i1 %cmp54, label %if.then.56, label %if.end.58

if.then.56:                                       ; preds = %if.then.52
  %shl.i.313494 = shl nuw i64 %xor149488, 63
  br label %cleanup

if.end.58:                                        ; preds = %if.then.52
  %cmp.i.303 = icmp eq i32 %and.i, 0
  br i1 %cmp.i.303, label %if.then.i, label %if.else.14.i

if.then.i:                                        ; preds = %if.end.58
  %cmp.i.i.304 = icmp ult i32 %a.sroa.1.0.extract.trunc.i, 65536
  %shl.i.i.305 = shl i32 %a.sroa.1.0.extract.trunc.i, 16
  %shl.a.i.i = select i1 %cmp.i.i.304, i32 %shl.i.i.305, i32 %a.sroa.1.0.extract.trunc.i
  %..i.i = select i1 %cmp.i.i.304, i8 16, i8 0
  %cmp2.i.i = icmp ult i32 %shl.a.i.i, 16777216
  br i1 %cmp2.i.i, label %if.then.4.i.i, label %countLeadingZeros32.exit.i

if.then.4.i.i:                                    ; preds = %if.then.i
  %conv5.23.i.i = zext i8 %..i.i to i32
  %add6.i.i = or i32 %conv5.23.i.i, 8
  %conv7.i.i = trunc i32 %add6.i.i to i8
  %shl8.i.i = shl i32 %shl.a.i.i, 8
  br label %countLeadingZeros32.exit.i

countLeadingZeros32.exit.i:                       ; preds = %if.then.4.i.i, %if.then.i
  %a.addr.1.i.i = phi i32 [ %shl8.i.i, %if.then.4.i.i ], [ %shl.a.i.i, %if.then.i ]
  %shiftCount.1.i.i = phi i8 [ %conv7.i.i, %if.then.4.i.i ], [ %..i.i, %if.then.i ]
  %shr.i.i.306 = lshr i32 %a.addr.1.i.i, 24
  %idxprom.i.i = zext i32 %shr.i.i.306 to i64
  %arrayidx.i.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i
  %4 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !5
  %conv10.22.i.i = zext i8 %4 to i32
  %conv11.21.i.i = zext i8 %shiftCount.1.i.i to i32
  %add12.i.i = add nuw nsw i32 %conv10.22.i.i, %conv11.21.i.i
  %conv.39.i = shl i32 %add12.i.i, 24
  %sext40.i = add i32 %conv.39.i, -184549376
  %conv2.i = ashr exact i32 %sext40.i, 24
  %cmp3.i.307 = icmp slt i32 %sext40.i, 0
  br i1 %cmp3.i.307, label %if.then.5.i, label %if.else.i

if.then.5.i:                                      ; preds = %countLeadingZeros32.exit.i
  %sub7.i = sub nsw i32 0, %conv2.i
  %shr.i.308 = lshr i32 %a.sroa.1.0.extract.trunc.i, %sub7.i
  %and.i.309 = and i32 %conv2.i, 31
  %shl.i.310 = shl i32 %a.sroa.1.0.extract.trunc.i, %and.i.309
  br label %if.end.i.311

if.else.i:                                        ; preds = %countLeadingZeros32.exit.i
  %shl10.i = shl i32 %a.sroa.1.0.extract.trunc.i, %conv2.i
  br label %if.end.i.311

if.end.i.311:                                     ; preds = %if.else.i, %if.then.5.i
  %aSig0.0 = phi i32 [ %shr.i.308, %if.then.5.i ], [ %shl10.i, %if.else.i ]
  %storemerge.41.i = phi i32 [ %shl.i.310, %if.then.5.i ], [ 0, %if.else.i ]
  %sub13.i = sub nsw i32 -31, %conv2.i
  br label %if.end.59

if.else.14.i:                                     ; preds = %if.end.58
  %cmp.i.45.i = icmp ult i32 %and.i, 65536
  %shl.i.46.i492 = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i, 16
  %shl.i.46.i = trunc i64 %shl.i.46.i492 to i32
  %shl.a.i.47.i = select i1 %cmp.i.45.i, i32 %shl.i.46.i, i32 %and.i
  %..i.48.i = select i1 %cmp.i.45.i, i8 16, i8 0
  %cmp2.i.49.i = icmp ult i32 %shl.a.i.47.i, 16777216
  br i1 %cmp2.i.49.i, label %if.then.4.i.54.i, label %countLeadingZeros32.exit64.i

if.then.4.i.54.i:                                 ; preds = %if.else.14.i
  %conv5.23.i.50.i = zext i8 %..i.48.i to i32
  %add6.i.51.i = or i32 %conv5.23.i.50.i, 8
  %conv7.i.52.i = trunc i32 %add6.i.51.i to i8
  %shl8.i.53.i = shl i32 %shl.a.i.47.i, 8
  br label %countLeadingZeros32.exit64.i

countLeadingZeros32.exit64.i:                     ; preds = %if.then.4.i.54.i, %if.else.14.i
  %a.addr.1.i.55.i = phi i32 [ %shl8.i.53.i, %if.then.4.i.54.i ], [ %shl.a.i.47.i, %if.else.14.i ]
  %shiftCount.1.i.56.i = phi i8 [ %conv7.i.52.i, %if.then.4.i.54.i ], [ %..i.48.i, %if.else.14.i ]
  %shr.i.57.i = lshr i32 %a.addr.1.i.55.i, 24
  %idxprom.i.58.i = zext i32 %shr.i.57.i to i64
  %arrayidx.i.59.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.58.i
  %5 = load i8, i8* %arrayidx.i.59.i, align 1, !tbaa !5
  %conv10.22.i.60.i = zext i8 %5 to i32
  %conv11.21.i.61.i = zext i8 %shiftCount.1.i.56.i to i32
  %add12.i.62.i = add nuw nsw i32 %conv10.22.i.60.i, %conv11.21.i.61.i
  %conv16.38.i = shl i32 %add12.i.62.i, 24
  %sext.i = add i32 %conv16.38.i, -184549376
  %conv19.i = ashr exact i32 %sext.i, 24
  %shl.i.42.i = shl i32 %a.sroa.1.0.extract.trunc.i, %conv19.i
  %cmp.i.43.i = icmp eq i32 %conv19.i, 0
  br i1 %cmp.i.43.i, label %shortShift64Left.exit.i, label %cond.false.i.i

cond.false.i.i:                                   ; preds = %countLeadingZeros32.exit64.i
  %shl1.i.i = shl i32 %and.i, %conv19.i
  %sub.i.i.312 = sub nsw i32 0, %conv19.i
  %and.i.i = and i32 %sub.i.i.312, 31
  %shr.i.44.i = lshr i32 %a.sroa.1.0.extract.trunc.i, %and.i.i
  %or.i.i = or i32 %shr.i.44.i, %shl1.i.i
  br label %shortShift64Left.exit.i

shortShift64Left.exit.i:                          ; preds = %cond.false.i.i, %countLeadingZeros32.exit64.i
  %cond.i.i = phi i32 [ %or.i.i, %cond.false.i.i ], [ %and.i, %countLeadingZeros32.exit64.i ]
  %sub21.i = sub nsw i32 1, %conv19.i
  br label %if.end.59

if.end.59:                                        ; preds = %shortShift64Left.exit.i, %if.end.i.311, %if.end.49
  %aSig1.1 = phi i32 [ %a.sroa.1.0.extract.trunc.i, %if.end.49 ], [ %storemerge.41.i, %if.end.i.311 ], [ %shl.i.42.i, %shortShift64Left.exit.i ]
  %aSig0.2 = phi i32 [ %and.i, %if.end.49 ], [ %aSig0.0, %if.end.i.311 ], [ %cond.i.i, %shortShift64Left.exit.i ]
  %aExp.0 = phi i32 [ %and.i.397, %if.end.49 ], [ %sub13.i, %if.end.i.311 ], [ %sub21.i, %shortShift64Left.exit.i ]
  %sub = sub nsw i32 %aExp.0, %bExp.0
  %shl.i.296 = shl i32 %aSig1.1, 11
  %or60 = shl i32 %aSig0.2, 11
  %shr.i.298 = lshr i32 %aSig1.1, 21
  %shl1.i.297 = or i32 %shr.i.298, %or60
  %or.i.299 = or i32 %shl1.i.297, -2147483648
  %shl.i.290 = shl i32 %bSig1.1, 11
  %or61 = shl i32 %bSig0.2, 11
  %shl1.i = or i32 %or61, -2147483648
  %shr.i.291 = lshr i32 %bSig1.1, 21
  %or.i.292 = or i32 %shr.i.291, %shl1.i
  %cmp.i.288 = icmp ult i32 %or.i.292, %or.i.299
  br i1 %cmp.i.288, label %if.then.64, label %lor.rhs.i

lor.rhs.i:                                        ; preds = %if.end.59
  %add = add nsw i32 %sub, 1021
  %cmp1.i.289 = icmp ne i32 %or.i.292, %or.i.299
  %cmp2.i = icmp ugt i32 %shl.i.290, %shl.i.296
  %or.cond = or i1 %cmp2.i, %cmp1.i.289
  br i1 %or.cond, label %if.end.65, label %if.then.64

if.then.64:                                       ; preds = %lor.rhs.i, %if.end.59
  %shl.i.284 = shl i32 %shr.i.298, 31
  %6 = shl i32 %aSig1.1, 10
  %shr.i.285 = and i32 %6, 2147482624
  %or.i.286 = or i32 %shl.i.284, %shr.i.285
  %shr6.i.287 = lshr i32 %or.i.299, 1
  %inc = add nsw i32 %sub, 1022
  br label %if.end.65

if.end.65:                                        ; preds = %lor.rhs.i, %if.then.64
  %aSig1.2 = phi i32 [ %or.i.286, %if.then.64 ], [ %shl.i.296, %lor.rhs.i ]
  %aSig0.3 = phi i32 [ %shr6.i.287, %if.then.64 ], [ %or.i.299, %lor.rhs.i ]
  %zExp.0 = phi i32 [ %inc, %if.then.64 ], [ %add, %lor.rhs.i ]
  %cmp.i.233 = icmp ugt i32 %or.i.292, %aSig0.3
  %shr.i.234 = lshr i32 %shl1.i, 16
  br i1 %cmp.i.233, label %if.end.i.237, label %if.end.65.estimateDiv64To32.exit283_crit_edge

if.end.65.estimateDiv64To32.exit283_crit_edge:    ; preds = %if.end.65
  %.pre514 = and i32 %or.i.292, 65535
  br label %estimateDiv64To32.exit283

if.end.i.237:                                     ; preds = %if.end.65
  %shl.i.235 = shl nuw i32 %shr.i.234, 16
  %cmp1.i.236 = icmp ugt i32 %shl.i.235, %aSig0.3
  br i1 %cmp1.i.236, label %cond.false.i.240, label %cond.end.i.255

cond.false.i.240:                                 ; preds = %if.end.i.237
  %div.i.238 = udiv i32 %aSig0.3, %shr.i.234
  %shl2.i.239 = shl i32 %div.i.238, 16
  br label %cond.end.i.255

cond.end.i.255:                                   ; preds = %cond.false.i.240, %if.end.i.237
  %cond.i.241 = phi i32 [ %shl2.i.239, %cond.false.i.240 ], [ -65536, %if.end.i.237 ]
  %shr3.i.i.242 = lshr exact i32 %cond.i.241, 16
  %conv5.i.i.243 = and i32 %or.i.292, 65535
  %mul9.i.i.244 = mul nuw i32 %shr3.i.i.242, %conv5.i.i.243
  %mul15.i.i.245 = mul nuw i32 %shr3.i.i.242, %shr.i.234
  %shr17.i.i.246 = lshr i32 %mul9.i.i.244, 16
  %shl20.i.i.247 = shl i32 %mul9.i.i.244, 16
  %sub.i.i.248 = sub i32 %aSig1.2, %shl20.i.i.247
  %cmp.i.39.i.249 = icmp ult i32 %aSig1.2, %shl20.i.i.247
  %conv.neg.i.i.250 = sext i1 %cmp.i.39.i.249 to i32
  %add24.i.neg.i.251 = sub i32 %aSig0.3, %mul15.i.i.245
  %sub1.i.i.252 = sub i32 %add24.i.neg.i.251, %shr17.i.i.246
  %sub2.i.i.253 = add i32 %sub1.i.i.252, %conv.neg.i.i.250
  %cmp3.45.i.254 = icmp slt i32 %sub2.i.i.253, 0
  br i1 %cmp3.45.i.254, label %while.body.lr.ph.i.257, label %while.end.i.276

while.body.lr.ph.i.257:                           ; preds = %cond.end.i.255
  %shl4.i.256 = shl i32 %or.i.292, 16
  br label %while.body.i.268

while.body.i.268:                                 ; preds = %while.body.i.268, %while.body.lr.ph.i.257
  %z.048.i.258 = phi i32 [ %cond.i.241, %while.body.lr.ph.i.257 ], [ %sub.i.261, %while.body.i.268 ]
  %rem0.047.i.259 = phi i32 [ %sub2.i.i.253, %while.body.lr.ph.i.257 ], [ %add2.i.i.266, %while.body.i.268 ]
  %rem1.046.i.260 = phi i32 [ %sub.i.i.248, %while.body.lr.ph.i.257 ], [ %add.i.37.i.262, %while.body.i.268 ]
  %sub.i.261 = add i32 %z.048.i.258, -65536
  %add.i.37.i.262 = add i32 %rem1.046.i.260, %shl4.i.256
  %add1.i.i.263 = add i32 %rem0.047.i.259, %shr.i.234
  %cmp.i.38.i.264 = icmp ult i32 %add.i.37.i.262, %rem1.046.i.260
  %conv.i.i.265 = zext i1 %cmp.i.38.i.264 to i32
  %add2.i.i.266 = add i32 %add1.i.i.263, %conv.i.i.265
  %cmp3.i.267 = icmp slt i32 %add2.i.i.266, 0
  br i1 %cmp3.i.267, label %while.body.i.268, label %while.end.i.276.loopexit

while.end.i.276.loopexit:                         ; preds = %while.body.i.268
  %add2.i.i.266.lcssa = phi i32 [ %add2.i.i.266, %while.body.i.268 ]
  %add.i.37.i.262.lcssa = phi i32 [ %add.i.37.i.262, %while.body.i.268 ]
  %sub.i.261.lcssa = phi i32 [ %sub.i.261, %while.body.i.268 ]
  br label %while.end.i.276

while.end.i.276:                                  ; preds = %while.end.i.276.loopexit, %cond.end.i.255
  %z.0.lcssa.i.269 = phi i32 [ %cond.i.241, %cond.end.i.255 ], [ %sub.i.261.lcssa, %while.end.i.276.loopexit ]
  %rem0.0.lcssa.i.270 = phi i32 [ %sub2.i.i.253, %cond.end.i.255 ], [ %add2.i.i.266.lcssa, %while.end.i.276.loopexit ]
  %rem1.0.lcssa.i.271 = phi i32 [ %sub.i.i.248, %cond.end.i.255 ], [ %add.i.37.i.262.lcssa, %while.end.i.276.loopexit ]
  %shl5.i.272 = shl i32 %rem0.0.lcssa.i.270, 16
  %shr6.i.273 = lshr i32 %rem1.0.lcssa.i.271, 16
  %or.i.274 = or i32 %shr6.i.273, %shl5.i.272
  %cmp8.i.275 = icmp ugt i32 %shl.i.235, %or.i.274
  br i1 %cmp8.i.275, label %cond.false.10.i.278, label %cond.end.12.i.281

cond.false.10.i.278:                              ; preds = %while.end.i.276
  %div11.i.277 = udiv i32 %or.i.274, %shr.i.234
  br label %cond.end.12.i.281

cond.end.12.i.281:                                ; preds = %cond.false.10.i.278, %while.end.i.276
  %cond13.i.279 = phi i32 [ %div11.i.277, %cond.false.10.i.278 ], [ 65535, %while.end.i.276 ]
  %or14.i.280 = or i32 %cond13.i.279, %z.0.lcssa.i.269
  br label %estimateDiv64To32.exit283

estimateDiv64To32.exit283:                        ; preds = %if.end.65.estimateDiv64To32.exit283_crit_edge, %cond.end.12.i.281
  %conv5.i.6.i.210.pre-phi = phi i32 [ %.pre514, %if.end.65.estimateDiv64To32.exit283_crit_edge ], [ %conv5.i.i.243, %cond.end.12.i.281 ]
  %retval.0.i.282 = phi i32 [ -1, %if.end.65.estimateDiv64To32.exit283_crit_edge ], [ %or14.i.280, %cond.end.12.i.281 ]
  %7 = lshr i32 %bSig1.1, 5
  %shr.i.i.191 = and i32 %7, 65535
  %shr3.i.i.192 = lshr i32 %retval.0.i.282, 16
  %conv5.i.i.193 = and i32 %shl.i.290, 63488
  %conv6.i.i.194 = and i32 %retval.0.i.282, 65535
  %mul.i.i.195 = mul nuw i32 %conv6.i.i.194, %conv5.i.i.193
  %mul9.i.i.196 = mul nuw i32 %shr3.i.i.192, %conv5.i.i.193
  %mul12.i.i.197 = mul nuw i32 %conv6.i.i.194, %shr.i.i.191
  %mul15.i.i.198 = mul nuw i32 %shr3.i.i.192, %shr.i.i.191
  %add.i.i.199 = add i32 %mul9.i.i.196, %mul12.i.i.197
  %cmp.i.i.200 = icmp ult i32 %add.i.i.199, %mul12.i.i.197
  %conv16.i.i.201 = zext i1 %cmp.i.i.200 to i32
  %shl.i.i.202 = shl nuw nsw i32 %conv16.i.i.201, 16
  %shr17.i.i.203 = lshr i32 %add.i.i.199, 16
  %add18.i.i.204 = or i32 %shl.i.i.202, %shr17.i.i.203
  %shl20.i.i.205 = shl i32 %add.i.i.199, 16
  %add21.i.i.206 = add i32 %shl20.i.i.205, %mul.i.i.195
  %cmp22.i.i.207 = icmp ult i32 %add21.i.i.206, %shl20.i.i.205
  %conv23.i.i.208 = zext i1 %cmp22.i.i.207 to i32
  %mul.i.8.i.211 = mul nuw i32 %conv6.i.i.194, %conv5.i.6.i.210.pre-phi
  %mul9.i.9.i.212 = mul nuw i32 %shr3.i.i.192, %conv5.i.6.i.210.pre-phi
  %mul12.i.10.i.213 = mul nuw i32 %conv6.i.i.194, %shr.i.234
  %mul15.i.11.i.214 = mul nuw i32 %shr3.i.i.192, %shr.i.234
  %add.i.12.i.215 = add i32 %mul9.i.9.i.212, %mul12.i.10.i.213
  %cmp.i.13.i.216 = icmp ult i32 %add.i.12.i.215, %mul12.i.10.i.213
  %conv16.i.14.i.217 = zext i1 %cmp.i.13.i.216 to i32
  %shl.i.15.i.218 = shl nuw nsw i32 %conv16.i.14.i.217, 16
  %shr17.i.16.i.219 = lshr i32 %add.i.12.i.215, 16
  %add18.i.17.i.220 = or i32 %shl.i.15.i.218, %shr17.i.16.i.219
  %shl20.i.19.i.222 = shl i32 %add.i.12.i.215, 16
  %add21.i.20.i.223 = add i32 %shl20.i.19.i.222, %mul.i.8.i.211
  %cmp22.i.21.i.224 = icmp ult i32 %add21.i.20.i.223, %shl20.i.19.i.222
  %add19.i.i.227 = add i32 %add21.i.20.i.223, %mul15.i.i.198
  %add24.i.i.228 = add i32 %add19.i.i.227, %add18.i.i.204
  %add.i.2.i.229 = add i32 %add24.i.i.228, %conv23.i.i.208
  %cmp.i.3.i.230 = icmp ult i32 %add.i.2.i.229, %add21.i.20.i.223
  %sub.i.179 = sub i32 0, %add21.i.i.206
  %cmp.i.180 = icmp ne i32 %add21.i.i.206, 0
  %sub2.i.181 = sub i32 %aSig1.2, %add.i.2.i.229
  %cmp3.i.182 = icmp ult i32 %aSig1.2, %add.i.2.i.229
  %conv23.i.22.i.225.neg = sext i1 %cmp22.i.21.i.224 to i32
  %conv.i.i.231.neg = sext i1 %cmp.i.3.i.230 to i32
  %conv7.i.184 = zext i1 %cmp.i.180 to i32
  %cmp8.i.185 = icmp ult i32 %sub2.i.181, %conv7.i.184
  %conv9.neg.i.186 = sext i1 %cmp8.i.185 to i32
  %sub12.i.187 = sub i32 %sub2.i.181, %conv7.i.184
  %conv13.neg.i.188 = sext i1 %cmp3.i.182 to i32
  %add19.i.18.i.221.neg = sub i32 %aSig0.3, %mul15.i.11.i.214
  %add24.i.23.i.226.neg = sub i32 %add19.i.18.i.221.neg, %add18.i.17.i.220
  %add2.i.i.232.neg = add i32 %add24.i.23.i.226.neg, %conv23.i.22.i.225.neg
  %sub6.i.183 = add i32 %add2.i.i.232.neg, %conv.i.i.231.neg
  %sub10.i.189 = add i32 %sub6.i.183, %conv13.neg.i.188
  %sub14.i.190 = add i32 %sub10.i.189, %conv9.neg.i.186
  %cmp67.506 = icmp slt i32 %sub14.i.190, 0
  br i1 %cmp67.506, label %while.body.preheader, label %while.end

while.body.preheader:                             ; preds = %estimateDiv64To32.exit283
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %rem2.0510 = phi i32 [ %add.i.168, %while.body ], [ %sub.i.179, %while.body.preheader ]
  %rem1.0509 = phi i32 [ %add8.i.173, %while.body ], [ %sub12.i.187, %while.body.preheader ]
  %rem0.0508 = phi i32 [ %add14.i.178, %while.body ], [ %sub14.i.190, %while.body.preheader ]
  %zSig0.0507 = phi i32 [ %dec, %while.body ], [ %retval.0.i.282, %while.body.preheader ]
  %dec = add i32 %zSig0.0507, -1
  %add.i.168 = add i32 %rem2.0510, %shl.i.290
  %cmp.i.169 = icmp ult i32 %add.i.168, %rem2.0510
  %add2.i.170 = add i32 %rem1.0509, %or.i.292
  %cmp3.i.171 = icmp ult i32 %add2.i.170, %rem1.0509
  %conv7.i.172 = zext i1 %cmp.i.169 to i32
  %add8.i.173 = add i32 %conv7.i.172, %add2.i.170
  %cmp10.i.174 = icmp ult i32 %add8.i.173, %conv7.i.172
  %conv11.i.175 = zext i1 %cmp10.i.174 to i32
  %conv13.i.176 = zext i1 %cmp3.i.171 to i32
  %add12.i.177 = add i32 %conv13.i.176, %rem0.0508
  %add14.i.178 = add i32 %add12.i.177, %conv11.i.175
  %cmp67 = icmp slt i32 %add14.i.178, 0
  br i1 %cmp67, label %while.body, label %while.end.loopexit

while.end.loopexit:                               ; preds = %while.body
  %add8.i.173.lcssa = phi i32 [ %add8.i.173, %while.body ]
  %add.i.168.lcssa = phi i32 [ %add.i.168, %while.body ]
  %dec.lcssa = phi i32 [ %dec, %while.body ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %estimateDiv64To32.exit283
  %rem2.0.lcssa = phi i32 [ %sub.i.179, %estimateDiv64To32.exit283 ], [ %add.i.168.lcssa, %while.end.loopexit ]
  %rem1.0.lcssa = phi i32 [ %sub12.i.187, %estimateDiv64To32.exit283 ], [ %add8.i.173.lcssa, %while.end.loopexit ]
  %zSig0.0.lcssa = phi i32 [ %retval.0.i.282, %estimateDiv64To32.exit283 ], [ %dec.lcssa, %while.end.loopexit ]
  %cmp.i.153 = icmp ugt i32 %or.i.292, %rem1.0.lcssa
  br i1 %cmp.i.153, label %if.end.i, label %if.end.84

if.end.i:                                         ; preds = %while.end
  %shl.i.155 = shl nuw i32 %shr.i.234, 16
  %cmp1.i = icmp ugt i32 %shl.i.155, %rem1.0.lcssa
  br i1 %cmp1.i, label %cond.false.i, label %cond.end.i

cond.false.i:                                     ; preds = %if.end.i
  %div.i = udiv i32 %rem1.0.lcssa, %shr.i.234
  %shl2.i = shl i32 %div.i, 16
  br label %cond.end.i

cond.end.i:                                       ; preds = %cond.false.i, %if.end.i
  %cond.i = phi i32 [ %shl2.i, %cond.false.i ], [ -65536, %if.end.i ]
  %shr3.i.i.156 = lshr exact i32 %cond.i, 16
  %mul9.i.i.158 = mul nuw i32 %shr3.i.i.156, %conv5.i.6.i.210.pre-phi
  %mul15.i.i.159 = mul nuw i32 %shr3.i.i.156, %shr.i.234
  %shr17.i.i.160 = lshr i32 %mul9.i.i.158, 16
  %shl20.i.i.161 = shl i32 %mul9.i.i.158, 16
  %sub.i.i = sub i32 %rem2.0.lcssa, %shl20.i.i.161
  %cmp.i.39.i = icmp ult i32 %rem2.0.lcssa, %shl20.i.i.161
  %conv.neg.i.i = sext i1 %cmp.i.39.i to i32
  %add24.i.neg.i = sub i32 %rem1.0.lcssa, %mul15.i.i.159
  %sub1.i.i = sub i32 %add24.i.neg.i, %shr17.i.i.160
  %sub2.i.i = add i32 %sub1.i.i, %conv.neg.i.i
  %cmp3.45.i = icmp slt i32 %sub2.i.i, 0
  br i1 %cmp3.45.i, label %while.body.lr.ph.i, label %while.end.i

while.body.lr.ph.i:                               ; preds = %cond.end.i
  %shl4.i = shl i32 %or.i.292, 16
  br label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %while.body.lr.ph.i
  %z.048.i = phi i32 [ %cond.i, %while.body.lr.ph.i ], [ %sub.i.162, %while.body.i ]
  %rem0.047.i = phi i32 [ %sub2.i.i, %while.body.lr.ph.i ], [ %add2.i.i.164, %while.body.i ]
  %rem1.046.i = phi i32 [ %sub.i.i, %while.body.lr.ph.i ], [ %add.i.37.i, %while.body.i ]
  %sub.i.162 = add i32 %z.048.i, -65536
  %add.i.37.i = add i32 %rem1.046.i, %shl4.i
  %add1.i.i = add i32 %rem0.047.i, %shr.i.234
  %cmp.i.38.i = icmp ult i32 %add.i.37.i, %rem1.046.i
  %conv.i.i.163 = zext i1 %cmp.i.38.i to i32
  %add2.i.i.164 = add i32 %add1.i.i, %conv.i.i.163
  %cmp3.i.165 = icmp slt i32 %add2.i.i.164, 0
  br i1 %cmp3.i.165, label %while.body.i, label %while.end.i.loopexit

while.end.i.loopexit:                             ; preds = %while.body.i
  %add2.i.i.164.lcssa = phi i32 [ %add2.i.i.164, %while.body.i ]
  %add.i.37.i.lcssa = phi i32 [ %add.i.37.i, %while.body.i ]
  %sub.i.162.lcssa = phi i32 [ %sub.i.162, %while.body.i ]
  br label %while.end.i

while.end.i:                                      ; preds = %while.end.i.loopexit, %cond.end.i
  %z.0.lcssa.i = phi i32 [ %cond.i, %cond.end.i ], [ %sub.i.162.lcssa, %while.end.i.loopexit ]
  %rem0.0.lcssa.i = phi i32 [ %sub2.i.i, %cond.end.i ], [ %add2.i.i.164.lcssa, %while.end.i.loopexit ]
  %rem1.0.lcssa.i = phi i32 [ %sub.i.i, %cond.end.i ], [ %add.i.37.i.lcssa, %while.end.i.loopexit ]
  %shl5.i = shl i32 %rem0.0.lcssa.i, 16
  %shr6.i = lshr i32 %rem1.0.lcssa.i, 16
  %or.i.166 = or i32 %shr6.i, %shl5.i
  %cmp8.i.167 = icmp ugt i32 %shl.i.155, %or.i.166
  br i1 %cmp8.i.167, label %cond.false.10.i, label %estimateDiv64To32.exit

cond.false.10.i:                                  ; preds = %while.end.i
  %div11.i = udiv i32 %or.i.166, %shr.i.234
  br label %estimateDiv64To32.exit

estimateDiv64To32.exit:                           ; preds = %while.end.i, %cond.false.10.i
  %cond13.i = phi i32 [ %div11.i, %cond.false.10.i ], [ 65535, %while.end.i ]
  %or14.i = or i32 %cond13.i, %z.0.lcssa.i
  %and = and i32 %or14.i, 1023
  %cmp70 = icmp ult i32 %and, 5
  br i1 %cmp70, label %if.then.72, label %if.end.84

if.then.72:                                       ; preds = %estimateDiv64To32.exit
  %shr3.i.i = lshr i32 %or14.i, 16
  %conv6.i.i = and i32 %or14.i, 65535
  %mul.i.i = mul nuw i32 %conv6.i.i, %conv5.i.i.193
  %mul9.i.i = mul nuw i32 %shr3.i.i, %conv5.i.i.193
  %mul12.i.i = mul nuw i32 %conv6.i.i, %shr.i.i.191
  %mul15.i.i = mul nuw i32 %shr3.i.i, %shr.i.i.191
  %add.i.i = add i32 %mul9.i.i, %mul12.i.i
  %cmp.i.i = icmp ult i32 %add.i.i, %mul12.i.i
  %conv16.i.i = zext i1 %cmp.i.i to i32
  %shl.i.i = shl nuw nsw i32 %conv16.i.i, 16
  %shr17.i.i = lshr i32 %add.i.i, 16
  %add18.i.i = or i32 %shl.i.i, %shr17.i.i
  %shl20.i.i = shl i32 %add.i.i, 16
  %add21.i.i = add i32 %shl20.i.i, %mul.i.i
  %cmp22.i.i = icmp ult i32 %add21.i.i, %shl20.i.i
  %conv23.i.i = zext i1 %cmp22.i.i to i32
  %mul.i.8.i = mul nuw i32 %conv6.i.i, %conv5.i.6.i.210.pre-phi
  %mul9.i.9.i = mul nuw i32 %shr3.i.i, %conv5.i.6.i.210.pre-phi
  %mul12.i.10.i = mul nuw i32 %conv6.i.i, %shr.i.234
  %mul15.i.11.i = mul nuw i32 %shr3.i.i, %shr.i.234
  %add.i.12.i = add i32 %mul9.i.9.i, %mul12.i.10.i
  %cmp.i.13.i = icmp ult i32 %add.i.12.i, %mul12.i.10.i
  %conv16.i.14.i = zext i1 %cmp.i.13.i to i32
  %shl.i.15.i = shl nuw nsw i32 %conv16.i.14.i, 16
  %shr17.i.16.i = lshr i32 %add.i.12.i, 16
  %add18.i.17.i = or i32 %shl.i.15.i, %shr17.i.16.i
  %shl20.i.19.i = shl i32 %add.i.12.i, 16
  %add21.i.20.i = add i32 %shl20.i.19.i, %mul.i.8.i
  %cmp22.i.21.i = icmp ult i32 %add21.i.20.i, %shl20.i.19.i
  %add19.i.i = add i32 %add21.i.20.i, %mul15.i.i
  %add24.i.i = add i32 %add19.i.i, %add18.i.i
  %add.i.2.i = add i32 %add24.i.i, %conv23.i.i
  %cmp.i.3.i = icmp ult i32 %add.i.2.i, %add21.i.20.i
  %sub.i = sub i32 0, %add21.i.i
  %cmp.i.150 = icmp ne i32 %add21.i.i, 0
  %sub2.i = sub i32 %rem2.0.lcssa, %add.i.2.i
  %cmp3.i.151 = icmp ult i32 %rem2.0.lcssa, %add.i.2.i
  %conv23.i.22.i.neg = sext i1 %cmp22.i.21.i to i32
  %conv.i.i.neg = sext i1 %cmp.i.3.i to i32
  %conv7.i.152 = zext i1 %cmp.i.150 to i32
  %cmp8.i = icmp ult i32 %sub2.i, %conv7.i.152
  %conv9.neg.i = sext i1 %cmp8.i to i32
  %sub12.i = sub i32 %sub2.i, %conv7.i.152
  %conv13.neg.i = sext i1 %cmp3.i.151 to i32
  %add19.i.18.i.neg = sub i32 %rem1.0.lcssa, %mul15.i.11.i
  %add24.i.23.i.neg = sub i32 %add19.i.18.i.neg, %add18.i.17.i
  %add2.i.i.neg = add i32 %add24.i.23.i.neg, %conv23.i.22.i.neg
  %sub6.i = add i32 %add2.i.i.neg, %conv.i.i.neg
  %sub10.i = add i32 %sub6.i, %conv13.neg.i
  %sub14.i = add i32 %sub10.i, %conv9.neg.i
  %cmp74.498 = icmp slt i32 %sub14.i, 0
  br i1 %cmp74.498, label %while.body.76.preheader, label %while.end.78

while.body.76.preheader:                          ; preds = %if.then.72
  br label %while.body.76

while.body.76:                                    ; preds = %while.body.76.preheader, %while.body.76
  %rem3.0502 = phi i32 [ %add.i, %while.body.76 ], [ %sub.i, %while.body.76.preheader ]
  %rem2.1501 = phi i32 [ %add8.i, %while.body.76 ], [ %sub12.i, %while.body.76.preheader ]
  %rem1.1500 = phi i32 [ %add14.i, %while.body.76 ], [ %sub14.i, %while.body.76.preheader ]
  %zSig1.0499 = phi i32 [ %dec77, %while.body.76 ], [ %or14.i, %while.body.76.preheader ]
  %dec77 = add i32 %zSig1.0499, -1
  %add.i = add i32 %rem3.0502, %shl.i.290
  %cmp.i = icmp ult i32 %add.i, %rem3.0502
  %add2.i = add i32 %rem2.1501, %or.i.292
  %cmp3.i = icmp ult i32 %add2.i, %rem2.1501
  %conv7.i = zext i1 %cmp.i to i32
  %add8.i = add i32 %conv7.i, %add2.i
  %cmp10.i = icmp ult i32 %add8.i, %conv7.i
  %conv11.i = zext i1 %cmp10.i to i32
  %conv13.i = zext i1 %cmp3.i to i32
  %add12.i = add i32 %conv13.i, %rem1.1500
  %add14.i = add i32 %add12.i, %conv11.i
  %cmp74 = icmp slt i32 %add14.i, 0
  br i1 %cmp74, label %while.body.76, label %while.end.78.loopexit

while.end.78.loopexit:                            ; preds = %while.body.76
  %add14.i.lcssa = phi i32 [ %add14.i, %while.body.76 ]
  %add8.i.lcssa = phi i32 [ %add8.i, %while.body.76 ]
  %add.i.lcssa = phi i32 [ %add.i, %while.body.76 ]
  %dec77.lcssa = phi i32 [ %dec77, %while.body.76 ]
  br label %while.end.78

while.end.78:                                     ; preds = %while.end.78.loopexit, %if.then.72
  %rem3.0.lcssa = phi i32 [ %sub.i, %if.then.72 ], [ %add.i.lcssa, %while.end.78.loopexit ]
  %rem2.1.lcssa = phi i32 [ %sub12.i, %if.then.72 ], [ %add8.i.lcssa, %while.end.78.loopexit ]
  %rem1.1.lcssa = phi i32 [ %sub14.i, %if.then.72 ], [ %add14.i.lcssa, %while.end.78.loopexit ]
  %zSig1.0.lcssa = phi i32 [ %or14.i, %if.then.72 ], [ %dec77.lcssa, %while.end.78.loopexit ]
  %or79 = or i32 %rem2.1.lcssa, %rem1.1.lcssa
  %or80 = or i32 %or79, %rem3.0.lcssa
  %cmp81 = icmp ne i32 %or80, 0
  %conv82 = zext i1 %cmp81 to i32
  %or83 = or i32 %conv82, %zSig1.0.lcssa
  br label %if.end.84

if.end.84:                                        ; preds = %while.end, %while.end.78, %estimateDiv64To32.exit
  %zSig1.1 = phi i32 [ %or83, %while.end.78 ], [ %or14.i, %estimateDiv64To32.exit ], [ -1, %while.end ]
  %shl.i = shl i32 %zSig1.1, 21
  %shl7.i = shl i32 %zSig0.0.lcssa, 21
  %shr.i = lshr i32 %zSig1.1, 11
  %or.i = or i32 %shr.i, %shl7.i
  %shr8.i = lshr i32 %zSig0.0.lcssa, 11
  %call85 = tail call fastcc i64 @roundAndPackFloat64(i8 signext %xor149, i32 signext %zExp.0, i32 zeroext %shr8.i, i32 zeroext %or.i, i32 zeroext %shl.i)
  %retval.sroa.0.0.extract.shift140 = and i64 %call85, -4294967296
  br label %cleanup

cleanup:                                          ; preds = %if.end.84, %if.then.56, %if.end.46, %invalid, %if.end.31, %if.then.29, %if.end.21, %if.then.18, %if.then.11
  %retval.sroa.0.0 = phi i64 [ %retval.sroa.0.0.extract.shift, %if.then.11 ], [ %retval.sroa.0.0.extract.shift128, %if.then.18 ], [ -2251799813685248, %invalid ], [ %add.i.400, %if.end.21 ], [ %retval.sroa.0.0.extract.shift132, %if.then.29 ], [ %shl.i.392496, %if.end.31 ], [ %add.i.387, %if.end.46 ], [ %shl.i.313494, %if.then.56 ], [ %retval.sroa.0.0.extract.shift140, %if.end.84 ]
  %retval.sroa.10.0 = phi i64 [ %call12, %if.then.11 ], [ %call19, %if.then.18 ], [ 0, %invalid ], [ %add.i.400, %if.end.21 ], [ %call30, %if.then.29 ], [ %shl.i.392496, %if.end.31 ], [ %add.i.387, %if.end.46 ], [ %shl.i.313494, %if.then.56 ], [ %call85, %if.end.84 ]
  %retval.sroa.0.0.insert.mask = and i64 %retval.sroa.10.0, 4294967295
  %retval.sroa.0.0.insert.insert = or i64 %retval.sroa.0.0.insert.mask, %retval.sroa.0.0
  ret i64 %retval.sroa.0.0.insert.insert
}

; Function Attrs: nounwind
define i64 @float64_rem(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.1.0.extract.trunc.i = trunc i64 %a.coerce to i32
  %a.sroa.0.0.extract.shift.i = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc.i = trunc i64 %a.sroa.0.0.extract.shift.i to i32
  %and.i = and i32 %a.sroa.0.0.extract.trunc.i, 1048575
  %a.sroa.0.0.extract.shift.i.449 = lshr i64 %a.coerce, 52
  %shr.i.450 = trunc i64 %a.sroa.0.0.extract.shift.i.449 to i32
  %and.i.451 = and i32 %shr.i.450, 2047
  %a.sroa.0.0.extract.shift.i.452 = lshr i64 %a.coerce, 63
  %conv.i.453 = trunc i64 %a.sroa.0.0.extract.shift.i.452 to i32
  %a.sroa.1.0.extract.trunc.i.460 = trunc i64 %b.coerce to i32
  %a.sroa.0.0.extract.shift.i.457 = lshr i64 %b.coerce, 32
  %a.sroa.0.0.extract.trunc.i.458 = trunc i64 %a.sroa.0.0.extract.shift.i.457 to i32
  %and.i.459 = and i32 %a.sroa.0.0.extract.trunc.i.458, 1048575
  %a.sroa.0.0.extract.shift.i.454 = lshr i64 %b.coerce, 52
  %shr.i.455 = trunc i64 %a.sroa.0.0.extract.shift.i.454 to i32
  %and.i.456 = and i32 %shr.i.455, 2047
  %cmp = icmp eq i32 %and.i.451, 2047
  br i1 %cmp, label %if.then, label %if.end.13

if.then:                                          ; preds = %entry
  %or = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then.11

lor.lhs.false:                                    ; preds = %if.then
  %cmp8 = icmp ne i32 %and.i.456, 2047
  %or9 = or i32 %and.i.459, %a.sroa.1.0.extract.trunc.i.460
  %tobool10 = icmp eq i32 %or9, 0
  %or.cond538 = or i1 %cmp8, %tobool10
  br i1 %or.cond538, label %invalid, label %if.then.11

if.then.11:                                       ; preds = %lor.lhs.false, %if.then
  %call12 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  %retval.sroa.0.0.extract.shift = and i64 %call12, -4294967296
  br label %cleanup

if.end.13:                                        ; preds = %entry
  switch i32 %and.i.456, label %if.end.28 [
    i32 2047, label %if.then.15
    i32 0, label %if.then.23
  ]

if.then.15:                                       ; preds = %if.end.13
  %or16 = or i32 %and.i.459, %a.sroa.1.0.extract.trunc.i.460
  %tobool17 = icmp eq i32 %or16, 0
  br i1 %tobool17, label %if.end.20, label %if.then.18

if.then.18:                                       ; preds = %if.then.15
  %call19 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %b.coerce)
  %retval.sroa.0.0.extract.shift159 = and i64 %call19, -4294967296
  br label %cleanup

if.end.20:                                        ; preds = %if.then.15
  %retval.sroa.0.0.extract.shift163 = and i64 %a.coerce, -4294967296
  br label %cleanup

if.then.23:                                       ; preds = %if.end.13
  %or24 = or i32 %and.i.459, %a.sroa.1.0.extract.trunc.i.460
  %cmp25 = icmp eq i32 %or24, 0
  br i1 %cmp25, label %invalid, label %if.end.27

invalid:                                          ; preds = %lor.lhs.false, %if.then.23
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.27:                                        ; preds = %if.then.23
  %cmp.i.378 = icmp eq i32 %and.i.459, 0
  br i1 %cmp.i.378, label %if.then.i.384, label %if.else.14.i.418

if.then.i.384:                                    ; preds = %if.end.27
  %cmp.i.i.379 = icmp ult i32 %a.sroa.1.0.extract.trunc.i.460, 65536
  %shl.i.i.380 = shl i32 %a.sroa.1.0.extract.trunc.i.460, 16
  %shl.a.i.i.381 = select i1 %cmp.i.i.379, i32 %shl.i.i.380, i32 %a.sroa.1.0.extract.trunc.i.460
  %..i.i.382 = select i1 %cmp.i.i.379, i8 16, i8 0
  %cmp2.i.i.383 = icmp ult i32 %shl.a.i.i.381, 16777216
  br i1 %cmp2.i.i.383, label %if.then.4.i.i.389, label %countLeadingZeros32.exit.i.402

if.then.4.i.i.389:                                ; preds = %if.then.i.384
  %conv5.23.i.i.385 = zext i8 %..i.i.382 to i32
  %add6.i.i.386 = or i32 %conv5.23.i.i.385, 8
  %conv7.i.i.387 = trunc i32 %add6.i.i.386 to i8
  %shl8.i.i.388 = shl i32 %shl.a.i.i.381, 8
  br label %countLeadingZeros32.exit.i.402

countLeadingZeros32.exit.i.402:                   ; preds = %if.then.4.i.i.389, %if.then.i.384
  %a.addr.1.i.i.390 = phi i32 [ %shl8.i.i.388, %if.then.4.i.i.389 ], [ %shl.a.i.i.381, %if.then.i.384 ]
  %shiftCount.1.i.i.391 = phi i8 [ %conv7.i.i.387, %if.then.4.i.i.389 ], [ %..i.i.382, %if.then.i.384 ]
  %shr.i.i.392 = lshr i32 %a.addr.1.i.i.390, 24
  %idxprom.i.i.393 = zext i32 %shr.i.i.392 to i64
  %arrayidx.i.i.394 = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i.393
  %1 = load i8, i8* %arrayidx.i.i.394, align 1, !tbaa !5
  %conv10.22.i.i.395 = zext i8 %1 to i32
  %conv11.21.i.i.396 = zext i8 %shiftCount.1.i.i.391 to i32
  %add12.i.i.397 = add nuw nsw i32 %conv10.22.i.i.395, %conv11.21.i.i.396
  %conv.39.i.398 = shl i32 %add12.i.i.397, 24
  %sext40.i.399 = add i32 %conv.39.i.398, -184549376
  %conv2.i.400 = ashr exact i32 %sext40.i.399, 24
  %cmp3.i.401 = icmp slt i32 %sext40.i.399, 0
  br i1 %cmp3.i.401, label %if.then.5.i.407, label %if.else.i.409

if.then.5.i.407:                                  ; preds = %countLeadingZeros32.exit.i.402
  %sub7.i.403 = sub nsw i32 0, %conv2.i.400
  %shr.i.404 = lshr i32 %a.sroa.1.0.extract.trunc.i.460, %sub7.i.403
  %and.i.405 = and i32 %conv2.i.400, 31
  %shl.i.406 = shl i32 %a.sroa.1.0.extract.trunc.i.460, %and.i.405
  br label %if.end.i.412

if.else.i.409:                                    ; preds = %countLeadingZeros32.exit.i.402
  %shl10.i.408 = shl i32 %a.sroa.1.0.extract.trunc.i.460, %conv2.i.400
  br label %if.end.i.412

if.end.i.412:                                     ; preds = %if.else.i.409, %if.then.5.i.407
  %bSig0.0 = phi i32 [ %shr.i.404, %if.then.5.i.407 ], [ %shl10.i.408, %if.else.i.409 ]
  %storemerge.41.i.410 = phi i32 [ %shl.i.406, %if.then.5.i.407 ], [ 0, %if.else.i.409 ]
  %sub13.i.411 = sub nsw i32 -31, %conv2.i.400
  br label %if.end.28

if.else.14.i.418:                                 ; preds = %if.end.27
  %cmp.i.45.i.413 = icmp ult i32 %and.i.459, 65536
  %shl.i.46.i.414539 = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i.457, 16
  %shl.i.46.i.414 = trunc i64 %shl.i.46.i.414539 to i32
  %shl.a.i.47.i.415 = select i1 %cmp.i.45.i.413, i32 %shl.i.46.i.414, i32 %and.i.459
  %..i.48.i.416 = select i1 %cmp.i.45.i.413, i8 16, i8 0
  %cmp2.i.49.i.417 = icmp ult i32 %shl.a.i.47.i.415, 16777216
  br i1 %cmp2.i.49.i.417, label %if.then.4.i.54.i.423, label %countLeadingZeros32.exit64.i.437

if.then.4.i.54.i.423:                             ; preds = %if.else.14.i.418
  %conv5.23.i.50.i.419 = zext i8 %..i.48.i.416 to i32
  %add6.i.51.i.420 = or i32 %conv5.23.i.50.i.419, 8
  %conv7.i.52.i.421 = trunc i32 %add6.i.51.i.420 to i8
  %shl8.i.53.i.422 = shl i32 %shl.a.i.47.i.415, 8
  br label %countLeadingZeros32.exit64.i.437

countLeadingZeros32.exit64.i.437:                 ; preds = %if.then.4.i.54.i.423, %if.else.14.i.418
  %a.addr.1.i.55.i.424 = phi i32 [ %shl8.i.53.i.422, %if.then.4.i.54.i.423 ], [ %shl.a.i.47.i.415, %if.else.14.i.418 ]
  %shiftCount.1.i.56.i.425 = phi i8 [ %conv7.i.52.i.421, %if.then.4.i.54.i.423 ], [ %..i.48.i.416, %if.else.14.i.418 ]
  %shr.i.57.i.426 = lshr i32 %a.addr.1.i.55.i.424, 24
  %idxprom.i.58.i.427 = zext i32 %shr.i.57.i.426 to i64
  %arrayidx.i.59.i.428 = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.58.i.427
  %2 = load i8, i8* %arrayidx.i.59.i.428, align 1, !tbaa !5
  %conv10.22.i.60.i.429 = zext i8 %2 to i32
  %conv11.21.i.61.i.430 = zext i8 %shiftCount.1.i.56.i.425 to i32
  %add12.i.62.i.431 = add nuw nsw i32 %conv10.22.i.60.i.429, %conv11.21.i.61.i.430
  %conv16.38.i.432 = shl i32 %add12.i.62.i.431, 24
  %sext.i.433 = add i32 %conv16.38.i.432, -184549376
  %conv19.i.434 = ashr exact i32 %sext.i.433, 24
  %shl.i.42.i.435 = shl i32 %a.sroa.1.0.extract.trunc.i.460, %conv19.i.434
  %cmp.i.43.i.436 = icmp eq i32 %conv19.i.434, 0
  br i1 %cmp.i.43.i.436, label %shortShift64Left.exit.i.446, label %cond.false.i.i.443

cond.false.i.i.443:                               ; preds = %countLeadingZeros32.exit64.i.437
  %shl1.i.i.438 = shl i32 %and.i.459, %conv19.i.434
  %sub.i.i.439 = sub nsw i32 0, %conv19.i.434
  %and.i.i.440 = and i32 %sub.i.i.439, 31
  %shr.i.44.i.441 = lshr i32 %a.sroa.1.0.extract.trunc.i.460, %and.i.i.440
  %or.i.i.442 = or i32 %shr.i.44.i.441, %shl1.i.i.438
  br label %shortShift64Left.exit.i.446

shortShift64Left.exit.i.446:                      ; preds = %cond.false.i.i.443, %countLeadingZeros32.exit64.i.437
  %cond.i.i.444 = phi i32 [ %or.i.i.442, %cond.false.i.i.443 ], [ %and.i.459, %countLeadingZeros32.exit64.i.437 ]
  %sub21.i.445 = sub nsw i32 1, %conv19.i.434
  br label %if.end.28

if.end.28:                                        ; preds = %shortShift64Left.exit.i.446, %if.end.i.412, %if.end.13
  %bSig0.2 = phi i32 [ %and.i.459, %if.end.13 ], [ %bSig0.0, %if.end.i.412 ], [ %cond.i.i.444, %shortShift64Left.exit.i.446 ]
  %bSig1.1 = phi i32 [ %a.sroa.1.0.extract.trunc.i.460, %if.end.13 ], [ %storemerge.41.i.410, %if.end.i.412 ], [ %shl.i.42.i.435, %shortShift64Left.exit.i.446 ]
  %bExp.0 = phi i32 [ %and.i.456, %if.end.13 ], [ %sub13.i.411, %if.end.i.412 ], [ %sub21.i.445, %shortShift64Left.exit.i.446 ]
  %cmp29 = icmp eq i32 %and.i.451, 0
  br i1 %cmp29, label %if.then.30, label %if.end.35

if.then.30:                                       ; preds = %if.end.28
  %or31 = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %cmp32 = icmp eq i32 %or31, 0
  br i1 %cmp32, label %if.then.33, label %if.end.34

if.then.33:                                       ; preds = %if.then.30
  %retval.sroa.0.0.extract.shift165 = and i64 %a.coerce, -4294967296
  br label %cleanup

if.end.34:                                        ; preds = %if.then.30
  %cmp.i.367 = icmp eq i32 %and.i, 0
  br i1 %cmp.i.367, label %if.then.i, label %if.else.14.i

if.then.i:                                        ; preds = %if.end.34
  %cmp.i.i.368 = icmp ult i32 %a.sroa.1.0.extract.trunc.i, 65536
  %shl.i.i.369 = shl i32 %a.sroa.1.0.extract.trunc.i, 16
  %shl.a.i.i = select i1 %cmp.i.i.368, i32 %shl.i.i.369, i32 %a.sroa.1.0.extract.trunc.i
  %..i.i = select i1 %cmp.i.i.368, i8 16, i8 0
  %cmp2.i.i = icmp ult i32 %shl.a.i.i, 16777216
  br i1 %cmp2.i.i, label %if.then.4.i.i, label %countLeadingZeros32.exit.i

if.then.4.i.i:                                    ; preds = %if.then.i
  %conv5.23.i.i = zext i8 %..i.i to i32
  %add6.i.i = or i32 %conv5.23.i.i, 8
  %conv7.i.i = trunc i32 %add6.i.i to i8
  %shl8.i.i = shl i32 %shl.a.i.i, 8
  br label %countLeadingZeros32.exit.i

countLeadingZeros32.exit.i:                       ; preds = %if.then.4.i.i, %if.then.i
  %a.addr.1.i.i = phi i32 [ %shl8.i.i, %if.then.4.i.i ], [ %shl.a.i.i, %if.then.i ]
  %shiftCount.1.i.i = phi i8 [ %conv7.i.i, %if.then.4.i.i ], [ %..i.i, %if.then.i ]
  %shr.i.i.370 = lshr i32 %a.addr.1.i.i, 24
  %idxprom.i.i = zext i32 %shr.i.i.370 to i64
  %arrayidx.i.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i
  %3 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !5
  %conv10.22.i.i = zext i8 %3 to i32
  %conv11.21.i.i = zext i8 %shiftCount.1.i.i to i32
  %add12.i.i = add nuw nsw i32 %conv10.22.i.i, %conv11.21.i.i
  %conv.39.i = shl i32 %add12.i.i, 24
  %sext40.i = add i32 %conv.39.i, -184549376
  %conv2.i = ashr exact i32 %sext40.i, 24
  %cmp3.i.371 = icmp slt i32 %sext40.i, 0
  br i1 %cmp3.i.371, label %if.then.5.i, label %if.else.i.375

if.then.5.i:                                      ; preds = %countLeadingZeros32.exit.i
  %sub7.i = sub nsw i32 0, %conv2.i
  %shr.i.372 = lshr i32 %a.sroa.1.0.extract.trunc.i, %sub7.i
  %and.i.373 = and i32 %conv2.i, 31
  %shl.i.374 = shl i32 %a.sroa.1.0.extract.trunc.i, %and.i.373
  br label %if.end.i.376

if.else.i.375:                                    ; preds = %countLeadingZeros32.exit.i
  %shl10.i = shl i32 %a.sroa.1.0.extract.trunc.i, %conv2.i
  br label %if.end.i.376

if.end.i.376:                                     ; preds = %if.else.i.375, %if.then.5.i
  %aSig0.0 = phi i32 [ %shr.i.372, %if.then.5.i ], [ %shl10.i, %if.else.i.375 ]
  %storemerge.41.i = phi i32 [ %shl.i.374, %if.then.5.i ], [ 0, %if.else.i.375 ]
  %sub13.i = sub nsw i32 -31, %conv2.i
  br label %if.end.35

if.else.14.i:                                     ; preds = %if.end.34
  %cmp.i.45.i = icmp ult i32 %and.i, 65536
  %shl.i.46.i541 = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i, 16
  %shl.i.46.i = trunc i64 %shl.i.46.i541 to i32
  %shl.a.i.47.i = select i1 %cmp.i.45.i, i32 %shl.i.46.i, i32 %and.i
  %..i.48.i = select i1 %cmp.i.45.i, i8 16, i8 0
  %cmp2.i.49.i = icmp ult i32 %shl.a.i.47.i, 16777216
  br i1 %cmp2.i.49.i, label %if.then.4.i.54.i, label %countLeadingZeros32.exit64.i

if.then.4.i.54.i:                                 ; preds = %if.else.14.i
  %conv5.23.i.50.i = zext i8 %..i.48.i to i32
  %add6.i.51.i = or i32 %conv5.23.i.50.i, 8
  %conv7.i.52.i = trunc i32 %add6.i.51.i to i8
  %shl8.i.53.i = shl i32 %shl.a.i.47.i, 8
  br label %countLeadingZeros32.exit64.i

countLeadingZeros32.exit64.i:                     ; preds = %if.then.4.i.54.i, %if.else.14.i
  %a.addr.1.i.55.i = phi i32 [ %shl8.i.53.i, %if.then.4.i.54.i ], [ %shl.a.i.47.i, %if.else.14.i ]
  %shiftCount.1.i.56.i = phi i8 [ %conv7.i.52.i, %if.then.4.i.54.i ], [ %..i.48.i, %if.else.14.i ]
  %shr.i.57.i = lshr i32 %a.addr.1.i.55.i, 24
  %idxprom.i.58.i = zext i32 %shr.i.57.i to i64
  %arrayidx.i.59.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.58.i
  %4 = load i8, i8* %arrayidx.i.59.i, align 1, !tbaa !5
  %conv10.22.i.60.i = zext i8 %4 to i32
  %conv11.21.i.61.i = zext i8 %shiftCount.1.i.56.i to i32
  %add12.i.62.i = add nuw nsw i32 %conv10.22.i.60.i, %conv11.21.i.61.i
  %conv16.38.i = shl i32 %add12.i.62.i, 24
  %sext.i = add i32 %conv16.38.i, -184549376
  %conv19.i = ashr exact i32 %sext.i, 24
  %shl.i.42.i = shl i32 %a.sroa.1.0.extract.trunc.i, %conv19.i
  %cmp.i.43.i = icmp eq i32 %conv19.i, 0
  br i1 %cmp.i.43.i, label %shortShift64Left.exit.i, label %cond.false.i.i

cond.false.i.i:                                   ; preds = %countLeadingZeros32.exit64.i
  %shl1.i.i = shl i32 %and.i, %conv19.i
  %sub.i.i.377 = sub nsw i32 0, %conv19.i
  %and.i.i = and i32 %sub.i.i.377, 31
  %shr.i.44.i = lshr i32 %a.sroa.1.0.extract.trunc.i, %and.i.i
  %or.i.i = or i32 %shr.i.44.i, %shl1.i.i
  br label %shortShift64Left.exit.i

shortShift64Left.exit.i:                          ; preds = %cond.false.i.i, %countLeadingZeros32.exit64.i
  %cond.i.i = phi i32 [ %or.i.i, %cond.false.i.i ], [ %and.i, %countLeadingZeros32.exit64.i ]
  %sub21.i = sub nsw i32 1, %conv19.i
  br label %if.end.35

if.end.35:                                        ; preds = %shortShift64Left.exit.i, %if.end.i.376, %if.end.28
  %aSig1.1 = phi i32 [ %a.sroa.1.0.extract.trunc.i, %if.end.28 ], [ %storemerge.41.i, %if.end.i.376 ], [ %shl.i.42.i, %shortShift64Left.exit.i ]
  %aSig0.2 = phi i32 [ %and.i, %if.end.28 ], [ %aSig0.0, %if.end.i.376 ], [ %cond.i.i, %shortShift64Left.exit.i ]
  %aExp.0 = phi i32 [ %and.i.451, %if.end.28 ], [ %sub13.i, %if.end.i.376 ], [ %sub21.i, %shortShift64Left.exit.i ]
  %sub = sub nsw i32 %aExp.0, %bExp.0
  %cmp36 = icmp slt i32 %sub, -1
  br i1 %cmp36, label %if.then.37, label %if.end.38

if.then.37:                                       ; preds = %if.end.35
  %retval.sroa.0.0.extract.shift167 = and i64 %a.coerce, -4294967296
  br label %cleanup

if.end.38:                                        ; preds = %if.end.35
  %or39 = or i32 %aSig0.2, 1048576
  %sub.lobit = lshr i32 %sub, 31
  %sub41 = sub nsw i32 11, %sub.lobit
  %shl.i.358 = shl i32 %aSig1.1, %sub41
  %shl1.i.359 = shl i32 %or39, %sub41
  %sub.i.360 = sub nsw i32 0, %sub41
  %and.i.361 = and i32 %sub.i.360, 23
  %shr.i.362 = lshr i32 %aSig1.1, %and.i.361
  %or.i.363 = or i32 %shr.i.362, %shl1.i.359
  %shl.i.351 = shl i32 %bSig1.1, 11
  %or42 = shl i32 %bSig0.2, 11
  %shl1.i.352 = or i32 %or42, -2147483648
  %shr.i.353 = lshr i32 %bSig1.1, 21
  %or.i.354 = or i32 %shr.i.353, %shl1.i.352
  %cmp.i.348 = icmp ugt i32 %or.i.363, %or.i.354
  br i1 %cmp.i.348, label %if.then.46, label %lor.rhs.i

lor.rhs.i:                                        ; preds = %if.end.38
  %cmp1.i.349 = icmp eq i32 %or.i.363, %or.i.354
  br i1 %cmp1.i.349, label %le64.exit, label %if.end.47

le64.exit:                                        ; preds = %lor.rhs.i
  %cmp2.i.350 = icmp uge i32 %shl.i.358, %shl.i.351
  %conv44 = zext i1 %cmp2.i.350 to i32
  br i1 %cmp2.i.350, label %if.then.46, label %if.end.47

if.then.46:                                       ; preds = %le64.exit, %if.end.38
  %conv44537 = phi i32 [ %conv44, %le64.exit ], [ 1, %if.end.38 ]
  %sub.i.343 = sub i32 %shl.i.358, %shl.i.351
  %sub1.i.344 = sub i32 %or.i.363, %or.i.354
  %cmp.i.345 = icmp ult i32 %shl.i.358, %shl.i.351
  %conv.neg.i.346 = sext i1 %cmp.i.345 to i32
  %sub2.i.347 = add i32 %sub1.i.344, %conv.neg.i.346
  br label %if.end.47

if.end.47:                                        ; preds = %le64.exit, %lor.rhs.i, %if.then.46
  %conv44533 = phi i32 [ %conv44, %le64.exit ], [ %conv44537, %if.then.46 ], [ 0, %lor.rhs.i ]
  %aSig1.2 = phi i32 [ %shl.i.358, %le64.exit ], [ %sub.i.343, %if.then.46 ], [ %shl.i.358, %lor.rhs.i ]
  %aSig0.3 = phi i32 [ %or.i.363, %le64.exit ], [ %sub2.i.347, %if.then.46 ], [ %or.i.363, %lor.rhs.i ]
  %sub48 = add nsw i32 %sub, -32
  %cmp49.545 = icmp sgt i32 %sub, 32
  br i1 %cmp49.545, label %while.body.lr.ph, label %while.end

while.body.lr.ph:                                 ; preds = %if.end.47
  %shr.i.293 = lshr i32 %shl1.i.352, 16
  %shl.i.294 = shl nuw i32 %shr.i.293, 16
  %conv5.i.i.302 = and i32 %or.i.354, 65535
  %shl4.i.315 = shl i32 %or.i.354, 16
  %5 = lshr i32 %bSig1.1, 5
  %shr.i.i.250 = and i32 %5, 65535
  %conv5.i.i.252 = and i32 %shl.i.351, 63488
  br label %while.body

while.body:                                       ; preds = %while.body.lr.ph, %estimateDiv64To32.exit342
  %expDiff.0550 = phi i32 [ %sub48, %while.body.lr.ph ], [ %sub55, %estimateDiv64To32.exit342 ]
  %aSig0.4548 = phi i32 [ %aSig0.3, %while.body.lr.ph ], [ %sub2.i.234, %estimateDiv64To32.exit342 ]
  %aSig1.3546 = phi i32 [ %aSig1.2, %while.body.lr.ph ], [ %sub.i.230, %estimateDiv64To32.exit342 ]
  %cmp.i.292 = icmp ugt i32 %or.i.354, %aSig0.4548
  br i1 %cmp.i.292, label %if.end.i.296, label %estimateDiv64To32.exit342

if.end.i.296:                                     ; preds = %while.body
  %cmp1.i.295 = icmp ugt i32 %shl.i.294, %aSig0.4548
  br i1 %cmp1.i.295, label %cond.false.i.299, label %cond.end.i.314

cond.false.i.299:                                 ; preds = %if.end.i.296
  %div.i.297 = udiv i32 %aSig0.4548, %shr.i.293
  %shl2.i.298 = shl i32 %div.i.297, 16
  br label %cond.end.i.314

cond.end.i.314:                                   ; preds = %cond.false.i.299, %if.end.i.296
  %cond.i.300 = phi i32 [ %shl2.i.298, %cond.false.i.299 ], [ -65536, %if.end.i.296 ]
  %shr3.i.i.301 = lshr exact i32 %cond.i.300, 16
  %mul9.i.i.303 = mul nuw i32 %shr3.i.i.301, %conv5.i.i.302
  %mul15.i.i.304 = mul nuw i32 %shr3.i.i.301, %shr.i.293
  %shr17.i.i.305 = lshr i32 %mul9.i.i.303, 16
  %shl20.i.i.306 = shl i32 %mul9.i.i.303, 16
  %sub.i.i.307 = sub i32 %aSig1.3546, %shl20.i.i.306
  %cmp.i.39.i.308 = icmp ult i32 %aSig1.3546, %shl20.i.i.306
  %conv.neg.i.i.309 = sext i1 %cmp.i.39.i.308 to i32
  %add24.i.neg.i.310 = sub i32 %aSig0.4548, %mul15.i.i.304
  %sub1.i.i.311 = sub i32 %add24.i.neg.i.310, %shr17.i.i.305
  %sub2.i.i.312 = add i32 %sub1.i.i.311, %conv.neg.i.i.309
  %cmp3.45.i.313 = icmp slt i32 %sub2.i.i.312, 0
  br i1 %cmp3.45.i.313, label %while.body.i.327.preheader, label %while.end.i.335

while.body.i.327.preheader:                       ; preds = %cond.end.i.314
  br label %while.body.i.327

while.body.i.327:                                 ; preds = %while.body.i.327.preheader, %while.body.i.327
  %z.048.i.317 = phi i32 [ %sub.i.320, %while.body.i.327 ], [ %cond.i.300, %while.body.i.327.preheader ]
  %rem0.047.i.318 = phi i32 [ %add2.i.i.325, %while.body.i.327 ], [ %sub2.i.i.312, %while.body.i.327.preheader ]
  %rem1.046.i.319 = phi i32 [ %add.i.37.i.321, %while.body.i.327 ], [ %sub.i.i.307, %while.body.i.327.preheader ]
  %sub.i.320 = add i32 %z.048.i.317, -65536
  %add.i.37.i.321 = add i32 %rem1.046.i.319, %shl4.i.315
  %add1.i.i.322 = add i32 %rem0.047.i.318, %shr.i.293
  %cmp.i.38.i.323 = icmp ult i32 %add.i.37.i.321, %rem1.046.i.319
  %conv.i.i.324 = zext i1 %cmp.i.38.i.323 to i32
  %add2.i.i.325 = add i32 %add1.i.i.322, %conv.i.i.324
  %cmp3.i.326 = icmp slt i32 %add2.i.i.325, 0
  br i1 %cmp3.i.326, label %while.body.i.327, label %while.end.i.335.loopexit

while.end.i.335.loopexit:                         ; preds = %while.body.i.327
  %add2.i.i.325.lcssa = phi i32 [ %add2.i.i.325, %while.body.i.327 ]
  %add.i.37.i.321.lcssa = phi i32 [ %add.i.37.i.321, %while.body.i.327 ]
  %sub.i.320.lcssa = phi i32 [ %sub.i.320, %while.body.i.327 ]
  br label %while.end.i.335

while.end.i.335:                                  ; preds = %while.end.i.335.loopexit, %cond.end.i.314
  %z.0.lcssa.i.328 = phi i32 [ %cond.i.300, %cond.end.i.314 ], [ %sub.i.320.lcssa, %while.end.i.335.loopexit ]
  %rem0.0.lcssa.i.329 = phi i32 [ %sub2.i.i.312, %cond.end.i.314 ], [ %add2.i.i.325.lcssa, %while.end.i.335.loopexit ]
  %rem1.0.lcssa.i.330 = phi i32 [ %sub.i.i.307, %cond.end.i.314 ], [ %add.i.37.i.321.lcssa, %while.end.i.335.loopexit ]
  %shl5.i.331 = shl i32 %rem0.0.lcssa.i.329, 16
  %shr6.i.332 = lshr i32 %rem1.0.lcssa.i.330, 16
  %or.i.333 = or i32 %shr6.i.332, %shl5.i.331
  %cmp8.i.334 = icmp ugt i32 %shl.i.294, %or.i.333
  br i1 %cmp8.i.334, label %cond.false.10.i.337, label %cond.end.12.i.340

cond.false.10.i.337:                              ; preds = %while.end.i.335
  %div11.i.336 = udiv i32 %or.i.333, %shr.i.293
  br label %cond.end.12.i.340

cond.end.12.i.340:                                ; preds = %cond.false.10.i.337, %while.end.i.335
  %cond13.i.338 = phi i32 [ %div11.i.336, %cond.false.10.i.337 ], [ 65535, %while.end.i.335 ]
  %or14.i.339 = or i32 %cond13.i.338, %z.0.lcssa.i.328
  br label %estimateDiv64To32.exit342

estimateDiv64To32.exit342:                        ; preds = %while.body, %cond.end.12.i.340
  %retval.0.i.341 = phi i32 [ %or14.i.339, %cond.end.12.i.340 ], [ -1, %while.body ]
  %cmp52 = icmp ugt i32 %retval.0.i.341, 4
  %sub54 = add i32 %retval.0.i.341, -4
  %cond = select i1 %cmp52, i32 %sub54, i32 0
  %shr3.i.i.251 = lshr i32 %cond, 16
  %conv6.i.i.253 = and i32 %cond, 65535
  %mul.i.i.254 = mul nuw i32 %conv6.i.i.253, %conv5.i.i.252
  %mul9.i.i.255 = mul nuw i32 %shr3.i.i.251, %conv5.i.i.252
  %mul12.i.i.256 = mul nuw i32 %conv6.i.i.253, %shr.i.i.250
  %mul15.i.i.257 = mul nuw i32 %shr3.i.i.251, %shr.i.i.250
  %add.i.i.258 = add i32 %mul9.i.i.255, %mul12.i.i.256
  %cmp.i.i.259 = icmp ult i32 %add.i.i.258, %mul12.i.i.256
  %conv16.i.i.260 = zext i1 %cmp.i.i.259 to i32
  %shl.i.i.261 = shl nuw nsw i32 %conv16.i.i.260, 16
  %shr17.i.i.262 = lshr i32 %add.i.i.258, 16
  %add18.i.i.263 = or i32 %shl.i.i.261, %shr17.i.i.262
  %shl20.i.i.264 = shl i32 %add.i.i.258, 16
  %add21.i.i.265 = add i32 %shl20.i.i.264, %mul.i.i.254
  %cmp22.i.i.266 = icmp ult i32 %add21.i.i.265, %shl20.i.i.264
  %conv23.i.i.267 = zext i1 %cmp22.i.i.266 to i32
  %mul.i.8.i.270 = mul nuw i32 %conv6.i.i.253, %conv5.i.i.302
  %mul9.i.9.i.271 = mul nuw i32 %shr3.i.i.251, %conv5.i.i.302
  %mul12.i.10.i.272 = mul nuw i32 %conv6.i.i.253, %shr.i.293
  %mul15.i.11.i.273 = mul nuw i32 %shr3.i.i.251, %shr.i.293
  %add.i.12.i.274 = add i32 %mul9.i.9.i.271, %mul12.i.10.i.272
  %shr17.i.16.i.278 = lshr i32 %add.i.12.i.274, 16
  %add19.i.18.i.280 = add i32 %shr17.i.16.i.278, %mul15.i.11.i.273
  %shl20.i.19.i.281 = shl i32 %add.i.12.i.274, 16
  %add21.i.20.i.282 = add i32 %shl20.i.19.i.281, %mul.i.8.i.270
  %cmp22.i.21.i.283 = icmp ult i32 %add21.i.20.i.282, %shl20.i.19.i.281
  %conv23.i.22.i.284 = zext i1 %cmp22.i.21.i.283 to i32
  %add24.i.23.i.285 = add i32 %add19.i.18.i.280, %conv23.i.22.i.284
  %add19.i.i.286 = add i32 %add21.i.20.i.282, %mul15.i.i.257
  %add24.i.i.287 = add i32 %add19.i.i.286, %add18.i.i.263
  %add.i.2.i.288 = add i32 %add24.i.i.287, %conv23.i.i.267
  %cmp.i.3.i.289 = icmp ult i32 %add.i.2.i.288, %add21.i.20.i.282
  %conv.i.i.290 = zext i1 %cmp.i.3.i.289 to i32
  %add2.i.i.291 = add i32 %add24.i.23.i.285, %conv.i.i.290
  %shl1.i.243 = shl i32 %add.i.2.i.288, 29
  %shl2.i.244 = shl i32 %add2.i.i.291, 29
  %shr.i.245 = lshr exact i32 %add21.i.i.265, 3
  %or.i.246 = or i32 %shl1.i.243, %shr.i.245
  %shr5.i = lshr i32 %add.i.2.i.288, 3
  %or6.i = or i32 %shl2.i.244, %shr5.i
  %shl1.i.236 = shl i32 %aSig0.4548, 29
  %shr.i.237 = lshr i32 %aSig1.3546, 3
  %or.i.238 = or i32 %shl1.i.236, %shr.i.237
  %sub.i.230 = sub i32 0, %or.i.246
  %cmp.i.232 = icmp ne i32 %or.i.246, 0
  %conv.neg.i.233 = sext i1 %cmp.i.232 to i32
  %sub1.i.231 = add i32 %conv.neg.i.233, %or.i.238
  %sub2.i.234 = sub i32 %sub1.i.231, %or6.i
  %sub55 = add nsw i32 %expDiff.0550, -29
  %cmp49 = icmp sgt i32 %expDiff.0550, 29
  br i1 %cmp49, label %while.body, label %while.end.loopexit

while.end.loopexit:                               ; preds = %estimateDiv64To32.exit342
  %sub55.lcssa = phi i32 [ %sub55, %estimateDiv64To32.exit342 ]
  %sub2.i.234.lcssa = phi i32 [ %sub2.i.234, %estimateDiv64To32.exit342 ]
  %sub.i.230.lcssa = phi i32 [ %sub.i.230, %estimateDiv64To32.exit342 ]
  %cond.lcssa = phi i32 [ %cond, %estimateDiv64To32.exit342 ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %if.end.47
  %expDiff.0.lcssa = phi i32 [ %sub48, %if.end.47 ], [ %sub55.lcssa, %while.end.loopexit ]
  %q.0.lcssa = phi i32 [ %conv44533, %if.end.47 ], [ %cond.lcssa, %while.end.loopexit ]
  %aSig0.4.lcssa = phi i32 [ %aSig0.3, %if.end.47 ], [ %sub2.i.234.lcssa, %while.end.loopexit ]
  %aSig1.3.lcssa = phi i32 [ %aSig1.2, %if.end.47 ], [ %sub.i.230.lcssa, %while.end.loopexit ]
  %cmp56 = icmp sgt i32 %expDiff.0.lcssa, -32
  br i1 %cmp56, label %if.then.58, label %if.else.73

if.then.58:                                       ; preds = %while.end
  %cmp.i.213 = icmp ugt i32 %or.i.354, %aSig0.4.lcssa
  br i1 %cmp.i.213, label %if.end.i, label %estimateDiv64To32.exit

if.end.i:                                         ; preds = %if.then.58
  %shr.i.214 = lshr i32 %shl1.i.352, 16
  %shl.i.215 = shl nuw i32 %shr.i.214, 16
  %cmp1.i = icmp ugt i32 %shl.i.215, %aSig0.4.lcssa
  br i1 %cmp1.i, label %cond.false.i.216, label %cond.end.i

cond.false.i.216:                                 ; preds = %if.end.i
  %div.i = udiv i32 %aSig0.4.lcssa, %shr.i.214
  %shl2.i = shl i32 %div.i, 16
  br label %cond.end.i

cond.end.i:                                       ; preds = %cond.false.i.216, %if.end.i
  %cond.i.217 = phi i32 [ %shl2.i, %cond.false.i.216 ], [ -65536, %if.end.i ]
  %shr3.i.i.218 = lshr exact i32 %cond.i.217, 16
  %conv5.i.i.219 = and i32 %or.i.354, 65535
  %mul9.i.i.220 = mul nuw i32 %shr3.i.i.218, %conv5.i.i.219
  %mul15.i.i.221 = mul nuw i32 %shr3.i.i.218, %shr.i.214
  %shr17.i.i.222 = lshr i32 %mul9.i.i.220, 16
  %shl20.i.i.223 = shl i32 %mul9.i.i.220, 16
  %sub.i.i = sub i32 %aSig1.3.lcssa, %shl20.i.i.223
  %cmp.i.39.i = icmp ult i32 %aSig1.3.lcssa, %shl20.i.i.223
  %conv.neg.i.i = sext i1 %cmp.i.39.i to i32
  %add24.i.neg.i = sub i32 %aSig0.4.lcssa, %mul15.i.i.221
  %sub1.i.i = sub i32 %add24.i.neg.i, %shr17.i.i.222
  %sub2.i.i = add i32 %sub1.i.i, %conv.neg.i.i
  %cmp3.45.i = icmp slt i32 %sub2.i.i, 0
  br i1 %cmp3.45.i, label %while.body.lr.ph.i, label %while.end.i

while.body.lr.ph.i:                               ; preds = %cond.end.i
  %shl4.i = shl i32 %or.i.354, 16
  br label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %while.body.lr.ph.i
  %z.048.i = phi i32 [ %cond.i.217, %while.body.lr.ph.i ], [ %sub.i.224, %while.body.i ]
  %rem0.047.i = phi i32 [ %sub2.i.i, %while.body.lr.ph.i ], [ %add2.i.i.226, %while.body.i ]
  %rem1.046.i = phi i32 [ %sub.i.i, %while.body.lr.ph.i ], [ %add.i.37.i, %while.body.i ]
  %sub.i.224 = add i32 %z.048.i, -65536
  %add.i.37.i = add i32 %rem1.046.i, %shl4.i
  %add1.i.i = add i32 %rem0.047.i, %shr.i.214
  %cmp.i.38.i = icmp ult i32 %add.i.37.i, %rem1.046.i
  %conv.i.i.225 = zext i1 %cmp.i.38.i to i32
  %add2.i.i.226 = add i32 %add1.i.i, %conv.i.i.225
  %cmp3.i = icmp slt i32 %add2.i.i.226, 0
  br i1 %cmp3.i, label %while.body.i, label %while.end.i.loopexit

while.end.i.loopexit:                             ; preds = %while.body.i
  %add2.i.i.226.lcssa = phi i32 [ %add2.i.i.226, %while.body.i ]
  %add.i.37.i.lcssa = phi i32 [ %add.i.37.i, %while.body.i ]
  %sub.i.224.lcssa = phi i32 [ %sub.i.224, %while.body.i ]
  br label %while.end.i

while.end.i:                                      ; preds = %while.end.i.loopexit, %cond.end.i
  %z.0.lcssa.i = phi i32 [ %cond.i.217, %cond.end.i ], [ %sub.i.224.lcssa, %while.end.i.loopexit ]
  %rem0.0.lcssa.i = phi i32 [ %sub2.i.i, %cond.end.i ], [ %add2.i.i.226.lcssa, %while.end.i.loopexit ]
  %rem1.0.lcssa.i = phi i32 [ %sub.i.i, %cond.end.i ], [ %add.i.37.i.lcssa, %while.end.i.loopexit ]
  %shl5.i = shl i32 %rem0.0.lcssa.i, 16
  %shr6.i.227 = lshr i32 %rem1.0.lcssa.i, 16
  %or.i.228 = or i32 %shr6.i.227, %shl5.i
  %cmp8.i.229 = icmp ugt i32 %shl.i.215, %or.i.228
  br i1 %cmp8.i.229, label %cond.false.10.i, label %cond.end.12.i

cond.false.10.i:                                  ; preds = %while.end.i
  %div11.i = udiv i32 %or.i.228, %shr.i.214
  br label %cond.end.12.i

cond.end.12.i:                                    ; preds = %cond.false.10.i, %while.end.i
  %cond13.i = phi i32 [ %div11.i, %cond.false.10.i ], [ 65535, %while.end.i ]
  %or14.i = or i32 %cond13.i, %z.0.lcssa.i
  br label %estimateDiv64To32.exit

estimateDiv64To32.exit:                           ; preds = %if.then.58, %cond.end.12.i
  %retval.0.i = phi i32 [ %or14.i, %cond.end.12.i ], [ -1, %if.then.58 ]
  %cmp60 = icmp ugt i32 %retval.0.i, 4
  %sub63 = add i32 %retval.0.i, -4
  %cond66 = select i1 %cmp60, i32 %sub63, i32 0
  %sub67 = sub nsw i32 0, %expDiff.0.lcssa
  %shr = lshr i32 %cond66, %sub67
  %shl.i.206 = shl i32 %shr.i.353, 24
  %6 = shl i32 %bSig1.1, 3
  %shr.i.207 = and i32 %6, 16777208
  %or.i.208 = or i32 %shl.i.206, %shr.i.207
  %shr6.i.209 = lshr i32 %or.i.354, 8
  %cmp68 = icmp slt i32 %expDiff.0.lcssa, -24
  br i1 %cmp68, label %if.then.70, label %if.else

if.then.70:                                       ; preds = %estimateDiv64To32.exit
  %sub71 = sub i32 -24, %expDiff.0.lcssa
  %sub.i.197 = sub nsw i32 0, %sub71
  %and.i.198 = and i32 %sub.i.197, 31
  %cmp.i.199 = icmp eq i32 %sub71, 0
  br i1 %cmp.i.199, label %if.end.72, label %if.else.i

if.else.i:                                        ; preds = %if.then.70
  %cmp2.i = icmp slt i32 %sub71, 32
  br i1 %cmp2.i, label %if.then.4.i, label %if.else.7.i

if.then.4.i:                                      ; preds = %if.else.i
  %shl.i.200 = shl i32 %aSig0.4.lcssa, %and.i.198
  %shr.i.201 = lshr i32 %aSig1.3.lcssa, %sub71
  %or.i.202 = or i32 %shl.i.200, %shr.i.201
  %shr6.i.203 = lshr i32 %aSig0.4.lcssa, %sub71
  br label %if.end.72

if.else.7.i:                                      ; preds = %if.else.i
  %cmp8.i = icmp slt i32 %sub71, 64
  %and10.i = and i32 %sub71, 31
  %shr11.i = lshr i32 %aSig0.4.lcssa, %and10.i
  %cond.i.204 = select i1 %cmp8.i, i32 %shr11.i, i32 0
  br label %if.end.72

if.else:                                          ; preds = %estimateDiv64To32.exit
  %add = add nsw i32 %expDiff.0.lcssa, 24
  %shl.i.191 = shl i32 %aSig1.3.lcssa, %add
  %cmp.i.192 = icmp eq i32 %add, 0
  br i1 %cmp.i.192, label %if.end.72, label %cond.false.i

cond.false.i:                                     ; preds = %if.else
  %shl1.i = shl i32 %aSig0.4.lcssa, %add
  %sub.i.193 = sub i32 -24, %expDiff.0.lcssa
  %and.i.194 = and i32 %sub.i.193, 31
  %shr.i.195 = lshr i32 %aSig1.3.lcssa, %and.i.194
  %or.i.196 = or i32 %shr.i.195, %shl1.i
  br label %if.end.72

if.end.72:                                        ; preds = %cond.false.i, %if.else, %if.else.7.i, %if.then.4.i, %if.then.70
  %aSig1.4 = phi i32 [ %or.i.202, %if.then.4.i ], [ %aSig1.3.lcssa, %if.then.70 ], [ %cond.i.204, %if.else.7.i ], [ %shl.i.191, %if.else ], [ %shl.i.191, %cond.false.i ]
  %aSig0.5 = phi i32 [ %shr6.i.203, %if.then.4.i ], [ %aSig0.4.lcssa, %if.then.70 ], [ 0, %if.else.7.i ], [ %aSig0.4.lcssa, %if.else ], [ %or.i.196, %cond.false.i ]
  %shr.i.i = lshr i32 %or.i.208, 16
  %shr3.i.i = lshr i32 %shr, 16
  %conv5.i.i = and i32 %6, 65528
  %conv6.i.i = and i32 %shr, 65535
  %mul.i.i = mul nuw i32 %conv6.i.i, %conv5.i.i
  %mul9.i.i = mul nuw i32 %shr3.i.i, %conv5.i.i
  %mul12.i.i = mul nuw i32 %conv6.i.i, %shr.i.i
  %mul15.i.i = mul nuw i32 %shr3.i.i, %shr.i.i
  %add.i.i = add i32 %mul9.i.i, %mul12.i.i
  %cmp.i.i = icmp ult i32 %add.i.i, %mul12.i.i
  %conv16.i.i = zext i1 %cmp.i.i to i32
  %shl.i.i = shl nuw nsw i32 %conv16.i.i, 16
  %shr17.i.i = lshr i32 %add.i.i, 16
  %add18.i.i = or i32 %shl.i.i, %shr17.i.i
  %shl20.i.i = shl i32 %add.i.i, 16
  %add21.i.i = add i32 %shl20.i.i, %mul.i.i
  %cmp22.i.i = icmp ult i32 %add21.i.i, %shl20.i.i
  %shr.i.4.i = lshr i32 %shl1.i.352, 24
  %conv5.i.6.i = and i32 %shr6.i.209, 65535
  %mul.i.8.i = mul nuw i32 %conv6.i.i, %conv5.i.6.i
  %mul9.i.9.i = mul nuw i32 %shr3.i.i, %conv5.i.6.i
  %mul12.i.10.i = mul nuw nsw i32 %conv6.i.i, %shr.i.4.i
  %add.i.12.i = add i32 %mul9.i.9.i, %mul12.i.10.i
  %shl20.i.19.i = shl i32 %add.i.12.i, 16
  %sub.i.186 = sub i32 %aSig1.4, %add21.i.i
  %conv23.i.i.neg = sext i1 %cmp22.i.i to i32
  %cmp.i.188 = icmp ult i32 %aSig1.4, %add21.i.i
  %conv.neg.i.189 = sext i1 %cmp.i.188 to i32
  %sum = add i32 %mul15.i.i, %mul.i.8.i
  %sum554 = add i32 %sum, %shl20.i.19.i
  %sum555 = add i32 %sum554, %add18.i.i
  %add.i.2.i.neg = sub i32 %conv23.i.i.neg, %sum555
  %sub1.i.187 = add i32 %add.i.2.i.neg, %aSig0.5
  %sub2.i.190 = add i32 %sub1.i.187, %conv.neg.i.189
  br label %do.body.preheader

if.else.73:                                       ; preds = %while.end
  %shl.i.182 = shl i32 %aSig0.4.lcssa, 24
  %shr.i.183 = lshr i32 %aSig1.3.lcssa, 8
  %or.i.184 = or i32 %shl.i.182, %shr.i.183
  %shr6.i.185 = lshr i32 %aSig0.4.lcssa, 8
  %shl.i = shl i32 %shr.i.353, 24
  %7 = shl i32 %bSig1.1, 3
  %shr.i = and i32 %7, 16777208
  %or.i = or i32 %shl.i, %shr.i
  %shr6.i = lshr i32 %or.i.354, 8
  br label %do.body.preheader

do.body.preheader:                                ; preds = %if.else.73, %if.end.72
  %aSig1.5.ph = phi i32 [ %or.i.184, %if.else.73 ], [ %sub.i.186, %if.end.72 ]
  %bSig0.3.ph = phi i32 [ %shr6.i, %if.else.73 ], [ %shr6.i.209, %if.end.72 ]
  %bSig1.2.ph = phi i32 [ %or.i, %if.else.73 ], [ %or.i.208, %if.end.72 ]
  %aSig0.6.ph = phi i32 [ %shr6.i.185, %if.else.73 ], [ %sub2.i.190, %if.end.72 ]
  %q.1.ph = phi i32 [ %q.0.lcssa, %if.else.73 ], [ %shr, %if.end.72 ]
  br label %do.body

do.body:                                          ; preds = %do.body.preheader, %do.body
  %aSig1.5 = phi i32 [ %sub.i.177, %do.body ], [ %aSig1.5.ph, %do.body.preheader ]
  %aSig0.6 = phi i32 [ %sub2.i.181, %do.body ], [ %aSig0.6.ph, %do.body.preheader ]
  %q.1 = phi i32 [ %inc, %do.body ], [ %q.1.ph, %do.body.preheader ]
  %inc = add i32 %q.1, 1
  %sub.i.177 = sub i32 %aSig1.5, %bSig1.2.ph
  %sub1.i.178 = sub i32 %aSig0.6, %bSig0.3.ph
  %cmp.i.179 = icmp ult i32 %aSig1.5, %bSig1.2.ph
  %conv.neg.i.180 = sext i1 %cmp.i.179 to i32
  %sub2.i.181 = add i32 %sub1.i.178, %conv.neg.i.180
  %cmp75 = icmp sgt i32 %sub2.i.181, -1
  br i1 %cmp75, label %do.body, label %do.end

do.end:                                           ; preds = %do.body
  %sub2.i.181.lcssa = phi i32 [ %sub2.i.181, %do.body ]
  %sub.i.177.lcssa = phi i32 [ %sub.i.177, %do.body ]
  %inc.lcssa = phi i32 [ %inc, %do.body ]
  %aSig0.6.lcssa = phi i32 [ %aSig0.6, %do.body ]
  %aSig1.5.lcssa = phi i32 [ %aSig1.5, %do.body ]
  %add.i = add i32 %sub.i.177.lcssa, %aSig1.5.lcssa
  %add1.i = add i32 %sub2.i.181.lcssa, %aSig0.6.lcssa
  %cmp.i.176 = icmp ult i32 %add.i, %sub.i.177.lcssa
  %conv.i = zext i1 %cmp.i.176 to i32
  %add2.i = add i32 %add1.i, %conv.i
  %cmp77 = icmp slt i32 %add2.i, 0
  br i1 %cmp77, label %if.then.85, label %lor.lhs.false.79

lor.lhs.false.79:                                 ; preds = %do.end
  %or80 = or i32 %add2.i, %add.i
  %cmp81 = icmp ne i32 %or80, 0
  %and = and i32 %inc.lcssa, 1
  %tobool84 = icmp eq i32 %and, 0
  %or.cond = or i1 %tobool84, %cmp81
  br i1 %or.cond, label %if.end.86, label %if.then.85

if.then.85:                                       ; preds = %lor.lhs.false.79, %do.end
  br label %if.end.86

if.end.86:                                        ; preds = %lor.lhs.false.79, %if.then.85
  %aSig1.6 = phi i32 [ %aSig1.5.lcssa, %if.then.85 ], [ %sub.i.177.lcssa, %lor.lhs.false.79 ]
  %aSig0.7 = phi i32 [ %aSig0.6.lcssa, %if.then.85 ], [ %sub2.i.181.lcssa, %lor.lhs.false.79 ]
  %.lobit = lshr i32 %aSig0.7, 31
  %tobool90 = icmp eq i32 %.lobit, 0
  br i1 %tobool90, label %if.end.92, label %if.then.91

if.then.91:                                       ; preds = %if.end.86
  %sub.i = sub i32 0, %aSig1.6
  %cmp.i = icmp ne i32 %aSig1.6, 0
  %conv.neg.i = sext i1 %cmp.i to i32
  %sub2.i = sub i32 %conv.neg.i, %aSig0.7
  br label %if.end.92

if.end.92:                                        ; preds = %if.end.86, %if.then.91
  %aSig1.7 = phi i32 [ %aSig1.6, %if.end.86 ], [ %sub.i, %if.then.91 ]
  %aSig0.8 = phi i32 [ %aSig0.7, %if.end.86 ], [ %sub2.i, %if.then.91 ]
  %xor = xor i32 %.lobit, %conv.i.453
  %conv95 = trunc i32 %xor to i8
  %sub96 = add nsw i32 %bExp.0, -4
  %call97 = tail call fastcc i64 @normalizeRoundAndPackFloat64(i8 signext %conv95, i32 signext %sub96, i32 zeroext %aSig0.8, i32 zeroext %aSig1.7)
  %retval.sroa.0.0.extract.shift161 = and i64 %call97, -4294967296
  br label %cleanup

cleanup:                                          ; preds = %if.end.92, %if.then.37, %if.then.33, %invalid, %if.end.20, %if.then.18, %if.then.11
  %retval.sroa.0.0 = phi i64 [ %retval.sroa.0.0.extract.shift, %if.then.11 ], [ -2251799813685248, %invalid ], [ %retval.sroa.0.0.extract.shift159, %if.then.18 ], [ %retval.sroa.0.0.extract.shift163, %if.end.20 ], [ %retval.sroa.0.0.extract.shift165, %if.then.33 ], [ %retval.sroa.0.0.extract.shift167, %if.then.37 ], [ %retval.sroa.0.0.extract.shift161, %if.end.92 ]
  %retval.sroa.8.0 = phi i64 [ %call12, %if.then.11 ], [ 0, %invalid ], [ %call19, %if.then.18 ], [ %a.coerce, %if.end.20 ], [ %a.coerce, %if.then.33 ], [ %a.coerce, %if.then.37 ], [ %call97, %if.end.92 ]
  %retval.sroa.0.0.insert.mask = and i64 %retval.sroa.8.0, 4294967295
  %retval.sroa.0.0.insert.insert = or i64 %retval.sroa.0.0.insert.mask, %retval.sroa.0.0
  ret i64 %retval.sroa.0.0.insert.insert
}

; Function Attrs: nounwind
define internal fastcc i64 @normalizeRoundAndPackFloat64(i8 signext %zSign, i32 signext %zExp, i32 zeroext %zSig0, i32 zeroext %zSig1) #2 {
entry:
  %cmp = icmp eq i32 %zSig0, 0
  %sub = add nsw i32 %zExp, -32
  %zSig1.zSig0 = select i1 %cmp, i32 %zSig1, i32 %zSig0
  %.zSig1 = select i1 %cmp, i32 0, i32 %zSig1
  %sub.zExp = select i1 %cmp, i32 %sub, i32 %zExp
  %cmp.i = icmp ult i32 %zSig1.zSig0, 65536
  %shl.i = shl i32 %zSig1.zSig0, 16
  %shl.a.i = select i1 %cmp.i, i32 %shl.i, i32 %zSig1.zSig0
  %..i = select i1 %cmp.i, i8 16, i8 0
  %cmp2.i = icmp ult i32 %shl.a.i, 16777216
  br i1 %cmp2.i, label %if.then.4.i, label %countLeadingZeros32.exit

if.then.4.i:                                      ; preds = %entry
  %conv5.23.i = zext i8 %..i to i32
  %add6.i = or i32 %conv5.23.i, 8
  %conv7.i = trunc i32 %add6.i to i8
  %shl8.i = shl i32 %shl.a.i, 8
  br label %countLeadingZeros32.exit

countLeadingZeros32.exit:                         ; preds = %entry, %if.then.4.i
  %a.addr.1.i = phi i32 [ %shl8.i, %if.then.4.i ], [ %shl.a.i, %entry ]
  %shiftCount.1.i = phi i8 [ %conv7.i, %if.then.4.i ], [ %..i, %entry ]
  %shr.i = lshr i32 %a.addr.1.i, 24
  %idxprom.i = zext i32 %shr.i to i64
  %arrayidx.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i
  %0 = load i8, i8* %arrayidx.i, align 1, !tbaa !5
  %conv10.22.i = zext i8 %0 to i32
  %conv11.21.i = zext i8 %shiftCount.1.i to i32
  %add12.i = add nuw nsw i32 %conv10.22.i, %conv11.21.i
  %conv.19 = shl i32 %add12.i, 24
  %sext = add i32 %conv.19, -184549376
  %conv3 = ashr exact i32 %sext, 24
  %cmp4 = icmp sgt i32 %sext, -16777216
  br i1 %cmp4, label %if.then.6, label %if.else

if.then.6:                                        ; preds = %countLeadingZeros32.exit
  %shl.i.20 = shl i32 %.zSig1, %conv3
  %cmp.i.21 = icmp eq i32 %conv3, 0
  br i1 %cmp.i.21, label %if.end.10, label %cond.false.i

cond.false.i:                                     ; preds = %if.then.6
  %shl1.i = shl i32 %zSig1.zSig0, %conv3
  %sub.i = sub nsw i32 0, %conv3
  %and.i = and i32 %sub.i, 31
  %shr.i.22 = lshr i32 %.zSig1, %and.i
  %or.i = or i32 %shr.i.22, %shl1.i
  br label %if.end.10

if.else:                                          ; preds = %countLeadingZeros32.exit
  %sub9 = sub nsw i32 0, %conv3
  %and.i.23 = and i32 %conv3, 31
  %cmp.i.24 = icmp eq i32 %conv3, 0
  br i1 %cmp.i.24, label %if.end.10, label %if.else.i

if.else.i:                                        ; preds = %if.else
  %cmp2.i.25 = icmp sgt i32 %sext, -536870912
  br i1 %cmp2.i.25, label %if.then.4.i.29, label %if.else.9.i

if.then.4.i.29:                                   ; preds = %if.else.i
  %shl.i.26 = shl i32 %.zSig1, %and.i.23
  %shl7.i = shl i32 %zSig1.zSig0, %and.i.23
  %shr.i.27 = lshr i32 %.zSig1, %sub9
  %or.i.28 = or i32 %shl7.i, %shr.i.27
  %shr8.i = lshr i32 %zSig1.zSig0, %sub9
  br label %if.end.28.i

if.else.9.i:                                      ; preds = %if.else.i
  %cmp10.i = icmp eq i32 %sub9, 32
  br i1 %cmp10.i, label %if.end.28.i, label %if.else.13.i

if.else.13.i:                                     ; preds = %if.else.9.i
  %cmp15.i = icmp sgt i32 %sext, -1073741824
  br i1 %cmp15.i, label %if.then.17.i, label %if.else.22.i

if.then.17.i:                                     ; preds = %if.else.13.i
  %shl19.i = shl i32 %zSig1.zSig0, %and.i.23
  %and20.i = and i32 %sub9, 31
  %shr21.i = lshr i32 %zSig1.zSig0, %and20.i
  br label %if.end.28.i

if.else.22.i:                                     ; preds = %if.else.13.i
  %cmp23.i = icmp eq i32 %sub9, 64
  %cmp25.i = icmp ne i32 %zSig1.zSig0, 0
  %conv26.i = zext i1 %cmp25.i to i32
  %cond.i.30 = select i1 %cmp23.i, i32 %zSig1.zSig0, i32 %conv26.i
  br label %if.end.28.i

if.end.28.i:                                      ; preds = %if.else.22.i, %if.then.17.i, %if.else.9.i, %if.then.4.i.29
  %z0.0.i = phi i32 [ %shr8.i, %if.then.4.i.29 ], [ 0, %if.else.9.i ], [ 0, %if.then.17.i ], [ 0, %if.else.22.i ]
  %z1.1.i = phi i32 [ %or.i.28, %if.then.4.i.29 ], [ %zSig1.zSig0, %if.else.9.i ], [ %shr21.i, %if.then.17.i ], [ 0, %if.else.22.i ]
  %z2.1.i = phi i32 [ %shl.i.26, %if.then.4.i.29 ], [ %.zSig1, %if.else.9.i ], [ %shl19.i, %if.then.17.i ], [ %cond.i.30, %if.else.22.i ]
  %a2.addr.1.i = phi i32 [ 0, %if.then.4.i.29 ], [ 0, %if.else.9.i ], [ %.zSig1, %if.then.17.i ], [ %.zSig1, %if.else.22.i ]
  %cmp29.i = icmp ne i32 %a2.addr.1.i, 0
  %conv30.i = zext i1 %cmp29.i to i32
  %or31.i = or i32 %conv30.i, %z2.1.i
  br label %if.end.10

if.end.10:                                        ; preds = %if.end.28.i, %if.else, %cond.false.i, %if.then.6
  %zSig0.addr.1 = phi i32 [ %or.i, %cond.false.i ], [ %zSig1.zSig0, %if.then.6 ], [ %z0.0.i, %if.end.28.i ], [ %zSig1.zSig0, %if.else ]
  %zSig1.addr.1 = phi i32 [ %shl.i.20, %cond.false.i ], [ %shl.i.20, %if.then.6 ], [ %z1.1.i, %if.end.28.i ], [ %.zSig1, %if.else ]
  %zSig2.0 = phi i32 [ 0, %cond.false.i ], [ 0, %if.then.6 ], [ %or31.i, %if.end.28.i ], [ 0, %if.else ]
  %sub12 = sub nsw i32 %sub.zExp, %conv3
  %call13 = tail call fastcc i64 @roundAndPackFloat64(i8 signext %zSign, i32 signext %sub12, i32 zeroext %zSig0.addr.1, i32 zeroext %zSig1.addr.1, i32 zeroext %zSig2.0)
  ret i64 %call13
}

; Function Attrs: nounwind
define i64 @float64_sqrt(i64 %a.coerce) #2 {
entry:
  %a.sroa.1.0.extract.trunc.i = trunc i64 %a.coerce to i32
  %a.sroa.0.0.extract.shift.i = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc.i = trunc i64 %a.sroa.0.0.extract.shift.i to i32
  %and.i = and i32 %a.sroa.0.0.extract.trunc.i, 1048575
  %a.sroa.0.0.extract.shift.i.263 = lshr i64 %a.coerce, 52
  %shr.i.264 = trunc i64 %a.sroa.0.0.extract.shift.i.263 to i32
  %and.i.265 = and i32 %shr.i.264, 2047
  %a.sroa.0.0.extract.shift.i.266 = lshr i64 %a.coerce, 63
  %conv.i.267 = trunc i64 %a.sroa.0.0.extract.shift.i.266 to i8
  %cmp = icmp eq i32 %and.i.265, 2047
  br i1 %cmp, label %if.then, label %if.end.9

if.then:                                          ; preds = %entry
  %or = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %if.end, label %if.then.4

if.then.4:                                        ; preds = %if.then
  %call5 = tail call fastcc i64 @propagateFloat64NaN(i64 %a.coerce, i64 %a.coerce)
  %retval.sroa.0.0.extract.shift = and i64 %call5, -4294967296
  br label %cleanup

if.end:                                           ; preds = %if.then
  %tobool6 = icmp eq i8 %conv.i.267, 0
  br i1 %tobool6, label %if.then.7, label %invalid

if.then.7:                                        ; preds = %if.end
  %retval.sroa.0.0.extract.shift96 = and i64 %a.coerce, -4294967296
  br label %cleanup

if.end.9:                                         ; preds = %entry
  %tobool10 = icmp eq i8 %conv.i.267, 0
  br i1 %tobool10, label %if.end.17, label %if.then.11

if.then.11:                                       ; preds = %if.end.9
  %or12 = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %or13 = or i32 %or12, %and.i.265
  %cmp14 = icmp eq i32 %or13, 0
  br i1 %cmp14, label %if.then.15, label %invalid

if.then.15:                                       ; preds = %if.then.11
  %retval.sroa.0.0.extract.shift98 = and i64 %a.coerce, -4294967296
  br label %cleanup

invalid:                                          ; preds = %if.end, %if.then.11
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.17:                                        ; preds = %if.end.9
  %cmp18 = icmp eq i32 %and.i.265, 0
  br i1 %cmp18, label %if.then.19, label %if.end.25

if.then.19:                                       ; preds = %if.end.17
  %or20 = or i32 %and.i, %a.sroa.1.0.extract.trunc.i
  %cmp21 = icmp eq i32 %or20, 0
  br i1 %cmp21, label %cleanup, label %if.end.24

if.end.24:                                        ; preds = %if.then.19
  %cmp.i.254 = icmp eq i32 %and.i, 0
  br i1 %cmp.i.254, label %if.then.i.255, label %if.else.14.i

if.then.i.255:                                    ; preds = %if.end.24
  %cmp.i.i = icmp ult i32 %a.sroa.1.0.extract.trunc.i, 65536
  %shl.i.i = shl i32 %a.sroa.1.0.extract.trunc.i, 16
  %shl.a.i.i = select i1 %cmp.i.i, i32 %shl.i.i, i32 %a.sroa.1.0.extract.trunc.i
  %..i.i = select i1 %cmp.i.i, i8 16, i8 0
  %cmp2.i.i = icmp ult i32 %shl.a.i.i, 16777216
  br i1 %cmp2.i.i, label %if.then.4.i.i, label %countLeadingZeros32.exit.i

if.then.4.i.i:                                    ; preds = %if.then.i.255
  %conv5.23.i.i = zext i8 %..i.i to i32
  %add6.i.i = or i32 %conv5.23.i.i, 8
  %conv7.i.i = trunc i32 %add6.i.i to i8
  %shl8.i.i = shl i32 %shl.a.i.i, 8
  br label %countLeadingZeros32.exit.i

countLeadingZeros32.exit.i:                       ; preds = %if.then.4.i.i, %if.then.i.255
  %a.addr.1.i.i = phi i32 [ %shl8.i.i, %if.then.4.i.i ], [ %shl.a.i.i, %if.then.i.255 ]
  %shiftCount.1.i.i = phi i8 [ %conv7.i.i, %if.then.4.i.i ], [ %..i.i, %if.then.i.255 ]
  %shr.i.i = lshr i32 %a.addr.1.i.i, 24
  %idxprom.i.i = zext i32 %shr.i.i to i64
  %arrayidx.i.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.i
  %1 = load i8, i8* %arrayidx.i.i, align 1, !tbaa !5
  %conv10.22.i.i = zext i8 %1 to i32
  %conv11.21.i.i = zext i8 %shiftCount.1.i.i to i32
  %add12.i.i = add nuw nsw i32 %conv10.22.i.i, %conv11.21.i.i
  %conv.39.i = shl i32 %add12.i.i, 24
  %sext40.i = add i32 %conv.39.i, -184549376
  %conv2.i = ashr exact i32 %sext40.i, 24
  %cmp3.i.256 = icmp slt i32 %sext40.i, 0
  br i1 %cmp3.i.256, label %if.then.5.i, label %if.else.i.260

if.then.5.i:                                      ; preds = %countLeadingZeros32.exit.i
  %sub7.i = sub nsw i32 0, %conv2.i
  %shr.i.257 = lshr i32 %a.sroa.1.0.extract.trunc.i, %sub7.i
  %and.i.258 = and i32 %conv2.i, 31
  %shl.i.259 = shl i32 %a.sroa.1.0.extract.trunc.i, %and.i.258
  br label %if.end.i.261

if.else.i.260:                                    ; preds = %countLeadingZeros32.exit.i
  %shl10.i = shl i32 %a.sroa.1.0.extract.trunc.i, %conv2.i
  br label %if.end.i.261

if.end.i.261:                                     ; preds = %if.else.i.260, %if.then.5.i
  %aSig0.0 = phi i32 [ %shr.i.257, %if.then.5.i ], [ %shl10.i, %if.else.i.260 ]
  %storemerge.41.i = phi i32 [ %shl.i.259, %if.then.5.i ], [ 0, %if.else.i.260 ]
  %sub13.i = sub nsw i32 -31, %conv2.i
  br label %if.end.25

if.else.14.i:                                     ; preds = %if.end.24
  %cmp.i.45.i = icmp ult i32 %and.i, 65536
  %shl.i.46.i320 = shl nuw nsw i64 %a.sroa.0.0.extract.shift.i, 16
  %shl.i.46.i = trunc i64 %shl.i.46.i320 to i32
  %shl.a.i.47.i = select i1 %cmp.i.45.i, i32 %shl.i.46.i, i32 %and.i
  %..i.48.i = select i1 %cmp.i.45.i, i8 16, i8 0
  %cmp2.i.49.i = icmp ult i32 %shl.a.i.47.i, 16777216
  br i1 %cmp2.i.49.i, label %if.then.4.i.54.i, label %countLeadingZeros32.exit64.i

if.then.4.i.54.i:                                 ; preds = %if.else.14.i
  %conv5.23.i.50.i = zext i8 %..i.48.i to i32
  %add6.i.51.i = or i32 %conv5.23.i.50.i, 8
  %conv7.i.52.i = trunc i32 %add6.i.51.i to i8
  %shl8.i.53.i = shl i32 %shl.a.i.47.i, 8
  br label %countLeadingZeros32.exit64.i

countLeadingZeros32.exit64.i:                     ; preds = %if.then.4.i.54.i, %if.else.14.i
  %a.addr.1.i.55.i = phi i32 [ %shl8.i.53.i, %if.then.4.i.54.i ], [ %shl.a.i.47.i, %if.else.14.i ]
  %shiftCount.1.i.56.i = phi i8 [ %conv7.i.52.i, %if.then.4.i.54.i ], [ %..i.48.i, %if.else.14.i ]
  %shr.i.57.i = lshr i32 %a.addr.1.i.55.i, 24
  %idxprom.i.58.i = zext i32 %shr.i.57.i to i64
  %arrayidx.i.59.i = getelementptr inbounds [256 x i8], [256 x i8]* @countLeadingZeros32.countLeadingZerosHigh, i64 0, i64 %idxprom.i.58.i
  %2 = load i8, i8* %arrayidx.i.59.i, align 1, !tbaa !5
  %conv10.22.i.60.i = zext i8 %2 to i32
  %conv11.21.i.61.i = zext i8 %shiftCount.1.i.56.i to i32
  %add12.i.62.i = add nuw nsw i32 %conv10.22.i.60.i, %conv11.21.i.61.i
  %conv16.38.i = shl i32 %add12.i.62.i, 24
  %sext.i = add i32 %conv16.38.i, -184549376
  %conv19.i = ashr exact i32 %sext.i, 24
  %shl.i.42.i = shl i32 %a.sroa.1.0.extract.trunc.i, %conv19.i
  %cmp.i.43.i = icmp eq i32 %conv19.i, 0
  br i1 %cmp.i.43.i, label %shortShift64Left.exit.i, label %cond.false.i.i

cond.false.i.i:                                   ; preds = %countLeadingZeros32.exit64.i
  %shl1.i.i = shl i32 %and.i, %conv19.i
  %sub.i.i.262 = sub nsw i32 0, %conv19.i
  %and.i.i = and i32 %sub.i.i.262, 31
  %shr.i.44.i = lshr i32 %a.sroa.1.0.extract.trunc.i, %and.i.i
  %or.i.i = or i32 %shr.i.44.i, %shl1.i.i
  br label %shortShift64Left.exit.i

shortShift64Left.exit.i:                          ; preds = %cond.false.i.i, %countLeadingZeros32.exit64.i
  %cond.i.i = phi i32 [ %or.i.i, %cond.false.i.i ], [ %and.i, %countLeadingZeros32.exit64.i ]
  %sub21.i = sub nsw i32 1, %conv19.i
  br label %if.end.25

if.end.25:                                        ; preds = %shortShift64Left.exit.i, %if.end.i.261, %if.end.17
  %aSig0.2 = phi i32 [ %and.i, %if.end.17 ], [ %aSig0.0, %if.end.i.261 ], [ %cond.i.i, %shortShift64Left.exit.i ]
  %aSig1.1 = phi i32 [ %a.sroa.1.0.extract.trunc.i, %if.end.17 ], [ %storemerge.41.i, %if.end.i.261 ], [ %shl.i.42.i, %shortShift64Left.exit.i ]
  %aExp.0 = phi i32 [ %and.i.265, %if.end.17 ], [ %sub13.i, %if.end.i.261 ], [ %sub21.i, %shortShift64Left.exit.i ]
  %sub = add nsw i32 %aExp.0, -1023
  %shr = ashr i32 %sub, 1
  %add = add nsw i32 %shr, 1022
  %or26 = or i32 %aSig0.2, 1048576
  %shl1.i.248 = shl i32 %or26, 11
  %shr.i.249 = lshr i32 %aSig1.1, 21
  %or.i.250 = or i32 %shr.i.249, %shl1.i.248
  %3 = lshr i32 %aSig0.2, 16
  %and.i.180 = and i32 %3, 15
  %and1.i = and i32 %aExp.0, 1
  %tobool.i = icmp eq i32 %and1.i, 0
  %4 = lshr i32 %or26, 6
  %shr2.i = and i32 %4, 32767
  br i1 %tobool.i, label %if.else.i, label %if.then.i

if.then.i:                                        ; preds = %if.end.25
  %conv.i.181 = zext i32 %and.i.180 to i64
  %add.i.182 = add nuw nsw i32 %shr2.i, 16384
  %arrayidx.i = getelementptr inbounds [16 x i16], [16 x i16]* @estimateSqrt32.sqrtOddAdjustments, i64 0, i64 %conv.i.181
  %5 = load i16, i16* %arrayidx.i, align 2, !tbaa !6
  %conv3.i = zext i16 %5 to i32
  %sub.i.183 = sub nsw i32 %add.i.182, %conv3.i
  %div.i.184 = udiv i32 %or.i.250, %sub.i.183
  %shl.i.185 = shl i32 %div.i.184, 14
  %shl4.i.186 = shl i32 %sub.i.183, 15
  %add5.i = add i32 %shl4.i.186, %shl.i.185
  %shr6.i.187 = lshr i32 %or.i.250, 1
  br label %if.end.21.i

if.else.i:                                        ; preds = %if.end.25
  %add8.i.188 = or i32 %shr2.i, 32768
  %idxprom9.43.i = zext i32 %and.i.180 to i64
  %arrayidx10.i = getelementptr inbounds [16 x i16], [16 x i16]* @estimateSqrt32.sqrtEvenAdjustments, i64 0, i64 %idxprom9.43.i
  %6 = load i16, i16* %arrayidx10.i, align 2, !tbaa !6
  %conv11.i.189 = zext i16 %6 to i32
  %sub12.i.190 = sub nsw i32 %add8.i.188, %conv11.i.189
  %div13.i = udiv i32 %or.i.250, %sub12.i.190
  %add14.i.191 = add i32 %sub12.i.190, %div13.i
  %cmp.i.192 = icmp ugt i32 %add14.i.191, 131071
  %shl16.i = shl i32 %add14.i.191, 15
  %cond.i.193 = select i1 %cmp.i.192, i32 -32768, i32 %shl16.i
  %cmp17.i = icmp ugt i32 %cond.i.193, %or.i.250
  br i1 %cmp17.i, label %if.end.21.i, label %if.then.19.i

if.then.19.i:                                     ; preds = %if.else.i
  %shr20.i = ashr i32 %or.i.250, 1
  br label %estimateSqrt32.exit

if.end.21.i:                                      ; preds = %if.else.i, %if.then.i
  %a.addr.0.i = phi i32 [ %shr6.i.187, %if.then.i ], [ %or.i.250, %if.else.i ]
  %z.0.i = phi i32 [ %add5.i, %if.then.i ], [ %cond.i.193, %if.else.i ]
  %cmp.i.196 = icmp ugt i32 %z.0.i, %a.addr.0.i
  br i1 %cmp.i.196, label %if.end.i.200, label %estimateDiv64To32.exit246

if.end.i.200:                                     ; preds = %if.end.21.i
  %shr.i.197 = lshr i32 %z.0.i, 16
  %shl.i.198 = shl nuw i32 %shr.i.197, 16
  %cmp1.i.199 = icmp ugt i32 %shl.i.198, %a.addr.0.i
  br i1 %cmp1.i.199, label %cond.false.i.203, label %cond.end.i.218

cond.false.i.203:                                 ; preds = %if.end.i.200
  %div.i.201 = udiv i32 %a.addr.0.i, %shr.i.197
  %shl2.i.202 = shl i32 %div.i.201, 16
  br label %cond.end.i.218

cond.end.i.218:                                   ; preds = %cond.false.i.203, %if.end.i.200
  %cond.i.204 = phi i32 [ %shl2.i.202, %cond.false.i.203 ], [ -65536, %if.end.i.200 ]
  %shr3.i.i.205 = lshr exact i32 %cond.i.204, 16
  %conv5.i.i.206 = and i32 %z.0.i, 65535
  %mul9.i.i.207 = mul nuw i32 %shr3.i.i.205, %conv5.i.i.206
  %mul15.i.i.208 = mul nuw i32 %shr3.i.i.205, %shr.i.197
  %shr17.i.i.209 = lshr i32 %mul9.i.i.207, 16
  %shl20.i.i.210 = shl i32 %mul9.i.i.207, 16
  %sub.i.i.211 = sub i32 0, %shl20.i.i.210
  %cmp.i.39.i.212 = icmp ne i32 %shl20.i.i.210, 0
  %conv.neg.i.i.213 = sext i1 %cmp.i.39.i.212 to i32
  %add24.i.neg.i.214 = sub i32 %a.addr.0.i, %mul15.i.i.208
  %sub1.i.i.215 = sub i32 %add24.i.neg.i.214, %shr17.i.i.209
  %sub2.i.i.216 = add i32 %sub1.i.i.215, %conv.neg.i.i.213
  %cmp3.45.i.217 = icmp slt i32 %sub2.i.i.216, 0
  br i1 %cmp3.45.i.217, label %while.body.lr.ph.i.220, label %while.end.i.239

while.body.lr.ph.i.220:                           ; preds = %cond.end.i.218
  %shl4.i.219 = shl i32 %z.0.i, 16
  br label %while.body.i.231

while.body.i.231:                                 ; preds = %while.body.i.231, %while.body.lr.ph.i.220
  %z.048.i.221 = phi i32 [ %cond.i.204, %while.body.lr.ph.i.220 ], [ %sub.i.224, %while.body.i.231 ]
  %rem0.047.i.222 = phi i32 [ %sub2.i.i.216, %while.body.lr.ph.i.220 ], [ %add2.i.i.229, %while.body.i.231 ]
  %rem1.046.i.223 = phi i32 [ %sub.i.i.211, %while.body.lr.ph.i.220 ], [ %add.i.37.i.225, %while.body.i.231 ]
  %sub.i.224 = add i32 %z.048.i.221, -65536
  %add.i.37.i.225 = add i32 %rem1.046.i.223, %shl4.i.219
  %add1.i.i.226 = add i32 %rem0.047.i.222, %shr.i.197
  %cmp.i.38.i.227 = icmp ult i32 %add.i.37.i.225, %rem1.046.i.223
  %conv.i.i.228 = zext i1 %cmp.i.38.i.227 to i32
  %add2.i.i.229 = add i32 %add1.i.i.226, %conv.i.i.228
  %cmp3.i.230 = icmp slt i32 %add2.i.i.229, 0
  br i1 %cmp3.i.230, label %while.body.i.231, label %while.end.i.239.loopexit

while.end.i.239.loopexit:                         ; preds = %while.body.i.231
  %add2.i.i.229.lcssa = phi i32 [ %add2.i.i.229, %while.body.i.231 ]
  %add.i.37.i.225.lcssa = phi i32 [ %add.i.37.i.225, %while.body.i.231 ]
  %sub.i.224.lcssa = phi i32 [ %sub.i.224, %while.body.i.231 ]
  br label %while.end.i.239

while.end.i.239:                                  ; preds = %while.end.i.239.loopexit, %cond.end.i.218
  %z.0.lcssa.i.232 = phi i32 [ %cond.i.204, %cond.end.i.218 ], [ %sub.i.224.lcssa, %while.end.i.239.loopexit ]
  %rem0.0.lcssa.i.233 = phi i32 [ %sub2.i.i.216, %cond.end.i.218 ], [ %add2.i.i.229.lcssa, %while.end.i.239.loopexit ]
  %rem1.0.lcssa.i.234 = phi i32 [ %sub.i.i.211, %cond.end.i.218 ], [ %add.i.37.i.225.lcssa, %while.end.i.239.loopexit ]
  %shl5.i.235 = shl i32 %rem0.0.lcssa.i.233, 16
  %shr6.i.236 = lshr i32 %rem1.0.lcssa.i.234, 16
  %or.i.237 = or i32 %shr6.i.236, %shl5.i.235
  %cmp8.i.238 = icmp ugt i32 %shl.i.198, %or.i.237
  br i1 %cmp8.i.238, label %cond.false.10.i.241, label %cond.end.12.i.244

cond.false.10.i.241:                              ; preds = %while.end.i.239
  %div11.i.240 = udiv i32 %or.i.237, %shr.i.197
  br label %cond.end.12.i.244

cond.end.12.i.244:                                ; preds = %cond.false.10.i.241, %while.end.i.239
  %cond13.i.242 = phi i32 [ %div11.i.240, %cond.false.10.i.241 ], [ 65535, %while.end.i.239 ]
  %or14.i.243 = or i32 %cond13.i.242, %z.0.lcssa.i.232
  %phitmp = lshr i32 %or14.i.243, 1
  br label %estimateDiv64To32.exit246

estimateDiv64To32.exit246:                        ; preds = %if.end.21.i, %cond.end.12.i.244
  %retval.0.i.245 = phi i32 [ %phitmp, %cond.end.12.i.244 ], [ 2147483647, %if.end.21.i ]
  %shr23.i = lshr i32 %z.0.i, 1
  %add24.i.194 = add nuw i32 %retval.0.i.245, %shr23.i
  br label %estimateSqrt32.exit

estimateSqrt32.exit:                              ; preds = %if.then.19.i, %estimateDiv64To32.exit246
  %retval.0.i.195 = phi i32 [ %add24.i.194, %estimateDiv64To32.exit246 ], [ %shr20.i, %if.then.19.i ]
  %shr28 = lshr i32 %retval.0.i.195, 1
  %add29 = add nuw i32 %shr28, 1
  %add33 = shl i32 %add29, 1
  %sub34 = sub nsw i32 9, %and1.i
  %shl.i.171 = shl i32 %aSig1.1, %sub34
  %shl1.i = shl i32 %or26, %sub34
  %sub.i.172 = sub nsw i32 0, %sub34
  %and.i.173 = and i32 %sub.i.172, 31
  %shr.i.174 = lshr i32 %aSig1.1, %and.i.173
  %or.i.175 = or i32 %shr.i.174, %shl1.i
  %shr.i.151 = lshr i32 %add29, 16
  %conv5.i.153 = and i32 %add29, 65535
  %mul.i.155 = mul nuw i32 %conv5.i.153, %conv5.i.153
  %mul9.i.156 = mul nuw i32 %shr.i.151, %conv5.i.153
  %mul15.i.158 = mul nuw i32 %shr.i.151, %shr.i.151
  %add.i.159 = shl i32 %mul9.i.156, 1
  %cmp.i.160 = icmp ult i32 %add.i.159, %mul9.i.156
  %conv16.i.161 = zext i1 %cmp.i.160 to i32
  %shl.i.162 = shl nuw nsw i32 %conv16.i.161, 16
  %7 = lshr i32 %mul9.i.156, 15
  %shr17.i.163 = and i32 %7, 65535
  %add18.i.164 = or i32 %shl.i.162, %shr17.i.163
  %shl20.i.166 = shl i32 %mul9.i.156, 17
  %add21.i.167 = add i32 %shl20.i.166, %mul.i.155
  %cmp22.i.168 = icmp ult i32 %add21.i.167, %shl20.i.166
  %sub.i.146 = sub i32 %shl.i.171, %add21.i.167
  %conv23.i.169.neg = sext i1 %cmp22.i.168 to i32
  %cmp.i.148 = icmp ult i32 %shl.i.171, %add21.i.167
  %conv.neg.i.149 = sext i1 %cmp.i.148 to i32
  %add19.i.165.neg = sub i32 %or.i.175, %mul15.i.158
  %add24.i.170.neg = add i32 %add19.i.165.neg, %conv23.i.169.neg
  %sub1.i.147 = add i32 %add24.i.170.neg, %conv.neg.i.149
  %sub2.i.150 = sub i32 %sub1.i.147, %add18.i.164
  %cmp35.330 = icmp slt i32 %sub2.i.150, 0
  br i1 %cmp35.330, label %while.body.preheader, label %while.end

while.body.preheader:                             ; preds = %estimateSqrt32.exit
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %doubleZSig0.0334 = phi i32 [ %sub36, %while.body ], [ %add33, %while.body.preheader ]
  %rem1.0333 = phi i32 [ %add.i.143, %while.body ], [ %sub.i.146, %while.body.preheader ]
  %rem0.0332 = phi i32 [ %add2.i.145, %while.body ], [ %sub2.i.150, %while.body.preheader ]
  %zSig0.0331 = phi i32 [ %dec, %while.body ], [ %add29, %while.body.preheader ]
  %dec = add i32 %zSig0.0331, -1
  %sub36 = add i32 %doubleZSig0.0334, -2
  %or37 = or i32 %sub36, 1
  %add.i.143 = add i32 %or37, %rem1.0333
  %cmp.i.144 = icmp ult i32 %add.i.143, %rem1.0333
  %conv.i = zext i1 %cmp.i.144 to i32
  %add2.i.145 = add i32 %conv.i, %rem0.0332
  %cmp35 = icmp slt i32 %add2.i.145, 0
  br i1 %cmp35, label %while.body, label %while.end.loopexit

while.end.loopexit:                               ; preds = %while.body
  %add.i.143.lcssa = phi i32 [ %add.i.143, %while.body ]
  %sub36.lcssa = phi i32 [ %sub36, %while.body ]
  %dec.lcssa = phi i32 [ %dec, %while.body ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %estimateSqrt32.exit
  %doubleZSig0.0.lcssa = phi i32 [ %add33, %estimateSqrt32.exit ], [ %sub36.lcssa, %while.end.loopexit ]
  %rem1.0.lcssa = phi i32 [ %sub.i.146, %estimateSqrt32.exit ], [ %add.i.143.lcssa, %while.end.loopexit ]
  %zSig0.0.lcssa = phi i32 [ %add29, %estimateSqrt32.exit ], [ %dec.lcssa, %while.end.loopexit ]
  %cmp.i.136 = icmp ugt i32 %doubleZSig0.0.lcssa, %rem1.0.lcssa
  br i1 %cmp.i.136, label %if.end.i, label %if.end.56

if.end.i:                                         ; preds = %while.end
  %shr.i.137 = lshr i32 %doubleZSig0.0.lcssa, 16
  %shl.i.138 = shl nuw i32 %shr.i.137, 16
  %cmp1.i = icmp ugt i32 %shl.i.138, %rem1.0.lcssa
  br i1 %cmp1.i, label %cond.false.i, label %cond.end.i

cond.false.i:                                     ; preds = %if.end.i
  %div.i = udiv i32 %rem1.0.lcssa, %shr.i.137
  %shl2.i = shl i32 %div.i, 16
  br label %cond.end.i

cond.end.i:                                       ; preds = %cond.false.i, %if.end.i
  %cond.i = phi i32 [ %shl2.i, %cond.false.i ], [ -65536, %if.end.i ]
  %shr3.i.i = lshr exact i32 %cond.i, 16
  %conv5.i.i = and i32 %doubleZSig0.0.lcssa, 65534
  %mul9.i.i = mul nuw i32 %shr3.i.i, %conv5.i.i
  %mul15.i.i = mul nuw i32 %shr3.i.i, %shr.i.137
  %shr17.i.i = lshr i32 %mul9.i.i, 16
  %shl20.i.i = shl i32 %mul9.i.i, 16
  %sub.i.i = sub i32 0, %shl20.i.i
  %cmp.i.39.i = icmp ne i32 %shl20.i.i, 0
  %conv.neg.i.i = sext i1 %cmp.i.39.i to i32
  %add24.i.neg.i = sub i32 %rem1.0.lcssa, %mul15.i.i
  %sub1.i.i = sub i32 %add24.i.neg.i, %shr17.i.i
  %sub2.i.i = add i32 %sub1.i.i, %conv.neg.i.i
  %cmp3.45.i = icmp slt i32 %sub2.i.i, 0
  br i1 %cmp3.45.i, label %while.body.lr.ph.i, label %while.end.i

while.body.lr.ph.i:                               ; preds = %cond.end.i
  %shl4.i = shl i32 %doubleZSig0.0.lcssa, 16
  br label %while.body.i

while.body.i:                                     ; preds = %while.body.i, %while.body.lr.ph.i
  %z.048.i = phi i32 [ %cond.i, %while.body.lr.ph.i ], [ %sub.i.139, %while.body.i ]
  %rem0.047.i = phi i32 [ %sub2.i.i, %while.body.lr.ph.i ], [ %add2.i.i, %while.body.i ]
  %rem1.046.i = phi i32 [ %sub.i.i, %while.body.lr.ph.i ], [ %add.i.37.i, %while.body.i ]
  %sub.i.139 = add i32 %z.048.i, -65536
  %add.i.37.i = add i32 %rem1.046.i, %shl4.i
  %add1.i.i = add i32 %rem0.047.i, %shr.i.137
  %cmp.i.38.i = icmp ult i32 %add.i.37.i, %rem1.046.i
  %conv.i.i = zext i1 %cmp.i.38.i to i32
  %add2.i.i = add i32 %add1.i.i, %conv.i.i
  %cmp3.i.140 = icmp slt i32 %add2.i.i, 0
  br i1 %cmp3.i.140, label %while.body.i, label %while.end.i.loopexit

while.end.i.loopexit:                             ; preds = %while.body.i
  %add2.i.i.lcssa = phi i32 [ %add2.i.i, %while.body.i ]
  %add.i.37.i.lcssa = phi i32 [ %add.i.37.i, %while.body.i ]
  %sub.i.139.lcssa = phi i32 [ %sub.i.139, %while.body.i ]
  br label %while.end.i

while.end.i:                                      ; preds = %while.end.i.loopexit, %cond.end.i
  %z.0.lcssa.i = phi i32 [ %cond.i, %cond.end.i ], [ %sub.i.139.lcssa, %while.end.i.loopexit ]
  %rem0.0.lcssa.i = phi i32 [ %sub2.i.i, %cond.end.i ], [ %add2.i.i.lcssa, %while.end.i.loopexit ]
  %rem1.0.lcssa.i = phi i32 [ %sub.i.i, %cond.end.i ], [ %add.i.37.i.lcssa, %while.end.i.loopexit ]
  %shl5.i = shl i32 %rem0.0.lcssa.i, 16
  %shr6.i = lshr i32 %rem1.0.lcssa.i, 16
  %or.i.141 = or i32 %shr6.i, %shl5.i
  %cmp8.i.142 = icmp ugt i32 %shl.i.138, %or.i.141
  br i1 %cmp8.i.142, label %cond.false.10.i, label %estimateDiv64To32.exit

cond.false.10.i:                                  ; preds = %while.end.i
  %div11.i = udiv i32 %or.i.141, %shr.i.137
  br label %estimateDiv64To32.exit

estimateDiv64To32.exit:                           ; preds = %while.end.i, %cond.false.10.i
  %cond13.i = phi i32 [ %div11.i, %cond.false.10.i ], [ 65535, %while.end.i ]
  %or14.i = or i32 %cond13.i, %z.0.lcssa.i
  %and39 = and i32 %or14.i, 510
  %cmp40 = icmp ult i32 %and39, 6
  br i1 %cmp40, label %if.then.41, label %if.end.56

if.then.41:                                       ; preds = %estimateDiv64To32.exit
  %cmp42 = icmp eq i32 %or14.i, 0
  %.or14.i = select i1 %cmp42, i32 1, i32 %or14.i
  %shr3.i.117 = lshr i32 %.or14.i, 16
  %conv6.i.119 = and i32 %.or14.i, 65535
  %mul.i.120 = mul nuw i32 %conv6.i.119, %conv5.i.i
  %mul9.i.121 = mul nuw i32 %shr3.i.117, %conv5.i.i
  %mul12.i.122 = mul nuw i32 %conv6.i.119, %shr.i.137
  %mul15.i.123 = mul nuw i32 %shr3.i.117, %shr.i.137
  %add.i.124 = add i32 %mul9.i.121, %mul12.i.122
  %cmp.i.125 = icmp ult i32 %add.i.124, %mul12.i.122
  %conv16.i.126 = zext i1 %cmp.i.125 to i32
  %shl.i.127 = shl nuw nsw i32 %conv16.i.126, 16
  %shr17.i.128 = lshr i32 %add.i.124, 16
  %add18.i.129 = or i32 %shl.i.127, %shr17.i.128
  %shl20.i.131 = shl i32 %add.i.124, 16
  %add21.i.132 = add i32 %shl20.i.131, %mul.i.120
  %cmp22.i.133 = icmp ult i32 %add21.i.132, %shl20.i.131
  %sub.i.113 = sub i32 0, %add21.i.132
  %conv23.i.134.neg = sext i1 %cmp22.i.133 to i32
  %cmp.i.114 = icmp ne i32 %add21.i.132, 0
  %conv.neg.i = sext i1 %cmp.i.114 to i32
  %mul.i = mul nuw i32 %conv6.i.119, %conv6.i.119
  %mul9.i = mul nuw i32 %shr3.i.117, %conv6.i.119
  %mul15.i = mul nuw i32 %shr3.i.117, %shr3.i.117
  %add.i.110 = shl i32 %mul9.i, 1
  %cmp.i.111 = icmp ult i32 %add.i.110, %mul9.i
  %conv16.i = zext i1 %cmp.i.111 to i32
  %shl.i.112 = shl nuw nsw i32 %conv16.i, 16
  %8 = lshr i32 %mul9.i, 15
  %shr17.i = and i32 %8, 65535
  %add18.i = or i32 %shl.i.112, %shr17.i
  %shl20.i = shl i32 %mul9.i, 17
  %add21.i = add i32 %shl20.i, %mul.i
  %cmp22.i = icmp ult i32 %add21.i, %shl20.i
  %conv23.i = zext i1 %cmp22.i to i32
  %add19.i = add i32 %conv23.i, %mul15.i
  %add24.i = add i32 %add19.i, %add18.i
  %sub.i = sub i32 0, %add21.i
  %cmp.i.106 = icmp ne i32 %add21.i, 0
  %sub2.i = sub i32 %sub.i.113, %add24.i
  %cmp3.i.107 = icmp ugt i32 %add24.i, %sub.i.113
  %conv7.i.108 = zext i1 %cmp.i.106 to i32
  %cmp8.i = icmp ult i32 %sub2.i, %conv7.i.108
  %conv9.neg.i = sext i1 %cmp8.i to i32
  %sub12.i = sub i32 %sub2.i, %conv7.i.108
  %conv13.neg.i = sext i1 %cmp3.i.107 to i32
  %add19.i.130.neg = sub i32 %rem1.0.lcssa, %mul15.i.123
  %add24.i.135.neg = sub i32 %add19.i.130.neg, %add18.i.129
  %sub1.i = add i32 %add24.i.135.neg, %conv23.i.134.neg
  %sub2.i.115 = add i32 %sub1.i, %conv.neg.i
  %sub10.i = add i32 %sub2.i.115, %conv13.neg.i
  %sub14.i = add i32 %sub10.i, %conv9.neg.i
  %cmp46.322 = icmp slt i32 %sub14.i, 0
  br i1 %cmp46.322, label %while.body.47.preheader, label %while.end.51

while.body.47.preheader:                          ; preds = %if.then.41
  br label %while.body.47

while.body.47:                                    ; preds = %while.body.47.preheader, %while.body.47
  %rem3.0326 = phi i32 [ %add.i, %while.body.47 ], [ %sub.i, %while.body.47.preheader ]
  %rem2.0325 = phi i32 [ %add8.i, %while.body.47 ], [ %sub12.i, %while.body.47.preheader ]
  %rem1.1324 = phi i32 [ %add14.i, %while.body.47 ], [ %sub14.i, %while.body.47.preheader ]
  %zSig1.1323 = phi i32 [ %dec48, %while.body.47 ], [ %.or14.i, %while.body.47.preheader ]
  %dec48 = add i32 %zSig1.1323, -1
  %shl.i.104 = shl i32 %dec48, 1
  %shr.i.105 = lshr i32 %dec48, 31
  %or49 = or i32 %shl.i.104, 1
  %or50 = or i32 %shr.i.105, %doubleZSig0.0.lcssa
  %add.i = add i32 %or49, %rem3.0326
  %cmp.i = icmp ult i32 %add.i, %rem3.0326
  %add2.i = add i32 %or50, %rem2.0325
  %cmp3.i = icmp ult i32 %add2.i, %rem2.0325
  %conv7.i = zext i1 %cmp.i to i32
  %add8.i = add i32 %conv7.i, %add2.i
  %cmp10.i = icmp ult i32 %add8.i, %conv7.i
  %conv11.i = zext i1 %cmp10.i to i32
  %conv13.i = zext i1 %cmp3.i to i32
  %add12.i = add i32 %conv13.i, %rem1.1324
  %add14.i = add i32 %add12.i, %conv11.i
  %cmp46 = icmp slt i32 %add14.i, 0
  br i1 %cmp46, label %while.body.47, label %while.end.51.loopexit

while.end.51.loopexit:                            ; preds = %while.body.47
  %add14.i.lcssa = phi i32 [ %add14.i, %while.body.47 ]
  %add8.i.lcssa = phi i32 [ %add8.i, %while.body.47 ]
  %add.i.lcssa = phi i32 [ %add.i, %while.body.47 ]
  %dec48.lcssa = phi i32 [ %dec48, %while.body.47 ]
  br label %while.end.51

while.end.51:                                     ; preds = %while.end.51.loopexit, %if.then.41
  %rem3.0.lcssa = phi i32 [ %sub.i, %if.then.41 ], [ %add.i.lcssa, %while.end.51.loopexit ]
  %rem2.0.lcssa = phi i32 [ %sub12.i, %if.then.41 ], [ %add8.i.lcssa, %while.end.51.loopexit ]
  %rem1.1.lcssa = phi i32 [ %sub14.i, %if.then.41 ], [ %add14.i.lcssa, %while.end.51.loopexit ]
  %zSig1.1.lcssa = phi i32 [ %.or14.i, %if.then.41 ], [ %dec48.lcssa, %while.end.51.loopexit ]
  %or52 = or i32 %rem2.0.lcssa, %rem1.1.lcssa
  %or53 = or i32 %or52, %rem3.0.lcssa
  %cmp54 = icmp ne i32 %or53, 0
  %conv = zext i1 %cmp54 to i32
  %or55 = or i32 %conv, %zSig1.1.lcssa
  br label %if.end.56

if.end.56:                                        ; preds = %while.end, %while.end.51, %estimateDiv64To32.exit
  %zSig1.2 = phi i32 [ %or55, %while.end.51 ], [ %or14.i, %estimateDiv64To32.exit ], [ -1, %while.end ]
  %shl.i = shl i32 %zSig1.2, 22
  %shl7.i = shl i32 %zSig0.0.lcssa, 22
  %shr.i = lshr i32 %zSig1.2, 10
  %or.i = or i32 %shr.i, %shl7.i
  %shr8.i = lshr i32 %zSig0.0.lcssa, 10
  %call57 = tail call fastcc i64 @roundAndPackFloat64(i8 signext 0, i32 signext %add, i32 zeroext %shr8.i, i32 zeroext %or.i, i32 zeroext %shl.i)
  %retval.sroa.0.0.extract.shift94 = and i64 %call57, -4294967296
  br label %cleanup

cleanup:                                          ; preds = %if.then.19, %if.end.56, %invalid, %if.then.15, %if.then.7, %if.then.4
  %retval.sroa.0.0 = phi i64 [ %retval.sroa.0.0.extract.shift, %if.then.4 ], [ -2251799813685248, %invalid ], [ %retval.sroa.0.0.extract.shift96, %if.then.7 ], [ %retval.sroa.0.0.extract.shift98, %if.then.15 ], [ %retval.sroa.0.0.extract.shift94, %if.end.56 ], [ 0, %if.then.19 ]
  %retval.sroa.7.0 = phi i64 [ %call5, %if.then.4 ], [ 0, %invalid ], [ %a.coerce, %if.then.7 ], [ %a.coerce, %if.then.15 ], [ %call57, %if.end.56 ], [ 0, %if.then.19 ]
  %retval.sroa.0.0.insert.mask = and i64 %retval.sroa.7.0, 4294967295
  %retval.sroa.0.0.insert.insert = or i64 %retval.sroa.0.0.insert.mask, %retval.sroa.0.0
  ret i64 %retval.sroa.0.0.insert.insert
}

; Function Attrs: nounwind
define signext i8 @float64_eq(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %a.sroa.7.0.extract.trunc = trunc i64 %a.coerce to i32
  %b.sroa.0.0.extract.shift = lshr i64 %b.coerce, 32
  %b.sroa.0.0.extract.trunc = trunc i64 %b.sroa.0.0.extract.shift to i32
  %b.sroa.7.0.extract.trunc = trunc i64 %b.coerce to i32
  %a.sroa.0.0.insert.shift = shl nuw i64 %a.sroa.0.0.extract.shift, 32
  %and.i = and i64 %a.coerce, 9218868437227405312
  %cmp = icmp eq i64 %and.i, 9218868437227405312
  br i1 %cmp, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %entry
  %and.i.114 = and i32 %a.sroa.0.0.extract.trunc, 1048575
  %or = or i32 %and.i.114, %a.sroa.7.0.extract.trunc
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %land.lhs.true, %entry
  %and.i.110 = and i64 %b.coerce, 9218868437227405312
  %cmp4 = icmp eq i64 %and.i.110, 9218868437227405312
  br i1 %cmp4, label %land.lhs.true.5, label %if.end.17

land.lhs.true.5:                                  ; preds = %lor.lhs.false
  %and.i.107 = and i32 %b.sroa.0.0.extract.trunc, 1048575
  %or8 = or i32 %and.i.107, %b.sroa.7.0.extract.trunc
  %tobool9 = icmp eq i32 %or8, 0
  br i1 %tobool9, label %if.end.17, label %if.then

if.then:                                          ; preds = %land.lhs.true, %land.lhs.true.5
  %and.i.96 = and i64 %a.sroa.0.0.insert.shift, 9221120237041090560
  %cmp.i.97 = icmp eq i64 %and.i.96, 9218868437227405312
  br i1 %cmp.i.97, label %land.rhs.i.100, label %lor.lhs.false.12

land.rhs.i.100:                                   ; preds = %if.then
  %tobool.i.99 = icmp eq i32 %a.sroa.7.0.extract.trunc, 0
  %and2.i.101 = and i64 %a.sroa.0.0.insert.shift, 2251795518717952
  %tobool3.i.102 = icmp eq i64 %and2.i.101, 0
  %or.cond = and i1 %tobool.i.99, %tobool3.i.102
  br i1 %or.cond, label %lor.lhs.false.12, label %if.then.16

lor.lhs.false.12:                                 ; preds = %land.rhs.i.100, %if.then
  %b.sroa.0.0.insert.shift49 = shl nuw i64 %b.sroa.0.0.extract.shift, 32
  %and.i.95 = and i64 %b.sroa.0.0.insert.shift49, 9221120237041090560
  %cmp.i = icmp eq i64 %and.i.95, 9218868437227405312
  br i1 %cmp.i, label %land.rhs.i, label %return

land.rhs.i:                                       ; preds = %lor.lhs.false.12
  %tobool.i = icmp eq i32 %b.sroa.7.0.extract.trunc, 0
  %and2.i = and i64 %b.sroa.0.0.insert.shift49, 2251795518717952
  %tobool3.i = icmp eq i64 %and2.i, 0
  %or.cond121 = and i1 %tobool.i, %tobool3.i
  br i1 %or.cond121, label %return, label %if.then.16

if.then.16:                                       ; preds = %land.rhs.i, %land.rhs.i.100
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %return

if.end.17:                                        ; preds = %land.lhs.true.5, %lor.lhs.false
  %cmp19 = icmp eq i32 %a.sroa.7.0.extract.trunc, %b.sroa.7.0.extract.trunc
  br i1 %cmp19, label %land.rhs, label %return

land.rhs:                                         ; preds = %if.end.17
  %cmp22 = icmp eq i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp22, label %return, label %lor.rhs

lor.rhs:                                          ; preds = %land.rhs
  %cmp25 = icmp eq i32 %a.sroa.7.0.extract.trunc, 0
  br i1 %cmp25, label %land.rhs.27, label %return

land.rhs.27:                                      ; preds = %lor.rhs
  %or3094 = or i64 %b.sroa.0.0.extract.shift, %a.sroa.0.0.extract.shift
  %shl.mask = and i64 %or3094, 2147483647
  %cmp31 = icmp eq i64 %shl.mask, 0
  %phitmp = zext i1 %cmp31 to i8
  br label %return

return:                                           ; preds = %land.rhs.i, %lor.lhs.false.12, %if.end.17, %lor.rhs, %land.rhs.27, %land.rhs, %if.then.16
  %retval.0 = phi i8 [ 0, %if.then.16 ], [ 0, %if.end.17 ], [ 1, %land.rhs ], [ 0, %lor.rhs ], [ %phitmp, %land.rhs.27 ], [ 0, %lor.lhs.false.12 ], [ 0, %land.rhs.i ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float64_le(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %a.sroa.8.0.extract.trunc = trunc i64 %a.coerce to i32
  %b.sroa.0.0.extract.shift = lshr i64 %b.coerce, 32
  %b.sroa.0.0.extract.trunc = trunc i64 %b.sroa.0.0.extract.shift to i32
  %b.sroa.8.0.extract.trunc = trunc i64 %b.coerce to i32
  %and.i = and i64 %a.coerce, 9218868437227405312
  %cmp = icmp eq i64 %and.i, 9218868437227405312
  br i1 %cmp, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %entry
  %and.i.127 = and i32 %a.sroa.0.0.extract.trunc, 1048575
  %or = or i32 %and.i.127, %a.sroa.8.0.extract.trunc
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %land.lhs.true, %entry
  %and.i.123 = and i64 %b.coerce, 9218868437227405312
  %cmp4 = icmp eq i64 %and.i.123, 9218868437227405312
  br i1 %cmp4, label %land.lhs.true.5, label %if.end

land.lhs.true.5:                                  ; preds = %lor.lhs.false
  %and.i.120 = and i32 %b.sroa.0.0.extract.trunc, 1048575
  %or8 = or i32 %and.i.120, %b.sroa.8.0.extract.trunc
  %tobool9 = icmp eq i32 %or8, 0
  br i1 %tobool9, label %if.end, label %if.then

if.then:                                          ; preds = %land.lhs.true, %land.lhs.true.5
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end:                                           ; preds = %land.lhs.true.5, %lor.lhs.false
  %a.sroa.0.0.extract.shift.i.117 = lshr i64 %a.coerce, 63
  %conv.i.118 = trunc i64 %a.sroa.0.0.extract.shift.i.117 to i8
  %a.sroa.0.0.extract.shift.i.116 = lshr i64 %b.coerce, 63
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i.116 to i8
  %cmp13 = icmp eq i8 %conv.i.118, %conv.i
  %tobool17 = icmp ne i8 %conv.i.118, 0
  br i1 %cmp13, label %if.end.26, label %if.then.15

if.then.15:                                       ; preds = %if.end
  br i1 %tobool17, label %cleanup, label %lor.rhs

lor.rhs:                                          ; preds = %if.then.15
  %or19108 = or i64 %b.sroa.0.0.extract.shift, %a.sroa.0.0.extract.shift
  %or19 = trunc i64 %or19108 to i32
  %shl = shl i32 %or19, 1
  %or20128 = or i64 %b.coerce, %a.coerce
  %or20 = trunc i64 %or20128 to i32
  %or22 = or i32 %or20, %shl
  %cmp23 = icmp eq i32 %or22, 0
  %phitmp = zext i1 %cmp23 to i8
  br label %cleanup

if.end.26:                                        ; preds = %if.end
  br i1 %tobool17, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end.26
  %cmp.i.109 = icmp ult i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp.i.109, label %cleanup, label %lor.rhs.i.111

lor.rhs.i.111:                                    ; preds = %cond.true
  %cmp1.i.110 = icmp eq i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp1.i.110, label %land.rhs.i.114, label %cleanup

land.rhs.i.114:                                   ; preds = %lor.rhs.i.111
  %cmp2.i.112 = icmp ule i32 %b.sroa.8.0.extract.trunc, %a.sroa.8.0.extract.trunc
  %phitmp.i.113 = zext i1 %cmp2.i.112 to i8
  br label %cleanup

cond.false:                                       ; preds = %if.end.26
  %cmp.i = icmp ult i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp.i, label %cleanup, label %lor.rhs.i

lor.rhs.i:                                        ; preds = %cond.false
  %cmp1.i = icmp eq i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp1.i, label %land.rhs.i, label %cleanup

land.rhs.i:                                       ; preds = %lor.rhs.i
  %cmp2.i = icmp ule i32 %a.sroa.8.0.extract.trunc, %b.sroa.8.0.extract.trunc
  %phitmp.i = zext i1 %cmp2.i to i8
  br label %cleanup

cleanup:                                          ; preds = %land.rhs.i, %lor.rhs.i, %cond.false, %land.rhs.i.114, %lor.rhs.i.111, %cond.true, %if.then.15, %lor.rhs, %if.then
  %retval.0 = phi i8 [ 0, %if.then ], [ 1, %if.then.15 ], [ %phitmp, %lor.rhs ], [ 1, %cond.true ], [ 0, %lor.rhs.i.111 ], [ %phitmp.i.113, %land.rhs.i.114 ], [ 1, %cond.false ], [ 0, %lor.rhs.i ], [ %phitmp.i, %land.rhs.i ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float64_lt(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %a.sroa.8.0.extract.trunc = trunc i64 %a.coerce to i32
  %b.sroa.0.0.extract.shift = lshr i64 %b.coerce, 32
  %b.sroa.0.0.extract.trunc = trunc i64 %b.sroa.0.0.extract.shift to i32
  %b.sroa.8.0.extract.trunc = trunc i64 %b.coerce to i32
  %and.i = and i64 %a.coerce, 9218868437227405312
  %cmp = icmp eq i64 %and.i, 9218868437227405312
  br i1 %cmp, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %entry
  %and.i.127 = and i32 %a.sroa.0.0.extract.trunc, 1048575
  %or = or i32 %and.i.127, %a.sroa.8.0.extract.trunc
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %land.lhs.true, %entry
  %and.i.123 = and i64 %b.coerce, 9218868437227405312
  %cmp4 = icmp eq i64 %and.i.123, 9218868437227405312
  br i1 %cmp4, label %land.lhs.true.5, label %if.end

land.lhs.true.5:                                  ; preds = %lor.lhs.false
  %and.i.120 = and i32 %b.sroa.0.0.extract.trunc, 1048575
  %or8 = or i32 %and.i.120, %b.sroa.8.0.extract.trunc
  %tobool9 = icmp eq i32 %or8, 0
  br i1 %tobool9, label %if.end, label %if.then

if.then:                                          ; preds = %land.lhs.true, %land.lhs.true.5
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end:                                           ; preds = %land.lhs.true.5, %lor.lhs.false
  %a.sroa.0.0.extract.shift.i.117 = lshr i64 %a.coerce, 63
  %conv.i.118 = trunc i64 %a.sroa.0.0.extract.shift.i.117 to i8
  %a.sroa.0.0.extract.shift.i.116 = lshr i64 %b.coerce, 63
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i.116 to i8
  %cmp13 = icmp eq i8 %conv.i.118, %conv.i
  %tobool17 = icmp ne i8 %conv.i.118, 0
  br i1 %cmp13, label %if.end.26, label %if.then.15

if.then.15:                                       ; preds = %if.end
  br i1 %tobool17, label %land.rhs, label %cleanup

land.rhs:                                         ; preds = %if.then.15
  %or19108 = or i64 %b.sroa.0.0.extract.shift, %a.sroa.0.0.extract.shift
  %or19 = trunc i64 %or19108 to i32
  %shl = shl i32 %or19, 1
  %or20128 = or i64 %b.coerce, %a.coerce
  %or20 = trunc i64 %or20128 to i32
  %or22 = or i32 %or20, %shl
  %cmp23 = icmp ne i32 %or22, 0
  %phitmp = zext i1 %cmp23 to i8
  br label %cleanup

if.end.26:                                        ; preds = %if.end
  br i1 %tobool17, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end.26
  %cmp.i.109 = icmp ult i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp.i.109, label %cleanup, label %lor.rhs.i.111

lor.rhs.i.111:                                    ; preds = %cond.true
  %cmp1.i.110 = icmp eq i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp1.i.110, label %land.rhs.i.114, label %cleanup

land.rhs.i.114:                                   ; preds = %lor.rhs.i.111
  %cmp2.i.112 = icmp ult i32 %b.sroa.8.0.extract.trunc, %a.sroa.8.0.extract.trunc
  %phitmp.i.113 = zext i1 %cmp2.i.112 to i8
  br label %cleanup

cond.false:                                       ; preds = %if.end.26
  %cmp.i = icmp ult i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp.i, label %cleanup, label %lor.rhs.i

lor.rhs.i:                                        ; preds = %cond.false
  %cmp1.i = icmp eq i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp1.i, label %land.rhs.i, label %cleanup

land.rhs.i:                                       ; preds = %lor.rhs.i
  %cmp2.i = icmp ult i32 %a.sroa.8.0.extract.trunc, %b.sroa.8.0.extract.trunc
  %phitmp.i = zext i1 %cmp2.i to i8
  br label %cleanup

cleanup:                                          ; preds = %land.rhs.i, %lor.rhs.i, %cond.false, %land.rhs.i.114, %lor.rhs.i.111, %cond.true, %if.then.15, %land.rhs, %if.then
  %retval.0 = phi i8 [ 0, %if.then ], [ 0, %if.then.15 ], [ %phitmp, %land.rhs ], [ 1, %cond.true ], [ 0, %lor.rhs.i.111 ], [ %phitmp.i.113, %land.rhs.i.114 ], [ 1, %cond.false ], [ 0, %lor.rhs.i ], [ %phitmp.i, %land.rhs.i ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float64_eq_signaling(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %a.sroa.6.0.extract.trunc = trunc i64 %a.coerce to i32
  %b.sroa.0.0.extract.shift = lshr i64 %b.coerce, 32
  %b.sroa.0.0.extract.trunc = trunc i64 %b.sroa.0.0.extract.shift to i32
  %b.sroa.6.0.extract.trunc = trunc i64 %b.coerce to i32
  %and.i = and i64 %a.coerce, 9218868437227405312
  %cmp = icmp eq i64 %and.i, 9218868437227405312
  br i1 %cmp, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %entry
  %and.i.72 = and i32 %a.sroa.0.0.extract.trunc, 1048575
  %or = or i32 %and.i.72, %a.sroa.6.0.extract.trunc
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %land.lhs.true, %entry
  %and.i.68 = and i64 %b.coerce, 9218868437227405312
  %cmp4 = icmp eq i64 %and.i.68, 9218868437227405312
  br i1 %cmp4, label %land.lhs.true.5, label %if.end

land.lhs.true.5:                                  ; preds = %lor.lhs.false
  %and.i.65 = and i32 %b.sroa.0.0.extract.trunc, 1048575
  %or8 = or i32 %and.i.65, %b.sroa.6.0.extract.trunc
  %tobool9 = icmp eq i32 %or8, 0
  br i1 %tobool9, label %if.end, label %if.then

if.then:                                          ; preds = %land.lhs.true, %land.lhs.true.5
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %return

if.end:                                           ; preds = %land.lhs.true.5, %lor.lhs.false
  %cmp11 = icmp eq i32 %a.sroa.6.0.extract.trunc, %b.sroa.6.0.extract.trunc
  br i1 %cmp11, label %land.rhs, label %return

land.rhs:                                         ; preds = %if.end
  %cmp13 = icmp eq i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp13, label %return, label %lor.rhs

lor.rhs:                                          ; preds = %land.rhs
  %cmp15 = icmp eq i32 %a.sroa.6.0.extract.trunc, 0
  br i1 %cmp15, label %land.rhs.16, label %return

land.rhs.16:                                      ; preds = %lor.rhs
  %or1963 = or i64 %b.sroa.0.0.extract.shift, %a.sroa.0.0.extract.shift
  %shl.mask = and i64 %or1963, 2147483647
  %cmp20 = icmp eq i64 %shl.mask, 0
  %phitmp = zext i1 %cmp20 to i8
  br label %return

return:                                           ; preds = %if.end, %lor.rhs, %land.rhs.16, %land.rhs, %if.then
  %retval.0 = phi i8 [ 0, %if.then ], [ 0, %if.end ], [ 1, %land.rhs ], [ 0, %lor.rhs ], [ %phitmp, %land.rhs.16 ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float64_le_quiet(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %a.sroa.9.0.extract.trunc = trunc i64 %a.coerce to i32
  %b.sroa.0.0.extract.shift = lshr i64 %b.coerce, 32
  %b.sroa.0.0.extract.trunc = trunc i64 %b.sroa.0.0.extract.shift to i32
  %b.sroa.9.0.extract.trunc = trunc i64 %b.coerce to i32
  %a.sroa.0.0.insert.shift = shl nuw i64 %a.sroa.0.0.extract.shift, 32
  %and.i = and i64 %a.coerce, 9218868437227405312
  %cmp = icmp eq i64 %and.i, 9218868437227405312
  br i1 %cmp, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %entry
  %and.i.169 = and i32 %a.sroa.0.0.extract.trunc, 1048575
  %or = or i32 %and.i.169, %a.sroa.9.0.extract.trunc
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %land.lhs.true, %entry
  %and.i.165 = and i64 %b.coerce, 9218868437227405312
  %cmp4 = icmp eq i64 %and.i.165, 9218868437227405312
  br i1 %cmp4, label %land.lhs.true.5, label %if.end.17

land.lhs.true.5:                                  ; preds = %lor.lhs.false
  %and.i.162 = and i32 %b.sroa.0.0.extract.trunc, 1048575
  %or8 = or i32 %and.i.162, %b.sroa.9.0.extract.trunc
  %tobool9 = icmp eq i32 %or8, 0
  br i1 %tobool9, label %if.end.17, label %if.then

if.then:                                          ; preds = %land.lhs.true, %land.lhs.true.5
  %and.i.151 = and i64 %a.sroa.0.0.insert.shift, 9221120237041090560
  %cmp.i.152 = icmp eq i64 %and.i.151, 9218868437227405312
  br i1 %cmp.i.152, label %land.rhs.i.155, label %lor.lhs.false.12

land.rhs.i.155:                                   ; preds = %if.then
  %tobool.i.154 = icmp eq i32 %a.sroa.9.0.extract.trunc, 0
  %and2.i.156 = and i64 %a.sroa.0.0.insert.shift, 2251795518717952
  %tobool3.i.157 = icmp eq i64 %and2.i.156, 0
  %or.cond = and i1 %tobool.i.154, %tobool3.i.157
  br i1 %or.cond, label %lor.lhs.false.12, label %if.then.16

lor.lhs.false.12:                                 ; preds = %land.rhs.i.155, %if.then
  %b.sroa.0.0.insert.shift68 = shl nuw i64 %b.sroa.0.0.extract.shift, 32
  %and.i.146 = and i64 %b.sroa.0.0.insert.shift68, 9221120237041090560
  %cmp.i.147 = icmp eq i64 %and.i.146, 9218868437227405312
  br i1 %cmp.i.147, label %land.rhs.i.148, label %cleanup

land.rhs.i.148:                                   ; preds = %lor.lhs.false.12
  %tobool.i = icmp eq i32 %b.sroa.9.0.extract.trunc, 0
  %and2.i = and i64 %b.sroa.0.0.insert.shift68, 2251795518717952
  %tobool3.i = icmp eq i64 %and2.i, 0
  %or.cond176 = and i1 %tobool.i, %tobool3.i
  br i1 %or.cond176, label %cleanup, label %if.then.16

if.then.16:                                       ; preds = %land.rhs.i.148, %land.rhs.i.155
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.17:                                        ; preds = %land.lhs.true.5, %lor.lhs.false
  %a.sroa.0.0.extract.shift.i.144 = lshr i64 %a.coerce, 63
  %conv.i.145 = trunc i64 %a.sroa.0.0.extract.shift.i.144 to i8
  %a.sroa.0.0.extract.shift.i.143 = lshr i64 %b.coerce, 63
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i.143 to i8
  %cmp22 = icmp eq i8 %conv.i.145, %conv.i
  %tobool26 = icmp ne i8 %conv.i.145, 0
  br i1 %cmp22, label %if.end.35, label %if.then.24

if.then.24:                                       ; preds = %if.end.17
  br i1 %tobool26, label %cleanup, label %lor.rhs

lor.rhs:                                          ; preds = %if.then.24
  %or28135 = or i64 %b.sroa.0.0.extract.shift, %a.sroa.0.0.extract.shift
  %or28 = trunc i64 %or28135 to i32
  %shl = shl i32 %or28, 1
  %or29177 = or i64 %b.coerce, %a.coerce
  %or29 = trunc i64 %or29177 to i32
  %or31 = or i32 %or29, %shl
  %cmp32 = icmp eq i32 %or31, 0
  %phitmp = zext i1 %cmp32 to i8
  br label %cleanup

if.end.35:                                        ; preds = %if.end.17
  br i1 %tobool26, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end.35
  %cmp.i.136 = icmp ult i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp.i.136, label %cleanup, label %lor.rhs.i.138

lor.rhs.i.138:                                    ; preds = %cond.true
  %cmp1.i.137 = icmp eq i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp1.i.137, label %land.rhs.i.141, label %cleanup

land.rhs.i.141:                                   ; preds = %lor.rhs.i.138
  %cmp2.i.139 = icmp ule i32 %b.sroa.9.0.extract.trunc, %a.sroa.9.0.extract.trunc
  %phitmp.i.140 = zext i1 %cmp2.i.139 to i8
  br label %cleanup

cond.false:                                       ; preds = %if.end.35
  %cmp.i = icmp ult i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp.i, label %cleanup, label %lor.rhs.i

lor.rhs.i:                                        ; preds = %cond.false
  %cmp1.i = icmp eq i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp1.i, label %land.rhs.i, label %cleanup

land.rhs.i:                                       ; preds = %lor.rhs.i
  %cmp2.i = icmp ule i32 %a.sroa.9.0.extract.trunc, %b.sroa.9.0.extract.trunc
  %phitmp.i = zext i1 %cmp2.i to i8
  br label %cleanup

cleanup:                                          ; preds = %land.rhs.i.148, %lor.lhs.false.12, %land.rhs.i, %lor.rhs.i, %cond.false, %land.rhs.i.141, %lor.rhs.i.138, %cond.true, %if.then.24, %lor.rhs, %if.then.16
  %retval.0 = phi i8 [ 0, %if.then.16 ], [ 1, %if.then.24 ], [ %phitmp, %lor.rhs ], [ 1, %cond.true ], [ 0, %lor.rhs.i.138 ], [ %phitmp.i.140, %land.rhs.i.141 ], [ 1, %cond.false ], [ 0, %lor.rhs.i ], [ %phitmp.i, %land.rhs.i ], [ 0, %lor.lhs.false.12 ], [ 0, %land.rhs.i.148 ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float64_lt_quiet(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %a.sroa.9.0.extract.trunc = trunc i64 %a.coerce to i32
  %b.sroa.0.0.extract.shift = lshr i64 %b.coerce, 32
  %b.sroa.0.0.extract.trunc = trunc i64 %b.sroa.0.0.extract.shift to i32
  %b.sroa.9.0.extract.trunc = trunc i64 %b.coerce to i32
  %a.sroa.0.0.insert.shift = shl nuw i64 %a.sroa.0.0.extract.shift, 32
  %and.i = and i64 %a.coerce, 9218868437227405312
  %cmp = icmp eq i64 %and.i, 9218868437227405312
  br i1 %cmp, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %entry
  %and.i.169 = and i32 %a.sroa.0.0.extract.trunc, 1048575
  %or = or i32 %and.i.169, %a.sroa.9.0.extract.trunc
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %land.lhs.true, %entry
  %and.i.165 = and i64 %b.coerce, 9218868437227405312
  %cmp4 = icmp eq i64 %and.i.165, 9218868437227405312
  br i1 %cmp4, label %land.lhs.true.5, label %if.end.17

land.lhs.true.5:                                  ; preds = %lor.lhs.false
  %and.i.162 = and i32 %b.sroa.0.0.extract.trunc, 1048575
  %or8 = or i32 %and.i.162, %b.sroa.9.0.extract.trunc
  %tobool9 = icmp eq i32 %or8, 0
  br i1 %tobool9, label %if.end.17, label %if.then

if.then:                                          ; preds = %land.lhs.true, %land.lhs.true.5
  %and.i.151 = and i64 %a.sroa.0.0.insert.shift, 9221120237041090560
  %cmp.i.152 = icmp eq i64 %and.i.151, 9218868437227405312
  br i1 %cmp.i.152, label %land.rhs.i.155, label %lor.lhs.false.12

land.rhs.i.155:                                   ; preds = %if.then
  %tobool.i.154 = icmp eq i32 %a.sroa.9.0.extract.trunc, 0
  %and2.i.156 = and i64 %a.sroa.0.0.insert.shift, 2251795518717952
  %tobool3.i.157 = icmp eq i64 %and2.i.156, 0
  %or.cond = and i1 %tobool.i.154, %tobool3.i.157
  br i1 %or.cond, label %lor.lhs.false.12, label %if.then.16

lor.lhs.false.12:                                 ; preds = %land.rhs.i.155, %if.then
  %b.sroa.0.0.insert.shift68 = shl nuw i64 %b.sroa.0.0.extract.shift, 32
  %and.i.146 = and i64 %b.sroa.0.0.insert.shift68, 9221120237041090560
  %cmp.i.147 = icmp eq i64 %and.i.146, 9218868437227405312
  br i1 %cmp.i.147, label %land.rhs.i.148, label %cleanup

land.rhs.i.148:                                   ; preds = %lor.lhs.false.12
  %tobool.i = icmp eq i32 %b.sroa.9.0.extract.trunc, 0
  %and2.i = and i64 %b.sroa.0.0.insert.shift68, 2251795518717952
  %tobool3.i = icmp eq i64 %and2.i, 0
  %or.cond176 = and i1 %tobool.i, %tobool3.i
  br i1 %or.cond176, label %cleanup, label %if.then.16

if.then.16:                                       ; preds = %land.rhs.i.148, %land.rhs.i.155
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end.17:                                        ; preds = %land.lhs.true.5, %lor.lhs.false
  %a.sroa.0.0.extract.shift.i.144 = lshr i64 %a.coerce, 63
  %conv.i.145 = trunc i64 %a.sroa.0.0.extract.shift.i.144 to i8
  %a.sroa.0.0.extract.shift.i.143 = lshr i64 %b.coerce, 63
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i.143 to i8
  %cmp22 = icmp eq i8 %conv.i.145, %conv.i
  %tobool26 = icmp ne i8 %conv.i.145, 0
  br i1 %cmp22, label %if.end.35, label %if.then.24

if.then.24:                                       ; preds = %if.end.17
  br i1 %tobool26, label %land.rhs, label %cleanup

land.rhs:                                         ; preds = %if.then.24
  %or28135 = or i64 %b.sroa.0.0.extract.shift, %a.sroa.0.0.extract.shift
  %or28 = trunc i64 %or28135 to i32
  %shl = shl i32 %or28, 1
  %or29177 = or i64 %b.coerce, %a.coerce
  %or29 = trunc i64 %or29177 to i32
  %or31 = or i32 %or29, %shl
  %cmp32 = icmp ne i32 %or31, 0
  %phitmp = zext i1 %cmp32 to i8
  br label %cleanup

if.end.35:                                        ; preds = %if.end.17
  br i1 %tobool26, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end.35
  %cmp.i.136 = icmp ult i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp.i.136, label %cleanup, label %lor.rhs.i.138

lor.rhs.i.138:                                    ; preds = %cond.true
  %cmp1.i.137 = icmp eq i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp1.i.137, label %land.rhs.i.141, label %cleanup

land.rhs.i.141:                                   ; preds = %lor.rhs.i.138
  %cmp2.i.139 = icmp ult i32 %b.sroa.9.0.extract.trunc, %a.sroa.9.0.extract.trunc
  %phitmp.i.140 = zext i1 %cmp2.i.139 to i8
  br label %cleanup

cond.false:                                       ; preds = %if.end.35
  %cmp.i = icmp ult i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp.i, label %cleanup, label %lor.rhs.i

lor.rhs.i:                                        ; preds = %cond.false
  %cmp1.i = icmp eq i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp1.i, label %land.rhs.i, label %cleanup

land.rhs.i:                                       ; preds = %lor.rhs.i
  %cmp2.i = icmp ult i32 %a.sroa.9.0.extract.trunc, %b.sroa.9.0.extract.trunc
  %phitmp.i = zext i1 %cmp2.i to i8
  br label %cleanup

cleanup:                                          ; preds = %land.rhs.i.148, %lor.lhs.false.12, %land.rhs.i, %lor.rhs.i, %cond.false, %land.rhs.i.141, %lor.rhs.i.138, %cond.true, %if.then.24, %land.rhs, %if.then.16
  %retval.0 = phi i8 [ 0, %if.then.16 ], [ 0, %if.then.24 ], [ %phitmp, %land.rhs ], [ 1, %cond.true ], [ 0, %lor.rhs.i.138 ], [ %phitmp.i.140, %land.rhs.i.141 ], [ 1, %cond.false ], [ 0, %lor.rhs.i ], [ %phitmp.i, %land.rhs.i ], [ 0, %lor.lhs.false.12 ], [ 0, %land.rhs.i.148 ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float32_gt(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 2139095040
  %cmp = icmp ne i32 %and.i, 2139095040
  %and.i.49 = and i32 %a, 8388607
  %tobool = icmp eq i32 %and.i.49, 0
  %or.cond = or i1 %cmp, %tobool
  br i1 %or.cond, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %and.i.48 = and i32 %b, 2139095040
  %cmp3 = icmp ne i32 %and.i.48, 2139095040
  %and.i.46 = and i32 %b, 8388607
  %tobool6 = icmp eq i32 %and.i.46, 0
  %or.cond50 = or i1 %cmp3, %tobool6
  br i1 %or.cond50, label %if.end, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end:                                           ; preds = %lor.lhs.false
  %shr.i.44 = lshr i32 %a, 31
  %conv.i.45 = trunc i32 %shr.i.44 to i8
  %shr.i.43 = lshr i32 %b, 31
  %conv.i = trunc i32 %shr.i.43 to i8
  %cmp10 = icmp eq i8 %conv.i.45, %conv.i
  br i1 %cmp10, label %if.end.18, label %if.then.12

if.then.12:                                       ; preds = %if.end
  %tobool14 = icmp eq i8 %conv.i.45, 0
  br i1 %tobool14, label %cleanup, label %land.rhs

land.rhs:                                         ; preds = %if.then.12
  %or = or i32 %b, %a
  %shl.mask = and i32 %or, 2147483647
  %cmp15 = icmp ne i32 %shl.mask, 0
  %phitmp42 = zext i1 %cmp15 to i8
  br label %cleanup

if.end.18:                                        ; preds = %if.end
  %cmp19 = icmp eq i32 %a, %b
  %cmp23 = icmp ugt i32 %a, %b
  %conv24 = zext i1 %cmp23 to i32
  %tobool25 = icmp ne i32 %shr.i.44, %conv24
  %phitmp = zext i1 %tobool25 to i8
  %1 = select i1 %cmp19, i8 0, i8 %phitmp
  br label %cleanup

cleanup:                                          ; preds = %if.end.18, %land.rhs, %if.then.12, %if.then
  %retval.0 = phi i8 [ 0, %if.then ], [ 0, %if.then.12 ], [ %phitmp42, %land.rhs ], [ %1, %if.end.18 ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float32_ge(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 2139095040
  %cmp = icmp ne i32 %and.i, 2139095040
  %and.i.49 = and i32 %a, 8388607
  %tobool = icmp eq i32 %and.i.49, 0
  %or.cond = or i1 %cmp, %tobool
  br i1 %or.cond, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %and.i.48 = and i32 %b, 2139095040
  %cmp3 = icmp ne i32 %and.i.48, 2139095040
  %and.i.46 = and i32 %b, 8388607
  %tobool6 = icmp eq i32 %and.i.46, 0
  %or.cond50 = or i1 %cmp3, %tobool6
  br i1 %or.cond50, label %if.end, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end:                                           ; preds = %lor.lhs.false
  %shr.i.44 = lshr i32 %a, 31
  %conv.i.45 = trunc i32 %shr.i.44 to i8
  %shr.i.43 = lshr i32 %b, 31
  %conv.i = trunc i32 %shr.i.43 to i8
  %cmp10 = icmp eq i8 %conv.i.45, %conv.i
  br i1 %cmp10, label %if.end.18, label %if.then.12

if.then.12:                                       ; preds = %if.end
  %tobool14 = icmp eq i8 %conv.i.45, 0
  br i1 %tobool14, label %lor.rhs, label %cleanup

lor.rhs:                                          ; preds = %if.then.12
  %or = or i32 %b, %a
  %shl.mask = and i32 %or, 2147483647
  %cmp15 = icmp eq i32 %shl.mask, 0
  %phitmp42 = zext i1 %cmp15 to i8
  br label %cleanup

if.end.18:                                        ; preds = %if.end
  %cmp19 = icmp eq i32 %a, %b
  %cmp23 = icmp ugt i32 %a, %b
  %conv24 = zext i1 %cmp23 to i32
  %tobool25 = icmp ne i32 %shr.i.44, %conv24
  %phitmp = zext i1 %tobool25 to i8
  %1 = select i1 %cmp19, i8 1, i8 %phitmp
  br label %cleanup

cleanup:                                          ; preds = %if.end.18, %lor.rhs, %if.then.12, %if.then
  %retval.0 = phi i8 [ 0, %if.then ], [ 1, %if.then.12 ], [ %phitmp42, %lor.rhs ], [ %1, %if.end.18 ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float64_gt(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %a.sroa.8.0.extract.trunc = trunc i64 %a.coerce to i32
  %b.sroa.0.0.extract.shift = lshr i64 %b.coerce, 32
  %b.sroa.0.0.extract.trunc = trunc i64 %b.sroa.0.0.extract.shift to i32
  %b.sroa.8.0.extract.trunc = trunc i64 %b.coerce to i32
  %and.i = and i64 %a.coerce, 9218868437227405312
  %cmp = icmp eq i64 %and.i, 9218868437227405312
  br i1 %cmp, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %entry
  %and.i.129 = and i32 %a.sroa.0.0.extract.trunc, 1048575
  %or = or i32 %and.i.129, %a.sroa.8.0.extract.trunc
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %land.lhs.true, %entry
  %and.i.125 = and i64 %b.coerce, 9218868437227405312
  %cmp4 = icmp eq i64 %and.i.125, 9218868437227405312
  br i1 %cmp4, label %land.lhs.true.5, label %if.end

land.lhs.true.5:                                  ; preds = %lor.lhs.false
  %and.i.122 = and i32 %b.sroa.0.0.extract.trunc, 1048575
  %or8 = or i32 %and.i.122, %b.sroa.8.0.extract.trunc
  %tobool9 = icmp eq i32 %or8, 0
  br i1 %tobool9, label %if.end, label %if.then

if.then:                                          ; preds = %land.lhs.true, %land.lhs.true.5
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end:                                           ; preds = %land.lhs.true.5, %lor.lhs.false
  %a.sroa.0.0.extract.shift.i.119 = lshr i64 %a.coerce, 63
  %conv.i.120 = trunc i64 %a.sroa.0.0.extract.shift.i.119 to i8
  %a.sroa.0.0.extract.shift.i.118 = lshr i64 %b.coerce, 63
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i.118 to i8
  %cmp13 = icmp eq i8 %conv.i.120, %conv.i
  %tobool17 = icmp ne i8 %conv.i.120, 0
  br i1 %cmp13, label %if.end.26, label %if.then.15

if.then.15:                                       ; preds = %if.end
  br i1 %tobool17, label %land.rhs, label %cleanup

land.rhs:                                         ; preds = %if.then.15
  %or19110 = or i64 %b.sroa.0.0.extract.shift, %a.sroa.0.0.extract.shift
  %or19 = trunc i64 %or19110 to i32
  %shl = shl i32 %or19, 1
  %or20130 = or i64 %b.coerce, %a.coerce
  %or20 = trunc i64 %or20130 to i32
  %or22 = or i32 %or20, %shl
  %cmp23 = icmp ne i32 %or22, 0
  %phitmp = zext i1 %cmp23 to i8
  br label %cleanup

if.end.26:                                        ; preds = %if.end
  br i1 %tobool17, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end.26
  %cmp.i.111 = icmp ult i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp.i.111, label %cond.end, label %lor.rhs.i.113

lor.rhs.i.113:                                    ; preds = %cond.true
  %cmp1.i.112 = icmp eq i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp1.i.112, label %land.rhs.i.116, label %cond.end

land.rhs.i.116:                                   ; preds = %lor.rhs.i.113
  %cmp2.i.114 = icmp ule i32 %b.sroa.8.0.extract.trunc, %a.sroa.8.0.extract.trunc
  %phitmp.i.115 = zext i1 %cmp2.i.114 to i8
  br label %cond.end

cond.false:                                       ; preds = %if.end.26
  %cmp.i = icmp ult i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp.i, label %cond.end, label %lor.rhs.i

lor.rhs.i:                                        ; preds = %cond.false
  %cmp1.i = icmp eq i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp1.i, label %land.rhs.i, label %cond.end

land.rhs.i:                                       ; preds = %lor.rhs.i
  %cmp2.i = icmp ule i32 %a.sroa.8.0.extract.trunc, %b.sroa.8.0.extract.trunc
  %phitmp.i = zext i1 %cmp2.i to i8
  br label %cond.end

cond.end:                                         ; preds = %land.rhs.i, %lor.rhs.i, %cond.false, %land.rhs.i.116, %lor.rhs.i.113, %cond.true
  %call33.sink = phi i8 [ 1, %cond.true ], [ 0, %lor.rhs.i.113 ], [ %phitmp.i.115, %land.rhs.i.116 ], [ 1, %cond.false ], [ 0, %lor.rhs.i ], [ %phitmp.i, %land.rhs.i ]
  %1 = xor i8 %call33.sink, 1
  br label %cleanup

cleanup:                                          ; preds = %if.then.15, %land.rhs, %cond.end, %if.then
  %retval.0 = phi i8 [ 0, %if.then ], [ %1, %cond.end ], [ 0, %if.then.15 ], [ %phitmp, %land.rhs ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float64_ge(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %a.sroa.8.0.extract.trunc = trunc i64 %a.coerce to i32
  %b.sroa.0.0.extract.shift = lshr i64 %b.coerce, 32
  %b.sroa.0.0.extract.trunc = trunc i64 %b.sroa.0.0.extract.shift to i32
  %b.sroa.8.0.extract.trunc = trunc i64 %b.coerce to i32
  %and.i = and i64 %a.coerce, 9218868437227405312
  %cmp = icmp eq i64 %and.i, 9218868437227405312
  br i1 %cmp, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %entry
  %and.i.129 = and i32 %a.sroa.0.0.extract.trunc, 1048575
  %or = or i32 %and.i.129, %a.sroa.8.0.extract.trunc
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %land.lhs.true, %entry
  %and.i.125 = and i64 %b.coerce, 9218868437227405312
  %cmp4 = icmp eq i64 %and.i.125, 9218868437227405312
  br i1 %cmp4, label %land.lhs.true.5, label %if.end

land.lhs.true.5:                                  ; preds = %lor.lhs.false
  %and.i.122 = and i32 %b.sroa.0.0.extract.trunc, 1048575
  %or8 = or i32 %and.i.122, %b.sroa.8.0.extract.trunc
  %tobool9 = icmp eq i32 %or8, 0
  br i1 %tobool9, label %if.end, label %if.then

if.then:                                          ; preds = %land.lhs.true, %land.lhs.true.5
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %cleanup

if.end:                                           ; preds = %land.lhs.true.5, %lor.lhs.false
  %a.sroa.0.0.extract.shift.i.119 = lshr i64 %a.coerce, 63
  %conv.i.120 = trunc i64 %a.sroa.0.0.extract.shift.i.119 to i8
  %a.sroa.0.0.extract.shift.i.118 = lshr i64 %b.coerce, 63
  %conv.i = trunc i64 %a.sroa.0.0.extract.shift.i.118 to i8
  %cmp13 = icmp eq i8 %conv.i.120, %conv.i
  %tobool17 = icmp ne i8 %conv.i.120, 0
  br i1 %cmp13, label %if.end.26, label %if.then.15

if.then.15:                                       ; preds = %if.end
  br i1 %tobool17, label %cleanup, label %lor.rhs

lor.rhs:                                          ; preds = %if.then.15
  %or19110 = or i64 %b.sroa.0.0.extract.shift, %a.sroa.0.0.extract.shift
  %or19 = trunc i64 %or19110 to i32
  %shl = shl i32 %or19, 1
  %or20130 = or i64 %b.coerce, %a.coerce
  %or20 = trunc i64 %or20130 to i32
  %or22 = or i32 %or20, %shl
  %cmp23 = icmp eq i32 %or22, 0
  %phitmp = zext i1 %cmp23 to i8
  br label %cleanup

if.end.26:                                        ; preds = %if.end
  br i1 %tobool17, label %cond.true, label %cond.false

cond.true:                                        ; preds = %if.end.26
  %cmp.i.111 = icmp ult i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp.i.111, label %cond.end, label %lor.rhs.i.113

lor.rhs.i.113:                                    ; preds = %cond.true
  %cmp1.i.112 = icmp eq i32 %b.sroa.0.0.extract.trunc, %a.sroa.0.0.extract.trunc
  br i1 %cmp1.i.112, label %land.rhs.i.116, label %cond.end

land.rhs.i.116:                                   ; preds = %lor.rhs.i.113
  %cmp2.i.114 = icmp ult i32 %b.sroa.8.0.extract.trunc, %a.sroa.8.0.extract.trunc
  %phitmp.i.115 = zext i1 %cmp2.i.114 to i8
  br label %cond.end

cond.false:                                       ; preds = %if.end.26
  %cmp.i = icmp ult i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp.i, label %cond.end, label %lor.rhs.i

lor.rhs.i:                                        ; preds = %cond.false
  %cmp1.i = icmp eq i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp1.i, label %land.rhs.i, label %cond.end

land.rhs.i:                                       ; preds = %lor.rhs.i
  %cmp2.i = icmp ult i32 %a.sroa.8.0.extract.trunc, %b.sroa.8.0.extract.trunc
  %phitmp.i = zext i1 %cmp2.i to i8
  br label %cond.end

cond.end:                                         ; preds = %land.rhs.i, %lor.rhs.i, %cond.false, %land.rhs.i.116, %lor.rhs.i.113, %cond.true
  %call33.sink = phi i8 [ 1, %cond.true ], [ 0, %lor.rhs.i.113 ], [ %phitmp.i.115, %land.rhs.i.116 ], [ 1, %cond.false ], [ 0, %lor.rhs.i ], [ %phitmp.i, %land.rhs.i ]
  %1 = xor i8 %call33.sink, 1
  br label %cleanup

cleanup:                                          ; preds = %if.then.15, %lor.rhs, %cond.end, %if.then
  %retval.0 = phi i8 [ 0, %if.then ], [ %1, %cond.end ], [ 1, %if.then.15 ], [ %phitmp, %lor.rhs ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float32_neq(i32 zeroext %a, i32 zeroext %b) #2 {
entry:
  %and.i = and i32 %a, 2139095040
  %cmp = icmp ne i32 %and.i, 2139095040
  %and.i.38 = and i32 %a, 8388607
  %tobool = icmp eq i32 %and.i.38, 0
  %or.cond = or i1 %cmp, %tobool
  br i1 %or.cond, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %entry
  %and.i.37 = and i32 %b, 2139095040
  %cmp3 = icmp ne i32 %and.i.37, 2139095040
  %and.i.35 = and i32 %b, 8388607
  %tobool6 = icmp eq i32 %and.i.35, 0
  %or.cond39 = or i1 %cmp3, %tobool6
  br i1 %or.cond39, label %if.end.14, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %entry
  %and.i.30 = and i32 %a, 2143289344
  %and1.i.32 = and i32 %a, 4194303
  %tobool840 = icmp eq i32 %and1.i.32, 0
  %not.cmp.i.31 = icmp ne i32 %and.i.30, 2139095040
  %tobool8 = or i1 %not.cmp.i.31, %tobool840
  br i1 %tobool8, label %lor.lhs.false.9, label %if.then.13

lor.lhs.false.9:                                  ; preds = %if.then
  %and.i.29 = and i32 %b, 2143289344
  %and1.i = and i32 %b, 4194303
  %tobool1241 = icmp eq i32 %and1.i, 0
  %not.cmp.i = icmp ne i32 %and.i.29, 2139095040
  %tobool12 = or i1 %not.cmp.i, %tobool1241
  br i1 %tobool12, label %return, label %if.then.13

if.then.13:                                       ; preds = %lor.lhs.false.9, %if.then
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %return

if.end.14:                                        ; preds = %lor.lhs.false
  %cmp15 = icmp eq i32 %a, %b
  br i1 %cmp15, label %return, label %lor.rhs

lor.rhs:                                          ; preds = %if.end.14
  %or = or i32 %b, %a
  %shl.mask = and i32 %or, 2147483647
  %phitmp = icmp ne i32 %shl.mask, 0
  %phitmp28 = zext i1 %phitmp to i8
  br label %return

return:                                           ; preds = %if.end.14, %lor.rhs, %if.then.13, %lor.lhs.false.9
  %retval.0 = phi i8 [ 1, %lor.lhs.false.9 ], [ 1, %if.then.13 ], [ 0, %if.end.14 ], [ %phitmp28, %lor.rhs ]
  ret i8 %retval.0
}

; Function Attrs: nounwind
define signext i8 @float64_neq(i64 %a.coerce, i64 %b.coerce) #2 {
entry:
  %a.sroa.0.0.extract.shift = lshr i64 %a.coerce, 32
  %a.sroa.0.0.extract.trunc = trunc i64 %a.sroa.0.0.extract.shift to i32
  %a.sroa.7.0.extract.trunc = trunc i64 %a.coerce to i32
  %b.sroa.0.0.extract.shift = lshr i64 %b.coerce, 32
  %b.sroa.0.0.extract.trunc = trunc i64 %b.sroa.0.0.extract.shift to i32
  %b.sroa.7.0.extract.trunc = trunc i64 %b.coerce to i32
  %a.sroa.0.0.insert.shift = shl nuw i64 %a.sroa.0.0.extract.shift, 32
  %and.i = and i64 %a.coerce, 9218868437227405312
  %cmp = icmp eq i64 %and.i, 9218868437227405312
  br i1 %cmp, label %land.lhs.true, label %lor.lhs.false

land.lhs.true:                                    ; preds = %entry
  %and.i.115 = and i32 %a.sroa.0.0.extract.trunc, 1048575
  %or = or i32 %and.i.115, %a.sroa.7.0.extract.trunc
  %tobool = icmp eq i32 %or, 0
  br i1 %tobool, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %land.lhs.true, %entry
  %and.i.111 = and i64 %b.coerce, 9218868437227405312
  %cmp4 = icmp eq i64 %and.i.111, 9218868437227405312
  br i1 %cmp4, label %land.lhs.true.5, label %if.end.17

land.lhs.true.5:                                  ; preds = %lor.lhs.false
  %and.i.108 = and i32 %b.sroa.0.0.extract.trunc, 1048575
  %or8 = or i32 %and.i.108, %b.sroa.7.0.extract.trunc
  %tobool9 = icmp eq i32 %or8, 0
  br i1 %tobool9, label %if.end.17, label %if.then

if.then:                                          ; preds = %land.lhs.true, %land.lhs.true.5
  %and.i.97 = and i64 %a.sroa.0.0.insert.shift, 9221120237041090560
  %cmp.i.98 = icmp eq i64 %and.i.97, 9218868437227405312
  br i1 %cmp.i.98, label %land.rhs.i.101, label %lor.lhs.false.12

land.rhs.i.101:                                   ; preds = %if.then
  %tobool.i.100 = icmp eq i32 %a.sroa.7.0.extract.trunc, 0
  %and2.i.102 = and i64 %a.sroa.0.0.insert.shift, 2251795518717952
  %tobool3.i.103 = icmp eq i64 %and2.i.102, 0
  %or.cond = and i1 %tobool.i.100, %tobool3.i.103
  br i1 %or.cond, label %lor.lhs.false.12, label %if.then.16

lor.lhs.false.12:                                 ; preds = %land.rhs.i.101, %if.then
  %b.sroa.0.0.insert.shift49 = shl nuw i64 %b.sroa.0.0.extract.shift, 32
  %and.i.96 = and i64 %b.sroa.0.0.insert.shift49, 9221120237041090560
  %cmp.i = icmp eq i64 %and.i.96, 9218868437227405312
  br i1 %cmp.i, label %land.rhs.i, label %return

land.rhs.i:                                       ; preds = %lor.lhs.false.12
  %tobool.i = icmp eq i32 %b.sroa.7.0.extract.trunc, 0
  %and2.i = and i64 %b.sroa.0.0.insert.shift49, 2251795518717952
  %tobool3.i = icmp eq i64 %and2.i, 0
  %or.cond122 = and i1 %tobool.i, %tobool3.i
  br i1 %or.cond122, label %return, label %if.then.16

if.then.16:                                       ; preds = %land.rhs.i, %land.rhs.i.101
  %0 = load i8, i8* @float_exception_flags, align 1, !tbaa !5
  %or3.i = or i8 %0, 1
  store i8 %or3.i, i8* @float_exception_flags, align 1, !tbaa !5
  br label %return

if.end.17:                                        ; preds = %land.lhs.true.5, %lor.lhs.false
  %cmp19 = icmp eq i32 %a.sroa.7.0.extract.trunc, %b.sroa.7.0.extract.trunc
  br i1 %cmp19, label %land.rhs, label %return

land.rhs:                                         ; preds = %if.end.17
  %cmp22 = icmp eq i32 %a.sroa.0.0.extract.trunc, %b.sroa.0.0.extract.trunc
  br i1 %cmp22, label %return, label %lor.rhs

lor.rhs:                                          ; preds = %land.rhs
  %cmp25 = icmp eq i32 %a.sroa.7.0.extract.trunc, 0
  br i1 %cmp25, label %land.rhs.27, label %return

land.rhs.27:                                      ; preds = %lor.rhs
  %or3095 = or i64 %b.sroa.0.0.extract.shift, %a.sroa.0.0.extract.shift
  %shl.mask = and i64 %or3095, 2147483647
  %phitmp = icmp ne i64 %shl.mask, 0
  %phitmp94 = zext i1 %phitmp to i8
  br label %return

return:                                           ; preds = %land.rhs.i, %lor.lhs.false.12, %if.end.17, %lor.rhs, %land.rhs.27, %land.rhs, %if.then.16
  %retval.0 = phi i8 [ 1, %if.then.16 ], [ 1, %if.end.17 ], [ 0, %land.rhs ], [ 1, %lor.rhs ], [ %phitmp94, %land.rhs.27 ], [ 1, %lor.lhs.false.12 ], [ 1, %land.rhs.i ]
  ret i8 %retval.0
}

attributes #0 = { inlinehint nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { inlinehint nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"int", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!3, !3, i64 0}
!6 = !{!7, !7, i64 0}
!7 = !{!"short", !3, i64 0}
