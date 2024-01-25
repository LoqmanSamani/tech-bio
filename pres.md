## Retrieve data from the database

```R
library(RPostgreSQL)
library(readxl)
library(dplyr)
library(ggplot2)

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

```R
author = dbReadTable(con, "body.Author")
project = dbReadTable(connect, "body.Project")
print(author)
print(project)
```

    **body.Author                                   body.Project**

| id  | name      | id  | given_name | family_name | matrikel_nr | project_id |
| --- | --------- | --- | ---------- | ----------- | ----------- | ---------- |
| 1   | Test      | 1   | Loghman    | Samani      | 3585810     | 2          |
| 2   | BodyPro11 | 2   |            |             |             |            |
| 3   | Project1  | 3   |            |             |             |            |
| 4   | Project2  | 4   |            |             |             |            |
| 5   | Project3  | 5   |            |             |             |            |
| ... | ...       | ... | ...        | ...         | ...         | ...        |

```R
join_ = "SELECT * FROM body.Person 
        INNER JOIN body.MeasurementResults 
        ON body.Person.id = body.MeasurementResults.person"

data = dbGetQuery(con, join_)

print(data)
```

| id  | number         | gender | age | measured_weight | measured_height | id_ | estimated_height | estimated_weight | project_id | person |
| --- | -------------- | ------ | --- | --------------- | --------------- | --- | ---------------- | ---------------- | ---------- | ------ |
| 1   | Participant 1  | male   | 26  | 73.1            | 175.5           | 1   | 175              | 76               | 2          | 1      |
| 2   | Participant 2  | male   | 39  | 79.1            | 172.9           | 2   | 174              | 78               | 2          | 2      |
| 3   | Participant 3  | male   | 48  | 76.3            | 168.5           | 3   | 171              | 76               | 2          | 3      |
| ... | ...            | ...    | ... | ...             | ...             | ... | ...              | ...              | ...        | ...    |
| 40  | Participant 40 | female | 55  | 58.9            | 161.6           | 40  | 161              | 87               | 2          | 40     |

```R
info = summary(data)
print(info)
```

| Variable         | Min   | 1st Qu. | Median | Mean  | 3rd Qu. | Max   |
| ---------------- | ----- | ------- | ------ | ----- | ------- | ----- |
| id               | 1.00  | 10.75   | 20.50  | 20.50 | 30.25   | 40.00 |
| number           | N/A   | N/A     | N/A    | N/A   | N/A     | N/A   |
| gender           | N/A   | N/A     | N/A    | N/A   | N/A     | N/A   |
| age              | 17.00 | 26.75   | 36.00  | 36.02 | 44.25   | 59.00 |
| measured_weight  | 54.20 | 62.05   | 70.10  | 71.40 | 81.17   | 91.60 |
| measured_height  | 157.5 | 165.4   | 169.9  | N/A   | 173.1   | 178.6 |
| id_              | 1.00  | 10.75   | 20.50  | N/A   | 30.25   | 40.00 |
| estimated_height | 157.0 | 165.0   | 171.0  | 169.6 | 174.0   | 179.0 |
| estimated_weight | 55.00 | 62.00   | 69.50  | 70.95 | 78.75   | 89.00 |
| project_id       | 2     | 2       | 2      | 2     | 2       | 2     |
| person           | 1.00  | 10.75   | 20.50  | 20.50 | 30.25   | 40.00 |

---

---

### Hypotheses:

**Weight Hypothesis:**

* Null Hypothesis (H0): There is no significant difference between reported and measured weights (**H0: μ = 0**).
* Alternative Hypothesis (H1): The differences in reported and measured weights are significantly less than 0 (**H1: μ  < 0**).

**Height Hypothesis:**

* Null Hypothesis (H0): There is no significant difference between reported and measured heights (**H0: μ  = 0**).
* Alternative Hypothesis (H1): The differences in reported and measured heights are significantly greater than 0 (**H1: μ > 0**).

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

![img](./image/diff_scatt.png)

```R
hist_h = ggplot(data, aes(x = h_diff)) +
  geom_histogram(binwidth = 1, color = "black", fill = "gray", alpha = 0.7) +
  labs(title = "Histogram of Differences in Height Measurement",
       x = "Height Difference (cm)",
       y = "Number of Participants") +
  theme_minimal()

hist_w = ggplot(data, aes(x = w_diff)) +
  geom_histogram(binwidth = 1, color = "black", fill = "gray", alpha = 0.7) +
  labs(title = "Histogram of Differences in Weight Measurement",
       x = "Weight Difference (kg)",
       y = "Number of Participants") +
  theme_minimal()

grid.arrange(hist_height, hist_weight, ncol = 2)
```

![img](./image/diff_hist.png)

```R
par(mfrow = c(1, 2), mar = c(5, 4, 2, 2))  # Set up a 1x2 grid of plots

boxplot(h_diff, horizontal = TRUE, col = "lightgray",
        main = "Boxplot of Height Differences",
        xlab = "Height Difference (cm)", 
        ylab = "Difference")

boxplot(w_diff, horizontal = TRUE, col = "gray", 
        main = "Boxplot of Weight Differences",
        xlab = "Weight Difference (kg)", 
        ylab = "Difference")

par(mfrow = c(1, 1))
```

![img](./image/diff_box.png)

---

#### The normality of the data distribution

##### Q-Q-Plot:

```R
par(mfrow = c(1, 2))
qqnorm(h_diff, col = "darkgray", pch = 20, cex = 2, main = "Q-Q Plot - h_diff")
qqline(h_diff,  col = "orange", lty = 1, lwd = 2.5)

qqnorm(w_diff, col = "darkgray", pch = 20, cex = 2, main = "Q-Q Plot - w_diff")
qqline(w_diff, col = "orange", lty = 1, lwd = 2.5)

par(mfrow = c(1, 1))
```

![img](./image/qq_plot_diff.png)

#### Shapiro-Wilk, Lilliefors:

```R
h_diff = shapiro.test(h_diff)                                                w_diff = shapiro.test(w_diff)
h_diff_sqrt = shapiro.test(sqrt(h_diff))                                     print(w_diff)  
h_diff_lil = lillie.test(h_diff) 

print(h_diff)
print(h_diff_sqrt)
print(h_diff_lil)
```

###### Shapiro-Wilk normality test (h_diff)                                                                    Shapiro-Wilk normality test (w_diff)

W = 0.94003, p-value = 0.03466                                                                                     W = 0.95836, p-value = 0.1471
W = 0.92852, p-value = 0.05657 (sqrt)

###### Lilliefors (Kolmogorov-Smirnov) normality test (h_diff)

D = 0.12597, p-value = 0.1132

#### one-sample t-test:

```R
t_test_height = t.test(h_diff, mu = 0, alternative = "greater")             t_test_weight = t.test(w_diff, mu = 0, alternative = "less")

print(t_test_height)                                                        print(t_test_weight)
```

##### One Sample t-test (h_diff)                                                             One Sample t-test (w_diff)

t = 4.2256, df = 39, ***p-value = 6.935e-05***                                                           t = -1.5098, df = 39,** *p-value = 0.06957***
alternative hypothesis: true mean is greater than 0                                               alternative hypothesis: true mean is less than 0
95 percent confidence interval:                                                                               95 percent confidence interval:
 0.4314089       Inf                                                                                                     -Inf 0.05187719
sample estimates:                                                                                                    sample estimates:
mean of x                                                                                                                 mean of x
   0.7175                                                                                                                    -0.4475

#### Results:

for **height differences**, there is strong evidence that the **true mean is greater than 0**. However, for weight differences, **we do not have
sufficient evidence to conclude that the true mean is less than 0**.

---

---

#### Gender Influence:

```R
g_split = split(data, data$gender)

m_data = g_split$Male
f_data = gender_split$Female

mh_diff = m_data$estimated_height - m_data$measured_height
fh_diff = f_data$estimated_height - f_data$measured_height

mw_diff = m_data$estimated_weight - m_data$measured_weight
fw_diff = f_data$estimated_weight - f_data$measured_weight
```

**Two-Sample t-test**

```R
p_value_height = var.test(mh_diff, fh_diff)$p.value                              p_value_weight = var.test(mw_diff, fw_diff)$p.value

t_test_height = t.test(mh_diff, fh_diff)                                         t_test_height = t.test(mw_diff, fw_diff)

print(p_value_height)                                                            print(p_value_weight)
print(t_test_height)                                                             print(t_test_height)
```

###### Levene's Test (mh_diff, fh_diff)                                                                               Levene's Test (mw_diff, fw_diff)

0.5342558                                                                                                                            0.05307442

**Welch Two Sample t-test (mh_diff, fh_diff)                                                             Welch Two Sample t-test (mw_diff, fw_diff)**

t = 2.2075, df = 37.231, **p-value = 0.03352**                                                                      t = -0.37537, df = 32.122, **p-value = 0.7099**
alternative hypothesis: true difference in means is not equal to 0                                       alternative hypothesis: true difference in means is not equal to 0
95 percent confidence interval:                                                                                            95 percent confidence interval:
 0.05885992 1.37114008                                                                                                      -1.4457864  0.9957864
sample estimates:                                                                                                                 sample estimates:
mean of x mean of y                                                                                                             mean of x mean of y
    1.075     0.360                                                                                                                      -0.560    -0.335

based on the results, there is evidence of **a significant difference in reported and measured heights** between males and females, while there is

**no significant difference in reported and measured weights** between the two genders.




* **Age-Based Analysis:**
  * Explore whether there are differences in the accuracy of self-reported measurements based on age groups. You can create age bins and analyze the differences within each group.
* **Histograms of Residuals:**
  * Plot histograms of the residuals (differences) to check if they follow a normal distribution. This is important, especially if you plan to use parametric statistical tests.
