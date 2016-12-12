; ModuleID = 'marker.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-unknown-linux-gnu"

@markerdata = global [210 x i16] [i16 -60, i16 418, i16 0, i16 261, i16 257, i16 257, i16 257, i16 0, i16 0, i16 0, i16 0, i16 258, i16 772, i16 1286, i16 1800, i16 2314, i16 2817, i16 3, i16 257, i16 257, i16 257, i16 257, i16 256, i16 0, i16 0, i16 1, i16 515, i16 1029, i16 1543, i16 2057, i16 2571, i16 4096, i16 513, i16 771, i16 516, i16 773, i16 1284, i16 1024, i16 1, i16 32001, i16 515, i16 4, i16 4357, i16 4641, i16 12609, i16 1555, i16 20833, i16 1826, i16 28948, i16 12929, i16 -28255, i16 2083, i16 17073, i16 -16107, i16 21201, i16 -4060, i16 13154, i16 29314, i16 2314, i16 5655, i16 6169, i16 6693, i16 9767, i16 10281, i16 10804, i16 13622, i16 14136, i16 14650, i16 17220, i16 17734, i16 18248, i16 18762, i16 21332, i16 21846, i16 22360, i16 22874, i16 25444, i16 25958, i16 26472, i16 26986, i16 29556, i16 30070, i16 30584, i16 31098, i16 -31868, i16 -31354, i16 -30840, i16 -30326, i16 -28013, i16 -27499, i16 -26985, i16 -26471, i16 -25950, i16 -23644, i16 -23130, i16 -22616, i16 -22102, i16 -19789, i16 -19275, i16 -18761, i16 -18247, i16 -17726, i16 -15420, i16 -14906, i16 -14392, i16 -13878, i16 -11565, i16 -11051, i16 -10537, i16 -10023, i16 -9503, i16 -7453, i16 -6939, i16 -6425, i16 -5911, i16 -5391, i16 -3341, i16 -2827, i16 -2313, i16 -1799, i16 -1519, i16 2, i16 258, i16 1028, i16 772, i16 1797, i16 1028, i16 1, i16 631, i16 1, i16 515, i16 4356, i16 1313, i16 12550, i16 4673, i16 20743, i16 24945, i16 4898, i16 12929, i16 2068, i16 17041, i16 -24143, i16 -16119, i16 9011, i16 21232, i16 5474, i16 29393, i16 2582, i16 9268, i16 -7899, i16 -3817, i16 6169, i16 6694, i16 10024, i16 10538, i16 13622, i16 14136, i16 14650, i16 17220, i16 17734, i16 18248, i16 18762, i16 21332, i16 21846, i16 22360, i16 22874, i16 25444, i16 25958, i16 26472, i16 26986, i16 29556, i16 30070, i16 30584, i16 31098, i16 -32125, i16 -31611, i16 -31097, i16 -30583, i16 -30062, i16 -27756, i16 -27242, i16 -26728, i16 -26214, i16 -23901, i16 -23387, i16 -22873, i16 -22359, i16 -21838, i16 -19532, i16 -19018, i16 -18504, i16 -17990, i16 -15677, i16 -15163, i16 -14649, i16 -14135, i16 -13614, i16 -11308, i16 -10794, i16 -10280, i16 -9766, i16 -7453, i16 -6939, i16 -6425, i16 -5911, i16 -5390, i16 -3084, i16 -2570, i16 -2056, i16 -1542], align 2
@Lqt = external global [64 x i8], align 1
@Cqt = external global [64 x i8], align 1

; Function Attrs: nounwind
define i32 @writeMarkers(i8* %outoutBuffer, i32 %imageFormat, i32 %width, i32 %height) #0 {
entry:
  store i8 -1, i8* %outoutBuffer, align 1, !tbaa !1
  %arrayidx2 = getelementptr inbounds i8, i8* %outoutBuffer, i32 1
  store i8 -40, i8* %arrayidx2, align 1, !tbaa !1
  %arrayidx4 = getelementptr inbounds i8, i8* %outoutBuffer, i32 2
  store i8 -1, i8* %arrayidx4, align 1, !tbaa !1
  %arrayidx6 = getelementptr inbounds i8, i8* %outoutBuffer, i32 3
  store i8 -37, i8* %arrayidx6, align 1, !tbaa !1
  %arrayidx8 = getelementptr inbounds i8, i8* %outoutBuffer, i32 4
  store i8 0, i8* %arrayidx8, align 1, !tbaa !1
  %arrayidx10 = getelementptr inbounds i8, i8* %outoutBuffer, i32 5
  store i8 -124, i8* %arrayidx10, align 1, !tbaa !1
  %arrayidx12 = getelementptr inbounds i8, i8* %outoutBuffer, i32 6
  store i8 0, i8* %arrayidx12, align 1, !tbaa !1
  %scevgep = getelementptr i8, i8* %outoutBuffer, i32 7
  %scevgep287 = getelementptr i8, i8* %outoutBuffer, i32 70
  %bound0 = icmp ule i8* %scevgep, getelementptr inbounds ([64 x i8], [64 x i8]* @Lqt, i32 0, i32 63)
  %bound1 = icmp uge i8* %scevgep287, getelementptr inbounds ([64 x i8], [64 x i8]* @Lqt, i32 0, i32 0)
  %memcheck.conflict = and i1 %bound0, %bound1
  br i1 %memcheck.conflict, label %middle.block, label %vector.body.preheader

vector.body.preheader:                            ; preds = %entry
  br label %vector.body

vector.body:                                      ; preds = %vector.body.preheader
  %wide.load = load <16 x i8>, <16 x i8>* bitcast ([64 x i8]* @Lqt to <16 x i8>*), align 1, !tbaa !1
  %0 = getelementptr inbounds i8, i8* %outoutBuffer, i32 7
  %1 = bitcast i8* %0 to <16 x i8>*
  store <16 x i8> %wide.load, <16 x i8>* %1, align 1, !tbaa !1
  %wide.load.1 = load <16 x i8>, <16 x i8>* bitcast (i8* getelementptr inbounds ([64 x i8], [64 x i8]* @Lqt, i32 0, i32 16) to <16 x i8>*), align 1, !tbaa !1
  %2 = getelementptr inbounds i8, i8* %outoutBuffer, i32 23
  %3 = bitcast i8* %2 to <16 x i8>*
  store <16 x i8> %wide.load.1, <16 x i8>* %3, align 1, !tbaa !1
  %wide.load.2 = load <16 x i8>, <16 x i8>* bitcast (i8* getelementptr inbounds ([64 x i8], [64 x i8]* @Lqt, i32 0, i32 32) to <16 x i8>*), align 1, !tbaa !1
  %4 = getelementptr inbounds i8, i8* %outoutBuffer, i32 39
  %5 = bitcast i8* %4 to <16 x i8>*
  store <16 x i8> %wide.load.2, <16 x i8>* %5, align 1, !tbaa !1
  %wide.load.3 = load <16 x i8>, <16 x i8>* bitcast (i8* getelementptr inbounds ([64 x i8], [64 x i8]* @Lqt, i32 0, i32 48) to <16 x i8>*), align 1, !tbaa !1
  %6 = getelementptr inbounds i8, i8* %outoutBuffer, i32 55
  %7 = bitcast i8* %6 to <16 x i8>*
  store <16 x i8> %wide.load.3, <16 x i8>* %7, align 1, !tbaa !1
  br label %middle.block

middle.block:                                     ; preds = %vector.body, %entry
  %resume.val = phi i32 [ 0, %entry ], [ 64, %vector.body ]
  %resume.val288 = phi i1 [ false, %entry ], [ true, %vector.body ]
  %trunc.resume.val = phi i32 [ 7, %entry ], [ 71, %vector.body ]
  br i1 %resume.val288, label %for.end, label %for.body.preheader

for.body.preheader:                               ; preds = %middle.block
  br label %for.body

for.body:                                         ; preds = %for.body.preheader, %for.body
  %indvars.iv284 = phi i32 [ %indvars.iv.next285, %for.body ], [ %resume.val, %for.body.preheader ]
  %j.0279 = phi i32 [ %inc15, %for.body ], [ %trunc.resume.val, %for.body.preheader ]
  %arrayidx14 = getelementptr inbounds [64 x i8], [64 x i8]* @Lqt, i32 0, i32 %indvars.iv284
  %8 = load i8, i8* %arrayidx14, align 1, !tbaa !1
  %inc15 = add nuw nsw i32 %j.0279, 1
  %arrayidx16 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %j.0279
  store i8 %8, i8* %arrayidx16, align 1, !tbaa !1
  %indvars.iv.next285 = add nuw nsw i32 %indvars.iv284, 1
  %exitcond286 = icmp eq i32 %indvars.iv.next285, 64
  br i1 %exitcond286, label %for.end.loopexit, label %for.body, !llvm.loop !4

for.end.loopexit:                                 ; preds = %for.body
  br label %for.end

for.end:                                          ; preds = %for.end.loopexit, %middle.block
  %arrayidx19 = getelementptr inbounds i8, i8* %outoutBuffer, i32 71
  store i8 1, i8* %arrayidx19, align 1, !tbaa !1
  %scevgep300 = getelementptr i8, i8* %outoutBuffer, i32 72
  %scevgep301 = getelementptr i8, i8* %outoutBuffer, i32 135
  %bound0302 = icmp ule i8* %scevgep300, getelementptr inbounds ([64 x i8], [64 x i8]* @Cqt, i32 0, i32 63)
  %bound1303 = icmp uge i8* %scevgep301, getelementptr inbounds ([64 x i8], [64 x i8]* @Cqt, i32 0, i32 0)
  %memcheck.conflict305 = and i1 %bound0302, %bound1303
  br i1 %memcheck.conflict305, label %middle.block295, label %vector.body294.preheader

vector.body294.preheader:                         ; preds = %for.end
  br label %vector.body294

vector.body294:                                   ; preds = %vector.body294.preheader
  %wide.load324 = load <16 x i8>, <16 x i8>* bitcast ([64 x i8]* @Cqt to <16 x i8>*), align 1, !tbaa !1
  %9 = getelementptr inbounds i8, i8* %outoutBuffer, i32 72
  %10 = bitcast i8* %9 to <16 x i8>*
  store <16 x i8> %wide.load324, <16 x i8>* %10, align 1, !tbaa !1
  %wide.load324.1 = load <16 x i8>, <16 x i8>* bitcast (i8* getelementptr inbounds ([64 x i8], [64 x i8]* @Cqt, i32 0, i32 16) to <16 x i8>*), align 1, !tbaa !1
  %11 = getelementptr inbounds i8, i8* %outoutBuffer, i32 88
  %12 = bitcast i8* %11 to <16 x i8>*
  store <16 x i8> %wide.load324.1, <16 x i8>* %12, align 1, !tbaa !1
  %wide.load324.2 = load <16 x i8>, <16 x i8>* bitcast (i8* getelementptr inbounds ([64 x i8], [64 x i8]* @Cqt, i32 0, i32 32) to <16 x i8>*), align 1, !tbaa !1
  %13 = getelementptr inbounds i8, i8* %outoutBuffer, i32 104
  %14 = bitcast i8* %13 to <16 x i8>*
  store <16 x i8> %wide.load324.2, <16 x i8>* %14, align 1, !tbaa !1
  %wide.load324.3 = load <16 x i8>, <16 x i8>* bitcast (i8* getelementptr inbounds ([64 x i8], [64 x i8]* @Cqt, i32 0, i32 48) to <16 x i8>*), align 1, !tbaa !1
  %15 = getelementptr inbounds i8, i8* %outoutBuffer, i32 120
  %16 = bitcast i8* %15 to <16 x i8>*
  store <16 x i8> %wide.load324.3, <16 x i8>* %16, align 1, !tbaa !1
  br label %middle.block295

middle.block295:                                  ; preds = %vector.body294, %for.end
  %resume.val308 = phi i32 [ 0, %for.end ], [ 64, %vector.body294 ]
  %resume.val310 = phi i1 [ false, %for.end ], [ true, %vector.body294 ]
  %trunc.resume.val311 = phi i32 [ 72, %for.end ], [ 136, %vector.body294 ]
  br i1 %resume.val310, label %for.body.36.preheader, label %for.body.24.preheader

for.body.24.preheader:                            ; preds = %middle.block295
  br label %for.body.24

for.body.24:                                      ; preds = %for.body.24.preheader, %for.body.24
  %indvars.iv281 = phi i32 [ %indvars.iv.next282, %for.body.24 ], [ %resume.val308, %for.body.24.preheader ]
  %j.1278 = phi i32 [ %j.1, %for.body.24 ], [ %trunc.resume.val311, %for.body.24.preheader ]
  %arrayidx26 = getelementptr inbounds [64 x i8], [64 x i8]* @Cqt, i32 0, i32 %indvars.iv281
  %17 = load i8, i8* %arrayidx26, align 1, !tbaa !1
  %arrayidx28 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %j.1278
  store i8 %17, i8* %arrayidx28, align 1, !tbaa !1
  %indvars.iv.next282 = add nuw nsw i32 %indvars.iv281, 1
  %j.1 = add nsw i32 %j.1278, 1
  %exitcond283 = icmp eq i32 %indvars.iv.next282, 64
  br i1 %exitcond283, label %for.body.36.preheader.loopexit, label %for.body.24, !llvm.loop !7

for.body.36.preheader.loopexit:                   ; preds = %for.body.24
  br label %for.body.36.preheader

for.body.36.preheader:                            ; preds = %for.body.36.preheader.loopexit, %middle.block295
  br label %for.body.36

for.body.36:                                      ; preds = %for.body.36.preheader, %for.body.36
  %indvars.iv = phi i32 [ %indvars.iv.next, %for.body.36 ], [ 0, %for.body.36.preheader ]
  %j.2274 = phi i32 [ %inc46, %for.body.36 ], [ 136, %for.body.36.preheader ]
  %arrayidx38 = getelementptr inbounds [210 x i16], [210 x i16]* @markerdata, i32 0, i32 %indvars.iv
  %18 = load i16, i16* %arrayidx38, align 2, !tbaa !8
  %shr.273 = lshr i16 %18, 8
  %conv40 = trunc i16 %shr.273 to i8
  %inc41 = or i32 %j.2274, 1
  %arrayidx42 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %j.2274
  store i8 %conv40, i8* %arrayidx42, align 1, !tbaa !1
  %19 = load i16, i16* %arrayidx38, align 2, !tbaa !8
  %conv45 = trunc i16 %19 to i8
  %inc46 = add nsw i32 %j.2274, 2
  %arrayidx47 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc41
  store i8 %conv45, i8* %arrayidx47, align 1, !tbaa !1
  %indvars.iv.next = add nuw nsw i32 %indvars.iv, 1
  %exitcond = icmp eq i32 %indvars.iv.next, 210
  br i1 %exitcond, label %for.end.50, label %for.body.36

for.end.50:                                       ; preds = %for.body.36
  %cmp51 = icmp eq i32 %imageFormat, 0
  %. = select i1 %cmp51, i8 1, i8 3
  %arrayidx54 = getelementptr inbounds i8, i8* %outoutBuffer, i32 556
  store i8 -1, i8* %arrayidx54, align 1, !tbaa !1
  %arrayidx56 = getelementptr inbounds i8, i8* %outoutBuffer, i32 557
  store i8 -64, i8* %arrayidx56, align 1, !tbaa !1
  %mul = mul nuw nsw i8 %., 3
  %add = add nuw nsw i8 %mul, 8
  %arrayidx63 = getelementptr inbounds i8, i8* %outoutBuffer, i32 558
  store i8 0, i8* %arrayidx63, align 1, !tbaa !1
  %arrayidx66 = getelementptr inbounds i8, i8* %outoutBuffer, i32 559
  store i8 %add, i8* %arrayidx66, align 1, !tbaa !1
  %arrayidx68 = getelementptr inbounds i8, i8* %outoutBuffer, i32 560
  store i8 8, i8* %arrayidx68, align 1, !tbaa !1
  %shr69 = lshr i32 %height, 8
  %conv70 = trunc i32 %shr69 to i8
  %arrayidx72 = getelementptr inbounds i8, i8* %outoutBuffer, i32 561
  store i8 %conv70, i8* %arrayidx72, align 1, !tbaa !1
  %conv73 = trunc i32 %height to i8
  %arrayidx75 = getelementptr inbounds i8, i8* %outoutBuffer, i32 562
  store i8 %conv73, i8* %arrayidx75, align 1, !tbaa !1
  %shr76 = lshr i32 %width, 8
  %conv77 = trunc i32 %shr76 to i8
  %arrayidx79 = getelementptr inbounds i8, i8* %outoutBuffer, i32 563
  store i8 %conv77, i8* %arrayidx79, align 1, !tbaa !1
  %conv80 = trunc i32 %width to i8
  %arrayidx82 = getelementptr inbounds i8, i8* %outoutBuffer, i32 564
  store i8 %conv80, i8* %arrayidx82, align 1, !tbaa !1
  %arrayidx84 = getelementptr inbounds i8, i8* %outoutBuffer, i32 565
  store i8 %., i8* %arrayidx84, align 1, !tbaa !1
  %arrayidx89 = getelementptr inbounds i8, i8* %outoutBuffer, i32 566
  store i8 1, i8* %arrayidx89, align 1, !tbaa !1
  %arrayidx91 = getelementptr inbounds i8, i8* %outoutBuffer, i32 567
  br i1 %cmp51, label %if.then.87, label %if.else.94

if.then.87:                                       ; preds = %for.end.50
  store i8 17, i8* %arrayidx91, align 1, !tbaa !1
  br label %if.end.113

if.else.94:                                       ; preds = %for.end.50
  store i8 33, i8* %arrayidx91, align 1, !tbaa !1
  %arrayidx102 = getelementptr inbounds i8, i8* %outoutBuffer, i32 569
  store i8 2, i8* %arrayidx102, align 1, !tbaa !1
  %arrayidx104 = getelementptr inbounds i8, i8* %outoutBuffer, i32 570
  store i8 17, i8* %arrayidx104, align 1, !tbaa !1
  %arrayidx106 = getelementptr inbounds i8, i8* %outoutBuffer, i32 571
  store i8 1, i8* %arrayidx106, align 1, !tbaa !1
  %arrayidx108 = getelementptr inbounds i8, i8* %outoutBuffer, i32 572
  store i8 3, i8* %arrayidx108, align 1, !tbaa !1
  %arrayidx110 = getelementptr inbounds i8, i8* %outoutBuffer, i32 573
  store i8 17, i8* %arrayidx110, align 1, !tbaa !1
  %arrayidx112 = getelementptr inbounds i8, i8* %outoutBuffer, i32 574
  store i8 1, i8* %arrayidx112, align 1, !tbaa !1
  br label %if.end.113

if.end.113:                                       ; preds = %if.else.94, %if.then.87
  %j.3 = phi i32 [ 569, %if.then.87 ], [ 575, %if.else.94 ]
  %20 = getelementptr inbounds i8, i8* %outoutBuffer, i32 568
  store i8 0, i8* %20, align 1
  %inc114 = add nuw nsw i32 %j.3, 1
  %arrayidx115 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %j.3
  store i8 -1, i8* %arrayidx115, align 1, !tbaa !1
  %inc116 = add nuw nsw i32 %j.3, 2
  %arrayidx117 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc114
  store i8 -38, i8* %arrayidx117, align 1, !tbaa !1
  %shl = shl nuw nsw i8 %., 1
  %add119 = add nuw nsw i8 %shl, 6
  %inc124 = add nuw nsw i32 %j.3, 3
  %arrayidx125 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc116
  store i8 0, i8* %arrayidx125, align 1, !tbaa !1
  %inc127 = add nuw nsw i32 %j.3, 4
  %arrayidx128 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc124
  store i8 %add119, i8* %arrayidx128, align 1, !tbaa !1
  %inc129 = add nuw nsw i32 %j.3, 5
  %arrayidx130 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc127
  store i8 %., i8* %arrayidx130, align 1, !tbaa !1
  %inc134 = add nuw nsw i32 %j.3, 6
  %arrayidx135 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc129
  store i8 1, i8* %arrayidx135, align 1, !tbaa !1
  %inc136 = add nuw nsw i32 %j.3, 7
  %arrayidx137 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc134
  store i8 0, i8* %arrayidx137, align 1, !tbaa !1
  br i1 %cmp51, label %if.end.151, label %if.else.138

if.else.138:                                      ; preds = %if.end.113
  %inc143 = add nuw nsw i32 %j.3, 8
  %arrayidx144 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc136
  store i8 2, i8* %arrayidx144, align 1, !tbaa !1
  %inc145 = add nuw nsw i32 %j.3, 9
  %arrayidx146 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc143
  store i8 17, i8* %arrayidx146, align 1, !tbaa !1
  %inc147 = add nuw nsw i32 %j.3, 10
  %arrayidx148 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc145
  store i8 3, i8* %arrayidx148, align 1, !tbaa !1
  %inc149 = add nuw nsw i32 %j.3, 11
  %arrayidx150 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc147
  store i8 17, i8* %arrayidx150, align 1, !tbaa !1
  br label %if.end.151

if.end.151:                                       ; preds = %if.end.113, %if.else.138
  %j.4 = phi i32 [ %inc136, %if.end.113 ], [ %inc149, %if.else.138 ]
  %inc152 = add nsw i32 %j.4, 1
  %arrayidx153 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %j.4
  store i8 0, i8* %arrayidx153, align 1, !tbaa !1
  %inc154 = add nsw i32 %j.4, 2
  %arrayidx155 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc152
  store i8 63, i8* %arrayidx155, align 1, !tbaa !1
  %inc156 = add nsw i32 %j.4, 3
  %arrayidx157 = getelementptr inbounds i8, i8* %outoutBuffer, i32 %inc154
  store i8 0, i8* %arrayidx157, align 1, !tbaa !1
  ret i32 %inc156
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"omnipotent char", !3, i64 0}
!3 = !{!"Simple C/C++ TBAA"}
!4 = distinct !{!4, !5, !6}
!5 = !{!"llvm.loop.vectorize.width", i32 1}
!6 = !{!"llvm.loop.interleave.count", i32 1}
!7 = distinct !{!7, !5, !6}
!8 = !{!9, !9, i64 0}
!9 = !{!"short", !2, i64 0}
