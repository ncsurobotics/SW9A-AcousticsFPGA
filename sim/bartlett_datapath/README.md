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

# Known Areas With Room For Improvement

PERFORMANCE ENHANCEMENTS
1. FFT - The FFT uses floating point blocks internally for higher precision and automatic scaling. This configuration adds a lot of latency. 
Switching to a fixed point implementation would reduce latency but require toying around with scaling schedule to minimize under/overflow
2. Complex Matrix Multiplier - The complex matrix multiplier (CMM) was designed to multiply a 4x256 matrix by its conjugate transpose. 
This design required very a high throughput of 16 multiplies per cycle, therefore 16 complex multiplier IPs are used. 
The current design multiplies a 4x1 matrix by its conjugate transpose, for a total of 16 multiplies. Therefore, the use of 16
complex multiply IPs is very wasteful for both power and resources (DSP/LUT), and a better design could be implemented. 
NOTE: The diagonal of the resulting matrix is still going to be 0 for the imaginary.
5. FFT - The FFT uses a Radix2 implementation, however, a Radix4 implementation would be ~50% faster for a minimal resource usage increase.
3. RXX - The complex matrix multiplier uses IPs which are configured to take in 32 bit (16imag,16real) numbers, and output 64 bit (32imag,32real) numbers.
The current implementation has those numbers then being arithmetically bit shifted 16 bits to the right to become 32 bit numbers again. 
The IP allows for configurable output size, therefore having it output 32 bit numbers would, most likely, internalize the logic we are putting into the scalar divide, and save some registers.
4. Ptheta - The ptheta module could be redesigned to be more pipelined and use less cmpy_1 IPs, as it currently uses 16 in parallel. This change would proportionally increase latency.
4. The complex multiplier IPs are all configured to only use LUTs, by implementing some of the above changes, more DSP slices would free up to allow for DSP to be used.


TESTING/VERIFICATION
1. The current method for testing a range of input samples is editing the filepath in the .v file, then recompiling and simulating for each input. This method is slow and inefficient.
Modifying the testbench to allow for a vector of input files to be played in series would greatly improve performance in simulation (currently to run 95 test datasets takes 1.5 hours, around 80% of that is compilation).
2. The angles tested thus far have been multiples of 10 degrees, which is the level of precision that design has. Analyzing the performance for more granular angles would be valueable.


CODE CLEANLINESS

1. Matrix - During the final stages of testing, it was found that the CMM's output was the transpose of the correct value. To fix this, the wire indexing was rearranged.
There may be a better and more correct solution to this issue.
2. The file "complex_mult.v" is the oldest file in the datapath, and thus has very inefficiently written code. "generate for loops" would clean up the file a lot.
3. scalar_divide.v has many scalar division implementations. Removing all but one would bring clarity.
