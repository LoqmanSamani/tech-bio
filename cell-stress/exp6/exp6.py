import pandas as pd


excel_file = r'C:\Users\yda2\Desktop/w.xlsx'
df = pd.read_excel(excel_file)


csv_file = 'fiji-output.csv'
df.to_csv(csv_file, index=False)

print(f"Data successfully exported to {csv_file}.")
