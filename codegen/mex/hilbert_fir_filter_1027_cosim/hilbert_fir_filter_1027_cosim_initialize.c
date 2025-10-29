/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * hilbert_fir_filter_1027_cosim_initialize.c
 *
 * Code generation for function 'hilbert_fir_filter_1027_cosim_initialize'
 *
 */

/* Include files */
#include "hilbert_fir_filter_1027_cosim_initialize.h"
#include "_coder_hilbert_fir_filter_1027_cosim_mex.h"
#include "hilbert_fir_filter_1027.h"
#include "hilbert_fir_filter_1027_cosim_data.h"
#include "rt_nonfinite.h"

/* Variable Definitions */
static emlrtMCInfo emlrtMCI = {
    -1, /* lineNo */
    -1, /* colNo */
    "", /* fName */
    ""  /* pName */
};

/* Function Declarations */
static const mxArray *b_numerictype(const emlrtStack *sp,
                                    emlrtMCInfo *location);

static void c_hilbert_fir_filter_1027_cosim(const emlrtStack *sp);

static const mxArray *c_numerictype(const emlrtStack *sp,
                                    emlrtMCInfo *location);

static const mxArray *fimath(const emlrtStack *sp, const char_T *s,
                             const char_T *s1, const char_T *s2,
                             const char_T *s3, emlrtMCInfo *location);

static const mxArray *numerictype(const emlrtStack *sp, emlrtMCInfo *location);

/* Function Definitions */
static const mxArray *b_numerictype(const emlrtStack *sp, emlrtMCInfo *location)
{
  const mxArray *pArrays[8];
  const mxArray *m;
  pArrays[0] = emlrtCreateStringR2022a((emlrtCTX)sp, "FractionLength");
  pArrays[1] = emlrtCreateDoubleScalar(14.0);
  pArrays[2] = emlrtCreateStringR2022a((emlrtCTX)sp, "BinaryPoint");
  pArrays[3] = emlrtCreateDoubleScalar(14.0);
  pArrays[4] = emlrtCreateStringR2022a((emlrtCTX)sp, "Slope");
  pArrays[5] = emlrtCreateDoubleScalar(6.103515625E-5);
  pArrays[6] = emlrtCreateStringR2022a((emlrtCTX)sp, "FixedExponent");
  pArrays[7] = emlrtCreateDoubleScalar(-14.0);
  return emlrtCallMATLABR2012b((emlrtConstCTX)sp, 1, &m, 8, &pArrays[0],
                               "numerictype", true, location);
}

static void c_hilbert_fir_filter_1027_cosim(const emlrtStack *sp)
{
  mex_InitInfAndNan();
  emlrtAssignP(&e_eml_mx, b_numerictype(sp, &emlrtMCI));
  emlrtAssignP(&d_eml_mx, c_numerictype(sp, &emlrtMCI));
  emlrtAssignP(&c_eml_mx,
               fimath(sp, "floor", "Floor", "wrap", "Wrap", &emlrtMCI));
  emlrtAssignP(&b_eml_mx, numerictype(sp, &emlrtMCI));
  emlrtAssignP(&eml_mx, fimath(sp, "nearest", "Nearest", "saturate", "Saturate",
                               &emlrtMCI));
  hilbert_fir_filter_1027_init();
  emlrtCheckDefaultFimathR2008b(&eml_mx);
}

static const mxArray *c_numerictype(const emlrtStack *sp, emlrtMCInfo *location)
{
  const mxArray *pArrays[10];
  const mxArray *m;
  pArrays[0] = emlrtCreateStringR2022a((emlrtCTX)sp, "WordLength");
  pArrays[1] = emlrtCreateDoubleScalar(32.0);
  pArrays[2] = emlrtCreateStringR2022a((emlrtCTX)sp, "FractionLength");
  pArrays[3] = emlrtCreateDoubleScalar(29.0);
  pArrays[4] = emlrtCreateStringR2022a((emlrtCTX)sp, "BinaryPoint");
  pArrays[5] = emlrtCreateDoubleScalar(29.0);
  pArrays[6] = emlrtCreateStringR2022a((emlrtCTX)sp, "Slope");
  pArrays[7] = emlrtCreateDoubleScalar(1.862645149230957E-9);
  pArrays[8] = emlrtCreateStringR2022a((emlrtCTX)sp, "FixedExponent");
  pArrays[9] = emlrtCreateDoubleScalar(-29.0);
  return emlrtCallMATLABR2012b((emlrtConstCTX)sp, 1, &m, 10, &pArrays[0],
                               "numerictype", true, location);
}

static const mxArray *fimath(const emlrtStack *sp, const char_T *s,
                             const char_T *s1, const char_T *s2,
                             const char_T *s3, emlrtMCInfo *location)
{
  const mxArray *pArrays[42];
  const mxArray *m;
  pArrays[0] = emlrtCreateStringR2022a((emlrtCTX)sp, "RoundMode");
  pArrays[1] = emlrtCreateStringR2022a((emlrtCTX)sp, s);
  pArrays[2] = emlrtCreateStringR2022a((emlrtCTX)sp, "RoundingMethod");
  pArrays[3] = emlrtCreateStringR2022a((emlrtCTX)sp, s1);
  pArrays[4] = emlrtCreateStringR2022a((emlrtCTX)sp, "OverflowMode");
  pArrays[5] = emlrtCreateStringR2022a((emlrtCTX)sp, s2);
  pArrays[6] = emlrtCreateStringR2022a((emlrtCTX)sp, "OverflowAction");
  pArrays[7] = emlrtCreateStringR2022a((emlrtCTX)sp, s3);
  pArrays[8] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductMode");
  pArrays[9] = emlrtCreateStringR2022a((emlrtCTX)sp, "FullPrecision");
  pArrays[10] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumMode");
  pArrays[11] = emlrtCreateStringR2022a((emlrtCTX)sp, "FullPrecision");
  pArrays[12] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductWordLength");
  pArrays[13] = emlrtCreateDoubleScalar(32.0);
  pArrays[14] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumWordLength");
  pArrays[15] = emlrtCreateDoubleScalar(32.0);
  pArrays[16] = emlrtCreateStringR2022a((emlrtCTX)sp, "MaxProductWordLength");
  pArrays[17] = emlrtCreateDoubleScalar(65535.0);
  pArrays[18] = emlrtCreateStringR2022a((emlrtCTX)sp, "MaxSumWordLength");
  pArrays[19] = emlrtCreateDoubleScalar(65535.0);
  pArrays[20] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductFractionLength");
  pArrays[21] = emlrtCreateDoubleScalar(30.0);
  pArrays[22] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductFixedExponent");
  pArrays[23] = emlrtCreateDoubleScalar(-30.0);
  pArrays[24] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumFractionLength");
  pArrays[25] = emlrtCreateDoubleScalar(30.0);
  pArrays[26] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumFixedExponent");
  pArrays[27] = emlrtCreateDoubleScalar(-30.0);
  pArrays[28] =
      emlrtCreateStringR2022a((emlrtCTX)sp, "SumSlopeAdjustmentFactor");
  pArrays[29] = emlrtCreateDoubleScalar(1.0);
  pArrays[30] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumBias");
  pArrays[31] = emlrtCreateDoubleScalar(0.0);
  pArrays[32] =
      emlrtCreateStringR2022a((emlrtCTX)sp, "ProductSlopeAdjustmentFactor");
  pArrays[33] = emlrtCreateDoubleScalar(1.0);
  pArrays[34] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductBias");
  pArrays[35] = emlrtCreateDoubleScalar(0.0);
  pArrays[36] = emlrtCreateStringR2022a((emlrtCTX)sp, "CastBeforeSum");
  pArrays[37] = emlrtCreateLogicalScalar(true);
  pArrays[38] = emlrtCreateStringR2022a((emlrtCTX)sp, "SumSlope");
  pArrays[39] = emlrtCreateDoubleScalar(9.3132257461547852E-10);
  pArrays[40] = emlrtCreateStringR2022a((emlrtCTX)sp, "ProductSlope");
  pArrays[41] = emlrtCreateDoubleScalar(9.3132257461547852E-10);
  return emlrtCallMATLABR2012b((emlrtConstCTX)sp, 1, &m, 42, &pArrays[0],
                               "fimath", true, location);
}

static const mxArray *numerictype(const emlrtStack *sp, emlrtMCInfo *location)
{
  const mxArray *m;
  return emlrtCallMATLABR2012b((emlrtConstCTX)sp, 1, &m, 0, NULL, "numerictype",
                               true, location);
}

void hilbert_fir_filter_1027_cosim_initialize(void)
{
  static const volatile char_T *emlrtBreakCheckR2012bFlagVar = NULL;
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtBreakCheckR2012bFlagVar = emlrtGetBreakCheckFlagAddressR2022b(&st);
  emlrtClearAllocCountR2012b(&st, false, 3U, "ForceOff");
  emlrtEnterRtStackR2012b(&st);
  emlrtLicenseCheckR2022a(&st, "EMLRT:runTime:MexFunctionNeedsLicense",
                          "dsp_hdl_toolbox", 2);
  emlrtLicenseCheckR2022a(&st, "EMLRT:runTime:MexFunctionNeedsLicense",
                          "signal_toolbox", 2);
  emlrtLicenseCheckR2022a(&st, "EMLRT:runTime:MexFunctionNeedsLicense",
                          "fixed_point_toolbox", 2);
  if (emlrtFirstTimeR2012b(emlrtRootTLSGlobal)) {
    c_hilbert_fir_filter_1027_cosim(&st);
  }
}

/* End of code generation (hilbert_fir_filter_1027_cosim_initialize.c) */
