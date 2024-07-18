import pandas as pd


excel_file = r'C:\Users\yda2\Desktop\exp51.xlsx'
df = pd.read_excel(excel_file)


csv_file = 'exp5-1.csv'
df.to_csv(csv_file, index=False)


excel_file = r'C:\Users\yda2\Desktop\exp52.xlsx'
df = pd.read_excel(excel_file)


csv_file = 'exp5-2.csv'
df.to_csv(csv_file, index=False)