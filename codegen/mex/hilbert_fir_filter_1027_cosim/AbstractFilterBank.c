/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * AbstractFilterBank.c
 *
 * Code generation for function 'AbstractFilterBank'
 *
 */

/* Include files */
#include "AbstractFilterBank.h"
#include "hilbert_fir_filter_1027_cosim_internal_types.h"
#include "rt_nonfinite.h"
#include <string.h>

/* Function Definitions */
void AbstractFilterBank_resetImpl(c_dsphdl_private_AbstractFilter *obj)
{
  obj->pWrOutBuffer_roll = false;
  obj->pRdOutBuffer_roll = false;
  obj->pResetStart = false;
  obj->pOutputVld = false;
  obj->pDinVldReg1 = false;
  obj->pDinVldReg2 = false;
  obj->pWrOutBuffer_index = 1.0;
  obj->pRdOutBuffer_index = 1.0;
  obj->pSimTime = 1.0;
  obj->pFilterBankIndex = 1.0;
  memset(&obj->pOutputBuffer[0], 0, 104U * sizeof(int32_T));
  memset(&obj->pVldInPipeline[0], 0, 13U * sizeof(real_T));
  memset(&obj->pAccReg[0], 0, 11U * sizeof(int64_T));
}

/* End of code generation (AbstractFilterBank.c) */
