import pandas as pd


excel_file = r'C:\Users\yda2\Desktop\exp4-ht29.xlsx'
df = pd.read_excel(excel_file)


csv_file = 'exp4-ht29.csv'
df.to_csv(csv_file, index=False)


excel_file = r'C:\Users\yda2\Desktop\exp4-hela.xlsx'
df = pd.read_excel(excel_file)


csv_file = 'exp4-hela.csv'
df.to_csv(csv_file, index=False)
