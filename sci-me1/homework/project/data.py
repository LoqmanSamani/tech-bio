import pandas as pd
import numpy as np


pd.set_option('display.max_columns', None)

np.random.seed(42)


# male variables
m_age = np.array([np.random.choice([i for i in range(20, 51)]) for _ in range(20)])
print(m_age)
""" [26 39 48 34 30 27 48 40 26 45 38 42 30 30 43 40 23 27 43 22] """

m_high = np.array([np.random.choice([i for i in range(170, 180)]) for _ in range(20)])
print(m_high)
""" [175 174 171 177 175 171 174 170 179 175 178 170 179 172 176 173 178 172 174 172] """

m_weight = np.array([np.random.choice([i for i in range(70, 90)]) for _ in range(20)])
print(m_weight)
""" [76 78 76 87 73 83 87 78 71 89 84 76 81 77 84 72 83 86 73 87] """


# female variables
f_age = np.array([np.random.choice([i for i in range(16, 60)]) for _ in range(20)])
print(f_age)
""" [55 19 17 21 57 19 44 33 41 59 49 25 51 29 46 30 23 29 38 55] """

f_high = np.array([np.random.choice([i for i in range(157, 174)]) for _ in range(20)])
print(f_high)
""" [172 169 171 169 165 171 169 157 163 165 157 168 164 167 173 164 159 159 157 161] """

f_weight = np.array([np.random.choice([i for i in range(55, 70)]) for _ in range(20)])
print(f_weight)
""" [64 61 64 63 66 61 63 62 66 56 55 61 61 68 62 59 57 66 62 60] """


p_id = [f"Participant {i}" for i in range(1, 41)]
print(p_id)
""" 
['Participant 1', 'Participant 2', 'Participant 3', 'Participant 4', 'Participant 5', 'Participant 6', 'Participant 7', 
'Participant 8', 'Participant 9', 'Participant 10', 'Participant 11', 'Participant 12', 'Participant 13', 
'Participant 14', 'Participant 15', 'Participant 16', 'Participant 17', 'Participant 18', 'Participant 19', 
'Participant 20', 'Participant 21', 'Participant 22', 'Participant 23', 'Participant 24', 'Participant 25', 
'Participant 26', 'Participant 27', 'Participant 28', 'Participant 29', 'Participant 30', 'Participant 31', 
'Participant 32', 'Participant 33', 'Participant 34', 'Participant 35', 'Participant 36', 'Participant 37', 
'Participant 38', 'Participant 39', 'Participant 40']
"""


gender = np.hstack((np.array(["Male" for i in range(20)]), np.array(["Female" for i in range(20)])))
print(gender)
"""
['Male' 'Male' 'Male' 'Male' 'Male' 'Male' 'Male' 'Male' 'Male' 'Male'
 'Male' 'Male' 'Male' 'Male' 'Male' 'Male' 'Male' 'Male' 'Male' 'Male'
 'Female' 'Female' 'Female' 'Female' 'Female' 'Female' 'Female' 'Female'
 'Female' 'Female' 'Female' 'Female' 'Female' 'Female' 'Female' 'Female'
 'Female' 'Female' 'Female' 'Female']
"""


# Measurements

def measure_generate(lst, left_r, right_r, r_num, num=20):

    measurements = []

    for i in range(num):

        error = np.random.uniform(-left_r, right_r)
        measurement = lst[i] + error
        if r_num == int:
            measurements.append(int(measurement))
        else:
            measurements.append(round(measurement, r_num))

    return np.array(measurements)


fm_high = measure_generate(m_high, 3, 1, r_num=1)
print(fm_high)


ff_high = measure_generate(f_high, 2, 1, r_num=1)
print(ff_high)


fm_weight = measure_generate(m_weight, 3, 5, r_num=1)
print(fm_weight)


ff_weight = measure_generate(f_weight, 2, 3, r_num=1)
print(ff_weight)



data = pd.DataFrame({
    "Participant ID": p_id,
    "Gender": gender,
    "Age": np.hstack((m_age, f_age)),
    "Guessed Height (cm)": np.hstack((m_high, f_high)),
    "Measured Height (cm)": np.hstack((fm_high, ff_high)),
    "Guessed Weight (kg)": np.hstack((m_weight, f_weight)),
    "Measured Weight (kg)": np.hstack((fm_weight, ff_weight))
})

print(data)


"""

Deviation in Height (cm): The calculated difference between guessed and measured height.
Deviation in Weight (kg): The calculated difference between guessed and measured weight.
Age Group: Categorize participants into "Young" and "Old" based on an age threshold.
"""

diff_height = round(data["Guessed Height (cm)"] - data["Measured Height (cm)"], 2)
diff_weight = round(data["Guessed Weight (kg)"] - data["Measured Weight (kg)"], 2)
age_group = ["Young" if age < 35 else "Old" for age in list(data["Age"])]


data["Deviation in Height (cm)"] = diff_height
data["Deviation in Weight (kg)"] = diff_weight
data["Age Group"] = age_group

print(data)

data.to_csv("data.csv", index=False)


