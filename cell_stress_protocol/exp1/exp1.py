import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import seaborn as sns



# Pipette Calibration Test


# 1)  prepare data
t = {
    "p10": {"1µ": [0.0010, 0.0011, 0.0009], "5µ": [0.0049, 0.0047, 0.0047], "10µ": [0.0096, 0.0098, 0.0098]},
    "p200": {"20µ": [0.0193, 0.0195, 0.0193], "100µ": [0.0980, 0.0983, 0.0985], "200µ": [0.1977, 0.1976, 0.1978]},
    "p1000": {"100µ": [0.0979, 0.0989, 0.0979], "500µ": [0.4949, 0.4931, 0.4928], "1000µ": [0.9892, 0.9881, 0.9851]}
}

l = {
    "p20": {"2µ": [0.014, 0.0016, 0.0018], "10µ": [0.0088, 0.0099, 0.0094], "20µ": [0.0189, 0.201, 0.0194]},
    "p200": {"20µ": [0.0193, 0.0199, 0.0200], "100µ": [0.0989, 0.0996, 0.0999], "200µ": [0.2050, 0.2006, 0.2006]}
}

t_data = []
for pipette, volumes in t.items():
    for volume, measurements in volumes.items():
        for measurement in measurements:
            t_data.append([pipette, volume, measurement])



t_df = pd.DataFrame(t_data, columns=["Pipette", "Volume*", "Measurement"])
pattern = ["low-val"]*3 + ["med-val"]*3 + ["high-val"]*3
repeated_pattern = pattern * 3
t_df["Volume"] = repeated_pattern
t_df["Normalized Measurement"] = t_df.groupby("Pipette")["Measurement"].transform(lambda x: (x - x.min()) / (x.max() - x.min()))

l_data = []
for pipette, volumes in l.items():
    for volume, measurements in volumes.items():
        for measurement in measurements:
            l_data.append([pipette, volume, measurement])



l_df = pd.DataFrame(l_data, columns=["Pipette", "Volume*", "Measurement"])
pattern = ["low-val"]*3 + ["med-val"]*3 + ["high-val"]*3
repeated_pattern = pattern * 2
l_df["Volume"] = repeated_pattern
l_df["Normalized Measurement"] = l_df.groupby("Pipette")["Measurement"].transform(lambda x: (x - x.min()) / (x.max() - x.min()))



# visualize data
plt.figure(figsize=(26, 8))
sns.catplot(kind='bar', data=t_df, x='Volume', y='Normalized Measurement', col='Pipette', capsize=0.02)
plt.show()


plt.figure(figsize=(18, 8))
sns.catplot(kind='bar', data=l_df, x='Volume', y='Normalized Measurement', col='Pipette', capsize=.05)
plt.show()


# handling errors and outliers





