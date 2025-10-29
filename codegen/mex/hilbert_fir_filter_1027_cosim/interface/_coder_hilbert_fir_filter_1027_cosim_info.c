/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_hilbert_fir_filter_1027_cosim_info.c
 *
 * Code generation for function 'hilbert_fir_filter_1027_cosim'
 *
 */

/* Include files */
#include "_coder_hilbert_fir_filter_1027_cosim_info.h"
#include "emlrt.h"
#include "tmwtypes.h"

/* Function Declarations */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void);

/* Function Definitions */
static const mxArray *c_emlrtMexFcnResolvedFunctionsI(void)
{
  const mxArray *nameCaptureInfo;
  const char_T *data[5] = {
      "789ce5544b4bc34010de4a15c1e7494ffe8552f5207aabd55605b56015c1959a66277631"
      "9bd4cdf6e5c99b17c5bfe44df0e8d91fe0d9b307dbb4db4760d96224"
      "be06c2e4e39bdd6f66321914dbde8d2184a651db8e27db7eaa83673b7e040d5a908f05e2"
      "6283e16814c507ce49febee34dd71150176de0180cba2789cba86338",
      "22df2803e2e0b9761588cf58d4863c6570d00ff65a8865faa82e6851adf77409cc8b830a"
      "43bce4f532b4fb41b71f678a7ae39a7e042dd88f609cd4bbfea49ebc"
      "7f41a327f912b58bc045c1a2bcf9d802786131b9b452305d8fb2be7cca21f399d0e42379"
      "6045200448c2a23e96faaf21f56f34fa923fd93c4dafe1430fb88753",
      "b5e694e123e0d476cf71eab262940df302170d2e6c1002373bd405056288262d4ad87409"
      "9c8383159dc57e67556cbbef09a69dbb9921eb0efa5efcb8efefb22f"
      "3e15959ef1f884a2d493f65d7a75c57dc3ceed9c426f36c03792c92a34d21bc23ccee5b2"
      "5b758b18ec2ad3cb23a7d1d1e5811438aafbffebff1f767ee635754b",
      "5e91cf8fd9ff0f21f54f34fa920ffffd159d4cb0817ace14f97ed51eba8d78af8fbdbf3d"
      "47a927edafeff5eaf2ee8e73c889b85a653cbd68edd3cd5a6dfdf7ef"
      "f50f6340fb56",
      ""};
  nameCaptureInfo = NULL;
  emlrtNameCaptureMxArrayR2016a(&data[0], 3184U, &nameCaptureInfo);
  return nameCaptureInfo;
}

mxArray *emlrtMexFcnProperties(void)
{
  mxArray *xEntryPoints;
  mxArray *xInputs;
  mxArray *xResult;
  const char_T *epFieldName[7] = {
      "QualifiedName",    "NumberOfInputs", "NumberOfOutputs", "ConstantInputs",
      "ResolvedFilePath", "TimeStamp",      "Visible"};
  const char_T *propFieldName[7] = {
      "Version",      "ResolvedFunctions", "Checksum", "EntryPoints",
      "CoverageInfo", "IsPolymorphic",     "AuxData"};
  uint8_T v[216] = {
      0U,   1U,   73U,  77U,  0U,   0U,   0U,   0U,   14U,  0U,   0U,   0U,
      200U, 0U,   0U,   0U,   6U,   0U,   0U,   0U,   8U,   0U,   0U,   0U,
      2U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,   5U,   0U,   0U,   0U,
      8U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,
      1U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,   5U,   0U,   4U,   0U,
      17U,  0U,   0U,   0U,   1U,   0U,   0U,   0U,   17U,  0U,   0U,   0U,
      67U,  108U, 97U,  115U, 115U, 69U,  110U, 116U, 114U, 121U, 80U,  111U,
      105U, 110U, 116U, 115U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      14U,  0U,   0U,   0U,   112U, 0U,   0U,   0U,   6U,   0U,   0U,   0U,
      8U,   0U,   0U,   0U,   2U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      5U,   0U,   0U,   0U,   8U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,
      0U,   0U,   0U,   0U,   1U,   0U,   0U,   0U,   0U,   0U,   0U,   0U,
      5U,   0U,   4U,   0U,   14U,  0U,   0U,   0U,   1U,   0U,   0U,   0U,
      56U,  0U,   0U,   0U,   81U,  117U, 97U,  108U, 105U, 102U, 105U, 101U,
      100U, 78U,  97U,  109U, 101U, 0U,   77U,  101U, 116U, 104U, 111U, 100U,
      115U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   80U,  114U, 111U, 112U,
      101U, 114U, 116U, 105U, 101U, 115U, 0U,   0U,   0U,   0U,   72U,  97U,
      110U, 100U, 108U, 101U, 0U,   0U,   0U,   0U,   0U,   0U,   0U,   0U};
  xEntryPoints =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&epFieldName[0]);
  xInputs = emlrtCreateLogicalMatrix(1, 3);
  emlrtSetField(xEntryPoints, 0, "QualifiedName",
                emlrtMxCreateString("hilbert_fir_filter_1027_cosim"));
  emlrtSetField(xEntryPoints, 0, "NumberOfInputs",
                emlrtMxCreateDoubleScalar(3.0));
  emlrtSetField(xEntryPoints, 0, "NumberOfOutputs",
                emlrtMxCreateDoubleScalar(2.0));
  emlrtSetField(xEntryPoints, 0, "ConstantInputs", xInputs);
  emlrtSetField(
      xEntryPoints, 0, "ResolvedFilePath",
      emlrtMxCreateString(
          "C:\\Users\\Aweso\\Verilog\\Aquapack\\bartlett\\sim\\bartlett_"
          "datapath\\codegen\\hilbert_fir_filter_1027\\cosim\\hilbert_fir_filt"
          "er_1027_cosim.m"));
  emlrtSetField(xEntryPoints, 0, "TimeStamp",
                emlrtMxCreateDoubleScalar(739917.74981481477));
  emlrtSetField(xEntryPoints, 0, "Visible", emlrtMxCreateLogicalScalar(true));
  xResult =
      emlrtCreateStructMatrix(1, 1, 7, (const char_T **)&propFieldName[0]);
  emlrtSetField(xResult, 0, "Version",
                emlrtMxCreateString("25.2.0.2998904 (R2025b)"));
  emlrtSetField(xResult, 0, "ResolvedFunctions",
                (mxArray *)c_emlrtMexFcnResolvedFunctionsI());
  emlrtSetField(xResult, 0, "Checksum",
                emlrtMxCreateString("ddut8FHr6320qnmJJKjIGE"));
  emlrtSetField(xResult, 0, "EntryPoints", xEntryPoints);
  emlrtSetField(xResult, 0, "AuxData",
                emlrtMxCreateRowVectorUINT8((const uint8_T *)&v, 216U));
  return xResult;
}

/* End of code generation (_coder_hilbert_fir_filter_1027_cosim_info.c) */
