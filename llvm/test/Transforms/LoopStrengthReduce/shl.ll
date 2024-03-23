; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -loop-reduce -gvn -S | FileCheck %s

target datalayout = "e-i64:64-v16:16-v32:32-n16:32:64"

; LoopStrengthReduce should reuse %mul as the stride.
define void @_Z3fooPfll(ptr nocapture readonly %input, i64 %n, i64 %s) {
; CHECK-LABEL: define void @_Z3fooPfll
; CHECK-SAME: (ptr nocapture readonly [[INPUT:%.*]], i64 [[N:%.*]], i64 [[S:%.*]]) {
; CHECK-NEXT:  entry:
; CHECK-NEXT:    [[MUL:%.*]] = shl i64 [[S]], 2
; CHECK-NEXT:    tail call void @_Z3bazl(i64 [[MUL]])
; CHECK-NEXT:    [[CMP_5:%.*]] = icmp sgt i64 [[N]], 0
; CHECK-NEXT:    br i1 [[CMP_5]], label [[FOR_BODY_PREHEADER:%.*]], label [[FOR_COND_CLEANUP:%.*]]
; CHECK:       for.body.preheader:
; CHECK-NEXT:    br label [[FOR_BODY:%.*]]
; CHECK:       for.cond.cleanup.loopexit:
; CHECK-NEXT:    br label [[FOR_COND_CLEANUP]]
; CHECK:       for.cond.cleanup:
; CHECK-NEXT:    ret void
; CHECK:       for.body:
; CHECK-NEXT:    [[LSR_IV:%.*]] = phi ptr [ [[SCEVGEP:%.*]], [[FOR_BODY]] ], [ [[INPUT]], [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[I_06:%.*]] = phi i64 [ [[ADD:%.*]], [[FOR_BODY]] ], [ 0, [[FOR_BODY_PREHEADER]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = load float, ptr [[LSR_IV]], align 4
; CHECK-NEXT:    tail call void @_Z3barf(float [[TMP0]])
; CHECK-NEXT:    [[ADD]] = add i64 [[I_06]], [[S]]
; CHECK-NEXT:    [[SCEVGEP]] = getelementptr i8, ptr [[LSR_IV]], i64 [[MUL]]
; CHECK-NEXT:    [[CMP:%.*]] = icmp slt i64 [[ADD]], [[N]]
; CHECK-NEXT:    br i1 [[CMP]], label [[FOR_BODY]], label [[FOR_COND_CLEANUP_LOOPEXIT:%.*]]
;
entry:
  %mul = shl nsw i64 %s, 2
  tail call void @_Z3bazl(i64 %mul) #2
  %cmp.5 = icmp sgt i64 %n, 0
  br i1 %cmp.5, label %for.body.preheader, label %for.cond.cleanup

for.body.preheader:                               ; preds = %entry
  br label %for.body

for.cond.cleanup.loopexit:                        ; preds = %for.body
  br label %for.cond.cleanup

for.cond.cleanup:                                 ; preds = %for.cond.cleanup.loopexit, %entry
  ret void

for.body:                                         ; preds = %for.body.preheader, %for.body
  %i.06 = phi i64 [ %add, %for.body ], [ 0, %for.body.preheader ]
  %arrayidx = getelementptr inbounds float, ptr %input, i64 %i.06
  %0 = load float, ptr %arrayidx, align 4
  tail call void @_Z3barf(float %0) #2
  %add = add nsw i64 %i.06, %s
  %cmp = icmp slt i64 %add, %n
  br i1 %cmp, label %for.body, label %for.cond.cleanup.loopexit
}

declare void @_Z3bazl(i64)

declare void @_Z3barf(float)