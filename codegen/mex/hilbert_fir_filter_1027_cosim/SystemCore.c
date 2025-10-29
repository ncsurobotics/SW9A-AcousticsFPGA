/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * SystemCore.c
 *
 * Code generation for function 'SystemCore'
 *
 */

/* Include files */
#include "SystemCore.h"
#include "AbstractFilterBank.h"
#include "hilbert_fir_filter_1027_cosim_data.h"
#include "hilbert_fir_filter_1027_cosim_internal_types.h"
#include "hilbert_fir_filter_1027_cosim_mexutil.h"
#include "rt_nonfinite.h"
#include "mwmathutil.h"
#include <string.h>

/* Variable Definitions */
static emlrtRSInfo d_emlrtRSI = {
    1,                      /* lineNo */
    "FIRFilter/updateImpl", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\dsphdl\\dsphdl\\+dsphdl\\FIRFilter.p" /* pathName
                                                                            */
};

static emlrtRSInfo e_emlrtRSI = {
    1,               /* lineNo */
    "System/System", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+"
    "coder\\System.p" /* pathName */
};

static emlrtRSInfo j_emlrtRSI = {
    1,                  /* lineNo */
    "SystemCore/setup", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+"
    "coder\\SystemCore.p" /* pathName */
};

static emlrtRSInfo k_emlrtRSI = {
    1,                               /* lineNo */
    "AbstractFilterBank/updateImpl", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\dsphdl\\dsphdl\\+dsphdl\\+"
    "private\\AbstractFilterBank.p" /* pathName */
};

static emlrtRSInfo n_emlrtRSI = {
    1,                                       /* lineNo */
    "AbstractFilterBank/AbstractFilterBank", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\dsphdl\\dsphdl\\+dsphdl\\+"
    "private\\AbstractFilterBank.p" /* pathName */
};

static emlrtRSInfo o_emlrtRSI = {
    1,                          /* lineNo */
    "SystemCore/setupAndReset", /* fcnName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+"
    "coder\\SystemCore.p" /* pathName */
};

static emlrtMCInfo f_emlrtMCI = {
    1,                      /* lineNo */
    1,                      /* colNo */
    "FIRFilter/updateImpl", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\dsphdl\\dsphdl\\+dsphdl\\FIRFilter.p" /* pName
                                                                            */
};

static emlrtRTEInfo emlrtRTEI = {
    13,               /* lineNo */
    13,               /* colNo */
    "toLogicalCheck", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\eml\\eml\\+coder\\+"
    "internal\\toLogicalCheck.m" /* pName */
};

static emlrtBCInfo emlrtBCI = {
    1,                               /* iFirst */
    1,                               /* iLast */
    1,                               /* lineNo */
    1,                               /* colNo */
    "",                              /* aName */
    "AbstractFilterBank/updateImpl", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\dsphdl\\dsphdl\\+dsphdl\\+"
    "private\\AbstractFilterBank.p", /* pName */
    0                                /* checkKind */
};

static emlrtDCInfo emlrtDCI = {
    1,                               /* lineNo */
    1,                               /* colNo */
    "AbstractFilterBank/updateImpl", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\dsphdl\\dsphdl\\+dsphdl\\+"
    "private\\AbstractFilterBank.p", /* pName */
    1                                /* checkKind */
};

static emlrtRTEInfo b_emlrtRTEI = {
    1,                           /* lineNo */
    1,                           /* colNo */
    "SystemCore/parenReference", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+"
    "coder\\SystemCore.p" /* pName */
};

static emlrtRTEInfo c_emlrtRTEI = {
    1,                  /* lineNo */
    1,                  /* colNo */
    "SystemCore/setup", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\shared\\system\\coder\\+matlab\\+system\\+"
    "coder\\SystemCore.p" /* pName */
};

static emlrtBCInfo b_emlrtBCI = {
    1,                               /* iFirst */
    104,                             /* iLast */
    1,                               /* lineNo */
    1,                               /* colNo */
    "",                              /* aName */
    "AbstractFilterBank/updateImpl", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\dsphdl\\dsphdl\\+dsphdl\\+"
    "private\\AbstractFilterBank.p", /* pName */
    0                                /* checkKind */
};

static emlrtBCInfo c_emlrtBCI = {
    1,                               /* iFirst */
    104,                             /* iLast */
    1,                               /* lineNo */
    1,                               /* colNo */
    "",                              /* aName */
    "AbstractFilterBank/updateImpl", /* fName */
    "C:\\Program "
    "Files\\MATLAB\\R2025b\\toolbox\\dsphdl\\dsphdl\\+dsphdl\\+"
    "private\\AbstractFilterBank.p", /* pName */
    3                                /* checkKind */
};

/* Function Declarations */
static void SystemCore_setup(const emlrtStack *sp,
                             c_dsphdl_private_AbstractFilter *obj);

static void c_dsphdlshared_internal_validat(
    const emlrtStack *sp, const mxArray *m, const mxArray *m1,
    const mxArray *m2, const mxArray *m3, const mxArray *m4, const mxArray *m5,
    const mxArray *m6, const mxArray *m7, emlrtMCInfo *location);

/* Function Definitions */
static void SystemCore_setup(const emlrtStack *sp,
                             c_dsphdl_private_AbstractFilter *obj)
{
  if (obj->isInitialized != 0) {
    emlrtErrorWithMessageIdR2018a(
        sp, &b_emlrtRTEI, "MATLAB:system:methodCalledWhenLockedReleasedCodegen",
        "MATLAB:system:methodCalledWhenLockedReleasedCodegen", 3, 4, 5,
        "setup");
  }
  obj->isInitialized = 1;
  memset(&obj->pVldInPipeline[0], 0, 13U * sizeof(real_T));
  obj->pWrOutBuffer_index = 1.0;
  obj->pRdOutBuffer_index = 1.0;
  obj->pWrOutBuffer_roll = false;
  obj->pRdOutBuffer_roll = false;
  obj->pSimTime = 1.0;
  obj->pResetStart = false;
  obj->pOutputVld = false;
  obj->pDinVldReg1 = false;
  obj->pDinVldReg2 = false;
  obj->pFilterBankIndex = 1.0;
  memset(&obj->pOutputBuffer[0], 0, 104U * sizeof(int32_T));
  memset(&obj->pAccReg[0], 0, 11U * sizeof(int64_T));
}

static void c_dsphdlshared_internal_validat(
    const emlrtStack *sp, const mxArray *m, const mxArray *m1,
    const mxArray *m2, const mxArray *m3, const mxArray *m4, const mxArray *m5,
    const mxArray *m6, const mxArray *m7, emlrtMCInfo *location)
{
  const mxArray *pArrays[8];
  pArrays[0] = m;
  pArrays[1] = m1;
  pArrays[2] = m2;
  pArrays[3] = m3;
  pArrays[4] = m4;
  pArrays[5] = m5;
  pArrays[6] = m6;
  pArrays[7] = m7;
  emlrtCallMATLABR2012b((emlrtConstCTX)sp, 0, NULL, 8, &pArrays[0],
                        "dsphdlshared.internal.validateCoefDataType", true,
                        location);
}

int32_T SystemCore_step(const emlrtStack *sp, dsphdl_FIRFilter *obj,
                        int16_T varargin_1, boolean_T varargin_2,
                        boolean_T varargin_3, boolean_T *varargout_2)
{
  static const real_T u[11] = {-0.171618920927293,
                               -2.74717688367269E-16,
                               -0.292172654639327,
                               2.3743215420913E-16,
                               -1.0,
                               0.0,
                               1.0,
                               -2.3743215420913E-16,
                               0.292172654639327,
                               2.74717688367269E-16,
                               0.171618920927293};
  static const int32_T iv[2] = {1, 16};
  static const int32_T iv1[2] = {1, 11};
  static const int16_T iv2[11] = {-2812, 0, -4787, 0, -16384, 0,
                                  16384, 0, 4787,  0, 2812};
  static const char_T blkName[16] = {'d', 's', 'p', 'h', 'd', 'l', '.', 'F',
                                     'I', 'R', 'F', 'i', 'l', 't', 'e', 'r'};
  c_dsphdl_private_AbstractFilter *b_obj;
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack d_st;
  emlrtStack e_st;
  emlrtStack f_st;
  emlrtStack g_st;
  emlrtStack h_st;
  emlrtStack st;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *m;
  const mxArray *m1;
  const mxArray *m2;
  const mxArray *y;
  real_T dataIndex;
  real_T dataLength;
  real_T *pData;
  int32_T i;
  int32_T varargout_1;
  int16_T b_varargin_1;
  boolean_T b_varargin_2;
  boolean_T reset;
  boolean_T yes;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  d_st.prev = &c_st;
  d_st.tls = c_st.tls;
  e_st.prev = &d_st;
  e_st.tls = d_st.tls;
  f_st.prev = &e_st;
  f_st.tls = e_st.tls;
  g_st.prev = &f_st;
  g_st.tls = f_st.tls;
  h_st.prev = &g_st;
  h_st.tls = g_st.tls;
  if (obj->isInitialized == 2) {
    emlrtErrorWithMessageIdR2018a(
        sp, &b_emlrtRTEI, "MATLAB:system:methodCalledWhenReleasedCodegen",
        "MATLAB:system:methodCalledWhenReleasedCodegen", 3, 4, 4, "step");
  }
  if (obj->isInitialized != 1) {
    st.site = &g_emlrtRSI;
    b_st.site = &g_emlrtRSI;
    if (obj->isInitialized != 0) {
      emlrtErrorWithMessageIdR2018a(
          &b_st, &c_emlrtRTEI,
          "MATLAB:system:methodCalledWhenLockedReleasedCodegen",
          "MATLAB:system:methodCalledWhenLockedReleasedCodegen", 3, 4, 5,
          "setup");
    }
    obj->isInitialized = 1;
    c_st.site = &j_emlrtRSI;
    d_st.site = &g_emlrtRSI;
    c_st.site = &j_emlrtRSI;
    y = NULL;
    m = emlrtCreateCharArray(2, &iv[0]);
    emlrtInitCharArrayR2013a(&c_st, 16, m, &blkName[0]);
    emlrtAssign(&y, m);
    b_y = NULL;
    m1 = NULL;
    emlrtAssign(&m1, emlrtAliasP(b_eml_mx));
    emlrtAssign(&b_y, emlrtAliasP(m1));
    emlrtDestroyArray(&m1);
    c_y = NULL;
    m = emlrtCreateNumericArray(2, (const void *)&iv1[0], mxDOUBLE_CLASS,
                                mxREAL);
    pData = emlrtMxGetPr(m);
    for (i = 0; i < 11; i++) {
      pData[i] = u[i];
    }
    emlrtAssign(&c_y, m);
    d_y = NULL;
    m2 = NULL;
    emlrtAssign(&m2, emlrtAliasP(e_eml_mx));
    emlrtAssign(&d_y, emlrtAliasP(m2));
    emlrtDestroyArray(&m2);
    d_st.site = &d_emlrtRSI;
    c_dsphdlshared_internal_validat(
        &d_st, y, emlrt_marshallOut(obj->pCoeffDTCheck), b_y, c_y, d_y,
        emlrt_marshallOut(true), emlrt_marshallOut(true),
        emlrt_marshallOut(false), &f_emlrtMCI);
    c_st.site = &j_emlrtRSI;
    d_st.site = &d_emlrtRSI;
    obj->pProcRst = false;
    d_st.site = &d_emlrtRSI;
    obj->pInitialize = true;
    d_st.site = &d_emlrtRSI;
    e_st.site = &d_emlrtRSI;
    f_st.site = &k_emlrtRSI;
    g_st.site = &e_emlrtRSI;
    g_st.site = &e_emlrtRSI;
    obj->coder_buffer_pobj0.isInitialized = 0;
    e_st.site = &d_emlrtRSI;
    f_st.site = &k_emlrtRSI;
    obj->coder_buffer_pobj0.pCoeffDTCheck = false;
    e_st.site = &d_emlrtRSI;
    f_st.site = &d_emlrtRSI;
    g_st.site = &d_emlrtRSI;
    obj->phFIR[0] = &obj->coder_buffer_pobj0;
    e_st.site = &d_emlrtRSI;
    obj->pResetStart = false;
    e_st.site = &d_emlrtRSI;
    f_st.site = &d_emlrtRSI;
    g_st.site = &n_emlrtRSI;
    e_st.site = &d_emlrtRSI;
    SystemCore_setup(&e_st, obj->phFIR[0]);
    obj->TunablePropsChanged = false;
    b_st.site = &g_emlrtRSI;
    c_st.site = &d_emlrtRSI;
    obj->pProcRst = false;
    c_st.site = &d_emlrtRSI;
    d_st.site = &d_emlrtRSI;
    obj->pResetStart = false;
    d_st.site = &d_emlrtRSI;
    obj->pProcRst = false;
    if (obj->pInitialize) {
      d_st.site = &d_emlrtRSI;
      obj->pInitialize = false;
    }
    d_st.site = &d_emlrtRSI;
    b_obj = obj->phFIR[0];
    if (b_obj->isInitialized == 2) {
      emlrtErrorWithMessageIdR2018a(
          &d_st, &b_emlrtRTEI, "MATLAB:system:methodCalledWhenReleasedCodegen",
          "MATLAB:system:methodCalledWhenReleasedCodegen", 3, 4, 5, "reset");
    }
    if (b_obj->isInitialized == 1) {
      e_st.site = &g_emlrtRSI;
      AbstractFilterBank_resetImpl(b_obj);
    }
  }
  st.site = &g_emlrtRSI;
  if (obj->TunablePropsChanged) {
    b_st.site = &g_emlrtRSI;
    obj->TunablePropsChanged = false;
  }
  st.site = &g_emlrtRSI;
  b_st.site = &g_emlrtRSI;
  c_st.site = &d_emlrtRSI;
  d_st.site = &d_emlrtRSI;
  b_obj = obj->phFIR[0];
  e_st.site = &g_emlrtRSI;
  yes = (b_obj->isInitialized == 2);
  if (yes) {
    emlrtErrorWithMessageIdR2018a(
        &d_st, &b_emlrtRTEI, "MATLAB:system:methodCalledWhenReleasedCodegen",
        "MATLAB:system:methodCalledWhenReleasedCodegen", 3, 4, 6, "output");
  }
  e_st.site = &g_emlrtRSI;
  if (b_obj->isInitialized == 2) {
    emlrtErrorWithMessageIdR2018a(
        &e_st, &b_emlrtRTEI, "MATLAB:system:methodCalledWhenReleasedCodegen",
        "MATLAB:system:methodCalledWhenReleasedCodegen", 3, 4, 8, "isLocked");
  }
  e_st.site = &g_emlrtRSI;
  if (b_obj->isInitialized == 2) {
    emlrtErrorWithMessageIdR2018a(
        &e_st, &b_emlrtRTEI, "MATLAB:system:methodCalledWhenReleasedCodegen",
        "MATLAB:system:methodCalledWhenReleasedCodegen", 3, 4, 8, "isLocked");
  }
  yes = (b_obj->isInitialized == 1);
  if (!yes) {
    e_st.site = &g_emlrtRSI;
    f_st.site = &o_emlrtRSI;
    SystemCore_setup(&f_st, b_obj);
    f_st.site = &o_emlrtRSI;
    AbstractFilterBank_resetImpl(b_obj);
  }
  e_st.site = &g_emlrtRSI;
  f_st.site = &k_emlrtRSI;
  varargout_1 = 0;
  dataIndex = b_obj->pRdOutBuffer_index;
  g_st.site = &k_emlrtRSI;
  if (b_obj->pRdOutBuffer_roll == b_obj->pWrOutBuffer_roll) {
    dataLength = b_obj->pWrOutBuffer_index - b_obj->pRdOutBuffer_index;
  } else {
    dataLength =
        (104.0 - b_obj->pRdOutBuffer_index) + b_obj->pWrOutBuffer_index;
  }
  yes = ((!b_obj->pResetStart) && (dataLength >= 1.0));
  if (yes) {
    if (b_obj->pOutputVld) {
      *varargout_2 = true;
      if (dataIndex != (int32_T)muDoubleScalarFloor(dataIndex)) {
        emlrtIntegerCheckR2012b(dataIndex, &emlrtDCI, &f_st);
      }
      if (((int32_T)dataIndex < 1) || ((int32_T)dataIndex > 104)) {
        emlrtDynamicBoundsCheckR2012b((int32_T)dataIndex, 1, 104, &b_emlrtBCI,
                                      &f_st);
      }
      varargout_1 = b_obj->pOutputBuffer[(int32_T)dataIndex - 1];
    } else {
      *varargout_2 = false;
    }
  } else {
    *varargout_2 = false;
  }
  b_st.site = &g_emlrtRSI;
  b_varargin_1 = varargin_1;
  b_varargin_2 = varargin_2;
  c_st.site = &d_emlrtRSI;
  if (varargin_3 || obj->pProcRst) {
    b_varargin_2 = false;
    b_varargin_1 = 0;
  }
  if (obj->pResetStart) {
    d_st.site = &d_emlrtRSI;
    obj->pResetStart = false;
  }
  if (varargin_3) {
    d_st.site = &d_emlrtRSI;
    obj->pResetStart = true;
  }
  d_st.site = &d_emlrtRSI;
  if (obj->pResetStart) {
    e_st.site = &d_emlrtRSI;
    f_st.site = &d_emlrtRSI;
    obj->pResetStart = false;
    f_st.site = &d_emlrtRSI;
    obj->pProcRst = false;
    if (obj->pInitialize) {
      f_st.site = &d_emlrtRSI;
      obj->pInitialize = false;
    }
    f_st.site = &d_emlrtRSI;
    b_obj = obj->phFIR[0];
    if (b_obj->isInitialized == 2) {
      emlrtErrorWithMessageIdR2018a(
          &f_st, &b_emlrtRTEI, "MATLAB:system:methodCalledWhenReleasedCodegen",
          "MATLAB:system:methodCalledWhenReleasedCodegen", 3, 4, 5, "reset");
    }
    if (b_obj->isInitialized == 1) {
      g_st.site = &g_emlrtRSI;
      AbstractFilterBank_resetImpl(b_obj);
    }
  }
  d_st.site = &d_emlrtRSI;
  e_st.site = &d_emlrtRSI;
  b_obj = obj->phFIR[0];
  f_st.site = &g_emlrtRSI;
  yes = (b_obj->isInitialized == 2);
  if (yes) {
    emlrtErrorWithMessageIdR2018a(
        &e_st, &b_emlrtRTEI, "MATLAB:system:methodCalledWhenReleasedCodegen",
        "MATLAB:system:methodCalledWhenReleasedCodegen", 3, 4, 6, "update");
  }
  f_st.site = &g_emlrtRSI;
  if (b_obj->isInitialized == 2) {
    emlrtErrorWithMessageIdR2018a(
        &f_st, &b_emlrtRTEI, "MATLAB:system:methodCalledWhenReleasedCodegen",
        "MATLAB:system:methodCalledWhenReleasedCodegen", 3, 4, 8, "isLocked");
  }
  yes = (b_obj->isInitialized == 1);
  if (!yes) {
    f_st.site = &g_emlrtRSI;
    yes = (b_obj->isInitialized == 1);
    if (!yes) {
      emlrtErrorWithMessageIdR2018a(
          &e_st, &b_emlrtRTEI, "MATLAB:system:updateCalledBeforeSetupCodegen",
          "MATLAB:system:updateCalledBeforeSetupCodegen", 3, 4, 33,
          "dsphdl.private.AbstractFilterBank");
    }
    f_st.site = &g_emlrtRSI;
    g_st.site = &o_emlrtRSI;
    SystemCore_setup(&g_st, b_obj);
    g_st.site = &o_emlrtRSI;
    AbstractFilterBank_resetImpl(b_obj);
  }
  f_st.site = &g_emlrtRSI;
  g_st.site = &k_emlrtRSI;
  if (b_obj->pRdOutBuffer_roll == b_obj->pWrOutBuffer_roll) {
    dataIndex = b_obj->pWrOutBuffer_index - b_obj->pRdOutBuffer_index;
  } else {
    dataIndex = (104.0 - b_obj->pRdOutBuffer_index) + b_obj->pWrOutBuffer_index;
  }
  yes = ((!b_obj->pResetStart) && (dataIndex >= 1.0));
  if (yes && b_obj->pOutputVld) {
    if (b_obj->pRdOutBuffer_index < 104.0) {
      b_obj->pRdOutBuffer_index++;
    } else {
      b_obj->pRdOutBuffer_index = 1.0;
      g_st.site = &k_emlrtRSI;
      yes = !b_obj->pRdOutBuffer_roll;
      b_obj->pRdOutBuffer_roll = yes;
    }
  }
  if (b_obj->pResetStart) {
    g_st.site = &k_emlrtRSI;
    b_obj->pResetStart = false;
  }
  if (varargin_3) {
    g_st.site = &k_emlrtRSI;
    b_obj->pResetStart = true;
  }
  g_st.site = &k_emlrtRSI;
  reset = false;
  if (b_obj->pResetStart) {
    AbstractFilterBank_resetImpl(b_obj);
    reset = true;
  }
  g_st.site = &k_emlrtRSI;
  b_obj->pOutputVld = false;
  if (reset) {
    for (i = 0; i < 13; i++) {
      b_obj->pVldInPipeline[i] = 0.0;
    }
    b_obj->pOutputVld = false;
    b_obj->pDinVldReg1 = false;
    b_obj->pDinVldReg2 = false;
  } else {
    h_st.site = &k_emlrtRSI;
    dataIndex = b_obj->pVldInPipeline[9];
    if (muDoubleScalarIsNaN(dataIndex)) {
      emlrtErrorWithMessageIdR2018a(&h_st, &emlrtRTEI, "MATLAB:nologicalnan",
                                    "MATLAB:nologicalnan", 0);
    }
    if ((b_obj->pVldInPipeline[9] != 0.0) && b_obj->pDinVldReg2) {
      yes = true;
    } else {
      yes = false;
    }
    b_obj->pOutputVld = yes;
    if (b_obj->pDinVldReg2) {
      for (i = 0; i < 9; i++) {
        b_obj->pVldInPipeline[9 - i] = b_obj->pVldInPipeline[8 - i];
      }
      b_obj->pVldInPipeline[0] = b_obj->pDinVldReg2;
    }
    yes = b_obj->pDinVldReg1;
    b_obj->pDinVldReg2 = yes;
    b_obj->pDinVldReg1 = b_varargin_2;
  }
  if ((!reset) && b_varargin_2) {
    int64_T acc[11];
    int64_T a0[6];
    int64_T b_a0[5];
    int32_T product[11];
    int32_T x[5];
    int32_T b_xtmp;
    int16_T filterCoef[11];
    g_st.site = &k_emlrtRSI;
    for (i = 0; i < 11; i++) {
      filterCoef[i] = iv2[i];
    }
    dataIndex = b_obj->pFilterBankIndex;
    if (dataIndex != (int32_T)muDoubleScalarFloor(dataIndex)) {
      emlrtIntegerCheckR2012b(dataIndex, &emlrtDCI, &g_st);
    }
    if (((int32_T)dataIndex < 1) || ((int32_T)dataIndex > 1)) {
      emlrtDynamicBoundsCheckR2012b((int32_T)dataIndex, 1, 1, &emlrtBCI, &g_st);
    }
    for (i = 0; i < 5; i++) {
      int16_T xtmp;
      xtmp = filterCoef[i];
      filterCoef[i] = filterCoef[10 - i];
      filterCoef[10 - i] = xtmp;
    }
    for (i = 0; i < 11; i++) {
      product[i] = b_varargin_1 * filterCoef[i];
    }
    for (i = 0; i < 6; i++) {
      a0[i] = b_obj->pAccReg[i];
    }
    for (i = 0; i < 5; i++) {
      x[i] = product[i];
    }
    b_xtmp = x[0];
    x[0] = x[4];
    x[4] = b_xtmp;
    b_xtmp = x[1];
    x[1] = x[3];
    x[3] = b_xtmp;
    for (i = 0; i < 5; i++) {
      b_a0[i] = b_obj->pAccReg[i + 6];
    }
    for (i = 0; i < 6; i++) {
      acc[i] = a0[i] + product[i];
    }
    for (i = 0; i < 5; i++) {
      acc[i + 6] = b_a0[i] - x[i];
    }
    b_obj->pAccReg[0] = 0LL;
    for (i = 0; i < 10; i++) {
      int64_T b_i;
      b_i = acc[i];
      if (b_i > 34359738367LL) {
        b_i = 34359738367LL;
      } else if (b_i < -34359738368LL) {
        b_i = -34359738368LL;
      }
      b_obj->pAccReg[i + 1] = b_i;
    }
    if (b_obj->pFilterBankIndex < 1.0) {
      b_obj->pFilterBankIndex++;
    } else {
      b_obj->pFilterBankIndex = 1.0;
    }
    h_st.site = &k_emlrtRSI;
    if (b_obj->pWrOutBuffer_index !=
        (int32_T)muDoubleScalarFloor(b_obj->pWrOutBuffer_index)) {
      emlrtIntegerCheckR2012b(b_obj->pWrOutBuffer_index, &emlrtDCI, &h_st);
    }
    b_xtmp = (int32_T)b_obj->pWrOutBuffer_index;
    if ((b_xtmp < 1) || (b_xtmp > 104)) {
      emlrtDynamicBoundsCheckR2012b(b_xtmp, 1, 104, &c_emlrtBCI, &h_st);
    }
    b_obj->pOutputBuffer[b_xtmp - 1] = (int32_T)acc[10];
    if (b_obj->pWrOutBuffer_index < 104.0) {
      b_obj->pWrOutBuffer_index++;
    } else {
      b_obj->pWrOutBuffer_index = 1.0;
      yes = !b_obj->pWrOutBuffer_roll;
      b_obj->pWrOutBuffer_roll = yes;
    }
  }
  g_st.site = &k_emlrtRSI;
  b_obj->pSimTime++;
  return varargout_1;
}

/* End of code generation (SystemCore.c) */
