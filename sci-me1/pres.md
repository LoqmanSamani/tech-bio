

#                  Wissenschaftliche Methodik I (Projekt)

   [Loghman Samani](samaniloqman91@gmail.com),  Winter 2024



## **Project Overview**

##### **Participants**

* 40 individuals (20 male, 20 female)

##### **Questions Explored**

* Age
* Gender
* Height
* Weight

##### **Key Measurements**

* Height
* Weight



---



## Retrieve data from the database



```R
library(RPostgreSQL)
library(readxl)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(car)
library(multcomp)
library(igraph)
library(PerformanceAnalytics)
library(multcompView)



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

  **[91] "body.Author"**

​      ...

  **[103] "body.Project"**
  [104] "\"body\".\"project\""
  **[105] "body.Person"
  [106] "body.MeasurementResults"**

```R
author = dbReadTable(con, "body.Author")
project = dbReadTable(connect, "body.Project")
print(author)
print(project)
```

   body.Project                                                                                   body.Author

|     id     | name                |  | id | given_name | family_name | matrikel_nr | project_id  |
| :---------: | ------------------- | - | :-: | ---------- | ----------- | ----------- | ----------- |
|      1      | Test                |  | 1 | Loghman    | Samani      | 3585810     | **2** |
| **2** | **BodyPro11** |  |    |            |             |             |             |
|      3      | Project1            |  |    |            |             |             |             |
|      4      | Project2            |  |    |            |             |             |             |
|      5      | Project3            |  |    |            |             |             |             |
|            | ...                 |  |    |            |             |             |             |
|     11     | Project3            |  |    |            |             |             |             |





```R
join_ = "SELECT * FROM body.Person 
        INNER JOIN body.MeasurementResults 
        ON body.Person.id = body.MeasurementResults.person"   # no need for ""LIMIT 40"

data = dbGetQuery(con, join_)

print(data)

dbDisconnect(con)
```

​                                                                                                    **data**

| id            | number         | gender | age | measured_weight | measured_height | estimated_height | estimated_weight | project_id | person        |
| ------------- | -------------- | ------ | --- | --------------- | --------------- | ---------------- | ---------------- | ---------- | ------------- |
| **1**   | Participant 1  | male   | 26  | 74.0            | 175.7           | 175              | 76               | 2          | **1**   |
| **2**   | Participant 2  | male   | 39  | 77.8            | 173.4           | 174              | 78               | 2          | **2**   |
| **3**   | Participant 3  | male   | 48  | 75.5            | 169.4           | 171              | 76               | 2          | **3**   |
| **...** | ...            | ...    | ... | ...             | ...             | ...              | ...              | ...        | **...** |
| **40**  | Participant 40 | female | 55  | 58.6            | 161.7           | 161              | 60               | 2          | **40**  |





---



## Height and Weight Analyses

### **Hypotheses**

##### **Weight Hypothesis**

* **Null Hypothesis (H0)**: There is no significant difference between reported and measured weights (**μ = 0**).
* **Alternative Hypothesis (H1)**: The differences in reported and measured weights are significantly less than 0 (**μ  < 0**).

##### **Height Hypothesis**

* **Null Hypothesis (H0):** There is no significant difference between reported and measured heights (**μ  = 0**).
* **Alternative Hypothesis (H1):** The differences in reported and measured heights are significantly greater than 0 (**μ > 0**).



```R
info = summary(data)
print(info)
```

| Variable                   | Min             | 1st Qu.         | Median          | Mean            | 3rd Qu.         | Max             |
| -------------------------- | --------------- | --------------- | --------------- | --------------- | --------------- | --------------- |
| id                         | 1.00            | 10.75           | 20.50           | 20.50           | 30.25           | 40.00           |
| number                     | N/A             | N/A             | N/A             | N/A             | N/A             | N/A             |
| gender                     | N/A             | N/A             | N/A             | N/A             | N/A             | N/A             |
| age                        | 17.00           | 26.75           | 36.00           | 36.02           | 44.25           | 59.00           |
| **measured_weight**  | **53.70** | **61.15** | **69.35** | **70.43** | **88.85** | **89.50** |
| **measured_height**  | **157.5** | **165.4** | **170.4** | **169.3** | **173.6** | **178.7** |
| **estimated_height** | **157.0** | **165.0** | **171.0** | **169.6** | **174.0** | **179.0** |
| **estimated_weight** | **55.00** | **62.00** | **69.50** | **70.95** | **78.75** | **89.00** |
| project_id                 | 2               | 2               | 2               | 2               | 2               | 2               |
| person                     | 1.00            | 10.75           | 20.50           | 20.50           | 30.25           | 40.00           |

```R
data$height_dev = data$measured_height - data$estimated_height
data$weight_dev = data$measured_weight - data$estimated_weight

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

#### The normality of the data distribution

##### *quantile–quantile plot* (Q-Q-Plot)

```R
par(mfrow = c(1, 2))
qqnorm(data$height_dev, col = "darkgray", pch = 20, cex = 2, main = "Q-Q Plot - h_diff")
qqline(data$height_dev,  col = "orange", lty = 1, lwd = 2.5)

qqnorm(data$weight_dev, col = "darkgray", pch = 20, cex = 2, main = "Q-Q Plot - w_diff")
qqline(data$weight_dev, col = "orange", lty = 1, lwd = 2.5)

par(mfrow = c(1, 1))
```

![img](./image/qq_plot_diff.png)

#### Shapiro-Wilk

```R
h_diff = shapiro.test(data$height_dev)
w_diff = shapiro.test(data$weight_dev)

print(h_diff)
print(w_diff)
```

##### Shapiro-Wilk normality test (height_dev)                                            Shapiro-Wilk normality test (weight_dev)

W = 0.94529, p-value = 0.05228                                                                         W = 0.96832, p-value = 0.3179



#### **homogeneity of variance**

```R
group = as.factor(c(rep(1, length(data$height_dev)), rep(2, length(data$weight_dev))))

levene = leveneTest(c(data$height_dev, data$weight_dev), group)

print(levene)
```

**Levene's Test for Homogeneity of Variance (center = median)**
            Df     F-value     Pr(>F)
group  1       0.2399      0.6257
            78

#### one-sample t-test

```R
t_test_height = t.test(data$height_dev, mu = 0, alternative = "greater")   
t_test_weight = t.test(data$weight_dev, mu = 0, alternative = "less")

print(t_test_height)       
print(t_test_weight)
```

##### One Sample t-test (height_dev)                                                             One Sample t-test (weight_dev)

t = -1.6199, df = 39, p-value = 0.9433                                                               t = 0.6692, df = 39, p-value = 0.7463

alternative hypothesis: true mean is greater than 0                                     alternative hypothesis: true mean is less than 0
95 percent confidence interval:                                                                         95 percent confidence interval:
Inf      -0.4539188                                                                                                  -Inf       0.3165965
sample estimates:                                                                                                  sample estimates:
mean of x                                                                                                                 mean of x
-0.2225                                                                                                                      0.09

#### **Conclusion**

* Since the p-value is greater than the threshold of 0.05, we fail to reject the null hypothesis. There is not enough evidence to suggest that the differences in reported and measured heights are significantly greater than 0.
* Since the p-value is greater than the threshold of 0.05, we fail to reject the null hypothesis. There is not enough evidence to suggest that the differences in reported and measured weights are significantly less than 0.



---





# Gender Influence

#### **Hypotheses**

* **Null Hypothesis (H0):** There is no significant difference in the mean differences between self-reported and measured values for males and females (**μ1 = μ2**).
* **Alternative Hypothesis (H1):** There is a significant difference in the mean differences between self-reported and measured values for males and females (**μ1 ≠ μ2**).



```R
g_split = split(data, data$gender)

m_data = g_split$Male
f_data = gender_split$Female

mh_diff = m_data$height_dev
fh_diff = f_data$height_dev

mw_diff = m_data$weight_dev
fw_diff = f_data$weight_dev

mh_shapiro = shapiro.test(mh_diff)$p.value
fh_shapiro = shapiro.test(sqrt(fh_diff))$p.value
mw_shapiro = shapiro.test(mw_diff)$p.value
fw_shapiro = shapiro.test(fw_diff)$p.value

h_group = as.factor(c(rep(1, length(mh_diff)), rep(2, length(fh_diff))))
h_levene = leveneTest(c(mh_diff, fh_diff), h_group)

w_group = as.factor(c(rep(1, length(mw_diff)), rep(2, length(fw_diff))))
w_levene = leveneTest(c(mw_diff, fw_diff), w_group)

print(mh_shapiro)
print(fh_shapiro)
print(mw_shapiro)
print(fw_shapiro)

print(h_levene)
print(w_levene)
```

**Shapiro-Wilk normality test (mh_diff, fh_diff)                            Shapiro-Wilk normality test (mw_diff, fw_diff)**

0.3755505                                                                                                       0.203872
0.1934725                                                                                                       0.3939695

**Levene's Test (mh_diff, fh_diff)                                                                    Levene's Test (mw_diff, fw_diff)**

​            Df    F-value      Pr(>F)                                                                                                  Df     F-value     Pr(>F)
group  1      0.1514       0.6994                                                                                     group   1      1.1284      0.2948

​             38                                                                                                                                     38



**Two-Sample t-test**

```R
t_test_height = t.test(mh_diff, fh_diff)   
t_test_height = t.test(mw_diff, fw_diff)

print(t_test_height)   
print(t_test_height)
```

**Welch Two Sample t-test (mh_diff, fh_diff)                                      Welch Two Sample t-test (mw_diff, fw_diff)**

 t = 0.59566, df = 36.386, p-value = 0.5551                                                    t = 0.22033, df = 33.843, p-value = 0.8269

alternative hypothesis: true difference in means                                       alternative hypothesis: true difference in means is not equal to 0.                                                                                                     is not equal to 0.
95 percent confidence interval:                                                                      95 percent confidence interval:
 -0.3965799        0.7265799                                                                                 -0.4935142        0.6135142
sample estimates:                                                                                                sample estimates:
mean of x mean of y                                                                                            mean of x mean of y
   0.305     0.140                                                                                                        -0.06     -0.12



#### Conclusion

* based on the conducted tests, there is no sufficient evidence to claim a significant difference in the mean differences between self-reported and measured values for height and weight between males and females.



---



### **Analyze the effects of gender and age on height and weight differences**

* young:  age <= 28
* middle age: 28 < age < 42
* old:   42 <= age

```R
data$age_group = cut(data$age,
                      breaks = c(-Inf, 28, 42, Inf),
                      labels = c("young", "middle age", "old"),
                      include.lowest = TRUE)

subdata = data[c("number", "height_dev", "weight_dev", "gender", "age_group")]
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



#### Full Factorial Experiment



| Age \ Gender         | Male              | Female            |
| -------------------- | ----------------- | ----------------- |
| **young**      | Interaction1_m_y  | Interaction1_f_y  |
| **middle age** | Interaction1_m_ma | Interaction1_f_ma |
| **old**        | Interaction1_m_o  | Interaction1_f_o  |



* Interaction1_m_y : interaction effect between male and young
* Interaction1_f_y : interaction effect between female and young
* Interaction1_m_ma : interaction effect between male and middle age
* Interaction1_f_ma : interaction effect between female and middle age
* Interaction1_m_o : interaction effect between male and old
* Interaction1_f_o : interaction effect between female and old



### **Hypotheses**

**Null Hypotheses (H0):**

* There is no significant difference in height and weight differences between **age groups**.

* There is no significant difference in height and weight differences between **genders**.

* There is no significant interaction effect between **age and gender** on height and weight differences.

  

**Alternative Hypotheses (H1):**

* There is a significant difference in height and weight differences between age groups.

* There is a significant difference in height and weight differences between genders.

* There is a significant interaction effect between age and gender on height and weight differences.

  



##### Two-way ANOVA

```R
model_height = aov(height_dev ~ age_group * gender, data = data)
model_weight = aov(weight_dev ~ age_group * gender, data = data)

h_summ = summary(model_height)
w_summ = summary(model_weight)

print(h_summ)
print(w_summ)
```

**Two-way anova (height_dev)                                                              Two-way anova (weight_dev)**

​                    Df  Sum-Sq  Mean-Sq  F-value  Pr(>F)                                                            Df  Sum-Sq  Mean-Sq  F-value  Pr(>F)
gender        1  0.272        0.2723       0.382     0.5406                                      gender         1       0.036      0.0360      0.052    0.822
age_group  2  0.030        0.0151       0.021     0.9790                                      age_group   2       1.594      0.7970       1.144    0.331
gender:age_group 2  4.904  2.4521   3.442  **0.0435** *                                   gender:age_group 2   2.894   1.4471   2.077   0.141
Residuals        34 24.223  0.7124                                                                      Residuals        34 23.692  0.6968

Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1



##### Tukey Honest Significant Difference (Tukey HSD)

```R
h_tukey = TukeyHSD(model_height, "age_group:gender", ordered=TRUE)
w_tukey = TukeyHSD(model_weight, "age_group:gender", ordered=TRUE)
print(h_tukey)
print(w_tukey)
```

 Tukey multiple comparisons of means
    95% family-wise confidence level
    factor levels have been ordered

Fit: aov(formula = **height_dev** ~ age_group * gender, data = data)

age_group:gender
                                                                        diff                      lwr                  upr                p adj
old:Male-young:Female                      0.05333333      -1.4893056      1.595972       0.9999981
middle age:Male-young:Female        0.10000000      -1.2426949      1.442695       0.9999135
old:Female-young:Female                  0.65833333      -0.7175195       2.034186      0.7005100
middle age:Female-young:Female    0.76666667      -0.7041819       2.237515      0.6209810
young:Male-young:Female                 0.90000000      -0.5708485       2.370849      0.4508598
middle age:Male-old:Male                  0.04666667      -1.3743080       1.467641      0.9999985
old:Female-old:Male                            0.60500000      -0.8473466       2.057347      0.8053868
middle age:Female-old:Male              0.71333333      -0.8293056       2.255972      0.7292414
young:Male-old:Male                           0.84666667      -0.6959723       2.389306      0.5685041
old:Female-middle age:Male              0.55833333      -0.6795702      1.796237       0.7490160
middle age:Female-middle age:Male 0.66666667     -0.6760282      2.009362       0.6674209
young:Male-middle age:Male             0.80000000      -0.5426949      2.142695       0.4801912
middle age:Female-old:Female          0.10833333      -1.2675195      1.484186       0.9998861
young:Male-old:Female                       0.24166667      -1.1341862      1.617519       0.9945326
young:Male-middle age:Female         0.13333333      -1.3375152      1.604182       0.9997723



  Tukey multiple comparisons of means
    95% family-wise confidence level
    factor levels have been ordered

Fit: aov(formula = **weight_dev** ~ age_group * gender, data = data)

age_group:gender
                                                                            diff                     lwr                  upr                p adj
old:Female-young:Male                         0.51666667      -0.8440192      1.877352      0.8584758
middle age:Male-young:Male               0.59444444      -0.7334489      1.922338      0.7547749
young:Female-young:Male                   0.61666667       -0.8379677     2.071301       0.7938357
middle age:Female-young:Male          0.81666667       -0.6379677     2.271301       0.5446077
old:Male-young:Male                            1.23666667       -0.2889667      2.762300       0.1691935
middle age:Male-old:Female               0.07777778       -1.1464794      1.302035       0.9999606
young:Female-old:Female                    0.10000000       -1.2606858     1.460686        0.9999190
middle age:Female-old:Female           0.30000000       -1.0606858     1.660686        0.9845674
old:Male-old:Female                              0.72000000       -0.7163363     2.156336        0.6585553
young:Female-middle age:Male          0.02222222       -1.3056712     1.350116        0.9999999
middle age:Female-middle age:Male 0.22222222       -1.1056712     1.550116        0.9956385
old:Male-middle age:Male                   0.64222222       -0.7630881      2.047532        0.7387128
middle age:Female-young:Female     0.20000000       -1.2546343      1.654634        0.9982810
old:Male-young:Female                       0.62000000       -0.9056334       2.145633       0.8208585
old:Male-middle age:Female              0.42000000        -1.1056334      1.945633       0.9595967



```R
plot(ht, las=1, col="#2b2929")
plot(wt, las=1, col="#2b2929")
```

![img](./image/tukey_box.png)





### **Key Findings:**

- **No significant difference** found between measured and reported heights and weights.
- **Insufficient evidence** to conclude a gender effect on differences.
- **Insufficient evidence** to conclude an age effect on differences.



