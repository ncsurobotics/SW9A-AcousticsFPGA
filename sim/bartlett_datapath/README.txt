# File naming format
test_NUMBER_BITWIDTH_ANGLE_ITER
NUMBER = first ever test = 1, each subsequent test is one higher
BITWIDTH = complex bit width. 32 = 16 Re, 16 Im
ANGLE = expected max angle
ITER = iteration of the max angle

# Scripts

## .v

bartlett_datapath_tb.v - manual simulation, simulation set "manual"
bartlett_datapath_tb_auto.v - automatic simulation, simulation set "sim_1"

## .m

oracle.m, oracle_modified.m - outputs correct result for directory. original is deprecated.
batch_oracle.m, batch_oracle_modified.m - outputs correct results for auto_tests/ subdir. original is deprecated.

batch_compare.m - runs individual compare*.m scripts on auto_tests/ subdir.
compare.m, compare_fourier.m, compare_max_freq_vec.m, compare_rxx.m, compare_oracles.m - compares the stated details of test results.

## .py

batch_convert.py - converts test_data/*.csv into values that can be read by testbench.

batch_sim.py - runs tcl scripts with bartlett_datapath_tb_auto.v for each subdir in auto_tests/ subdir

naming.py - used in batch simulate

# Results

test_* - these tests were done manually, individually. non standardized parameters/implementations.
[deprecated] fftvsfir/ - these tests were done to compare the fir implementation vs fft implementation. 
[deprecated] auto_tests_v1, v2, v3/ - these tests were done with earlier implementations of the algorithm. (v3 newest)
auto_tests/ - most recent and working implementation test results
test_data/ - generated raw hydrophone data