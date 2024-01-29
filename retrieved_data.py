
import pandas as pd

path = "data.csv"

with open(path) as file:
    data = pd.read_csv(file)

print(data.columns)




id = range(1, 41)
number = data["Participant ID"]
gender = data["Gender"]
age = data["Age"]
measured_weight = data["Measured Weight (kg)"]
measured_height = data["Measured Height (cm)"]
estimated_height = data["Guessed Weight (kg)"]
estimated_weight = data["Guessed Weight (kg)"]
project_id = [2 for _ in range(1, 41)]
person = range(1, 41)


new_data = pd.DataFrame({

    "id" : range(1, 41),
    "number" : data["Participant ID"],
    "gender" : data["Gender"],
    "age" : data["Age"],
    "measured_weight": data["Measured Weight (kg)"],
    "measured_height": data["Measured Height (cm)"],
    "estimated_height": data["Guessed Height (cm)"],
    "estimated_weight": data["Guessed Weight (kg)"],
    "project_id": [2 for _ in range(1, 41)],
    "person": range(1, 41)

})



new_data.to_csv("retrieved_data1.csv", index=False)
