; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -S -passes=early-cse -earlycse-debug-hash | FileCheck %s
; RUN: opt < %s -S -passes='early-cse<memssa>' | FileCheck %s

define i64 @branching_int(i32 %a) {
; CHECK-LABEL: @branching_int(
; CHECK-NEXT:    [[CONV1:%.*]] = zext i32 [[A:%.*]] to i64
; CHECK-NEXT:    [[CMP2:%.*]] = icmp ugt i64 1, [[CONV1]]
; CHECK-NEXT:    br i1 [[CMP2]], label [[IF_THEN3:%.*]], label [[IF_END3:%.*]]
; CHECK:       if.then3:
; CHECK-NEXT:    [[C:%.*]] = call double @truefunc.f64.i1(i1 true)
; CHECK-NEXT:    br label [[OUT:%.*]]
; CHECK:       if.end3:
; CHECK-NEXT:    [[D:%.*]] = call double @falsefunc.f64.i1(i1 false)
; CHECK-NEXT:    br label [[OUT]]
; CHECK:       out:
; CHECK-NEXT:    ret i64 [[CONV1]]
;
  %conv1 = zext i32 %a to i64
  %cmp2 = icmp ugt i64 1, %conv1
  br i1 %cmp2, label %if.then3, label %if.end3

if.then3:
  %c = call double @truefunc.f64.i1(i1 %cmp2)
  br label %out

if.end3:
  %d = call double @falsefunc.f64.i1(i1 %cmp2)
  br label %out

out:
  ret i64 %conv1
}

define double @branching_fp(i64 %a) {
; CHECK-LABEL: @branching_fp(
; CHECK-NEXT:    [[CONV1:%.*]] = uitofp i64 [[A:%.*]] to double
; CHECK-NEXT:    [[CMP2:%.*]] = fcmp ogt double 1.000000e+00, [[CONV1]]
; CHECK-NEXT:    br i1 [[CMP2]], label [[IF_THEN3:%.*]], label [[IF_END3:%.*]]
; CHECK:       if.then3:
; CHECK-NEXT:    [[C:%.*]] = call double @truefunc.f64.i1(i1 true)
; CHECK-NEXT:    br label [[OUT:%.*]]
; CHECK:       if.end3:
; CHECK-NEXT:    [[D:%.*]] = call double @falsefunc.f64.i1(i1 false)
; CHECK-NEXT:    br label [[OUT]]
; CHECK:       out:
; CHECK-NEXT:    ret double [[CONV1]]
;
  %conv1 = uitofp i64 %a to double
  %cmp2 = fcmp ogt double 1.000000e+00, %conv1
  br i1 %cmp2, label %if.then3, label %if.end3

if.then3:
  %c = call double @truefunc.f64.i1(i1 %cmp2)
  br label %out

if.end3:
  %d = call double @falsefunc.f64.i1(i1 %cmp2)
  br label %out

out:
  ret double %conv1
}

define double @branching_exceptignore(i64 %a) #0 {
; CHECK-LABEL: @branching_exceptignore(
; CHECK-NEXT:    [[CONV1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i64(i64 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.ignore") #[[ATTR0:[0-9]+]]
; CHECK-NEXT:    [[CMP2:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double 1.000000e+00, double [[CONV1]], metadata !"ogt", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    br i1 [[CMP2]], label [[IF_THEN3:%.*]], label [[IF_END3:%.*]]
; CHECK:       if.then3:
; CHECK-NEXT:    [[C:%.*]] = call double @truefunc.f64.i1(i1 true) #[[ATTR0]]
; CHECK-NEXT:    br label [[OUT:%.*]]
; CHECK:       if.end3:
; CHECK-NEXT:    [[D:%.*]] = call double @falsefunc.f64.i1(i1 false) #[[ATTR0]]
; CHECK-NEXT:    br label [[OUT]]
; CHECK:       out:
; CHECK-NEXT:    ret double [[CONV1]]
;
  %conv1 = call double @llvm.experimental.constrained.uitofp.f64.i64(i64 %a, metadata !"round.tonearest", metadata !"fpexcept.ignore") #0
  %cmp2 = call i1 @llvm.experimental.constrained.fcmps.f64(double 1.000000e+00, double %conv1, metadata !"ogt", metadata !"fpexcept.ignore") #0
  br i1 %cmp2, label %if.then3, label %if.end3

if.then3:
  %c = call double @truefunc.f64.i1(i1 %cmp2) #0
  br label %out

if.end3:
  %d = call double @falsefunc.f64.i1(i1 %cmp2) #0
  br label %out

out:
  ret double %conv1
}

define double @branching_exceptignore_dynround(i64 %a) #0 {
; CHECK-LABEL: @branching_exceptignore_dynround(
; CHECK-NEXT:    [[CONV1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i64(i64 [[A:%.*]], metadata !"round.dynamic", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    [[CMP2:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double 1.000000e+00, double [[CONV1]], metadata !"ogt", metadata !"fpexcept.ignore") #[[ATTR0]]
; CHECK-NEXT:    br i1 [[CMP2]], label [[IF_THEN3:%.*]], label [[IF_END3:%.*]]
; CHECK:       if.then3:
; CHECK-NEXT:    [[C:%.*]] = call double @truefunc.f64.i1(i1 true) #[[ATTR0]]
; CHECK-NEXT:    br label [[OUT:%.*]]
; CHECK:       if.end3:
; CHECK-NEXT:    [[D:%.*]] = call double @falsefunc.f64.i1(i1 false) #[[ATTR0]]
; CHECK-NEXT:    br label [[OUT]]
; CHECK:       out:
; CHECK-NEXT:    ret double [[CONV1]]
;
  %conv1 = call double @llvm.experimental.constrained.uitofp.f64.i64(i64 %a, metadata !"round.dynamic", metadata !"fpexcept.ignore") #0
  %cmp2 = call i1 @llvm.experimental.constrained.fcmps.f64(double 1.000000e+00, double %conv1, metadata !"ogt", metadata !"fpexcept.ignore") #0
  br i1 %cmp2, label %if.then3, label %if.end3

if.then3:
  %c = call double @truefunc.f64.i1(i1 %cmp2) #0
  br label %out

if.end3:
  %d = call double @falsefunc.f64.i1(i1 %cmp2) #0
  br label %out

out:
  ret double %conv1
}

define double @branching_maytrap(i64 %a) #0 {
; CHECK-LABEL: @branching_maytrap(
; CHECK-NEXT:    [[CONV1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i64(i64 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    [[CMP2:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double 1.000000e+00, double [[CONV1]], metadata !"ogt", metadata !"fpexcept.maytrap") #[[ATTR0]]
; CHECK-NEXT:    br i1 [[CMP2]], label [[IF_THEN3:%.*]], label [[IF_END3:%.*]]
; CHECK:       if.then3:
; CHECK-NEXT:    [[C:%.*]] = call double @truefunc.f64.i1(i1 true) #[[ATTR0]]
; CHECK-NEXT:    br label [[OUT:%.*]]
; CHECK:       if.end3:
; CHECK-NEXT:    [[D:%.*]] = call double @falsefunc.f64.i1(i1 false) #[[ATTR0]]
; CHECK-NEXT:    br label [[OUT]]
; CHECK:       out:
; CHECK-NEXT:    ret double [[CONV1]]
;
  %conv1 = call double @llvm.experimental.constrained.uitofp.f64.i64(i64 %a, metadata !"round.tonearest", metadata !"fpexcept.maytrap") #0
  %cmp2 = call i1 @llvm.experimental.constrained.fcmps.f64(double 1.000000e+00, double %conv1, metadata !"ogt", metadata !"fpexcept.maytrap") #0
  br i1 %cmp2, label %if.then3, label %if.end3

if.then3:
  %c = call double @truefunc.f64.i1(i1 %cmp2) #0
  br label %out

if.end3:
  %d = call double @falsefunc.f64.i1(i1 %cmp2) #0
  br label %out

out:
  ret double %conv1
}

; TODO: Fix this optimization so it works with strict exception behavior.
; TODO: This may or may not be worth the added complication and risk.
define double @branching_ebstrict(i64 %a) #0 {
; CHECK-LABEL: @branching_ebstrict(
; CHECK-NEXT:    [[CONV1:%.*]] = call double @llvm.experimental.constrained.uitofp.f64.i64(i64 [[A:%.*]], metadata !"round.tonearest", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    [[CMP2:%.*]] = call i1 @llvm.experimental.constrained.fcmps.f64(double 1.000000e+00, double [[CONV1]], metadata !"ogt", metadata !"fpexcept.strict") #[[ATTR0]]
; CHECK-NEXT:    br i1 [[CMP2]], label [[IF_THEN3:%.*]], label [[IF_END3:%.*]]
; CHECK:       if.then3:
; CHECK-NEXT:    [[C:%.*]] = call double @truefunc.f64.i1(i1 [[CMP2]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[OUT:%.*]]
; CHECK:       if.end3:
; CHECK-NEXT:    [[D:%.*]] = call double @falsefunc.f64.i1(i1 [[CMP2]]) #[[ATTR0]]
; CHECK-NEXT:    br label [[OUT]]
; CHECK:       out:
; CHECK-NEXT:    ret double [[CONV1]]
;
  %conv1 = call double @llvm.experimental.constrained.uitofp.f64.i64(i64 %a, metadata !"round.tonearest", metadata !"fpexcept.strict") #0
  %cmp2 = call i1 @llvm.experimental.constrained.fcmps.f64(double 1.000000e+00, double %conv1, metadata !"ogt", metadata !"fpexcept.strict") #0
  br i1 %cmp2, label %if.then3, label %if.end3

if.then3:
  %c = call double @truefunc.f64.i1(i1 %cmp2) #0
  br label %out

if.end3:
  %d = call double @falsefunc.f64.i1(i1 %cmp2) #0
  br label %out

out:
  ret double %conv1
}

declare double @truefunc.f64.i1(i1)
declare double @falsefunc.f64.i1(i1)
declare double @llvm.experimental.constrained.uitofp.f64.i64(i64, metadata, metadata) #0
declare i1 @llvm.experimental.constrained.fcmps.f64(double, double, metadata, metadata) #0

attributes #0 = { strictfp }

declare <4 x float> @llvm.experimental.constrained.fadd.v4f32(<4 x float>, <4 x float>, metadata, metadata) strictfp