import pandas as pd


excel_file = r'C:\Users\yda2\Desktop\internship\ApoptoEverything\Input\Book1.xlsx'
df = pd.read_excel(excel_file)


csv_file = 'exp2.csv'
df.to_csv(csv_file, index=False)

