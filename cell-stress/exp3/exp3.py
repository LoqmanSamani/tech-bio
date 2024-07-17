import pandas as pd
import matplotlib.pyplot as plt


data = {
    'Sample': ['s1', 's2', 's3', 's4', 's5', 's6', 's7', 's8'],
    'Cell Line': ['wt', 'wt', 'wt', 'wt', 'ko', 'ko', 'ko', 'ko'],
    'Treatment': ['Control', '10 ng/ml TRAIL', '50 ng/ml TRAIL',
                  '100 ng/ml TRAIL', 'Control', '10 ng/ml TRAIL',
                  '50 ng/ml TRAIL', '100 ng/ml TRAIL']
}


df = pd.DataFrame(data)


df.to_csv("sampling-pattern.csv", index=False)











# Define the data for DR5, GAPDH, and PARP
data = {
    'DR5': {
        'Hela WT -': [1551.103, 436.974],
        'Hela WT 10 ng': [550.763, 2385.102],
        'Hela WT 50 ng': [201.196, 2343.714],
        'Hela WT 100 ng': [172.075, 2711.592],
        'Hela DR5 KO -': [2070.677, 830.061],
        'Hela DR5 KO 10 ng': [1869.5, 1564.652],
        'Hela DR5 KO 50 ng': [1328.068, 1463.086],
        'Hela DR5 KO 100 ng': [872.008, 1651.164],
        'Background': [81.374, 81.374]
    },
    'GAPDH': {
        'lane': [999.414, 1238.315, 1178.613, 1298.584, 1462.433, 1254.242, 910.851, 923.26],
        'Background': [48.107, 48.107, 48.107, 48.107, 48.107, 48.107, 48.107, 48.107]
    },
    'PARP': {
        'lane 1': [731.298, 249.637, 94.261, 82.663, 1073.128, 924.098, 626.007, 402.091],
        'lane 2': [193.376, 1248.802, 1171.63, 1406.162, 380.408, 764.407, 701.06, 795.721],
        'Background': [34.107, 34.107, 34.107, 34.107, 34.107, 34.107, 34.107, 34.107]
    }
}

# Convert data to pandas DataFrames
df_dr5 = pd.DataFrame(data['DR5'], index=['lane 1', 'lane 2'])
df_gapdh = pd.DataFrame({'lane': data['GAPDH']['lane'], 'Background': data['GAPDH']['Background']}, index=['lane'])
df_parp = pd.DataFrame(data['PARP'], index=['lane 1', 'lane 2'])

# Step 1: Background subtraction
df_dr5_subtracted = df_dr5.sub(df_dr5.loc['Background'], axis=1)
df_gapdh_subtracted = df_gapdh.sub(df_gapdh.loc['lane', 'Background'])
df_parp_subtracted = df_parp.sub(df_parp.loc['Background'], axis=1)

# Step 2: Normalization
# For DR5, using Hela WT - as the loading control
loading_control_dr5 = 'Hela WT -'
df_dr5_normalized = df_dr5_subtracted.div(df_dr5_subtracted[loading_control_dr5], axis=0)

# For GAPDH, using the average of all lanes as the loading control
loading_control_gapdh = df_gapdh_subtracted.mean()
df_gapdh_normalized = df_gapdh_subtracted / loading_control_gapdh

# For PARP, using the average of lane 1 and lane 2 as the loading control
loading_control_parp = df_parp_subtracted.mean(axis=1)
df_parp_normalized = df_parp_subtracted.div(loading_control_parp, axis=0)

# Step 3: Calculate relative expression (%)
df_dr5_relative_expression = df_dr5_normalized / df_dr5_normalized.loc[:, loading_control_dr5].mean() * 100
df_gapdh_relative_expression = df_gapdh_normalized / df_gapdh_normalized.loc['lane'].mean() * 100
df_parp_relative_expression = df_parp_normalized / df_parp_normalized.mean().mean() * 100

# Combine all data into one DataFrame
df_combined = pd.concat([df_dr5, df_gapdh, df_parp,
                         df_dr5_normalized, df_gapdh_normalized, df_parp_normalized,
                         df_dr5_relative_expression, df_gapdh_relative_expression, df_parp_relative_expression],
                        keys=['DR5', 'GAPDH', 'PARP'],
                        axis=1)

# Print the final combined DataFrame
print("Combined DataFrame:")
print(df_combined)

# Visualization: Plotting relative expression
plt.figure(figsize=(14, 8))

# DR5
plt.subplot(2, 2, 1)
df_dr5_relative_expression.plot(kind='bar', ax=plt.gca(), title='DR5 Relative Expression')
plt.xticks(rotation=0)

# GAPDH
plt.subplot(2, 2, 2)
df_gapdh_relative_expression.plot(kind='bar', ax=plt.gca(), title='GAPDH Relative Expression')
plt.xticks(rotation=0)

# PARP
plt.subplot(2, 2, 3)
df_parp_relative_expression.plot(kind='bar', ax=plt.gca(), title='PARP Relative Expression')
plt.xticks(rotation=0)

plt.tight_layout()
plt.show()
