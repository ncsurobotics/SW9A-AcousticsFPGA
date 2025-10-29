/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * SystemCore.h
 *
 * Code generation for function 'SystemCore'
 *
 */

#pragma once

/* Include files */
#include "hilbert_fir_filter_1027_cosim_internal_types.h"
#include "rtwtypes.h"
#include "emlrt.h"
#include "mex.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* Function Declarations */
int32_T SystemCore_step(const emlrtStack *sp, dsphdl_FIRFilter *obj,
                        int16_T varargin_1, boolean_T varargin_2,
                        boolean_T varargin_3, boolean_T *varargout_2);

/* End of code generation (SystemCore.h) */
