# Retrieve data from the database

```R
library(RPostgreSQL)
library(readxl)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(car)

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

[87] `<span style="color:purple">`"body.Project"
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

---

---

# Analyse Data

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

```R
data$height_dev = data$estimated_height - data$measured_height
data$weight_dev = data$estimated_weight - data$measured_weight

par(mfrow=c(1,2), mar=c(4,4,2,1)) 

plot(1:40, data$height_dev, col="gray", xlab="Participant Index",
     ylab="Height Difference (cm)",
     main="Difference between Measured and Estimated Height")

abline(h=0, col="orange")

plot(1:40, data$weight_dev, col="gray", xlab="Participant Index",
     ylab="Weight Difference (kg)",
     main="Difference between Measured and Estimated Weight")

abline(h=0, col="orange")
par(mfrow=c(1,1), mar=c(5,4,4,2)+0.1)
```

![img](./image/diff_scatt.png)

```R
hist_height = ggplot(data, aes(x = height_dev)) +
  geom_histogram(binwidth = 1, color = "black", fill = "gray", alpha = 0.7) +
  labs(title = "Histogram of Differences in Height Measurement",
       x = "Height Difference (cm)",
       y = "Number of Participants") +
  theme_minimal()


hist_weight = ggplot(data, aes(x = weight_dev)) +
  geom_histogram(binwidth = 1, color = "black", fill = "gray", alpha = 0.7) +
  labs(title = "Histogram of Differences in Weight Measurement",
       x = "Weight Difference (kg)",
       y = "Number of Participants") +
  theme_minimal()

grid.arrange(hist_height, hist_weight, ncol = 2)
```

![img](./image/diff_hist.png)

```R
par(mfrow = c(1, 2), mar = c(5, 4, 2, 2))  

boxplot(data$height_dev, horizontal = TRUE, col = "lightgray",
        main = "Boxplot of Height Differences",
        xlab = "Height Difference (cm)", 
        ylab = "Difference")

boxplot(data$weight_dev, horizontal = TRUE, col = "gray", 
        main = "Boxplot of Weight Differences",
        xlab = "Weight Difference (kg)", 
        ylab = "Difference")

par(mfrow = c(1, 1))
```

![img](./image/diff_box.png)

---

# Hypotheses

**Weight Hypothesis:**

* Null Hypothesis (H0): There is no significant difference between reported and measured weights (**H0: μ = 0**).
* Alternative Hypothesis (H1): The differences in reported and measured weights are significantly less than 0 (**H1: μ  < 0**).

**Height Hypothesis:**

* Null Hypothesis (H0): There is no significant difference between reported and measured heights (**H0: μ  = 0**).
* Alternative Hypothesis (H1): The differences in reported and measured heights are significantly greater than 0 (**H1: μ > 0**).

#### The normality of the data distribution

##### Q-Q-Plot:

```R
par(mfrow = c(1, 2))
qqnorm(data$height_dev, col = "darkgray", pch = 20, cex = 2, main = "Q-Q Plot - h_diff")
qqline(data$height_dev,  col = "orange", lty = 1, lwd = 2.5)

qqnorm(data$weight_dev, col = "darkgray", pch = 20, cex = 2, main = "Q-Q Plot - w_diff")
qqline(data$weight_dev, col = "orange", lty = 1, lwd = 2.5)

par(mfrow = c(1, 1))
```

![img](./image/qq_plot_diff.png)

#### Shapiro-Wilk, Lilliefors:

```R
h_diff = shapiro.test(data$height_dev)                                      
h_diff_sqrt = shapiro.test(sqrt(data$height_dev))                            
h_diff_lil = lillie.test(data$height_dev) 
w_diff = shapiro.test(data$weight_dev)

print(h_diff)
print(h_diff_sqrt)
print(h_diff_lil)
print(w_diff)
```

###### Shapiro-Wilk normality test (h_diff)                                                                    Shapiro-Wilk normality test (w_diff)

W = 0.94003, p-value = 0.03466                                                                                     W = 0.95836, p-value = 0.1471
W = 0.92852, p-value = 0.05657 (sqrt)

###### Lilliefors (Kolmogorov-Smirnov) normality test (h_diff)

D = 0.12597, p-value = 0.1132

#### one-sample t-test:

```R
t_test_height = t.test(data$height_dev, mu = 0, alternative = "greater")   
t_test_weight = t.test(data$weight_dev, mu = 0, alternative = "less")

print(t_test_height)                                                       
print(t_test_weight)
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

# Gender Influence

#### **Hypotheses**

* **Null Hypothesis (H0):** There is no significant difference in the mean differences between self-reported and measured values for males and females.
* **Alternative Hypothesis (H1):** There is a significant difference in the mean differences between self-reported and measured values for males and females.

```R
g_split = split(data, data$gender)

m_data = g_split$Male
f_data = gender_split$Female

mh_diff = m_data$height_dev
fh_diff = f_data$height_dev

mw_diff = m_data$weight_dev
fw_diff = f_data$weight_dev
```

**Two-Sample t-test**

```R
p_value_height = var.test(mh_diff, fh_diff)$p.value            
p_value_weight = var.test(mw_diff, fw_diff)$p.value

t_test_height = t.test(mh_diff, fh_diff)                         
t_test_height = t.test(mw_diff, fw_diff)

print(p_value_height)                                              
print(p_value_weight)

print(t_test_height)                                                 
print(t_test_height)
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

---

---

# Age-Based Analyse

**Age as a Covariate**

```R
data$age_group = cut(data$age,
                      breaks = c(-Inf, 28, 42, Inf),
                      labels = c("young", "middle age", "old"),
                      include.lowest = TRUE)
```


```R
model_height = lm(height_dev ~ gender + age_group + gender:age_group, data = data)
model_weight = lm(weight_dev ~ gender + age_group + gender:age_group, data = data)

h_summ = summary(model_height)
w_summ = summary(model_weight)

print(h_summ)
print(w_summ)
```

###### ANCOVA Result for Height                                                                              ANCOVA Result for Weight

Residuals:                                                                                                                    Residuals:
 Min           1Q       Median      3Q        Max                                                                   Min          1Q       Median      3Q        Max
-1.640    -0.610     -0.190     0.855     2.290                                                                -5.090    -1.137     0.395     1.290     2.510

Coefficients:                                                                                                                 Coefficients:
                                                    Estimate  Std.Error  t-value  Pr(>|t|)                                                                                      Estimate  Std.Error  t-value  Pr(>|t|)
(Intercept)                                     0.0400     0.3050   0.131   0.89639                              (Intercept)                                      -0.1800     0.5725    -0.314   0.7550
**genderMale**                                **1.5000**    0.4314   3.477   **0.00134**                               genderMale                                   -1.3300     0.8097    -1.643   0.1092
age_groupyoung                           0.6400     0.4314   1.484   0.14660                               age_groupyoung                            **-0.3100**     0.8097    -0.383   **0.7041**
**genderMale:age_groupyoung** **-1.5700**   0.6100  -2.574   **0.01433**                              **genderMale:age_groupyoung**   **2.2100**     1.1451     1.930   **0.0615**

Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1                                                       Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.9646 on 36 degrees of freedom                                         Residual standard error: 1.81 on 36 degrees of freedom
Multiple R-squared:  0.2553,    Adjusted R-squared:  0.1933                                        Multiple R-squared:  0.1389,    Adjusted R-squared:  0.06716
F-statistic: 4.115 on 3 and 36 DF,  **p-value: 0.01312**                                                    F-statistic: 1.936 on 3 and 36 DF,  p-value: 0.1412

For **height_dev**, the most important factors appear to be the **gender effect** and the **interaction effect between gender and age group**.

For **weight_dev**, the **gender effect is marginally significant**, and the **interaction effect with age group** is also **marginally significant**.

##### Interaction Effects Between Age Groups and Differences

```R
height = aov(height_dev ~ gender * age_group, data = data)
weight = aov(weight_dev ~ gender * age_group, data = data)

h_summ = summary(height)
w_summ = summary(weight)

print(h_summ)
print(w_summ)
```

    Df  Sum-Sq   Mean-Sq F-value  Pr(>F)                                                                      Df    Sum-Sq  Mean-Sq  F-value    Pr(>F)
gender                    1      5.11      5.112      5.495**0.0247**                                          gender                   1      0.51      0.506      0.154      0.6966
age_group               1     0.21      0.210      0.226     0.6374                                       age_group              1      6.32      6.320      1.928      0.1735
gender:age_group   1     6.16      6.162      6.624     **0.0143**                                      gender:age_group  1     12.21     12.210    3.725     **0.0615**
Residuals                 36  33.49   0.930                                                                        Residuals                36 118.00   3.278

Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1                                                     Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

---

---

## Full Factorial Experiment

##### Analyze the effects of gender and age on height and weight differences

* young:  age <= 28
* middle age: 28 < age < 42
* old:   42 <= age

| Age \ Gender | Male | Female |
| :----------- | ---- | ------ |
| young        |      |        |
| middle mge   |      |        |
| old          |      |        |

* Interaction1_m_y : interaction effect between male and young
* Interaction1_f_y : interaction effect between female and young
* Interaction1_m_ma : interaction effect between male and middle age
* Interaction1_f_ma : interaction effect between female and middle age
* Interaction1_m_o : interaction effect between male and old
* Interaction1_f_o : interaction effect between female and old

| Age \ Gender | Male              | Female            |
| ------------ | ----------------- | ----------------- |
| Young        | Interacion1_M_Y   | Interaction1_F_Y  |
| Middle Age   | Interaction1_M_MA | Interaction1_F_MA |
| Old          | Interaction1_M_O  | Interaction1_F_O  |

### Hypotheses

**Null Hypotheses (H0):**

* There is no significant difference in height differences between age groups.
* There is no significant difference in height differences between genders.
* There is no significant interaction effect between age and gender on height differences.
* Repeat the same for weight differences.

**Alternative Hypotheses (H1):**

* There is a significant difference in height differences between age groups.
* There is a significant difference in height differences between genders.
* There is a significant interaction effect between age and gender on height differences.
* Repeat the same for weight differences.


```R
subdata <- data[c("number", "height_dev", "weight_dev", "gender", "age_group")]
print(subdata)
```


|     | number         | height_dev | weight_dev | gender | age_group  |
| --- | -------------- | ---------- | ---------- | ------ | ---------- |
| 1   | Participant 1  | -0.5       | 2.9        | Male   | young      |
| 2   | Participant 2  | 1.1        | -1.1       | Male   | middle age |
| 3   | Participant 3  | 2.5        | -0.3       | Male   | old        |
| 4   | Participant 4  | 0.1        | 1.2        | Male   | middle age |
| 5   | Participant 5  | 0.0        | 2.0        | Male   | middle age |
| ... | ...            | ...        | ...        | ...    | ...        |
| 40  | Participant 40 | -0.6       | 1.1        | Female | old        |


##### Two-way ANOVA

```R
model_height <- aov(height_dev ~ age_group * gender, data = data)
model_weight <- aov(weight_dev ~ age_group * gender, data = data)

h_summ = summary(model_height)
w_summ = summary(model_weight)

print(h_summ)
print(w_summ)
```

    Df Sum Sq Mean Sq F value Pr(>F)                                                            Df Sum Sq Mean Sq F value Pr(>F)
age_group         2     0.28     0.141     0.144   0.8666                                   age_group        2    8.26    4.132     1.234    0.304
gender              1     4.86     4.855     4.958   0.0327 *                                 gender             1     0.68    0.683     0.204    0.654
age_group:gender  2   6.55   3.273   3.342   0.0473 *                                 age_group:gender  2  14.20   7.098  2.119   0.136
Residuals         34    33.29   0.979                                                                Residuals        34 113.90   3.350

Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
  

##### Tukey Honest Significant Difference (Tukey HSD)

```R
h_tukey = TukeyHSD(model_height, "age_group:gender", ordered=TRUE)
w_tukey = TukeyHSD(model_height, "age_group:gender", ordered=TRUE)
print(h_tukey)
print(w_tukey)
```


Tukey multiple comparisons of means
    95% family-wise confidence level
    factor levels have been ordered

Fit: aov(formula = height_dev ~ age_group * gender, data = data)

$`age_group:gender`
                                                             diff        lwr          upr     p adj
old:Female-middle age:Female          0.12916667   -1.4838735   1.742207   0.9998763
young:Male-middle age:Female         0.40000000   -1.3244124  2.124412 0.9806670
young:Female-middle age:Female    0.91666667 -0.8077458 2.641079 0.6013519
middle age:Male-middle age:Female 1.31111111 -0.2630549 2.885277 0.1484476
old:Male-middle age:Female        1.32666667 -0.4819123 3.135246 0.2579237
young:Male-old:Female             0.27083333 -1.3422068 1.883873 0.9955706
young:Female-old:Female           0.78750000 -0.8255401 2.400540 0.6827695
middle age:Male-old:Female        1.18194444 -0.2693649 2.633254 0.1655018
old:Male-old:Female               1.19750000 -0.5052208 2.900221 0.3001979
young:Female-young:Male           0.51666667 -1.2077458 2.241079 0.9427297
middle age:Male-young:Male        0.91111111 -0.6630549 2.485277 0.5118580
old:Male-young:Male               0.92666667 -0.8819123 2.735246 0.6377380
middle age:Male-young:Female      0.39444444 -1.1797215 1.968610 0.9729241
old:Male-young:Female             0.41000000 -1.3985790 2.218579 0.9825338
old:Male-middle age:Male          0.01555556 -1.6503851 1.681496 1.0000000


Tukey multiple comparisons of means
    95% family-wise confidence level
    factor levels have been ordered

Fit: aov(formula = height_dev ~ age_group * gender, data = data)

$`age_group:gender`
                                        diff        lwr      upr     p adj
old:Female-middle age:Female      0.12916667 -1.4838735 1.742207 0.9998763
young:Male-middle age:Female      0.40000000 -1.3244124 2.124412 0.9806670
young:Female-middle age:Female    0.91666667 -0.8077458 2.641079 0.6013519
middle age:Male-middle age:Female 1.31111111 -0.2630549 2.885277 0.1484476
old:Male-middle age:Female        1.32666667 -0.4819123 3.135246 0.2579237
young:Male-old:Female             0.27083333 -1.3422068 1.883873 0.9955706
young:Female-old:Female           0.78750000 -0.8255401 2.400540 0.6827695
middle age:Male-old:Female        1.18194444 -0.2693649 2.633254 0.1655018
old:Male-old:Female               1.19750000 -0.5052208 2.900221 0.3001979
young:Female-young:Male           0.51666667 -1.2077458 2.241079 0.9427297
middle age:Male-young:Male        0.91111111 -0.6630549 2.485277 0.5118580
old:Male-young:Male               0.92666667 -0.8819123 2.735246 0.6377380
middle age:Male-young:Female      0.39444444 -1.1797215 1.968610 0.9729241
old:Male-young:Female             0.41000000 -1.3985790 2.218579 0.9825338
old:Male-middle age:Male          0.01555556 -1.6503851 1.681496 1.0000000
