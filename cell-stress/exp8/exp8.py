import pandas as pd


excel_file = r'C:\Users\yda2\Desktop\internship\tabea\f\exp8_data.xlsx'
df = pd.read_excel(excel_file)


csv_file = 'mtt-data.csv'
df.to_csv(csv_file, index=False)