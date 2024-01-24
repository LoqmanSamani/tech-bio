import pandas as pd

with open("data.csv") as file:
    data = pd.read_csv(file)


print(data.columns)

age = list(data["Age"])
print(age)

mw = list(data['Measured Weight (kg)'])
print(mw)
mh = list(data["Measured Height (cm)"])
print(mh)
eh = list(data["Guessed Height (cm)"])
print(eh)
ew = list(data["Guessed Weight (kg)"])
print(ew)