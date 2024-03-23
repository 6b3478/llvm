; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=riscv32 -mattr=+m,+d,+zfh,+v,+zvfh \
; RUN:   -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,CHECK-RV32
; RUN: llc -mtriple=riscv64 -mattr=+m,+d,+zfh,+v,+zvfh \
; RUN:   -riscv-v-vector-bits-min=128 -verify-machineinstrs < %s \
; RUN:   | FileCheck %s --check-prefixes=CHECK,CHECK-RV64

declare <2 x i8> @llvm.experimental.vp.strided.load.v2i8.p0.i8(ptr, i8, <2 x i1>, i32)

define <2 x i8> @strided_vpload_v2i8_i8(ptr %ptr, i8 signext %stride, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v2i8_i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf8, ta, ma
; CHECK-NEXT:    vlse8.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <2 x i8> @llvm.experimental.vp.strided.load.v2i8.p0.i8(ptr %ptr, i8 %stride, <2 x i1> %m, i32 %evl)
  ret <2 x i8> %load
}

declare <2 x i8> @llvm.experimental.vp.strided.load.v2i8.p0.i16(ptr, i16, <2 x i1>, i32)

define <2 x i8> @strided_vpload_v2i8_i16(ptr %ptr, i16 signext %stride, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v2i8_i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf8, ta, ma
; CHECK-NEXT:    vlse8.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <2 x i8> @llvm.experimental.vp.strided.load.v2i8.p0.i16(ptr %ptr, i16 %stride, <2 x i1> %m, i32 %evl)
  ret <2 x i8> %load
}

declare <2 x i8> @llvm.experimental.vp.strided.load.v2i8.p0.i64(ptr, i64, <2 x i1>, i32)

define <2 x i8> @strided_vpload_v2i8_i64(ptr %ptr, i64 signext %stride, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-RV32-LABEL: strided_vpload_v2i8_i64:
; CHECK-RV32:       # %bb.0:
; CHECK-RV32-NEXT:    vsetvli zero, a3, e8, mf8, ta, ma
; CHECK-RV32-NEXT:    vlse8.v v8, (a0), a1, v0.t
; CHECK-RV32-NEXT:    ret
;
; CHECK-RV64-LABEL: strided_vpload_v2i8_i64:
; CHECK-RV64:       # %bb.0:
; CHECK-RV64-NEXT:    vsetvli zero, a2, e8, mf8, ta, ma
; CHECK-RV64-NEXT:    vlse8.v v8, (a0), a1, v0.t
; CHECK-RV64-NEXT:    ret
  %load = call <2 x i8> @llvm.experimental.vp.strided.load.v2i8.p0.i64(ptr %ptr, i64 %stride, <2 x i1> %m, i32 %evl)
  ret <2 x i8> %load
}

declare <2 x i8> @llvm.experimental.vp.strided.load.v2i8.p0.i32(ptr, i32, <2 x i1>, i32)

define <2 x i8> @strided_vpload_v2i8(ptr %ptr, i32 signext %stride, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v2i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf8, ta, ma
; CHECK-NEXT:    vlse8.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <2 x i8> @llvm.experimental.vp.strided.load.v2i8.p0.i32(ptr %ptr, i32 %stride, <2 x i1> %m, i32 %evl)
  ret <2 x i8> %load
}

declare <4 x i8> @llvm.experimental.vp.strided.load.v4i8.p0.i32(ptr, i32, <4 x i1>, i32)

define <4 x i8> @strided_vpload_v4i8(ptr %ptr, i32 signext %stride, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v4i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf4, ta, ma
; CHECK-NEXT:    vlse8.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <4 x i8> @llvm.experimental.vp.strided.load.v4i8.p0.i32(ptr %ptr, i32 %stride, <4 x i1> %m, i32 %evl)
  ret <4 x i8> %load
}

define <4 x i8> @strided_vpload_v4i8_allones_mask(ptr %ptr, i32 signext %stride, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v4i8_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf4, ta, ma
; CHECK-NEXT:    vlse8.v v8, (a0), a1
; CHECK-NEXT:    ret
  %a = insertelement <4 x i1> poison, i1 true, i32 0
  %b = shufflevector <4 x i1> %a, <4 x i1> poison, <4 x i32> zeroinitializer
  %load = call <4 x i8> @llvm.experimental.vp.strided.load.v4i8.p0.i32(ptr %ptr, i32 %stride, <4 x i1> %b, i32 %evl)
  ret <4 x i8> %load
}

declare <8 x i8> @llvm.experimental.vp.strided.load.v8i8.p0.i32(ptr, i32, <8 x i1>, i32)

define <8 x i8> @strided_vpload_v8i8(ptr %ptr, i32 signext %stride, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v8i8:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e8, mf2, ta, ma
; CHECK-NEXT:    vlse8.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <8 x i8> @llvm.experimental.vp.strided.load.v8i8.p0.i32(ptr %ptr, i32 %stride, <8 x i1> %m, i32 %evl)
  ret <8 x i8> %load
}

declare <2 x i16> @llvm.experimental.vp.strided.load.v2i16.p0.i32(ptr, i32, <2 x i1>, i32)

define <2 x i16> @strided_vpload_v2i16(ptr %ptr, i32 signext %stride, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v2i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, mf4, ta, ma
; CHECK-NEXT:    vlse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <2 x i16> @llvm.experimental.vp.strided.load.v2i16.p0.i32(ptr %ptr, i32 %stride, <2 x i1> %m, i32 %evl)
  ret <2 x i16> %load
}

declare <4 x i16> @llvm.experimental.vp.strided.load.v4i16.p0.i32(ptr, i32, <4 x i1>, i32)

define <4 x i16> @strided_vpload_v4i16(ptr %ptr, i32 signext %stride, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v4i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, mf2, ta, ma
; CHECK-NEXT:    vlse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <4 x i16> @llvm.experimental.vp.strided.load.v4i16.p0.i32(ptr %ptr, i32 %stride, <4 x i1> %m, i32 %evl)
  ret <4 x i16> %load
}

declare <8 x i16> @llvm.experimental.vp.strided.load.v8i16.p0.i32(ptr, i32, <8 x i1>, i32)

define <8 x i16> @strided_vpload_v8i16(ptr %ptr, i32 signext %stride, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v8i16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, ta, ma
; CHECK-NEXT:    vlse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <8 x i16> @llvm.experimental.vp.strided.load.v8i16.p0.i32(ptr %ptr, i32 %stride, <8 x i1> %m, i32 %evl)
  ret <8 x i16> %load
}

define <8 x i16> @strided_vpload_v8i16_allones_mask(ptr %ptr, i32 signext %stride, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v8i16_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, ta, ma
; CHECK-NEXT:    vlse16.v v8, (a0), a1
; CHECK-NEXT:    ret
  %a = insertelement <8 x i1> poison, i1 true, i32 0
  %b = shufflevector <8 x i1> %a, <8 x i1> poison, <8 x i32> zeroinitializer
  %load = call <8 x i16> @llvm.experimental.vp.strided.load.v8i16.p0.i32(ptr %ptr, i32 %stride, <8 x i1> %b, i32 %evl)
  ret <8 x i16> %load
}

declare <2 x i32> @llvm.experimental.vp.strided.load.v2i32.p0.i32(ptr, i32, <2 x i1>, i32)

define <2 x i32> @strided_vpload_v2i32(ptr %ptr, i32 signext %stride, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v2i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, mf2, ta, ma
; CHECK-NEXT:    vlse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <2 x i32> @llvm.experimental.vp.strided.load.v2i32.p0.i32(ptr %ptr, i32 %stride, <2 x i1> %m, i32 %evl)
  ret <2 x i32> %load
}

declare <4 x i32> @llvm.experimental.vp.strided.load.v4i32.p0.i32(ptr, i32, <4 x i1>, i32)

define <4 x i32> @strided_vpload_v4i32(ptr %ptr, i32 signext %stride, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v4i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-NEXT:    vlse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <4 x i32> @llvm.experimental.vp.strided.load.v4i32.p0.i32(ptr %ptr, i32 %stride, <4 x i1> %m, i32 %evl)
  ret <4 x i32> %load
}

declare <8 x i32> @llvm.experimental.vp.strided.load.v8i32.p0.i32(ptr, i32, <8 x i1>, i32)

define <8 x i32> @strided_vpload_v8i32(ptr %ptr, i32 signext %stride, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v8i32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, ta, ma
; CHECK-NEXT:    vlse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <8 x i32> @llvm.experimental.vp.strided.load.v8i32.p0.i32(ptr %ptr, i32 %stride, <8 x i1> %m, i32 %evl)
  ret <8 x i32> %load
}

define <8 x i32> @strided_vpload_v8i32_allones_mask(ptr %ptr, i32 signext %stride, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v8i32_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, ta, ma
; CHECK-NEXT:    vlse32.v v8, (a0), a1
; CHECK-NEXT:    ret
  %a = insertelement <8 x i1> poison, i1 true, i32 0
  %b = shufflevector <8 x i1> %a, <8 x i1> poison, <8 x i32> zeroinitializer
  %load = call <8 x i32> @llvm.experimental.vp.strided.load.v8i32.p0.i32(ptr %ptr, i32 %stride, <8 x i1> %b, i32 %evl)
  ret <8 x i32> %load
}

declare <2 x i64> @llvm.experimental.vp.strided.load.v2i64.p0.i32(ptr, i32, <2 x i1>, i32)

define <2 x i64> @strided_vpload_v2i64(ptr %ptr, i32 signext %stride, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v2i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, ta, ma
; CHECK-NEXT:    vlse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <2 x i64> @llvm.experimental.vp.strided.load.v2i64.p0.i32(ptr %ptr, i32 %stride, <2 x i1> %m, i32 %evl)
  ret <2 x i64> %load
}

declare <4 x i64> @llvm.experimental.vp.strided.load.v4i64.p0.i32(ptr, i32, <4 x i1>, i32)

define <4 x i64> @strided_vpload_v4i64(ptr %ptr, i32 signext %stride, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v4i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, ta, ma
; CHECK-NEXT:    vlse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <4 x i64> @llvm.experimental.vp.strided.load.v4i64.p0.i32(ptr %ptr, i32 %stride, <4 x i1> %m, i32 %evl)
  ret <4 x i64> %load
}

define <4 x i64> @strided_vpload_v4i64_allones_mask(ptr %ptr, i32 signext %stride, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v4i64_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, ta, ma
; CHECK-NEXT:    vlse64.v v8, (a0), a1
; CHECK-NEXT:    ret
  %a = insertelement <4 x i1> poison, i1 true, i32 0
  %b = shufflevector <4 x i1> %a, <4 x i1> poison, <4 x i32> zeroinitializer
  %load = call <4 x i64> @llvm.experimental.vp.strided.load.v4i64.p0.i32(ptr %ptr, i32 %stride, <4 x i1> %b, i32 %evl)
  ret <4 x i64> %load
}

declare <8 x i64> @llvm.experimental.vp.strided.load.v8i64.p0.i32(ptr, i32, <8 x i1>, i32)

define <8 x i64> @strided_vpload_v8i64(ptr %ptr, i32 signext %stride, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v8i64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, ta, ma
; CHECK-NEXT:    vlse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <8 x i64> @llvm.experimental.vp.strided.load.v8i64.p0.i32(ptr %ptr, i32 %stride, <8 x i1> %m, i32 %evl)
  ret <8 x i64> %load
}

declare <2 x half> @llvm.experimental.vp.strided.load.v2f16.p0.i32(ptr, i32, <2 x i1>, i32)

define <2 x half> @strided_vpload_v2f16(ptr %ptr, i32 signext %stride, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v2f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, mf4, ta, ma
; CHECK-NEXT:    vlse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <2 x half> @llvm.experimental.vp.strided.load.v2f16.p0.i32(ptr %ptr, i32 %stride, <2 x i1> %m, i32 %evl)
  ret <2 x half> %load
}

define <2 x half> @strided_vpload_v2f16_allones_mask(ptr %ptr, i32 signext %stride, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v2f16_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, mf4, ta, ma
; CHECK-NEXT:    vlse16.v v8, (a0), a1
; CHECK-NEXT:    ret
  %a = insertelement <2 x i1> poison, i1 true, i32 0
  %b = shufflevector <2 x i1> %a, <2 x i1> poison, <2 x i32> zeroinitializer
  %load = call <2 x half> @llvm.experimental.vp.strided.load.v2f16.p0.i32(ptr %ptr, i32 %stride, <2 x i1> %b, i32 %evl)
  ret <2 x half> %load
}

declare <4 x half> @llvm.experimental.vp.strided.load.v4f16.p0.i32(ptr, i32, <4 x i1>, i32)

define <4 x half> @strided_vpload_v4f16(ptr %ptr, i32 signext %stride, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v4f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, mf2, ta, ma
; CHECK-NEXT:    vlse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <4 x half> @llvm.experimental.vp.strided.load.v4f16.p0.i32(ptr %ptr, i32 %stride, <4 x i1> %m, i32 %evl)
  ret <4 x half> %load
}

declare <8 x half> @llvm.experimental.vp.strided.load.v8f16.p0.i32(ptr, i32, <8 x i1>, i32)

define <8 x half> @strided_vpload_v8f16(ptr %ptr, i32 signext %stride, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v8f16:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e16, m1, ta, ma
; CHECK-NEXT:    vlse16.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <8 x half> @llvm.experimental.vp.strided.load.v8f16.p0.i32(ptr %ptr, i32 %stride, <8 x i1> %m, i32 %evl)
  ret <8 x half> %load
}

declare <2 x float> @llvm.experimental.vp.strided.load.v2f32.p0.i32(ptr, i32, <2 x i1>, i32)

define <2 x float> @strided_vpload_v2f32(ptr %ptr, i32 signext %stride, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v2f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, mf2, ta, ma
; CHECK-NEXT:    vlse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <2 x float> @llvm.experimental.vp.strided.load.v2f32.p0.i32(ptr %ptr, i32 %stride, <2 x i1> %m, i32 %evl)
  ret <2 x float> %load
}

declare <4 x float> @llvm.experimental.vp.strided.load.v4f32.p0.i32(ptr, i32, <4 x i1>, i32)

define <4 x float> @strided_vpload_v4f32(ptr %ptr, i32 signext %stride, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v4f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m1, ta, ma
; CHECK-NEXT:    vlse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <4 x float> @llvm.experimental.vp.strided.load.v4f32.p0.i32(ptr %ptr, i32 %stride, <4 x i1> %m, i32 %evl)
  ret <4 x float> %load
}

declare <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i32(ptr, i32, <8 x i1>, i32)

define <8 x float> @strided_vpload_v8f32(ptr %ptr, i32 signext %stride, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v8f32:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, ta, ma
; CHECK-NEXT:    vlse32.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i32(ptr %ptr, i32 %stride, <8 x i1> %m, i32 %evl)
  ret <8 x float> %load
}

define <8 x float> @strided_vpload_v8f32_allones_mask(ptr %ptr, i32 signext %stride, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v8f32_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e32, m2, ta, ma
; CHECK-NEXT:    vlse32.v v8, (a0), a1
; CHECK-NEXT:    ret
  %a = insertelement <8 x i1> poison, i1 true, i32 0
  %b = shufflevector <8 x i1> %a, <8 x i1> poison, <8 x i32> zeroinitializer
  %load = call <8 x float> @llvm.experimental.vp.strided.load.v8f32.p0.i32(ptr %ptr, i32 %stride, <8 x i1> %b, i32 %evl)
  ret <8 x float> %load
}

declare <2 x double> @llvm.experimental.vp.strided.load.v2f64.p0.i32(ptr, i32, <2 x i1>, i32)

define <2 x double> @strided_vpload_v2f64(ptr %ptr, i32 signext %stride, <2 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v2f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m1, ta, ma
; CHECK-NEXT:    vlse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <2 x double> @llvm.experimental.vp.strided.load.v2f64.p0.i32(ptr %ptr, i32 %stride, <2 x i1> %m, i32 %evl)
  ret <2 x double> %load
}

declare <4 x double> @llvm.experimental.vp.strided.load.v4f64.p0.i32(ptr, i32, <4 x i1>, i32)

define <4 x double> @strided_vpload_v4f64(ptr %ptr, i32 signext %stride, <4 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v4f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, ta, ma
; CHECK-NEXT:    vlse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <4 x double> @llvm.experimental.vp.strided.load.v4f64.p0.i32(ptr %ptr, i32 %stride, <4 x i1> %m, i32 %evl)
  ret <4 x double> %load
}

define <4 x double> @strided_vpload_v4f64_allones_mask(ptr %ptr, i32 signext %stride, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v4f64_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, ta, ma
; CHECK-NEXT:    vlse64.v v8, (a0), a1
; CHECK-NEXT:    ret
  %a = insertelement <4 x i1> poison, i1 true, i32 0
  %b = shufflevector <4 x i1> %a, <4 x i1> poison, <4 x i32> zeroinitializer
  %load = call <4 x double> @llvm.experimental.vp.strided.load.v4f64.p0.i32(ptr %ptr, i32 %stride, <4 x i1> %b, i32 %evl)
  ret <4 x double> %load
}

declare <8 x double> @llvm.experimental.vp.strided.load.v8f64.p0.i32(ptr, i32, <8 x i1>, i32)

define <8 x double> @strided_vpload_v8f64(ptr %ptr, i32 signext %stride, <8 x i1> %m, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v8f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m4, ta, ma
; CHECK-NEXT:    vlse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <8 x double> @llvm.experimental.vp.strided.load.v8f64.p0.i32(ptr %ptr, i32 %stride, <8 x i1> %m, i32 %evl)
  ret <8 x double> %load
}

; Widening
define <3 x double> @strided_vpload_v3f64(ptr %ptr, i32 signext %stride, <3 x i1> %mask, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v3f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, ta, ma
; CHECK-NEXT:    vlse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %v = call <3 x double> @llvm.experimental.vp.strided.load.v3f64.p0.i32(ptr %ptr, i32 %stride, <3 x i1> %mask, i32 %evl)
  ret <3 x double> %v
}

define <3 x double> @strided_vpload_v3f64_allones_mask(ptr %ptr, i32 signext %stride, i32 zeroext %evl) {
; CHECK-LABEL: strided_vpload_v3f64_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    vsetvli zero, a2, e64, m2, ta, ma
; CHECK-NEXT:    vlse64.v v8, (a0), a1
; CHECK-NEXT:    ret
  %one = insertelement <3 x i1> poison, i1 true, i32 0
  %allones = shufflevector <3 x i1> %one, <3 x i1> poison, <3 x i32> zeroinitializer
  %v = call <3 x double> @llvm.experimental.vp.strided.load.v3f64.p0.i32(ptr %ptr, i32 %stride, <3 x i1> %allones, i32 %evl)
  ret <3 x double> %v
}

declare <3 x double> @llvm.experimental.vp.strided.load.v3f64.p0.i32(ptr, i32, <3 x i1>, i32)

; Splitting
define <32 x double> @strided_vpload_v32f64(ptr %ptr, i32 signext %stride, <32 x i1> %m, i32 zeroext %evl) nounwind {
; CHECK-LABEL: strided_vpload_v32f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a4, 16
; CHECK-NEXT:    vmv1r.v v8, v0
; CHECK-NEXT:    mv a3, a2
; CHECK-NEXT:    bltu a2, a4, .LBB33_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a3, 16
; CHECK-NEXT:  .LBB33_2:
; CHECK-NEXT:    mul a4, a3, a1
; CHECK-NEXT:    add a4, a0, a4
; CHECK-NEXT:    addi a5, a2, -16
; CHECK-NEXT:    sltu a2, a2, a5
; CHECK-NEXT:    addi a2, a2, -1
; CHECK-NEXT:    and a2, a2, a5
; CHECK-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-NEXT:    vslidedown.vi v0, v8, 2
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vlse64.v v16, (a4), a1, v0.t
; CHECK-NEXT:    vsetvli zero, a3, e64, m8, ta, ma
; CHECK-NEXT:    vmv1r.v v0, v8
; CHECK-NEXT:    vlse64.v v8, (a0), a1, v0.t
; CHECK-NEXT:    ret
  %load = call <32 x double> @llvm.experimental.vp.strided.load.v32f64.p0.i32(ptr %ptr, i32 %stride, <32 x i1> %m, i32 %evl)
  ret <32 x double> %load
}

define <32 x double> @strided_vpload_v32f64_allones_mask(ptr %ptr, i32 signext %stride, i32 zeroext %evl) nounwind {
; CHECK-LABEL: strided_vpload_v32f64_allones_mask:
; CHECK:       # %bb.0:
; CHECK-NEXT:    li a4, 16
; CHECK-NEXT:    mv a3, a2
; CHECK-NEXT:    bltu a2, a4, .LBB34_2
; CHECK-NEXT:  # %bb.1:
; CHECK-NEXT:    li a3, 16
; CHECK-NEXT:  .LBB34_2:
; CHECK-NEXT:    mul a4, a3, a1
; CHECK-NEXT:    add a4, a0, a4
; CHECK-NEXT:    addi a5, a2, -16
; CHECK-NEXT:    sltu a2, a2, a5
; CHECK-NEXT:    addi a2, a2, -1
; CHECK-NEXT:    and a2, a2, a5
; CHECK-NEXT:    vsetvli zero, a2, e64, m8, ta, ma
; CHECK-NEXT:    vlse64.v v16, (a4), a1
; CHECK-NEXT:    vsetvli zero, a3, e64, m8, ta, ma
; CHECK-NEXT:    vlse64.v v8, (a0), a1
; CHECK-NEXT:    ret
  %one = insertelement <32 x i1> poison, i1 true, i32 0
  %allones = shufflevector <32 x i1> %one, <32 x i1> poison, <32 x i32> zeroinitializer
  %load = call <32 x double> @llvm.experimental.vp.strided.load.v32f64.p0.i32(ptr %ptr, i32 %stride, <32 x i1> %allones, i32 %evl)
  ret <32 x double> %load
}

declare <32 x double> @llvm.experimental.vp.strided.load.v32f64.p0.i32(ptr, i32, <32 x i1>, i32)

; Widening + splitting (with HiIsEmpty == true)
define <33 x double> @strided_load_v33f64(ptr %ptr, i64 %stride, <33 x i1> %mask, i32 zeroext %evl) {
; CHECK-RV32-LABEL: strided_load_v33f64:
; CHECK-RV32:       # %bb.0:
; CHECK-RV32-NEXT:    li a5, 32
; CHECK-RV32-NEXT:    vmv1r.v v8, v0
; CHECK-RV32-NEXT:    mv a3, a4
; CHECK-RV32-NEXT:    bltu a4, a5, .LBB35_2
; CHECK-RV32-NEXT:  # %bb.1:
; CHECK-RV32-NEXT:    li a3, 32
; CHECK-RV32-NEXT:  .LBB35_2:
; CHECK-RV32-NEXT:    mul a5, a3, a2
; CHECK-RV32-NEXT:    addi a6, a4, -32
; CHECK-RV32-NEXT:    sltu a4, a4, a6
; CHECK-RV32-NEXT:    addi a4, a4, -1
; CHECK-RV32-NEXT:    and a6, a4, a6
; CHECK-RV32-NEXT:    li a4, 16
; CHECK-RV32-NEXT:    add a5, a1, a5
; CHECK-RV32-NEXT:    bltu a6, a4, .LBB35_4
; CHECK-RV32-NEXT:  # %bb.3:
; CHECK-RV32-NEXT:    li a6, 16
; CHECK-RV32-NEXT:  .LBB35_4:
; CHECK-RV32-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; CHECK-RV32-NEXT:    vslidedown.vi v0, v8, 4
; CHECK-RV32-NEXT:    vsetvli zero, a6, e64, m8, ta, ma
; CHECK-RV32-NEXT:    vlse64.v v16, (a5), a2, v0.t
; CHECK-RV32-NEXT:    addi a5, a3, -16
; CHECK-RV32-NEXT:    sltu a6, a3, a5
; CHECK-RV32-NEXT:    addi a6, a6, -1
; CHECK-RV32-NEXT:    and a5, a6, a5
; CHECK-RV32-NEXT:    bltu a3, a4, .LBB35_6
; CHECK-RV32-NEXT:  # %bb.5:
; CHECK-RV32-NEXT:    li a3, 16
; CHECK-RV32-NEXT:  .LBB35_6:
; CHECK-RV32-NEXT:    mul a4, a3, a2
; CHECK-RV32-NEXT:    add a4, a1, a4
; CHECK-RV32-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-RV32-NEXT:    vslidedown.vi v0, v8, 2
; CHECK-RV32-NEXT:    vsetvli zero, a5, e64, m8, ta, ma
; CHECK-RV32-NEXT:    vlse64.v v24, (a4), a2, v0.t
; CHECK-RV32-NEXT:    vsetvli zero, a3, e64, m8, ta, ma
; CHECK-RV32-NEXT:    vmv1r.v v0, v8
; CHECK-RV32-NEXT:    vlse64.v v8, (a1), a2, v0.t
; CHECK-RV32-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-RV32-NEXT:    vse64.v v8, (a0)
; CHECK-RV32-NEXT:    addi a1, a0, 256
; CHECK-RV32-NEXT:    vsetivli zero, 1, e64, m8, ta, ma
; CHECK-RV32-NEXT:    vse64.v v16, (a1)
; CHECK-RV32-NEXT:    addi a0, a0, 128
; CHECK-RV32-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-RV32-NEXT:    vse64.v v24, (a0)
; CHECK-RV32-NEXT:    ret
;
; CHECK-RV64-LABEL: strided_load_v33f64:
; CHECK-RV64:       # %bb.0:
; CHECK-RV64-NEXT:    li a5, 32
; CHECK-RV64-NEXT:    vmv1r.v v8, v0
; CHECK-RV64-NEXT:    mv a4, a3
; CHECK-RV64-NEXT:    bltu a3, a5, .LBB35_2
; CHECK-RV64-NEXT:  # %bb.1:
; CHECK-RV64-NEXT:    li a4, 32
; CHECK-RV64-NEXT:  .LBB35_2:
; CHECK-RV64-NEXT:    mul a5, a4, a2
; CHECK-RV64-NEXT:    addi a6, a3, -32
; CHECK-RV64-NEXT:    sltu a3, a3, a6
; CHECK-RV64-NEXT:    addi a3, a3, -1
; CHECK-RV64-NEXT:    and a6, a3, a6
; CHECK-RV64-NEXT:    li a3, 16
; CHECK-RV64-NEXT:    add a5, a1, a5
; CHECK-RV64-NEXT:    bltu a6, a3, .LBB35_4
; CHECK-RV64-NEXT:  # %bb.3:
; CHECK-RV64-NEXT:    li a6, 16
; CHECK-RV64-NEXT:  .LBB35_4:
; CHECK-RV64-NEXT:    vsetivli zero, 4, e8, mf2, ta, ma
; CHECK-RV64-NEXT:    vslidedown.vi v0, v8, 4
; CHECK-RV64-NEXT:    vsetvli zero, a6, e64, m8, ta, ma
; CHECK-RV64-NEXT:    vlse64.v v16, (a5), a2, v0.t
; CHECK-RV64-NEXT:    addi a5, a4, -16
; CHECK-RV64-NEXT:    sltu a6, a4, a5
; CHECK-RV64-NEXT:    addi a6, a6, -1
; CHECK-RV64-NEXT:    and a5, a6, a5
; CHECK-RV64-NEXT:    bltu a4, a3, .LBB35_6
; CHECK-RV64-NEXT:  # %bb.5:
; CHECK-RV64-NEXT:    li a4, 16
; CHECK-RV64-NEXT:  .LBB35_6:
; CHECK-RV64-NEXT:    mul a3, a4, a2
; CHECK-RV64-NEXT:    add a3, a1, a3
; CHECK-RV64-NEXT:    vsetivli zero, 2, e8, mf4, ta, ma
; CHECK-RV64-NEXT:    vslidedown.vi v0, v8, 2
; CHECK-RV64-NEXT:    vsetvli zero, a5, e64, m8, ta, ma
; CHECK-RV64-NEXT:    vlse64.v v24, (a3), a2, v0.t
; CHECK-RV64-NEXT:    vsetvli zero, a4, e64, m8, ta, ma
; CHECK-RV64-NEXT:    vmv1r.v v0, v8
; CHECK-RV64-NEXT:    vlse64.v v8, (a1), a2, v0.t
; CHECK-RV64-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-RV64-NEXT:    vse64.v v8, (a0)
; CHECK-RV64-NEXT:    addi a1, a0, 256
; CHECK-RV64-NEXT:    vsetivli zero, 1, e64, m8, ta, ma
; CHECK-RV64-NEXT:    vse64.v v16, (a1)
; CHECK-RV64-NEXT:    addi a0, a0, 128
; CHECK-RV64-NEXT:    vsetivli zero, 16, e64, m8, ta, ma
; CHECK-RV64-NEXT:    vse64.v v24, (a0)
; CHECK-RV64-NEXT:    ret
  %v = call <33 x double> @llvm.experimental.vp.strided.load.v33f64.p0.i64(ptr %ptr, i64 %stride, <33 x i1> %mask, i32 %evl)
  ret <33 x double> %v
}

declare <33 x double> @llvm.experimental.vp.strided.load.v33f64.p0.i64(ptr, i64, <33 x i1>, i32)