/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * hilbert_fir_filter_1027_cosim_internal_types.h
 *
 * Code generation for function 'hilbert_fir_filter_1027_cosim'
 *
 */

#pragma once

/* Include files */
#include "hilbert_fir_filter_1027_cosim_types.h"
#include "rtwtypes.h"
#include "emlrt.h"

/* Type Definitions */
#ifndef c_typedef_c_dsphdl_private_Abst
#define c_typedef_c_dsphdl_private_Abst
typedef struct {
  int32_T isInitialized;
  boolean_T pWrOutBuffer_roll;
  boolean_T pRdOutBuffer_roll;
  boolean_T pResetStart;
  boolean_T pOutputVld;
  boolean_T pDinVldReg1;
  boolean_T pDinVldReg2;
  boolean_T pCoeffDTCheck;
  real_T pWrOutBuffer_index;
  real_T pRdOutBuffer_index;
  real_T pSimTime;
  int32_T pOutputBuffer[104];
  real_T pFilterBankIndex;
  real_T pVldInPipeline[13];
  int64_T pAccReg[11];
} c_dsphdl_private_AbstractFilter;
#endif /* c_typedef_c_dsphdl_private_Abst */

#ifndef typedef_dsphdl_FIRFilter
#define typedef_dsphdl_FIRFilter
typedef struct {
  int32_T isInitialized;
  boolean_T TunablePropsChanged;
  c_dsphdl_private_AbstractFilter *phFIR[1];
  boolean_T pResetStart;
  boolean_T pCoeffDTCheck;
  boolean_T pInitialize;
  boolean_T pProcRst;
  c_dsphdl_private_AbstractFilter coder_buffer_pobj0;
} dsphdl_FIRFilter;
#endif /* typedef_dsphdl_FIRFilter */

#ifndef typedef_rtDesignRangeCheckInfo
#define typedef_rtDesignRangeCheckInfo
typedef struct {
  int32_T lineNo;
  int32_T colNo;
  const char_T *fName;
  const char_T *pName;
} rtDesignRangeCheckInfo;
#endif /* typedef_rtDesignRangeCheckInfo */

#ifndef typedef_rtEqualityCheckInfo
#define typedef_rtEqualityCheckInfo
typedef struct {
  int32_T nDims;
  int32_T lineNo;
  int32_T colNo;
  const char_T *fName;
  const char_T *pName;
} rtEqualityCheckInfo;
#endif /* typedef_rtEqualityCheckInfo */

#ifndef typedef_rtRunTimeErrorInfo
#define typedef_rtRunTimeErrorInfo
typedef struct {
  int32_T lineNo;
  int32_T colNo;
  const char_T *fName;
  const char_T *pName;
} rtRunTimeErrorInfo;
#endif /* typedef_rtRunTimeErrorInfo */

/* End of code generation (hilbert_fir_filter_1027_cosim_internal_types.h) */
