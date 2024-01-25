import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import pylab
import scipy.stats as stats
import statsmodels.api as sm

with open("retrieved_data.csv") as file:
    data = pd.read_csv(file)

print(data.columns)


h_diff = data["estimated_height"] - data["measured_height"]
print(h_diff)
print(sum(h_diff))


w_diff = data["estimated_weight"] - data["measured_weight"]
print(w_diff)
print(sum(w_diff))

"""
plt.figure(figsize=(12, 4))

plt.subplot(1, 2, 1)
plt.scatter(range(1, 41), h_diff, color="gray")
plt.plot(range(41), [0 for _ in range(41)], color="orange")
plt.xlabel("Participant Index")
plt.ylabel("Height Difference (cm)")
plt.title("Difference between Measured and Estimated Height")

plt.subplot(1, 2, 2)
plt.scatter(range(1, 41), w_diff, color="gray")
plt.plot(range(41), [0 for _ in range(41)], color="orange")
plt.xlabel("Participant Index")
plt.ylabel("Weight Difference (kg)")
plt.title("Difference between Measured and Estimated Weight")

plt.tight_layout()
plt.show()

# Histograms
plt.figure(figsize=(12, 4))

plt.subplot(1, 2, 1)
plt.hist(h_diff, bins=20, rwidth=0.8, edgecolor='black', color="gray")
plt.ylabel("Number of Participants")
plt.xlabel("Height Difference (cm)")
plt.title("Histogram of Differences in Height Measurement")

plt.subplot(1, 2, 2)
plt.hist(w_diff, bins=20, rwidth=0.8, edgecolor='black', color="gray")
plt.ylabel("Number of Participants")
plt.xlabel("Weight Difference (kg)")
plt.title("Histogram of Differences in Weight Measurement")

plt.tight_layout()
plt.show()


fig, ax = plt.subplots()


boxplot_height = ax.boxplot(h_diff, positions=[1], widths=0.6, whis=True, patch_artist=True)
boxplot_weight = ax.boxplot(w_diff, positions=[2], widths=0.6, whis=True, patch_artist=True)


colors = ['lightgray', 'gray']
for boxplot, color in zip([boxplot_height, boxplot_weight], colors):
    for box in boxplot['boxes']:
        box.set_facecolor(color)

# Set labels and title
ax.set_xticks([1, 2])
ax.set_xticklabels(['Height Difference', 'Weight Difference'])
ax.set_ylabel('Difference')
ax.set_title('Boxplots of Height and Weight Differences')

plt.show()
"""

# Descriptive Statistics
h_mean, h_std, h_med = (np.mean(h_diff), np.std(h_diff), np.median(h_diff))
w_mean, w_std, w_med = (np.mean(w_diff), np.std(w_diff), np.median(w_diff))
print(h_mean)
print(h_std)
print(h_med)
print(w_mean)
print(w_std)
print(w_med)
"""
0.7175000000000011
1.060397920593963
0.8500000000000085
-0.44750000000000034
1.850944015901076
-0.10000000000000142
"""


# Q-Q plots
fig = sm.qqplot(w_diff, line="s")
plt.show()


print(list(h_diff))
print(list(w_diff))
"""
Additional Considerations:

    Ensure assumptions of the t-test are met, including normality of the data and equal variances between groups.
    Consider visualizations such as box plots or histograms to better understand the distribution of differences for each gender.
"""

m = data[data["gender"] == "Male"]
f = data[data["gender"] == "Female"]
print(m)
print(f)

mh_diff = m["estimated_height"] - m["measured_height"]
fh_diff = f["estimated_height"] - f["measured_height"]

mw_diff = m["estimated_weight"] - m["measured_weight"]
fw_diff = f["estimated_weight"] - f["measured_weight"]

mh_mean, mh_std, mh_var,  mh_med = (np.mean(mh_diff), np.std(mh_diff), np.var(mh_diff), np.median(mh_diff))
fh_mean, fh_std, fh_var,  fh_med = (np.mean(fh_diff), np.std(fh_diff), np.var(fh_diff), np.median(fh_diff))

mw_mean, mw_std, mw_var, mw_med = (np.mean(mw_diff), np.std(mw_diff), np.var(mw_diff), np.median(mw_diff))
fw_mean, fw_std, fw_var, fw_med = (np.mean(fw_diff), np.std(fw_diff), np.var(fw_diff), np.median(fw_diff))

print(mh_mean)
print(mh_var)
print(mh_std)
print(mh_med)


print(fh_mean)
print(fh_var)
print(fh_std)
print(fh_med)


print(mw_mean)
print(mw_var)
print(mw_std)
print(mw_med)


print(fw_mean)
print(fw_var)
print(fw_std)
print(fw_med)


self_reported = data["estimated_height"]
measured = data["measured_height"]      # Replace [...] with your data


differences = self_reported - measured
means = (self_reported + measured) / 2

# Bland-Altman Plot
plt.figure(figsize=(8, 6))
plt.scatter(means, differences, color='blue', alpha=0.7)
plt.axhline(y=np.mean(differences), color='red', linestyle='--', label='Mean Difference')
plt.title('Bland-Altman Plot')
plt.xlabel('Mean of Self-reported and Measured')
plt.ylabel('Difference (Self-reported - Measured)')
plt.legend()
plt.show()
