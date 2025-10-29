/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_hilbert_fir_filter_1027_cosim_api.c
 *
 * Code generation for function '_coder_hilbert_fir_filter_1027_cosim_api'
 *
 */

/* Include files */
#include "_coder_hilbert_fir_filter_1027_cosim_api.h"
#include "hilbert_fir_filter_1027_cosim.h"
#include "hilbert_fir_filter_1027_cosim_data.h"
#include "hilbert_fir_filter_1027_cosim_mexutil.h"
#include "rt_nonfinite.h"

/* Function Declarations */
static int16_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId);

static boolean_T c_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier);

static boolean_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static int16_T e_emlrt_marshallIn(const mxArray *src);

static int16_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                const char_T *identifier);

static boolean_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId);

/* Function Definitions */
static int16_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId)
{
  static const int32_T dims = 0;
  int16_T y;
  emlrtCheckFiR2012b((emlrtCTX)sp, parentId, u, false, 0U, (void *)&dims,
                     eml_mx, b_eml_mx);
  y = e_emlrt_marshallIn(emlrtAlias(u));
  emlrtDestroyArray(&u);
  return y;
}

static boolean_T c_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  boolean_T y;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = d_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static boolean_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  boolean_T y;
  y = f_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static int16_T e_emlrt_marshallIn(const mxArray *src)
{
  const mxArray *mxInt;
  int16_T ret;
  mxInt = emlrtImportFiIntArrayR2008b(src);
  ret = *(int16_T *)emlrtMxGetData(mxInt);
  emlrtDestroyArray(&mxInt);
  emlrtDestroyArray(&src);
  return ret;
}

static int16_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                                const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  int16_T y;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

static boolean_T f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  boolean_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "logical", false, 0U,
                          (const void *)&dims);
  ret = *emlrtMxGetLogicals(src);
  emlrtDestroyArray(&src);
  return ret;
}

void d_hilbert_fir_filter_1027_cosim(const mxArray *const prhs[3], int32_T nlhs,
                                     const mxArray *plhs[2])
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  int32_T ref_dataOut;
  int16_T dataIn;
  boolean_T ref_validOut;
  boolean_T resetIn;
  boolean_T validIn;
  st.tls = emlrtRootTLSGlobal;
  /* Marshall function inputs */
  dataIn = emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "dataIn");
  validIn = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "validIn");
  resetIn = c_emlrt_marshallIn(&st, emlrtAliasP(prhs[2]), "resetIn");
  /* Invoke the target function */
  hilbert_fir_filter_1027_cosim(&st, dataIn, validIn, resetIn, &ref_dataOut,
                                &ref_validOut);
  /* Marshall function outputs */
  plhs[0] = b_emlrt_marshallOut(&st, ref_dataOut);
  if (nlhs > 1) {
    plhs[1] = emlrt_marshallOut(ref_validOut);
  }
}

/* End of code generation (_coder_hilbert_fir_filter_1027_cosim_api.c) */
