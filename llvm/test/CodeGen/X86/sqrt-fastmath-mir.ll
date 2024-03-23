; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mattr=avx2,fma -stop-after=finalize-isel 2>&1 | FileCheck %s

declare float @llvm.sqrt.f32(float) #2

define float @sqrt_ieee(float %f) #0 {
  ; CHECK-LABEL: name: sqrt_ieee
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $xmm0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:fr32 = COPY $xmm0
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:fr32 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[VSQRTSSr:%[0-9]+]]:fr32 = nofpexcept VSQRTSSr killed [[DEF]], [[COPY]], implicit $mxcsr
  ; CHECK-NEXT:   $xmm0 = COPY [[VSQRTSSr]]
  ; CHECK-NEXT:   RET 0, $xmm0
  %call = tail call float @llvm.sqrt.f32(float %f)
  ret float %call
}

define float @sqrt_ieee_ninf(float %f) #0 {
  ; CHECK-LABEL: name: sqrt_ieee_ninf
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $xmm0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:fr32 = COPY $xmm0
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:fr32 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[VRSQRTSSr:%[0-9]+]]:fr32 = VRSQRTSSr killed [[DEF]], [[COPY]]
  ; CHECK-NEXT:   [[VMULSSrr:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr [[COPY]], [[VRSQRTSSr]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMOVSSrm_alt:%[0-9]+]]:fr32 = VMOVSSrm_alt $rip, 1, $noreg, %const.0, $noreg :: (load (s32) from constant-pool)
  ; CHECK-NEXT:   [[VFMADD213SSr:%[0-9]+]]:fr32 = ninf afn nofpexcept VFMADD213SSr [[VRSQRTSSr]], killed [[VMULSSrr]], [[VMOVSSrm_alt]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMOVSSrm_alt1:%[0-9]+]]:fr32 = VMOVSSrm_alt $rip, 1, $noreg, %const.1, $noreg :: (load (s32) from constant-pool)
  ; CHECK-NEXT:   [[VMULSSrr1:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr [[VRSQRTSSr]], [[VMOVSSrm_alt1]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr2:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr killed [[VMULSSrr1]], killed [[VFMADD213SSr]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr3:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr [[COPY]], [[VMULSSrr2]], implicit $mxcsr
  ; CHECK-NEXT:   [[VFMADD213SSr1:%[0-9]+]]:fr32 = ninf afn nofpexcept VFMADD213SSr [[VMULSSrr2]], [[VMULSSrr3]], [[VMOVSSrm_alt]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr4:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr [[VMULSSrr3]], [[VMOVSSrm_alt1]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr5:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr killed [[VMULSSrr4]], killed [[VFMADD213SSr1]], implicit $mxcsr
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vr128 = COPY [[VMULSSrr5]]
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:vr128 = COPY [[COPY]]
  ; CHECK-NEXT:   [[VPBROADCASTDrm:%[0-9]+]]:vr128 = VPBROADCASTDrm $rip, 1, $noreg, %const.2, $noreg :: (load (s32) from constant-pool)
  ; CHECK-NEXT:   [[VPANDrr:%[0-9]+]]:vr128 = VPANDrr killed [[COPY2]], killed [[VPBROADCASTDrm]]
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:fr32 = COPY [[VPANDrr]]
  ; CHECK-NEXT:   [[VCMPSSrm:%[0-9]+]]:fr32 = nofpexcept VCMPSSrm killed [[COPY3]], $rip, 1, $noreg, %const.3, $noreg, 1, implicit $mxcsr :: (load (s32) from constant-pool)
  ; CHECK-NEXT:   [[COPY4:%[0-9]+]]:vr128 = COPY [[VCMPSSrm]]
  ; CHECK-NEXT:   [[VPANDNrr:%[0-9]+]]:vr128 = VPANDNrr killed [[COPY4]], killed [[COPY1]]
  ; CHECK-NEXT:   [[COPY5:%[0-9]+]]:fr32 = COPY [[VPANDNrr]]
  ; CHECK-NEXT:   $xmm0 = COPY [[COPY5]]
  ; CHECK-NEXT:   RET 0, $xmm0
  %call = tail call ninf afn float @llvm.sqrt.f32(float %f)
  ret float %call
}

define float @sqrt_daz(float %f) #1 {
  ; CHECK-LABEL: name: sqrt_daz
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $xmm0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:fr32 = COPY $xmm0
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:fr32 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[VSQRTSSr:%[0-9]+]]:fr32 = nofpexcept VSQRTSSr killed [[DEF]], [[COPY]], implicit $mxcsr
  ; CHECK-NEXT:   $xmm0 = COPY [[VSQRTSSr]]
  ; CHECK-NEXT:   RET 0, $xmm0
  %call = tail call float @llvm.sqrt.f32(float %f)
  ret float %call
}

define float @sqrt_daz_ninf(float %f) #1 {
  ; CHECK-LABEL: name: sqrt_daz_ninf
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $xmm0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:fr32 = COPY $xmm0
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:fr32 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[VRSQRTSSr:%[0-9]+]]:fr32 = VRSQRTSSr killed [[DEF]], [[COPY]]
  ; CHECK-NEXT:   [[VMULSSrr:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr [[COPY]], [[VRSQRTSSr]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMOVSSrm_alt:%[0-9]+]]:fr32 = VMOVSSrm_alt $rip, 1, $noreg, %const.0, $noreg :: (load (s32) from constant-pool)
  ; CHECK-NEXT:   [[VFMADD213SSr:%[0-9]+]]:fr32 = ninf afn nofpexcept VFMADD213SSr [[VRSQRTSSr]], killed [[VMULSSrr]], [[VMOVSSrm_alt]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMOVSSrm_alt1:%[0-9]+]]:fr32 = VMOVSSrm_alt $rip, 1, $noreg, %const.1, $noreg :: (load (s32) from constant-pool)
  ; CHECK-NEXT:   [[VMULSSrr1:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr [[VRSQRTSSr]], [[VMOVSSrm_alt1]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr2:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr killed [[VMULSSrr1]], killed [[VFMADD213SSr]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr3:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr [[COPY]], [[VMULSSrr2]], implicit $mxcsr
  ; CHECK-NEXT:   [[VFMADD213SSr1:%[0-9]+]]:fr32 = ninf afn nofpexcept VFMADD213SSr [[VMULSSrr2]], [[VMULSSrr3]], [[VMOVSSrm_alt]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr4:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr [[VMULSSrr3]], [[VMOVSSrm_alt1]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr5:%[0-9]+]]:fr32 = ninf afn nofpexcept VMULSSrr killed [[VMULSSrr4]], killed [[VFMADD213SSr1]], implicit $mxcsr
  ; CHECK-NEXT:   [[COPY1:%[0-9]+]]:vr128 = COPY [[VMULSSrr5]]
  ; CHECK-NEXT:   [[FsFLD0SS:%[0-9]+]]:fr32 = FsFLD0SS
  ; CHECK-NEXT:   [[VCMPSSrr:%[0-9]+]]:fr32 = nofpexcept VCMPSSrr [[COPY]], killed [[FsFLD0SS]], 0, implicit $mxcsr
  ; CHECK-NEXT:   [[COPY2:%[0-9]+]]:vr128 = COPY [[VCMPSSrr]]
  ; CHECK-NEXT:   [[VPANDNrr:%[0-9]+]]:vr128 = VPANDNrr killed [[COPY2]], killed [[COPY1]]
  ; CHECK-NEXT:   [[COPY3:%[0-9]+]]:fr32 = COPY [[VPANDNrr]]
  ; CHECK-NEXT:   $xmm0 = COPY [[COPY3]]
  ; CHECK-NEXT:   RET 0, $xmm0
  %call = tail call ninf afn float @llvm.sqrt.f32(float %f)
  ret float %call
}

define float @rsqrt_ieee(float %f) #0 {
  ; CHECK-LABEL: name: rsqrt_ieee
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $xmm0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:fr32 = COPY $xmm0
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:fr32 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[VRSQRTSSr:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc VRSQRTSSr killed [[DEF]], [[COPY]]
  ; CHECK-NEXT:   [[VMULSSrr:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr [[COPY]], [[VRSQRTSSr]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMOVSSrm_alt:%[0-9]+]]:fr32 = VMOVSSrm_alt $rip, 1, $noreg, %const.0, $noreg :: (load (s32) from constant-pool)
  ; CHECK-NEXT:   [[VFMADD213SSr:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VFMADD213SSr [[VRSQRTSSr]], killed [[VMULSSrr]], [[VMOVSSrm_alt]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMOVSSrm_alt1:%[0-9]+]]:fr32 = VMOVSSrm_alt $rip, 1, $noreg, %const.1, $noreg :: (load (s32) from constant-pool)
  ; CHECK-NEXT:   [[VMULSSrr1:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr [[VRSQRTSSr]], [[VMOVSSrm_alt1]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr2:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr killed [[VMULSSrr1]], killed [[VFMADD213SSr]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr3:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr [[COPY]], [[VMULSSrr2]], implicit $mxcsr
  ; CHECK-NEXT:   [[VFMADD213SSr1:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VFMADD213SSr [[VMULSSrr2]], killed [[VMULSSrr3]], [[VMOVSSrm_alt]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr4:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr [[VMULSSrr2]], [[VMOVSSrm_alt1]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr5:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr killed [[VMULSSrr4]], killed [[VFMADD213SSr1]], implicit $mxcsr
  ; CHECK-NEXT:   $xmm0 = COPY [[VMULSSrr5]]
  ; CHECK-NEXT:   RET 0, $xmm0
  %sqrt = tail call float @llvm.sqrt.f32(float %f)
  %div = fdiv fast float 1.0, %sqrt
  ret float %div
}

define float @rsqrt_daz(float %f) #1 {
  ; CHECK-LABEL: name: rsqrt_daz
  ; CHECK: bb.0 (%ir-block.0):
  ; CHECK-NEXT:   liveins: $xmm0
  ; CHECK-NEXT: {{  $}}
  ; CHECK-NEXT:   [[COPY:%[0-9]+]]:fr32 = COPY $xmm0
  ; CHECK-NEXT:   [[DEF:%[0-9]+]]:fr32 = IMPLICIT_DEF
  ; CHECK-NEXT:   [[VRSQRTSSr:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc VRSQRTSSr killed [[DEF]], [[COPY]]
  ; CHECK-NEXT:   [[VMULSSrr:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr [[COPY]], [[VRSQRTSSr]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMOVSSrm_alt:%[0-9]+]]:fr32 = VMOVSSrm_alt $rip, 1, $noreg, %const.0, $noreg :: (load (s32) from constant-pool)
  ; CHECK-NEXT:   [[VFMADD213SSr:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VFMADD213SSr [[VRSQRTSSr]], killed [[VMULSSrr]], [[VMOVSSrm_alt]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMOVSSrm_alt1:%[0-9]+]]:fr32 = VMOVSSrm_alt $rip, 1, $noreg, %const.1, $noreg :: (load (s32) from constant-pool)
  ; CHECK-NEXT:   [[VMULSSrr1:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr [[VRSQRTSSr]], [[VMOVSSrm_alt1]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr2:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr killed [[VMULSSrr1]], killed [[VFMADD213SSr]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr3:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr [[COPY]], [[VMULSSrr2]], implicit $mxcsr
  ; CHECK-NEXT:   [[VFMADD213SSr1:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VFMADD213SSr [[VMULSSrr2]], killed [[VMULSSrr3]], [[VMOVSSrm_alt]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr4:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr [[VMULSSrr2]], [[VMOVSSrm_alt1]], implicit $mxcsr
  ; CHECK-NEXT:   [[VMULSSrr5:%[0-9]+]]:fr32 = nnan ninf nsz arcp contract afn reassoc nofpexcept VMULSSrr killed [[VMULSSrr4]], killed [[VFMADD213SSr1]], implicit $mxcsr
  ; CHECK-NEXT:   $xmm0 = COPY [[VMULSSrr5]]
  ; CHECK-NEXT:   RET 0, $xmm0
  %sqrt = tail call float @llvm.sqrt.f32(float %f)
  %div = fdiv fast float 1.0, %sqrt
  ret float %div
}

attributes #0 = { "unsafe-fp-math"="true" "reciprocal-estimates"="sqrt:2" "denormal-fp-math"="ieee,ieee" }
attributes #1 = { "unsafe-fp-math"="true" "reciprocal-estimates"="sqrt:2" "denormal-fp-math"="ieee,preserve-sign" }
attributes #2 = { nounwind readnone }