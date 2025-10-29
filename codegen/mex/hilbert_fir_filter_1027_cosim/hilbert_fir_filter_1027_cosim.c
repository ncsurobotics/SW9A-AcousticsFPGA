/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * hilbert_fir_filter_1027_cosim.c
 *
 * Code generation for function 'hilbert_fir_filter_1027_cosim'
 *
 */

/* Include files */
#include "hilbert_fir_filter_1027_cosim.h"
#include "SystemCore.h"
#include "hilbert_fir_filter_1027_cosim_data.h"
#include "hilbert_fir_filter_1027_cosim_internal_types.h"
#include "hilbert_fir_filter_1027_cosim_mexutil.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtRSInfo emlrtRSI = {
    21,                              /* lineNo */
    "hilbert_fir_filter_1027_cosim", /* fcnName */
    "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
    "datapath\\codegen\\hilbert_fir_filter_1027\\cosim\\hilbert_fir_filt"
    "er_1027_cosim.m" /* pathName */
};

static emlrtRSInfo b_emlrtRSI = {
    7,                         /* lineNo */
    "hilbert_fir_filter_1027", /* fcnName */
    "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
    "datapath\\hilbert_fir_filter_1027.m" /* pathName */
};

static emlrtRSInfo c_emlrtRSI = {
    13,                        /* lineNo */
    "hilbert_fir_filter_1027", /* fcnName */
    "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
    "datapath\\hilbert_fir_filter_1027.m" /* pathName */
};

static emlrtMCInfo b_emlrtMCI = {
    24,                              /* lineNo */
    1,                               /* colNo */
    "hilbert_fir_filter_1027_cosim", /* fName */
    "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
    "datapath\\codegen\\hilbert_fir_filter_1027\\cosim\\hilbert_fir_filt"
    "er_1027_cosim.m" /* pName */
};

static emlrtMCInfo c_emlrtMCI = {
    27,                              /* lineNo */
    12,                              /* colNo */
    "hilbert_fir_filter_1027_cosim", /* fName */
    "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
    "datapath\\codegen\\hilbert_fir_filter_1027\\cosim\\hilbert_fir_filt"
    "er_1027_cosim.m" /* pName */
};

static emlrtMCInfo d_emlrtMCI = {
    31,                              /* lineNo */
    1,                               /* colNo */
    "hilbert_fir_filter_1027_cosim", /* fName */
    "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
    "datapath\\codegen\\hilbert_fir_filter_1027\\cosim\\hilbert_fir_filt"
    "er_1027_cosim.m" /* pName */
};

static emlrtMCInfo e_emlrtMCI = {
    32,                              /* lineNo */
    1,                               /* colNo */
    "hilbert_fir_filter_1027_cosim", /* fName */
    "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
    "datapath\\codegen\\hilbert_fir_filter_1027\\cosim\\hilbert_fir_filt"
    "er_1027_cosim.m" /* pName */
};

static emlrtRSInfo s_emlrtRSI = {
    31,                              /* lineNo */
    "hilbert_fir_filter_1027_cosim", /* fcnName */
    "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
    "datapath\\codegen\\hilbert_fir_filter_1027\\cosim\\hilbert_fir_filt"
    "er_1027_cosim.m" /* pathName */
};

static emlrtRSInfo t_emlrtRSI = {
    24,                              /* lineNo */
    "hilbert_fir_filter_1027_cosim", /* fcnName */
    "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
    "datapath\\codegen\\hilbert_fir_filter_1027\\cosim\\hilbert_fir_filt"
    "er_1027_cosim.m" /* pathName */
};

static emlrtRSInfo u_emlrtRSI = {
    27,                              /* lineNo */
    "hilbert_fir_filter_1027_cosim", /* fcnName */
    "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
    "datapath\\codegen\\hilbert_fir_filter_1027\\cosim\\hilbert_fir_filt"
    "er_1027_cosim.m" /* pathName */
};

static emlrtRSInfo v_emlrtRSI = {
    32,                              /* lineNo */
    "hilbert_fir_filter_1027_cosim", /* fcnName */
    "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
    "datapath\\codegen\\hilbert_fir_filter_1027\\cosim\\hilbert_fir_filt"
    "er_1027_cosim.m" /* pathName */
};

/* Function Declarations */
static void c_hilbert_fir_filter_1027_sysob(const emlrtStack *sp,
                                            const mxArray *m, const mxArray *m1,
                                            const mxArray *m2,
                                            emlrtMCInfo *location,
                                            const mxArray **r,
                                            const mxArray **r1);

static void hdlverifier_assert(const emlrtStack *sp, const mxArray *m,
                               const mxArray *m1, const mxArray *m2,
                               emlrtMCInfo *location);

static const mxArray *logical(const emlrtStack *sp, const mxArray *m,
                              emlrtMCInfo *location);

/* Function Definitions */
static void c_hilbert_fir_filter_1027_sysob(const emlrtStack *sp,
                                            const mxArray *m, const mxArray *m1,
                                            const mxArray *m2,
                                            emlrtMCInfo *location,
                                            const mxArray **r,
                                            const mxArray **r1)
{
  const mxArray *pArrays[3];
  const mxArray *mv[2];
  pArrays[0] = m;
  pArrays[1] = m1;
  pArrays[2] = m2;
  emlrtAssign(r, emlrtCallMATLABR2012b(
                     (emlrtConstCTX)sp, 2, &mv[0], 3, &pArrays[0],
                     "hilbert_fir_filter_1027_sysobj_cosim", true, location));
  emlrtAssign(r1, mv[1]);
}

static void hdlverifier_assert(const emlrtStack *sp, const mxArray *m,
                               const mxArray *m1, const mxArray *m2,
                               emlrtMCInfo *location)
{
  const mxArray *pArrays[3];
  pArrays[0] = m;
  pArrays[1] = m1;
  pArrays[2] = m2;
  emlrtCallMATLABR2012b((emlrtConstCTX)sp, 0, NULL, 3, &pArrays[0],
                        "hdlverifier.assert", true, location);
}

static const mxArray *logical(const emlrtStack *sp, const mxArray *m,
                              emlrtMCInfo *location)
{
  const mxArray *m1;
  return emlrtCallMATLABR2012b((emlrtConstCTX)sp, 1, &m1, 1, &m, "logical",
                               true, location);
}

void hilbert_fir_filter_1027_cosim(const emlrtStack *sp, int16_T dataIn,
                                   boolean_T validIn, boolean_T resetIn,
                                   int32_T *ref_dataOut,
                                   boolean_T *ref_validOut)
{
  static dsphdl_FIRFilter ipblock;
  static const int32_T iv[2] = {1, 7};
  static const int32_T iv1[2] = {1, 8};
  static const char_T b_u[8] = {'v', 'a', 'l', 'i', 'd', 'O', 'u', 't'};
  static const char_T u[7] = {'d', 'a', 't', 'a', 'O', 'u', 't'};
  emlrtStack b_st;
  emlrtStack c_st;
  emlrtStack st;
  const mxArray *b_validOut;
  const mxArray *b_y;
  const mxArray *c_y;
  const mxArray *d_y;
  const mxArray *dataOut;
  const mxArray *m;
  const mxArray *validOut;
  const mxArray *y;
  int32_T b_ref_dataOut;
  boolean_T b_ref_validOut;
  st.prev = sp;
  st.tls = sp->tls;
  b_st.prev = &st;
  b_st.tls = st.tls;
  c_st.prev = &b_st;
  c_st.tls = b_st.tls;
  validOut = NULL;
  dataOut = NULL;
  b_validOut = NULL;
  /*  Auto generated function to simulate the generated HDL code using
   * cosimulation */
  /*   */
  /*  Generated by MATLAB 25.2 and HDL Coder 25.2 */
  /*  Declare persistent variables */
  /*  Initialize persistent variables */
  /*  Call the original MATLAB function to get reference signal */
  st.site = &emlrtRSI;
  /*  Generated by HDL IP Designer. */
  if (!ipblock_not_empty) {
    b_st.site = &b_emlrtRSI;
    ipblock.pCoeffDTCheck = true;
    ipblock.isInitialized = 0;
    ipblock_not_empty = true;
  }
  b_st.site = &c_emlrtRSI;
  c_st.site = &g_emlrtRSI;
  b_ref_dataOut = SystemCore_step(&c_st, &ipblock, dataIn, validIn, resetIn,
                                  &b_ref_validOut);
  *ref_dataOut = b_ref_dataOut;
  *ref_validOut = b_ref_validOut;
  /*  Run cosimulation */
  y = NULL;
  b_y = NULL;
  m = emlrtCreateNumericMatrix(1, 1, mxINT16_CLASS, mxREAL);
  *(int16_T *)emlrtMxGetData(m) = dataIn;
  emlrtAssign(&b_y, m);
  emlrtAssign(&y, emlrtCreateFIR2013b((emlrtCTX)sp, eml_mx, b_eml_mx,
                                      "simulinkarray", b_y, false, false));
  st.site = &t_emlrtRSI;
  c_hilbert_fir_filter_1027_sysob(&st, y, emlrt_marshallOut(validIn),
                                  emlrt_marshallOut(resetIn), &b_emlrtMCI,
                                  &dataOut, &b_validOut);
  /*  Convert output signals */
  st.site = &u_emlrtRSI;
  emlrtAssign(&validOut, logical(&st, emlrtAlias(b_validOut), &c_emlrtMCI));
  /*  Verify the cosimulation output */
  c_y = NULL;
  m = emlrtCreateCharArray(2, &iv[0]);
  emlrtInitCharArrayR2013a((emlrtConstCTX)sp, 7, m, &u[0]);
  emlrtAssign(&c_y, m);
  st.site = &s_emlrtRSI;
  hdlverifier_assert(&st, emlrtAlias(dataOut),
                     b_emlrt_marshallOut(&st, b_ref_dataOut), c_y, &d_emlrtMCI);
  d_y = NULL;
  m = emlrtCreateCharArray(2, &iv1[0]);
  emlrtInitCharArrayR2013a((emlrtConstCTX)sp, 8, m, &b_u[0]);
  emlrtAssign(&d_y, m);
  st.site = &v_emlrtRSI;
  hdlverifier_assert(&st, emlrtAlias(validOut),
                     emlrt_marshallOut(b_ref_validOut), d_y, &e_emlrtMCI);
  emlrtDestroyArray(&validOut);
  emlrtDestroyArray(&dataOut);
  emlrtDestroyArray(&b_validOut);
}

/* End of code generation (hilbert_fir_filter_1027_cosim.c) */
