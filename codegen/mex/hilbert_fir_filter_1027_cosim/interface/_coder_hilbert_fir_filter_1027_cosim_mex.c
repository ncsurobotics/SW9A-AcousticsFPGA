/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_hilbert_fir_filter_1027_cosim_mex.c
 *
 * Code generation for function '_coder_hilbert_fir_filter_1027_cosim_mex'
 *
 */

/* Include files */
#include "_coder_hilbert_fir_filter_1027_cosim_mex.h"
#include "_coder_hilbert_fir_filter_1027_cosim_api.h"
#include "hilbert_fir_filter_1027_cosim_data.h"
#include "hilbert_fir_filter_1027_cosim_initialize.h"
#include "hilbert_fir_filter_1027_cosim_terminate.h"
#include "rt_nonfinite.h"

/* Function Definitions */
void hilbert_fir_filter_1027_cosim_mexFunction(int32_T nlhs, mxArray *plhs[2],
                                               int32_T nrhs,
                                               const mxArray *prhs[3])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  const mxArray *b_prhs[3];
  const mxArray *outputs[2];
  int32_T i;
  st.tls = emlrtRootTLSGlobal;
  /* Check for proper number of arguments. */
  if (nrhs != 3) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 3, 4,
                        29, "hilbert_fir_filter_1027_cosim");
  }
  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 29,
                        "hilbert_fir_filter_1027_cosim");
  }
  /* Call the function. */
  b_prhs[0] = prhs[0];
  b_prhs[1] = prhs[1];
  b_prhs[2] = prhs[2];
  d_hilbert_fir_filter_1027_cosim(b_prhs, nlhs, outputs);
  /* Copy over outputs to the caller. */
  if (nlhs < 1) {
    i = 1;
  } else {
    i = nlhs;
  }
  emlrtReturnArrays(i, &plhs[0], &outputs[0]);
}

void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&hilbert_fir_filter_1027_cosim_atexit);
  hilbert_fir_filter_1027_cosim_initialize();
  hilbert_fir_filter_1027_cosim_mexFunction(nlhs, plhs, nrhs, prhs);
  hilbert_fir_filter_1027_cosim_terminate();
}

emlrtCTX mexFunctionCreateRootTLS(void)
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, NULL, 1,
                           NULL, "windows-1252", true);
  return emlrtRootTLSGlobal;
}

/* End of code generation (_coder_hilbert_fir_filter_1027_cosim_mex.c) */
