; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -passes=licm -mtriple aarch64-linux-gnu -S < %s | FileCheck %s

define i1 @func(ptr %0, i64 %1) {
; CHECK-LABEL: @func(
; CHECK-NEXT:    br label [[TMP3:%.*]]
; CHECK:       3:
; CHECK-NEXT:    [[TMP4:%.*]] = phi i64 [ 0, [[TMP2:%.*]] ], [ [[TMP12:%.*]], [[TMP11:%.*]] ]
; CHECK-NEXT:    [[TMP5:%.*]] = icmp ult i64 [[TMP4]], [[TMP1:%.*]]
; CHECK-NEXT:    br i1 [[TMP5]], label [[TMP6:%.*]], label [[DOTSPLIT_LOOP_EXIT2:%.*]]
; CHECK:       6:
; CHECK-NEXT:    [[TMP7:%.*]] = getelementptr inbounds <1 x i64>, ptr [[TMP0:%.*]], i64 [[TMP4]]
; CHECK-NEXT:    [[TMP8:%.*]] = load <1 x i64>, ptr [[TMP7]], align 8
; CHECK-NEXT:    [[TMP9:%.*]] = extractelement <1 x i64> [[TMP8]], i64 0
; CHECK-NEXT:    [[TMP10:%.*]] = icmp eq i64 [[TMP9]], -1
; CHECK-NEXT:    br i1 [[TMP10]], label [[TMP11]], label [[DOTSPLIT_LOOP_EXIT:%.*]]
; CHECK:       11:
; CHECK-NEXT:    [[TMP12]] = add i64 [[TMP4]], 1
; CHECK-NEXT:    br label [[TMP3]]
; CHECK:       .split.loop.exit:
; CHECK-NEXT:    [[DOTLCSSA:%.*]] = phi i64 [ [[TMP9]], [[TMP6]] ]
; CHECK-NEXT:    [[DOTLCSSA6:%.*]] = phi i64 [ [[TMP4]], [[TMP6]] ]
; CHECK-NEXT:    [[DOTPH:%.*]] = phi i1 [ [[TMP5]], [[TMP6]] ]
; CHECK-NEXT:    [[TMP13:%.*]] = xor i64 [[DOTLCSSA]], -1
; CHECK-NEXT:    [[TMP14:%.*]] = add i64 [[TMP13]], [[DOTLCSSA6]]
; CHECK-NEXT:    [[TMP15:%.*]] = icmp uge i64 [[TMP14]], [[TMP1]]
; CHECK-NEXT:    br label [[TMP16:%.*]]
; CHECK:       .split.loop.exit2:
; CHECK-NEXT:    [[DOTPH3:%.*]] = phi i1 [ [[TMP5]], [[TMP3]] ]
; CHECK-NEXT:    [[DOTPH4:%.*]] = phi i1 [ undef, [[TMP3]] ]
; CHECK-NEXT:    br label [[TMP16]]
; CHECK:       16:
; CHECK-NEXT:    [[TMP17:%.*]] = phi i1 [ [[DOTPH]], [[DOTSPLIT_LOOP_EXIT]] ], [ [[DOTPH3]], [[DOTSPLIT_LOOP_EXIT2]] ]
; CHECK-NEXT:    [[TMP18:%.*]] = phi i1 [ [[TMP15]], [[DOTSPLIT_LOOP_EXIT]] ], [ [[DOTPH4]], [[DOTSPLIT_LOOP_EXIT2]] ]
; CHECK-NEXT:    [[TMP19:%.*]] = xor i1 [[TMP17]], true
; CHECK-NEXT:    [[TMP20:%.*]] = select i1 [[TMP19]], i1 true, i1 [[TMP18]]
; CHECK-NEXT:    ret i1 [[TMP20]]
;
  br label %3

3:                                                ; preds = %14, %2
  %4 = phi i64 [ 0, %2 ], [ %15, %14 ]
  %5 = icmp ult i64 %4, %1
  br i1 %5, label %6, label %16

6:                                                ; preds = %3
  %7 = getelementptr inbounds <1 x i64>, ptr %0, i64 %4
  %8 = load <1 x i64>, ptr %7, align 8
  %9 = extractelement <1 x i64> %8, i64 0
  %10 = icmp eq i64 %9, -1
  %11 = xor i64 %9, -1
  %12 = add i64 %11, %4
  %13 = icmp uge i64 %12, %1
  br i1 %10, label %14, label %16

14:                                               ; preds = %6
  %15 = add i64 %4, 1
  br label %3

16:                                               ; preds = %3, %6
  %17 = phi i1 [ %5, %3 ], [ %5, %6 ]
  %18 = phi i1 [ %13, %6 ], [ undef, %3 ]
  %19 = xor i1 %17, true
  %20 = select i1 %19, i1 true, i1 %18
  ret i1 %20
}