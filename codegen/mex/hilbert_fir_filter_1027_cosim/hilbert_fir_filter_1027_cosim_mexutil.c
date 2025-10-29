/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * hilbert_fir_filter_1027_cosim_mexutil.c
 *
 * Code generation for function 'hilbert_fir_filter_1027_cosim_mexutil'
 *
 */

/* Include files */
#include "hilbert_fir_filter_1027_cosim_mexutil.h"
#include "hilbert_fir_filter_1027_cosim_data.h"
#include "rt_nonfinite.h"

/* Function Definitions */
const mxArray *b_emlrt_marshallOut(const emlrtStack *sp, const int32_T u)
{
  const mxArray *b_y;
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  b_y = NULL;
  m = emlrtCreateNumericMatrix(1, 1, mxINT32_CLASS, mxREAL);
  *(int32_T *)emlrtMxGetData(m) = u;
  emlrtAssign(&b_y, m);
  emlrtAssign(&y, emlrtCreateFIR2013b((emlrtCTX)sp, c_eml_mx, d_eml_mx,
                                      "simulinkarray", b_y, true, false));
  return y;
}

const mxArray *emlrt_marshallOut(const boolean_T u)
{
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateLogicalScalar(u);
  emlrtAssign(&y, m);
  return y;
}

/* End of code generation (hilbert_fir_filter_1027_cosim_mexutil.c) */
