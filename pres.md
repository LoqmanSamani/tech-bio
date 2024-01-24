```R
library(RPostgreSQL)
library(readxl)
library(dplyr)

host = "82.165.61.139"
port = 5430
dbname = "Veg"
user = "TechBio"
password = "T3chB10!"

connect =  dbConnect(
                 dbDriver("PostgreSQL"), 
                 host=host, 
                 port=port, 
                 dbname=dbname,  
                 user=user, 
                 password=password
           )

tables = dbListTables(con)
print(tables)
```

---

[1] "author"
  [2] "measurementresults"
  [3] "person"
  [4] "author"
  [5] "project"
  [6] "databasechangelog"
 ...

[87] "body.Project"
 [94] "body.Person"
 [95] "body.Author"
 [96] "body.MeasurementResults"
...

---

```R
author = dbReadTable(con, "body.Author")
project = dbReadTable(connect, "body.Project")
print(quthor)
print(project)
```

---

id      name                                        id    given_name      family_name      matrikel_nr      project_id
1       Test                                           1      Loghman             Samani             3585810             2
2       BodyPro11
3       Project1
4       Project2
5       Project3
...

---

```R
join_ = "SELECT * FROM body.Person 
        INNER JOIN body.MeasurementResults 
        ON body.Person.id = body.MeasurementResults.person"

data = dbGetQuery(con, join_)

print(data)
```

---

_id   number        gender   age   measured_weight    measured_height   id_   estimated_height   estimated_weight   project_id    person

1  Participant 1   male       26            73.1                        175.5              1              175                            76                    2               1

2  Participant 2   male       39            79.1                        172.9              2              174                            78                    2               2

3  Participant 3   male       48            76.3                        168.5              3              171                            76                    2               3

...

40 Participant 40 female   55            58.9                        161.6             40              161                            87                   2              40

---

### Hypotheses:

**Weight Hypothesis:**

* Null Hypothesis (H0): There is no significant difference between reported and measured weights (μ = 0).
* Alternative Hypothesis (H1): The differences in reported and measured weights are significantly less than 0 (μ  < 0).

**Height Hypothesis:**

* Null Hypothesis (H0): There is no significant difference between reported and measured heights (μ  = 0).
* Alternative Hypothesis (H1): The differences in reported and measured heights are significantly greater than 0 (μ > 0).

---

```R
h_diff = data$estimated_height - data$measured_height
w_diff = data$estimated_weight - data$measured_weight

par(mfrow=c(1,2), mar=c(4,4,2,1)) 

plot(1:40, h_diff, col="gray", xlab="Participant Index",
     ylab="Height Difference (cm)",
     main="Difference between Measured and Estimated Height")

abline(h=0, col="orange")

plot(1:40, w_diff, col="gray", xlab="Participant Index",
     ylab="Weight Difference (kg)",
     main="Difference between Measured and Estimated Weight")

abline(h=0, col="orange")
par(mfrow=c(1,1), mar=c(5,4,4,2)+0.1)
```
---
![diff_hist.png](https://github.com/LoqmanSamani/rproject/blob/systembiology/diff_hist.png)

