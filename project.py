import numpy as np
import pandas as pd
import matplotlib.pyplot as plt



with open("retrieved_data.csv") as file:
    data = pd.read_csv(file)

print(data.columns)


h_diff = data["estimated_height"] - data["measured_height"]
print(h_diff)
print(sum(h_diff))


w_diff = data["estimated_weight"] - data["measured_weight"]
print(w_diff)
print(sum(w_diff))


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


