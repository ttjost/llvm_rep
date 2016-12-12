; ModuleID = 'huffman.c'
target datalayout = "e-m:e-p:32:32-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i386-unknown-linux-gnu"

@luminance_dc_code_table = global [12 x i16] [i16 0, i16 2, i16 3, i16 4, i16 5, i16 6, i16 14, i16 30, i16 62, i16 126, i16 254, i16 510], align 2
@luminance_dc_size_table = global [12 x i16] [i16 2, i16 3, i16 3, i16 3, i16 3, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8, i16 9], align 2
@chrominance_dc_code_table = global [12 x i16] [i16 0, i16 1, i16 2, i16 6, i16 14, i16 30, i16 62, i16 126, i16 254, i16 510, i16 1022, i16 2046], align 2
@chrominance_dc_size_table = global [12 x i16] [i16 2, i16 2, i16 2, i16 3, i16 4, i16 5, i16 6, i16 7, i16 8, i16 9, i16 10, i16 11], align 2
@luminance_ac_code_table = global [162 x i16] [i16 10, i16 0, i16 1, i16 4, i16 11, i16 26, i16 120, i16 248, i16 1014, i16 -126, i16 -125, i16 12, i16 27, i16 121, i16 502, i16 2038, i16 -124, i16 -123, i16 -122, i16 -121, i16 -120, i16 28, i16 249, i16 1015, i16 4084, i16 -119, i16 -118, i16 -117, i16 -116, i16 -115, i16 -114, i16 58, i16 503, i16 4085, i16 -113, i16 -112, i16 -111, i16 -110, i16 -109, i16 -108, i16 -107, i16 59, i16 1016, i16 -106, i16 -105, i16 -104, i16 -103, i16 -102, i16 -101, i16 -100, i16 -99, i16 122, i16 2039, i16 -98, i16 -97, i16 -96, i16 -95, i16 -94, i16 -93, i16 -92, i16 -91, i16 123, i16 4086, i16 -90, i16 -89, i16 -88, i16 -87, i16 -86, i16 -85, i16 -84, i16 -83, i16 250, i16 4087, i16 -82, i16 -81, i16 -80, i16 -79, i16 -78, i16 -77, i16 -76, i16 -75, i16 504, i16 32704, i16 -74, i16 -73, i16 -72, i16 -71, i16 -70, i16 -69, i16 -68, i16 -67, i16 505, i16 -66, i16 -65, i16 -64, i16 -63, i16 -62, i16 -61, i16 -60, i16 -59, i16 -58, i16 506, i16 -57, i16 -56, i16 -55, i16 -54, i16 -53, i16 -52, i16 -51, i16 -50, i16 -49, i16 1017, i16 -48, i16 -47, i16 -46, i16 -45, i16 -44, i16 -43, i16 -42, i16 -41, i16 -40, i16 1018, i16 -39, i16 -38, i16 -37, i16 -36, i16 -35, i16 -34, i16 -33, i16 -32, i16 -31, i16 2040, i16 -30, i16 -29, i16 -28, i16 -27, i16 -26, i16 -25, i16 -24, i16 -23, i16 -22, i16 -21, i16 -20, i16 -19, i16 -18, i16 -17, i16 -16, i16 -15, i16 -14, i16 -13, i16 -12, i16 -11, i16 -10, i16 -9, i16 -8, i16 -7, i16 -6, i16 -5, i16 -4, i16 -3, i16 -2, i16 2041], align 2
@luminance_ac_size_table = global [162 x i16] [i16 4, i16 2, i16 2, i16 3, i16 4, i16 5, i16 7, i16 8, i16 10, i16 16, i16 16, i16 4, i16 5, i16 7, i16 9, i16 11, i16 16, i16 16, i16 16, i16 16, i16 16, i16 5, i16 8, i16 10, i16 12, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 6, i16 9, i16 12, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 6, i16 10, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 7, i16 11, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 7, i16 12, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 8, i16 12, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 9, i16 15, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 9, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 9, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 10, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 10, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 11, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 11], align 2
@chrominance_ac_code_table = global [162 x i16] [i16 0, i16 1, i16 4, i16 10, i16 24, i16 25, i16 56, i16 120, i16 500, i16 1014, i16 4084, i16 11, i16 57, i16 246, i16 501, i16 2038, i16 4085, i16 -120, i16 -119, i16 -118, i16 -117, i16 26, i16 247, i16 1015, i16 4086, i16 32706, i16 -116, i16 -115, i16 -114, i16 -113, i16 -112, i16 27, i16 248, i16 1016, i16 4087, i16 -111, i16 -110, i16 -109, i16 -108, i16 -107, i16 -106, i16 58, i16 502, i16 -105, i16 -104, i16 -103, i16 -102, i16 -101, i16 -100, i16 -99, i16 -98, i16 59, i16 1017, i16 -97, i16 -96, i16 -95, i16 -94, i16 -93, i16 -92, i16 -91, i16 -90, i16 121, i16 2039, i16 -89, i16 -88, i16 -87, i16 -86, i16 -85, i16 -84, i16 -83, i16 -82, i16 122, i16 2040, i16 -81, i16 -80, i16 -79, i16 -78, i16 -77, i16 -76, i16 -75, i16 -74, i16 249, i16 -73, i16 -72, i16 -71, i16 -70, i16 -69, i16 -68, i16 -67, i16 -66, i16 -65, i16 503, i16 -64, i16 -63, i16 -62, i16 -61, i16 -60, i16 -59, i16 -58, i16 -57, i16 -56, i16 504, i16 -55, i16 -54, i16 -53, i16 -52, i16 -51, i16 -50, i16 -49, i16 -48, i16 -47, i16 505, i16 -46, i16 -45, i16 -44, i16 -43, i16 -42, i16 -41, i16 -40, i16 -39, i16 -38, i16 506, i16 -37, i16 -36, i16 -35, i16 -34, i16 -33, i16 -32, i16 -31, i16 -30, i16 -29, i16 2041, i16 -28, i16 -27, i16 -26, i16 -25, i16 -24, i16 -23, i16 -22, i16 -21, i16 -20, i16 16352, i16 -19, i16 -18, i16 -17, i16 -16, i16 -15, i16 -14, i16 -13, i16 -12, i16 -11, i16 32707, i16 -10, i16 -9, i16 -8, i16 -7, i16 -6, i16 -5, i16 -4, i16 -3, i16 -2, i16 1018], align 2
@chrominance_ac_size_table = global [162 x i16] [i16 2, i16 2, i16 3, i16 4, i16 5, i16 5, i16 6, i16 7, i16 9, i16 10, i16 12, i16 4, i16 6, i16 8, i16 9, i16 11, i16 12, i16 16, i16 16, i16 16, i16 16, i16 5, i16 8, i16 10, i16 12, i16 15, i16 16, i16 16, i16 16, i16 16, i16 16, i16 5, i16 8, i16 10, i16 12, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 6, i16 9, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 6, i16 10, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 7, i16 11, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 7, i16 11, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 8, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 9, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 9, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 9, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 9, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 11, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 14, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 15, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 16, i16 10], align 2
@bitsize = global [256 x i8] c"\00\01\02\02\03\03\03\03\04\04\04\04\04\04\04\04\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\05\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\06\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\07\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08\08", align 1
@Temp = external global [64 x i16], align 2
@global_ldc1 = external global i16, align 2
@global_ldc2 = external global i16, align 2
@global_ldc3 = external global i16, align 2
@bitindex = external global i16, align 2
@lcode = external global i32, align 4

; Function Attrs: nounwind
define i32 @huffman(i16 zeroext %component, i8* %output_ptr, i32 %k) #0 {
entry:
  %0 = load i16, i16* getelementptr inbounds ([64 x i16], [64 x i16]* @Temp, i32 0, i32 0), align 2, !tbaa !1
  switch i16 %component, label %if.else.6 [
    i16 1, label %if.then
    i16 2, label %if.then.5
  ]

if.then:                                          ; preds = %entry
  %1 = load i16, i16* @global_ldc1, align 2, !tbaa !1
  store i16 %0, i16* @global_ldc1, align 2, !tbaa !1
  br label %if.end.7

if.then.5:                                        ; preds = %entry
  %2 = load i16, i16* @global_ldc2, align 2, !tbaa !1
  store i16 %0, i16* @global_ldc2, align 2, !tbaa !1
  br label %if.end.7

if.else.6:                                        ; preds = %entry
  %3 = load i16, i16* @global_ldc3, align 2, !tbaa !1
  store i16 %0, i16* @global_ldc3, align 2, !tbaa !1
  br label %if.end.7

if.end.7:                                         ; preds = %if.then.5, %if.else.6, %if.then
  %DcCodeTable.0 = phi i16* [ getelementptr inbounds ([12 x i16], [12 x i16]* @luminance_dc_code_table, i32 0, i32 0), %if.then ], [ getelementptr inbounds ([12 x i16], [12 x i16]* @chrominance_dc_code_table, i32 0, i32 0), %if.then.5 ], [ getelementptr inbounds ([12 x i16], [12 x i16]* @chrominance_dc_code_table, i32 0, i32 0), %if.else.6 ]
  %DcSizeTable.0 = phi i16* [ getelementptr inbounds ([12 x i16], [12 x i16]* @luminance_dc_size_table, i32 0, i32 0), %if.then ], [ getelementptr inbounds ([12 x i16], [12 x i16]* @chrominance_dc_size_table, i32 0, i32 0), %if.then.5 ], [ getelementptr inbounds ([12 x i16], [12 x i16]* @chrominance_dc_size_table, i32 0, i32 0), %if.else.6 ]
  %AcCodeTable.0 = phi i16* [ getelementptr inbounds ([162 x i16], [162 x i16]* @luminance_ac_code_table, i32 0, i32 0), %if.then ], [ getelementptr inbounds ([162 x i16], [162 x i16]* @chrominance_ac_code_table, i32 0, i32 0), %if.then.5 ], [ getelementptr inbounds ([162 x i16], [162 x i16]* @chrominance_ac_code_table, i32 0, i32 0), %if.else.6 ]
  %AcSizeTable.0 = phi i16* [ getelementptr inbounds ([162 x i16], [162 x i16]* @luminance_ac_size_table, i32 0, i32 0), %if.then ], [ getelementptr inbounds ([162 x i16], [162 x i16]* @chrominance_ac_size_table, i32 0, i32 0), %if.then.5 ], [ getelementptr inbounds ([162 x i16], [162 x i16]* @chrominance_ac_size_table, i32 0, i32 0), %if.else.6 ]
  %LastDc.0 = phi i16 [ %1, %if.then ], [ %2, %if.then.5 ], [ %3, %if.else.6 ]
  %sub = sub i16 %0, %LastDc.0
  %cmp12 = icmp slt i16 %sub, 0
  %sub15 = sub i16 0, %sub
  %sub.lobit = ashr i16 %sub, 15
  %Coeff.0 = add i16 %sub.lobit, %sub
  %cond = select i1 %cmp12, i16 %sub15, i16 %sub
  %cmp19.565 = icmp eq i16 %cond, 0
  br i1 %cmp19.565, label %while.end, label %while.body.preheader

while.body.preheader:                             ; preds = %if.end.7
  br label %while.body

while.body:                                       ; preds = %while.body.preheader, %while.body
  %DataSize.0567 = phi i16 [ %inc, %while.body ], [ 0, %while.body.preheader ]
  %AbsCoeff.0566 = phi i16 [ %shr.545, %while.body ], [ %cond, %while.body.preheader ]
  %shr.545 = lshr i16 %AbsCoeff.0566, 1
  %inc = add i16 %DataSize.0567, 1
  %cmp19 = icmp eq i16 %shr.545, 0
  br i1 %cmp19, label %while.end.loopexit, label %while.body

while.end.loopexit:                               ; preds = %while.body
  %inc.lcssa = phi i16 [ %inc, %while.body ]
  br label %while.end

while.end:                                        ; preds = %while.end.loopexit, %if.end.7
  %DataSize.0.lcssa = phi i16 [ 0, %if.end.7 ], [ %inc.lcssa, %while.end.loopexit ]
  %idxprom = zext i16 %DataSize.0.lcssa to i32
  %arrayidx = getelementptr inbounds i16, i16* %DcCodeTable.0, i32 %idxprom
  %4 = load i16, i16* %arrayidx, align 2, !tbaa !1
  %arrayidx24 = getelementptr inbounds i16, i16* %DcSizeTable.0, i32 %idxprom
  %5 = load i16, i16* %arrayidx24, align 2, !tbaa !1
  %shl = shl i32 1, %idxprom
  %sub26 = add i32 %shl, 65535
  %conv27.539 = zext i16 %Coeff.0 to i32
  %and = and i32 %sub26, %conv27.539
  %conv29 = zext i16 %4 to i32
  %shl31 = shl i32 %conv29, %idxprom
  %sext = shl nuw i32 %and, 16
  %conv32 = ashr exact i32 %sext, 16
  %or = or i32 %shl31, %conv32
  %add = add i16 %5, %DataSize.0.lcssa
  %6 = load i16, i16* @bitindex, align 2, !tbaa !1
  %add38 = add i16 %add, -32
  %sub39 = add i16 %add38, %6
  %cmp42 = icmp slt i16 %sub39, 0
  %7 = load i32, i32* @lcode, align 4, !tbaa !5
  br i1 %cmp42, label %if.then.44, label %if.else.52

if.then.44:                                       ; preds = %while.end
  %conv37 = zext i16 %add to i32
  %shl46 = shl i32 %7, %conv37
  %or47 = or i32 %shl46, %or
  store i32 %or47, i32* @lcode, align 4, !tbaa !5
  %add50 = add i16 %6, %add
  br label %if.end.102

if.else.52:                                       ; preds = %while.end
  %conv41 = sext i16 %sub39 to i32
  %conv36 = zext i16 %6 to i32
  %sub54 = sub nsw i32 32, %conv36
  %shl55 = shl i32 %7, %sub54
  %shr57 = lshr i32 %or, %conv41
  %or58 = or i32 %shr57, %shl55
  store i32 %or58, i32* @lcode, align 4, !tbaa !5
  %shr59 = lshr i32 %or58, 24
  %conv60 = trunc i32 %shr59 to i8
  %inc61 = add nsw i32 %k, 1
  %arrayidx62 = getelementptr inbounds i8, i8* %output_ptr, i32 %k
  store i8 %conv60, i8* %arrayidx62, align 1, !tbaa !7
  %cmp64 = icmp eq i32 %shr59, 255
  br i1 %cmp64, label %if.then.66, label %if.end.69

if.then.66:                                       ; preds = %if.else.52
  %inc67 = add nsw i32 %k, 2
  %arrayidx68 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc61
  store i8 0, i8* %arrayidx68, align 1, !tbaa !7
  br label %if.end.69

if.end.69:                                        ; preds = %if.then.66, %if.else.52
  %k.addr.0 = phi i32 [ %inc67, %if.then.66 ], [ %inc61, %if.else.52 ]
  %8 = load i32, i32* @lcode, align 4, !tbaa !5
  %shr70 = lshr i32 %8, 16
  %conv71 = trunc i32 %shr70 to i8
  %inc72 = add nsw i32 %k.addr.0, 1
  %arrayidx73 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.0
  store i8 %conv71, i8* %arrayidx73, align 1, !tbaa !7
  %conv74 = and i32 %shr70, 255
  %cmp75 = icmp eq i32 %conv74, 255
  br i1 %cmp75, label %if.then.77, label %if.end.80

if.then.77:                                       ; preds = %if.end.69
  %inc78 = add nsw i32 %k.addr.0, 2
  %arrayidx79 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc72
  store i8 0, i8* %arrayidx79, align 1, !tbaa !7
  br label %if.end.80

if.end.80:                                        ; preds = %if.then.77, %if.end.69
  %k.addr.1 = phi i32 [ %inc78, %if.then.77 ], [ %inc72, %if.end.69 ]
  %9 = load i32, i32* @lcode, align 4, !tbaa !5
  %shr81 = lshr i32 %9, 8
  %conv82 = trunc i32 %shr81 to i8
  %inc83 = add nsw i32 %k.addr.1, 1
  %arrayidx84 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.1
  store i8 %conv82, i8* %arrayidx84, align 1, !tbaa !7
  %conv85 = and i32 %shr81, 255
  %cmp86 = icmp eq i32 %conv85, 255
  br i1 %cmp86, label %if.then.88, label %if.end.91

if.then.88:                                       ; preds = %if.end.80
  %inc89 = add nsw i32 %k.addr.1, 2
  %arrayidx90 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc83
  store i8 0, i8* %arrayidx90, align 1, !tbaa !7
  br label %if.end.91

if.end.91:                                        ; preds = %if.then.88, %if.end.80
  %k.addr.2 = phi i32 [ %inc89, %if.then.88 ], [ %inc83, %if.end.80 ]
  %10 = load i32, i32* @lcode, align 4, !tbaa !5
  %conv92 = trunc i32 %10 to i8
  %inc93 = add nsw i32 %k.addr.2, 1
  %arrayidx94 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.2
  store i8 %conv92, i8* %arrayidx94, align 1, !tbaa !7
  %conv95 = and i32 %10, 255
  %cmp96 = icmp eq i32 %conv95, 255
  br i1 %cmp96, label %if.then.98, label %if.end.101

if.then.98:                                       ; preds = %if.end.91
  %inc99 = add nsw i32 %k.addr.2, 2
  %arrayidx100 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc93
  store i8 0, i8* %arrayidx100, align 1, !tbaa !7
  br label %if.end.101

if.end.101:                                       ; preds = %if.then.98, %if.end.91
  %k.addr.3 = phi i32 [ %inc99, %if.then.98 ], [ %inc93, %if.end.91 ]
  store i32 %or, i32* @lcode, align 4, !tbaa !5
  br label %if.end.102

if.end.102:                                       ; preds = %if.end.101, %if.then.44
  %11 = phi i32 [ %or, %if.end.101 ], [ %or47, %if.then.44 ]
  %storemerge = phi i16 [ %sub39, %if.end.101 ], [ %add50, %if.then.44 ]
  %k.addr.4 = phi i32 [ %k.addr.3, %if.end.101 ], [ %k, %if.then.44 ]
  store i16 %storemerge, i16* @bitindex, align 2, !tbaa !1
  %arrayidx119 = getelementptr inbounds i16, i16* %AcCodeTable.0, i32 161
  %arrayidx121 = getelementptr inbounds i16, i16* %AcSizeTable.0, i32 161
  br label %for.body

for.body:                                         ; preds = %if.end.102, %for.inc
  %12 = phi i32 [ %11, %if.end.102 ], [ %34, %for.inc ]
  %13 = phi i16 [ %storemerge, %if.end.102 ], [ %35, %for.inc ]
  %k.addr.5564 = phi i32 [ %k.addr.4, %if.end.102 ], [ %k.addr.16, %for.inc ]
  %RunLength.0563 = phi i16 [ 0, %if.end.102 ], [ %RunLength.2, %for.inc ]
  %Temp_Ptr.0562 = phi i16* [ getelementptr inbounds ([64 x i16], [64 x i16]* @Temp, i32 0, i32 1), %if.end.102 ], [ %incdec.ptr106, %for.inc ]
  %i.0561 = phi i16 [ 63, %if.end.102 ], [ %dec311, %for.inc ]
  %incdec.ptr106 = getelementptr inbounds i16, i16* %Temp_Ptr.0562, i32 1
  %14 = load i16, i16* %Temp_Ptr.0562, align 2, !tbaa !1
  %cmp108 = icmp eq i16 %14, 0
  br i1 %cmp108, label %if.else.308, label %while.cond.111.preheader

while.cond.111.preheader:                         ; preds = %for.body
  %cmp113.549.556 = icmp ugt i16 %RunLength.0563, 15
  br i1 %cmp113.549.556, label %while.body.115.lr.ph.preheader, label %while.end.189

while.body.115.lr.ph.preheader:                   ; preds = %while.cond.111.preheader
  br label %while.body.115.lr.ph

while.body.115.lr.ph:                             ; preds = %while.body.115.lr.ph.preheader, %if.end.187
  %15 = phi i32 [ %conv120, %if.end.187 ], [ %12, %while.body.115.lr.ph.preheader ]
  %16 = phi i16 [ %sub125.lcssa, %if.end.187 ], [ %13, %while.body.115.lr.ph.preheader ]
  %k.addr.6.ph558 = phi i32 [ %k.addr.10, %if.end.187 ], [ %k.addr.5564, %while.body.115.lr.ph.preheader ]
  %RunLength.1.ph557 = phi i16 [ %sub117.lcssa, %if.end.187 ], [ %RunLength.0563, %while.body.115.lr.ph.preheader ]
  %17 = load i16, i16* %arrayidx119, align 2, !tbaa !1
  %conv120 = zext i16 %17 to i32
  %18 = load i16, i16* %arrayidx121, align 2, !tbaa !1
  %add124 = add i16 %18, -32
  %conv123 = zext i16 %18 to i32
  br label %while.body.115

while.body.115:                                   ; preds = %while.body.115.lr.ph, %if.then.130
  %19 = phi i32 [ %15, %while.body.115.lr.ph ], [ %or133, %if.then.130 ]
  %20 = phi i16 [ %16, %while.body.115.lr.ph ], [ %add136, %if.then.130 ]
  %RunLength.1550 = phi i16 [ %RunLength.1.ph557, %while.body.115.lr.ph ], [ %sub117, %if.then.130 ]
  %sub117 = add i16 %RunLength.1550, -16
  %sub125 = add i16 %add124, %20
  %cmp128 = icmp slt i16 %sub125, 0
  br i1 %cmp128, label %if.then.130, label %if.else.138

if.then.130:                                      ; preds = %while.body.115
  %shl132 = shl i32 %19, %conv123
  %or133 = or i32 %shl132, %conv120
  store i32 %or133, i32* @lcode, align 4, !tbaa !5
  %add136 = add i16 %20, %18
  store i16 %add136, i16* @bitindex, align 2, !tbaa !1
  %cmp113 = icmp ugt i16 %sub117, 15
  br i1 %cmp113, label %while.body.115, label %while.end.189.loopexit

if.else.138:                                      ; preds = %while.body.115
  %sub125.lcssa = phi i16 [ %sub125, %while.body.115 ]
  %sub117.lcssa = phi i16 [ %sub117, %while.body.115 ]
  %.lcssa606 = phi i16 [ %20, %while.body.115 ]
  %.lcssa = phi i32 [ %19, %while.body.115 ]
  %conv127 = sext i16 %sub125.lcssa to i32
  %conv122 = zext i16 %.lcssa606 to i32
  %sub140 = sub nsw i32 32, %conv122
  %shl141 = shl i32 %.lcssa, %sub140
  %shr143 = lshr i32 %conv120, %conv127
  %or144 = or i32 %shr143, %shl141
  store i32 %or144, i32* @lcode, align 4, !tbaa !5
  %shr145 = lshr i32 %or144, 24
  %conv146 = trunc i32 %shr145 to i8
  %inc147 = add nsw i32 %k.addr.6.ph558, 1
  %arrayidx148 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.6.ph558
  store i8 %conv146, i8* %arrayidx148, align 1, !tbaa !7
  %cmp150 = icmp eq i32 %shr145, 255
  br i1 %cmp150, label %if.then.152, label %if.end.155

if.then.152:                                      ; preds = %if.else.138
  %inc153 = add nsw i32 %k.addr.6.ph558, 2
  %arrayidx154 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc147
  store i8 0, i8* %arrayidx154, align 1, !tbaa !7
  br label %if.end.155

if.end.155:                                       ; preds = %if.then.152, %if.else.138
  %k.addr.7 = phi i32 [ %inc153, %if.then.152 ], [ %inc147, %if.else.138 ]
  %21 = load i32, i32* @lcode, align 4, !tbaa !5
  %shr156 = lshr i32 %21, 16
  %conv157 = trunc i32 %shr156 to i8
  %inc158 = add nsw i32 %k.addr.7, 1
  %arrayidx159 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.7
  store i8 %conv157, i8* %arrayidx159, align 1, !tbaa !7
  %conv160 = and i32 %shr156, 255
  %cmp161 = icmp eq i32 %conv160, 255
  br i1 %cmp161, label %if.then.163, label %if.end.166

if.then.163:                                      ; preds = %if.end.155
  %inc164 = add nsw i32 %k.addr.7, 2
  %arrayidx165 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc158
  store i8 0, i8* %arrayidx165, align 1, !tbaa !7
  br label %if.end.166

if.end.166:                                       ; preds = %if.then.163, %if.end.155
  %k.addr.8 = phi i32 [ %inc164, %if.then.163 ], [ %inc158, %if.end.155 ]
  %22 = load i32, i32* @lcode, align 4, !tbaa !5
  %shr167 = lshr i32 %22, 8
  %conv168 = trunc i32 %shr167 to i8
  %inc169 = add nsw i32 %k.addr.8, 1
  %arrayidx170 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.8
  store i8 %conv168, i8* %arrayidx170, align 1, !tbaa !7
  %conv171 = and i32 %shr167, 255
  %cmp172 = icmp eq i32 %conv171, 255
  br i1 %cmp172, label %if.then.174, label %if.end.177

if.then.174:                                      ; preds = %if.end.166
  %inc175 = add nsw i32 %k.addr.8, 2
  %arrayidx176 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc169
  store i8 0, i8* %arrayidx176, align 1, !tbaa !7
  br label %if.end.177

if.end.177:                                       ; preds = %if.then.174, %if.end.166
  %k.addr.9 = phi i32 [ %inc175, %if.then.174 ], [ %inc169, %if.end.166 ]
  %23 = load i32, i32* @lcode, align 4, !tbaa !5
  %conv178 = trunc i32 %23 to i8
  %inc179 = add nsw i32 %k.addr.9, 1
  %arrayidx180 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.9
  store i8 %conv178, i8* %arrayidx180, align 1, !tbaa !7
  %conv181 = and i32 %23, 255
  %cmp182 = icmp eq i32 %conv181, 255
  br i1 %cmp182, label %if.then.184, label %if.end.187

if.then.184:                                      ; preds = %if.end.177
  %inc185 = add nsw i32 %k.addr.9, 2
  %arrayidx186 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc179
  store i8 0, i8* %arrayidx186, align 1, !tbaa !7
  br label %if.end.187

if.end.187:                                       ; preds = %if.then.184, %if.end.177
  %k.addr.10 = phi i32 [ %inc185, %if.then.184 ], [ %inc179, %if.end.177 ]
  store i32 %conv120, i32* @lcode, align 4, !tbaa !5
  store i16 %sub125.lcssa, i16* @bitindex, align 2, !tbaa !1
  %cmp113.549 = icmp ugt i16 %sub117.lcssa, 15
  br i1 %cmp113.549, label %while.body.115.lr.ph, label %while.end.189.loopexit595

while.end.189.loopexit:                           ; preds = %if.then.130
  %k.addr.6.ph558.lcssa610 = phi i32 [ %k.addr.6.ph558, %if.then.130 ]
  %add136.lcssa = phi i16 [ %add136, %if.then.130 ]
  %or133.lcssa = phi i32 [ %or133, %if.then.130 ]
  %sub117.lcssa608 = phi i16 [ %sub117, %if.then.130 ]
  br label %while.end.189

while.end.189.loopexit595:                        ; preds = %if.end.187
  %k.addr.10.lcssa = phi i32 [ %k.addr.10, %if.end.187 ]
  %conv120.lcssa = phi i32 [ %conv120, %if.end.187 ]
  %sub125.lcssa.lcssa = phi i16 [ %sub125.lcssa, %if.end.187 ]
  %sub117.lcssa.lcssa = phi i16 [ %sub117.lcssa, %if.end.187 ]
  br label %while.end.189

while.end.189:                                    ; preds = %while.end.189.loopexit595, %while.end.189.loopexit, %while.cond.111.preheader
  %24 = phi i32 [ %12, %while.cond.111.preheader ], [ %or133.lcssa, %while.end.189.loopexit ], [ %conv120.lcssa, %while.end.189.loopexit595 ]
  %25 = phi i16 [ %13, %while.cond.111.preheader ], [ %add136.lcssa, %while.end.189.loopexit ], [ %sub125.lcssa.lcssa, %while.end.189.loopexit595 ]
  %k.addr.6.ph.lcssa = phi i32 [ %k.addr.5564, %while.cond.111.preheader ], [ %k.addr.6.ph558.lcssa610, %while.end.189.loopexit ], [ %k.addr.10.lcssa, %while.end.189.loopexit595 ]
  %conv112.lcssa.in = phi i16 [ %RunLength.0563, %while.cond.111.preheader ], [ %sub117.lcssa608, %while.end.189.loopexit ], [ %sub117.lcssa.lcssa, %while.end.189.loopexit595 ]
  %conv112.lcssa = zext i16 %conv112.lcssa.in to i32
  %cmp191 = icmp slt i16 %14, 0
  %sub196 = sub i16 0, %14
  %.lobit = ashr i16 %14, 15
  %Coeff.1 = add i16 %.lobit, %14
  %cond200 = select i1 %cmp191, i16 %sub196, i16 %14
  %conv202 = zext i16 %cond200 to i32
  %shr203.540 = lshr i32 %conv202, 8
  %cmp204 = icmp eq i32 %shr203.540, 0
  br i1 %cmp204, label %if.then.206, label %if.else.210

if.then.206:                                      ; preds = %while.end.189
  %arrayidx208 = getelementptr inbounds [256 x i8], [256 x i8]* @bitsize, i32 0, i32 %conv202
  %26 = load i8, i8* %arrayidx208, align 1, !tbaa !7
  %conv209 = zext i8 %26 to i32
  br label %if.end.217

if.else.210:                                      ; preds = %while.end.189
  %arrayidx213 = getelementptr inbounds [256 x i8], [256 x i8]* @bitsize, i32 0, i32 %shr203.540
  %27 = load i8, i8* %arrayidx213, align 1, !tbaa !7
  %conv214 = zext i8 %27 to i32
  %add215 = add nuw nsw i32 %conv214, 8
  br label %if.end.217

if.end.217:                                       ; preds = %if.else.210, %if.then.206
  %DataSize.1 = phi i32 [ %conv209, %if.then.206 ], [ %add215, %if.else.210 ]
  %mul = mul nuw nsw i32 %conv112.lcssa, 10
  %conv219 = and i32 %DataSize.1, 65535
  %add220 = add nsw i32 %DataSize.1, %mul
  %idxprom222 = and i32 %add220, 65535
  %arrayidx223 = getelementptr inbounds i16, i16* %AcCodeTable.0, i32 %idxprom222
  %28 = load i16, i16* %arrayidx223, align 2, !tbaa !1
  %arrayidx225 = getelementptr inbounds i16, i16* %AcSizeTable.0, i32 %idxprom222
  %29 = load i16, i16* %arrayidx225, align 2, !tbaa !1
  %shl227 = shl i32 1, %conv219
  %sub228 = add i32 %shl227, 65535
  %conv229.541 = zext i16 %Coeff.1 to i32
  %and230 = and i32 %sub228, %conv229.541
  %conv232 = zext i16 %28 to i32
  %shl234 = shl i32 %conv232, %conv219
  %sext542 = shl nuw i32 %and230, 16
  %conv235 = ashr exact i32 %sext542, 16
  %or236 = or i32 %conv235, %shl234
  %conv237 = zext i16 %29 to i32
  %add239 = add nsw i32 %conv237, %DataSize.1
  %conv241 = zext i16 %25 to i32
  %conv242 = and i32 %add239, 65535
  %add243 = add nsw i32 %add239, 65504
  %sub244 = add nsw i32 %add243, %conv241
  %sext543 = shl i32 %sub244, 16
  %cmp247 = icmp slt i32 %sext543, 0
  br i1 %cmp247, label %if.then.249, label %if.else.257

if.then.249:                                      ; preds = %if.end.217
  %shl251 = shl i32 %24, %conv242
  %or252 = or i32 %or236, %shl251
  store i32 %or252, i32* @lcode, align 4, !tbaa !5
  %add255 = add nuw nsw i32 %conv241, %conv242
  br label %if.end.307

if.else.257:                                      ; preds = %if.end.217
  %conv246 = ashr exact i32 %sext543, 16
  %sub259 = sub nsw i32 32, %conv241
  %shl260 = shl i32 %24, %sub259
  %shr262 = lshr i32 %or236, %conv246
  %or263 = or i32 %shr262, %shl260
  store i32 %or263, i32* @lcode, align 4, !tbaa !5
  %shr264 = lshr i32 %or263, 24
  %conv265 = trunc i32 %shr264 to i8
  %inc266 = add nsw i32 %k.addr.6.ph.lcssa, 1
  %arrayidx267 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.6.ph.lcssa
  store i8 %conv265, i8* %arrayidx267, align 1, !tbaa !7
  %cmp269 = icmp eq i32 %shr264, 255
  br i1 %cmp269, label %if.then.271, label %if.end.274

if.then.271:                                      ; preds = %if.else.257
  %inc272 = add nsw i32 %k.addr.6.ph.lcssa, 2
  %arrayidx273 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc266
  store i8 0, i8* %arrayidx273, align 1, !tbaa !7
  br label %if.end.274

if.end.274:                                       ; preds = %if.then.271, %if.else.257
  %k.addr.11 = phi i32 [ %inc272, %if.then.271 ], [ %inc266, %if.else.257 ]
  %30 = load i32, i32* @lcode, align 4, !tbaa !5
  %shr275 = lshr i32 %30, 16
  %conv276 = trunc i32 %shr275 to i8
  %inc277 = add nsw i32 %k.addr.11, 1
  %arrayidx278 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.11
  store i8 %conv276, i8* %arrayidx278, align 1, !tbaa !7
  %conv279 = and i32 %shr275, 255
  %cmp280 = icmp eq i32 %conv279, 255
  br i1 %cmp280, label %if.then.282, label %if.end.285

if.then.282:                                      ; preds = %if.end.274
  %inc283 = add nsw i32 %k.addr.11, 2
  %arrayidx284 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc277
  store i8 0, i8* %arrayidx284, align 1, !tbaa !7
  br label %if.end.285

if.end.285:                                       ; preds = %if.then.282, %if.end.274
  %k.addr.12 = phi i32 [ %inc283, %if.then.282 ], [ %inc277, %if.end.274 ]
  %31 = load i32, i32* @lcode, align 4, !tbaa !5
  %shr286 = lshr i32 %31, 8
  %conv287 = trunc i32 %shr286 to i8
  %inc288 = add nsw i32 %k.addr.12, 1
  %arrayidx289 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.12
  store i8 %conv287, i8* %arrayidx289, align 1, !tbaa !7
  %conv290 = and i32 %shr286, 255
  %cmp291 = icmp eq i32 %conv290, 255
  br i1 %cmp291, label %if.then.293, label %if.end.296

if.then.293:                                      ; preds = %if.end.285
  %inc294 = add nsw i32 %k.addr.12, 2
  %arrayidx295 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc288
  store i8 0, i8* %arrayidx295, align 1, !tbaa !7
  br label %if.end.296

if.end.296:                                       ; preds = %if.then.293, %if.end.285
  %k.addr.13 = phi i32 [ %inc294, %if.then.293 ], [ %inc288, %if.end.285 ]
  %32 = load i32, i32* @lcode, align 4, !tbaa !5
  %conv297 = trunc i32 %32 to i8
  %inc298 = add nsw i32 %k.addr.13, 1
  %arrayidx299 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.13
  store i8 %conv297, i8* %arrayidx299, align 1, !tbaa !7
  %conv300 = and i32 %32, 255
  %cmp301 = icmp eq i32 %conv300, 255
  br i1 %cmp301, label %if.then.303, label %if.end.306

if.then.303:                                      ; preds = %if.end.296
  %inc304 = add nsw i32 %k.addr.13, 2
  %arrayidx305 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc298
  store i8 0, i8* %arrayidx305, align 1, !tbaa !7
  br label %if.end.306

if.end.306:                                       ; preds = %if.then.303, %if.end.296
  %k.addr.14 = phi i32 [ %inc304, %if.then.303 ], [ %inc298, %if.end.296 ]
  store i32 %or236, i32* @lcode, align 4, !tbaa !5
  br label %if.end.307

if.end.307:                                       ; preds = %if.end.306, %if.then.249
  %33 = phi i32 [ %or236, %if.end.306 ], [ %or252, %if.then.249 ]
  %storemerge.544.in = phi i32 [ %sub244, %if.end.306 ], [ %add255, %if.then.249 ]
  %k.addr.15 = phi i32 [ %k.addr.14, %if.end.306 ], [ %k.addr.6.ph.lcssa, %if.then.249 ]
  %storemerge.544 = trunc i32 %storemerge.544.in to i16
  store i16 %storemerge.544, i16* @bitindex, align 2, !tbaa !1
  br label %for.inc

if.else.308:                                      ; preds = %for.body
  %inc309 = add i16 %RunLength.0563, 1
  br label %for.inc

for.inc:                                          ; preds = %if.end.307, %if.else.308
  %34 = phi i32 [ %33, %if.end.307 ], [ %12, %if.else.308 ]
  %35 = phi i16 [ %storemerge.544, %if.end.307 ], [ %13, %if.else.308 ]
  %RunLength.2 = phi i16 [ 0, %if.end.307 ], [ %inc309, %if.else.308 ]
  %k.addr.16 = phi i32 [ %k.addr.15, %if.end.307 ], [ %k.addr.5564, %if.else.308 ]
  %dec311 = add nsw i16 %i.0561, -1
  %cmp104 = icmp eq i16 %dec311, 0
  br i1 %cmp104, label %for.end, label %for.body

for.end:                                          ; preds = %for.inc
  %k.addr.16.lcssa = phi i32 [ %k.addr.16, %for.inc ]
  %RunLength.2.lcssa = phi i16 [ %RunLength.2, %for.inc ]
  %.lcssa613 = phi i16 [ %35, %for.inc ]
  %.lcssa612 = phi i32 [ %34, %for.inc ]
  %cmp313 = icmp eq i16 %RunLength.2.lcssa, 0
  br i1 %cmp313, label %if.end.386, label %if.then.315

if.then.315:                                      ; preds = %for.end
  %36 = load i16, i16* %AcCodeTable.0, align 2, !tbaa !1
  %conv317 = zext i16 %36 to i32
  %37 = load i16, i16* %AcSizeTable.0, align 2, !tbaa !1
  %add321 = add i16 %37, -32
  %sub322 = add i16 %add321, %.lcssa613
  %cmp325 = icmp slt i16 %sub322, 0
  br i1 %cmp325, label %if.then.327, label %if.else.335

if.then.327:                                      ; preds = %if.then.315
  %conv320 = zext i16 %37 to i32
  %shl329 = shl i32 %.lcssa612, %conv320
  %or330 = or i32 %shl329, %conv317
  store i32 %or330, i32* @lcode, align 4, !tbaa !5
  %add333 = add i16 %.lcssa613, %37
  store i16 %add333, i16* @bitindex, align 2, !tbaa !1
  br label %if.end.386

if.else.335:                                      ; preds = %if.then.315
  %conv324 = sext i16 %sub322 to i32
  %conv319 = zext i16 %.lcssa613 to i32
  %sub337 = sub nsw i32 32, %conv319
  %shl338 = shl i32 %.lcssa612, %sub337
  %shr340 = lshr i32 %conv317, %conv324
  %or341 = or i32 %shr340, %shl338
  store i32 %or341, i32* @lcode, align 4, !tbaa !5
  %shr342 = lshr i32 %or341, 24
  %conv343 = trunc i32 %shr342 to i8
  %inc344 = add nsw i32 %k.addr.16.lcssa, 1
  %arrayidx345 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.16.lcssa
  store i8 %conv343, i8* %arrayidx345, align 1, !tbaa !7
  %cmp347 = icmp eq i32 %shr342, 255
  br i1 %cmp347, label %if.then.349, label %if.end.352

if.then.349:                                      ; preds = %if.else.335
  %inc350 = add nsw i32 %k.addr.16.lcssa, 2
  %arrayidx351 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc344
  store i8 0, i8* %arrayidx351, align 1, !tbaa !7
  br label %if.end.352

if.end.352:                                       ; preds = %if.then.349, %if.else.335
  %k.addr.17 = phi i32 [ %inc350, %if.then.349 ], [ %inc344, %if.else.335 ]
  %38 = load i32, i32* @lcode, align 4, !tbaa !5
  %shr353 = lshr i32 %38, 16
  %conv354 = trunc i32 %shr353 to i8
  %inc355 = add nsw i32 %k.addr.17, 1
  %arrayidx356 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.17
  store i8 %conv354, i8* %arrayidx356, align 1, !tbaa !7
  %conv357 = and i32 %shr353, 255
  %cmp358 = icmp eq i32 %conv357, 255
  br i1 %cmp358, label %if.then.360, label %if.end.363

if.then.360:                                      ; preds = %if.end.352
  %inc361 = add nsw i32 %k.addr.17, 2
  %arrayidx362 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc355
  store i8 0, i8* %arrayidx362, align 1, !tbaa !7
  br label %if.end.363

if.end.363:                                       ; preds = %if.then.360, %if.end.352
  %k.addr.18 = phi i32 [ %inc361, %if.then.360 ], [ %inc355, %if.end.352 ]
  %39 = load i32, i32* @lcode, align 4, !tbaa !5
  %shr364 = lshr i32 %39, 8
  %conv365 = trunc i32 %shr364 to i8
  %inc366 = add nsw i32 %k.addr.18, 1
  %arrayidx367 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.18
  store i8 %conv365, i8* %arrayidx367, align 1, !tbaa !7
  %conv368 = and i32 %shr364, 255
  %cmp369 = icmp eq i32 %conv368, 255
  br i1 %cmp369, label %if.then.371, label %if.end.374

if.then.371:                                      ; preds = %if.end.363
  %inc372 = add nsw i32 %k.addr.18, 2
  %arrayidx373 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc366
  store i8 0, i8* %arrayidx373, align 1, !tbaa !7
  br label %if.end.374

if.end.374:                                       ; preds = %if.then.371, %if.end.363
  %k.addr.19 = phi i32 [ %inc372, %if.then.371 ], [ %inc366, %if.end.363 ]
  %40 = load i32, i32* @lcode, align 4, !tbaa !5
  %conv375 = trunc i32 %40 to i8
  %inc376 = add nsw i32 %k.addr.19, 1
  %arrayidx377 = getelementptr inbounds i8, i8* %output_ptr, i32 %k.addr.19
  store i8 %conv375, i8* %arrayidx377, align 1, !tbaa !7
  %conv378 = and i32 %40, 255
  %cmp379 = icmp eq i32 %conv378, 255
  br i1 %cmp379, label %if.then.381, label %if.end.384

if.then.381:                                      ; preds = %if.end.374
  %inc382 = add nsw i32 %k.addr.19, 2
  %arrayidx383 = getelementptr inbounds i8, i8* %output_ptr, i32 %inc376
  store i8 0, i8* %arrayidx383, align 1, !tbaa !7
  br label %if.end.384

if.end.384:                                       ; preds = %if.then.381, %if.end.374
  %k.addr.20 = phi i32 [ %inc382, %if.then.381 ], [ %inc376, %if.end.374 ]
  store i32 %conv317, i32* @lcode, align 4, !tbaa !5
  store i16 %sub322, i16* @bitindex, align 2, !tbaa !1
  br label %if.end.386

if.end.386:                                       ; preds = %for.end, %if.then.327, %if.end.384
  %k.addr.21 = phi i32 [ %k.addr.16.lcssa, %if.then.327 ], [ %k.addr.20, %if.end.384 ], [ %k.addr.16.lcssa, %for.end ]
  ret i32 %k.addr.21
}

; Function Attrs: nounwind
define i32 @closeBitstream(i8* nocapture %outputBuffer, i32 %k) #0 {
entry:
  %0 = load i16, i16* @bitindex, align 2, !tbaa !1
  %cmp = icmp eq i16 %0, 0
  br i1 %cmp, label %if.end.14, label %if.then

if.then:                                          ; preds = %entry
  %conv = zext i16 %0 to i32
  %sub = sub nsw i32 32, %conv
  %1 = load i32, i32* @lcode, align 4, !tbaa !5
  %shl = shl i32 %1, %sub
  store i32 %shl, i32* @lcode, align 4, !tbaa !5
  %add = add nuw nsw i32 %conv, 7
  %shr.22 = lshr i32 %add, 3
  %conv4 = trunc i32 %shr.22 to i16
  %cmp6.23 = icmp eq i16 %conv4, 0
  br i1 %cmp6.23, label %if.end.14, label %for.body.lr.ph

for.body.lr.ph:                                   ; preds = %if.then
  %2 = lshr i32 %shl, 24
  %3 = trunc i32 %2 to i8
  br label %for.body

for.body:                                         ; preds = %for.inc.for.body_crit_edge, %for.body.lr.ph
  %4 = phi i8 [ %3, %for.body.lr.ph ], [ %.pre, %for.inc.for.body_crit_edge ]
  %ptr.026 = phi i8* [ getelementptr (i8, i8* bitcast (i32* @lcode to i8*), i32 3), %for.body.lr.ph ], [ %incdec.ptr, %for.inc.for.body_crit_edge ]
  %k.addr.025 = phi i32 [ %k, %for.body.lr.ph ], [ %k.addr.1, %for.inc.for.body_crit_edge ]
  %i.024 = phi i16 [ %conv4, %for.body.lr.ph ], [ %dec, %for.inc.for.body_crit_edge ]
  %incdec.ptr = getelementptr inbounds i8, i8* %ptr.026, i32 -1
  %inc = add nsw i32 %k.addr.025, 1
  %arrayidx = getelementptr inbounds i8, i8* %outputBuffer, i32 %k.addr.025
  store i8 %4, i8* %arrayidx, align 1, !tbaa !7
  %cmp9 = icmp eq i8 %4, -1
  br i1 %cmp9, label %if.then.11, label %for.inc

if.then.11:                                       ; preds = %for.body
  %inc12 = add nsw i32 %k.addr.025, 2
  %arrayidx13 = getelementptr inbounds i8, i8* %outputBuffer, i32 %inc
  store i8 0, i8* %arrayidx13, align 1, !tbaa !7
  br label %for.inc

for.inc:                                          ; preds = %for.body, %if.then.11
  %k.addr.1 = phi i32 [ %inc12, %if.then.11 ], [ %inc, %for.body ]
  %dec = add i16 %i.024, -1
  %cmp6 = icmp eq i16 %dec, 0
  br i1 %cmp6, label %if.end.14.loopexit, label %for.inc.for.body_crit_edge

for.inc.for.body_crit_edge:                       ; preds = %for.inc
  %.pre = load i8, i8* %incdec.ptr, align 1, !tbaa !7
  br label %for.body

if.end.14.loopexit:                               ; preds = %for.inc
  %k.addr.1.lcssa = phi i32 [ %k.addr.1, %for.inc ]
  br label %if.end.14

if.end.14:                                        ; preds = %if.end.14.loopexit, %if.then, %entry
  %k.addr.2 = phi i32 [ %k, %entry ], [ %k, %if.then ], [ %k.addr.1.lcssa, %if.end.14.loopexit ]
  ret i32 %k.addr.2
}

attributes #0 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="pentium4" "target-features"="+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.7.1 (tags/RELEASE_371/final)"}
!1 = !{!2, !2, i64 0}
!2 = !{!"short", !3, i64 0}
!3 = !{!"omnipotent char", !4, i64 0}
!4 = !{!"Simple C/C++ TBAA"}
!5 = !{!6, !6, i64 0}
!6 = !{!"int", !3, i64 0}
!7 = !{!3, !3, i64 0}
