import numpy as np
import pandas as pd

Fs = 250_000         # sample rate
f_sig = 25_000       # signal freq
N = 256              # samples per channel
bits = 16
amp = 0.8            # 80% full-scale
phases = [0, np.pi/4, np.pi/2, 3*np.pi/4]  # distinguish channels

def to_int16(x):
    # scale to 16-bit 2's complement and round
    return np.round(x * ((1 << (bits-1)) - 1)).astype(np.int16)

def pack_word(ch1: int, ch2: int, ch3: int, ch4: int) -> int:
    """
    Pack into 128 bits (MSB→LSB):
    ch4(16i,16r) _ ch3(16i,16r) _ ch2(16i,16r) _ ch1(16i,16r)
    Imag parts are zero.  Use ONLY Python ints to avoid 64-bit overflow.
    """
    fields = [
        0,               int(ch4) & 0xFFFF,
        0,               int(ch3) & 0xFFFF,
        0,               int(ch2) & 0xFFFF,
        0,               int(ch1) & 0xFFFF,
    ]
    packed = 0
    for f in fields:
        packed = (packed << 16) | (f & 0xFFFF)
    return packed

def unpack_word(word: int):
    """Decode back to signed halves for verification."""
    halves = [ (word >> shift) & 0xFFFF for shift in range(112, -1, -16) ]
    def s16(v): return v - 0x10000 if v & 0x8000 else v
    keys = ["ch4_i","ch4_r","ch3_i","ch3_r","ch2_i","ch2_r","ch1_i","ch1_r"]
    return {k: s16(v) for k,v in zip(keys, halves)}

# Generate signals (all real)
t = np.arange(N) / Fs
signals = [to_int16(amp * np.sin(2*np.pi*f_sig*t + ph)) for ph in phases]

# Write file
out_path = "input_data.txt"
with open(out_path, "w") as f:
    for i in range(N):
        w = pack_word(int(signals[0][i]), int(signals[1][i]),
                      int(signals[2][i]), int(signals[3][i]))
        f.write(f"{w:032X}\n")

# Quick verification (decode first few)
with open(out_path, "r") as f:
    preview = [int(next(f).strip(), 16) for _ in range(6)]
decoded = [unpack_word(w) for w in preview]
print("First 6 samples decoded:")
for row in decoded:
    print(row)
