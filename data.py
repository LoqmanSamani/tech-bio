import pandas as pd
import numpy as np

p_id = [f"Participant {i}" for i in range(1, 41)]
gender = np.hstack((np.array(["Male" for i in range(20)]), np.array(["Female" for i in range(20)])))
age = [26, 39, 48, 34, 30, 27, 48, 40, 26, 45, 38, 42, 30, 30, 43, 40, 23, 27, 43, 22, 55, 19, 17, 21, 57, 19, 44, 33, 41, 59, 49, 25, 51, 29, 46, 30, 23, 29, 38, 55]
measured_weight = [73.1, 79.1, 76.3, 85.8, 71.0, 82.7, 91.5, 77.6, 72.2, 91.6, 83.9, 80.8, 85.7, 76.0, 85.0, 71.4, 82.3, 83.3, 74.9, 88.0, 62.3, 60.4, 66.5, 62.2, 64.7, 61.4, 65.9, 61.2, 67.4, 57.8, 54.2, 62.6, 60.8, 69.2, 63.2, 59.7, 55.5, 68.2, 61.6, 58.9]
measured_height = [175.5, 172.9, 168.5, 176.9, 175.0, 170.2, 174.1, 169.0, 178.1, 173.7, 175.1, 167.4, 176.1, 171.5, 174.3, 172.0, 178.6, 170.0, 172.6, 172.0, 170.7, 167.2, 169.9, 167.5, 165.8, 171.4, 168.9, 157.6, 163.4, 163.6, 157.7, 167.6, 164.4, 167.7, 172.0, 162.3, 157.7, 158.3, 157.5, 161.6]
estimated_height = [175, 174, 171, 177, 175, 171, 174, 170, 179, 175, 178, 170, 179, 172, 176, 173, 178, 172, 174, 172, 172, 169, 171, 169, 165, 171, 169, 157, 163, 165, 157, 168, 164, 167, 173, 164, 159, 159, 157, 161]
estimated_weight = [76, 78, 76, 87, 73, 83, 87, 78, 71, 89, 84, 76, 81, 77, 84, 72, 83, 86, 73, 87, 64, 61, 64, 63, 66, 61, 63, 62, 66, 56, 55, 61, 61, 68, 62, 59, 57, 66, 62, 60]


data = pd.DataFrame({

    "id": list(range(1, 41)),
    "number": p_id,
    "gender": gender,
    "age": age,
    "measured_weight": measured_weight,
    "measured_height": measured_height,
    "id_": list(range(1, 41)),
    "estimated_height": estimated_height,
    "estimated_weight": estimated_weight,
    "project_id": [2 for _ in range(40)],
    "person": list(range(1, 41))

})

print(data)
"""
  id          number  gender  ...  estimated_weight  project_id  person
0    1   Participant 1    Male  ...                76           2       1
1    2   Participant 2    Male  ...                78           2       2
2    3   Participant 3    Male  ...                76           2       3
3    4   Participant 4    Male  ...                87           2       4
4    5   Participant 5    Male  ...                73           2       5
5    6   Participant 6    Male  ...                83           2       6
6    7   Participant 7    Male  ...                87           2       7
7    8   Participant 8    Male  ...                78           2       8
8    9   Participant 9    Male  ...                71           2       9
9   10  Participant 10    Male  ...                89           2      10
10  11  Participant 11    Male  ...                84           2      11
11  12  Participant 12    Male  ...                76           2      12
12  13  Participant 13    Male  ...                81           2      13
13  14  Participant 14    Male  ...                77           2      14
14  15  Participant 15    Male  ...                84           2      15
15  16  Participant 16    Male  ...                72           2      16
16  17  Participant 17    Male  ...                83           2      17
17  18  Participant 18    Male  ...                86           2      18
18  19  Participant 19    Male  ...                73           2      19
19  20  Participant 20    Male  ...                87           2      20
20  21  Participant 21  Female  ...                64           2      21
21  22  Participant 22  Female  ...                61           2      22
22  23  Participant 23  Female  ...                64           2      23
23  24  Participant 24  Female  ...                63           2      24
24  25  Participant 25  Female  ...                66           2      25
25  26  Participant 26  Female  ...                61           2      26
26  27  Participant 27  Female  ...                63           2      27
27  28  Participant 28  Female  ...                62           2      28
28  29  Participant 29  Female  ...                66           2      29
29  30  Participant 30  Female  ...                56           2      30
30  31  Participant 31  Female  ...                55           2      31
31  32  Participant 32  Female  ...                61           2      32
32  33  Participant 33  Female  ...                61           2      33
33  34  Participant 34  Female  ...                68           2      34
34  35  Participant 35  Female  ...                62           2      35
35  36  Participant 36  Female  ...                59           2      36
36  37  Participant 37  Female  ...                57           2      37
37  38  Participant 38  Female  ...                66           2      38
38  39  Participant 39  Female  ...                62           2      39
39  40  Participant 40  Female  ...                60           2      40

"""

data.to_csv("retrieved_data.csv", index=False)
