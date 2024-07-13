import pandas as pd

# Create a dictionary with the data
data = {
    'Sample': ['s1', 's2', 's3', 's4', 's5', 's6', 's7', 's8'],
    'Cell Line': ['wt', 'wt', 'wt', 'wt', 'ko', 'ko', 'ko', 'ko'],
    'Treatment': ['Control', '10 ng/ml TRAIL', '50 ng/ml TRAIL', '100 ng/ml TRAIL', 'Control', '10 ng/ml TRAIL', '50 ng/ml TRAIL', '100 ng/ml TRAIL']
}

# Create a DataFrame
df = pd.DataFrame(data)


df.to_csv("sampling-pattern.csv", index=False)