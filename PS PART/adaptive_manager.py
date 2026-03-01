from pynq import Overlay, allocate
import numpy as np
import pandas as pd
from scipy.signal import find_peaks
import matplotlib.pyplot as plt


# Load overlay
ol = Overlay("design.bit")
dma = ol.axi_dma_0

print("Overlay Loaded")

# Load ECG data
df = pd.read_csv("223.csv")
ecg = df[df.columns[1]].values.astype(np.int32)
N = len(ecg)

# Heart rate calculation
peaks, _ = find_peaks(ecg, distance=150)
hr = len(peaks) * 6
print("Heart Rate:", hr)

# Buffer allocation
input_buffer = allocate(shape=(N,), dtype=np.int32)
output_buffer = allocate(shape=(N,), dtype=np.int32)

input_buffer[:] = ecg

# DMA Transfer
dma.sendchannel.transfer(input_buffer)
dma.recvchannel.transfer(output_buffer)

dma.sendchannel.wait()
dma.recvchannel.wait()

filtered = np.copy(output_buffer)

# Plot
plt.figure(figsize=(12,5))
plt.plot(ecg, label="Original")
plt.plot(filtered, label="Filtered")
plt.legend()
plt.title("Adaptive ECG Filtering")
plt.show()

input_buffer.freebuffer()
output_buffer.freebuffer()
