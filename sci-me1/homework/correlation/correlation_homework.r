
library(ppcor)
library(corrplot)







# Question1


# The Pearson correlation coefficient for KFZ-Gewicht and Zuverlässigkeit is -0.3.
# This negative correlation suggests that as the KFZ-Gewicht (car weight) increases,
# the Zuverlässigkeit (reliability) tends to decrease. So, option 1 seems to be correct.

# The Pearson correlation coefficient for KFZ-Gewicht and Jährliche Servicekosten is 0.2.
# This positive correlation indicates that as the KFZ-Gewicht increases, the Jährliche 
# Servicekosten (annual service costs) also tend to increase. So, option 2 also seems to be correct.

# The statement "KFZ-Gewicht und Zuverlässigkeit sind stärker korreliert als KFZ-Gewicht und Service-Kosten"
# (Car weight and reliability are more strongly correlated than car weight and service costs) 
# is not necessarily supported or refuted by the given correlation coefficients.

# Heavier cars seem to be less reliable (Option 1).
# Heavier cars tend to have higher annual service costs (Option 2).

# Therefore, the correct answer would be: □ 1. and 2.









# Question 2


# cov(xy) = sum([(x - mean_x) * (y - mean_y)])
# here x and y are arrays contain datapoints.


# s(x) = sqrt(sum(x - mean_x)²)
# s(y) = sqrt(sum(y - mean_y)²)


# Pearson's correlation coefficient (r) is calculated using 
# the covariance and standard deviations of the variables
# r(xy) = cov(xy) / (s(x) * s(y)) 


# The Z-Transformation (Fisher) is used to transform the correlation
# coefficient (r) to a variable with an approximately normal distribution.
# This transformation is useful for hypothesis testing.
# Z_transformation(fisher) = 1/2 * ln (1+r / 1 - r)


# here we can see the Z_transformation is dependant on r and sample size (n) but not variance.
# but r is dependant on std (standard deviation) so it means Z is inderect dependent on std and var.


# extra explanation: 
# The Z-Transformation involves the natural logarithm of the ratio of 1+r1+r to 1−r1−r, and it's this 
# ratio that matters for hypothesis testing, not the absolute variances or standard deviations of the variables.








# Question 3


file_path <- "/home/sam/Documents/my_files/technical_biology/technical_biology_2/scientific_methodology/homework/correlation/hypervent.csv"

data <- read.table(file = file_path, header = T, sep = ";")


x <- c(data$Normal)
y <- c(data$Hypervent)

x_norm <- (x - min(x)) / (max(x) - min(x))
y_norm <- (y - min(y)) / (max(y) - min(y))


plot(x_norm, y_norm, xlab = "Normalized Normal", ylab = "Normalized Hypervent",
     main = "Scatter Plot of Normalized Data", col = "blue", pch = 19)


pearson_cor1 <- cor(x, y, method = "pearson")
spearman_cor1 <- cor(x, y, method = "spearman")

print("Q 3")
cat("Pearson Correlation Coefficient:", pearson_cor1, "\n")
cat("Spearman Correlation Coefficient:", spearman_cor1, "\n")


# The reason one correlation coefficient is greater than the other
# lies in the type of relationship between the data and the 
# characteristics of the dataset. The Pearson correlation coefficient 
# measures linear relationships, and when the relationship between the 
# times is approximately linear, the Pearson coefficient tends to be larger. 
# On the other hand, the Spearman correlation coefficient evaluates
# monotonic relationships, regardless of the specific form of the relationship, 
# and it is less sensitive to non-linear relationships and outliers. If the 
# relationship between the times is not strictly linear and/or if outliers are 
# present, the Spearman coefficient tends to be smaller than the Pearson 
# coefficient, highlighting the distinct applications of these correlation
# measures based on data characteristics.





# Question 4

path <- "/home/sam/Documents/my_files/technical_biology/technical_biology_2/scientific_methodology/homework/correlation/faith.csv"

faith <- read.table(file = path, header = T, sep = ",")

erup <- c(faith$eruptions)
wait <- c(faith$waiting)

erup_norm <- (erup - min(erup)) / (max(erup) - min(erup))
wait_norm <- (wait - min(wait)) / (max(wait) - min(wait))



plot(erup_norm, wait_norm, xlab = "Normalized Eruptions",
     ylab = "Normalized Waiting", main = "Scatter Plot of Normalized Data",
     col = "blue", pch = 19)


pearson_cor2 <- cor.test(erup, wait, method = "pearson")
print("Q 4")
print(pearson_cor2)

# The data is binomial ("Daten-Inseln" können Korrelation vortäuschen)






# Question 5

ice_path <- "/home/sam/Documents/my_files/technical_biology/technical_biology_2/scientific_methodology/homework/correlation/ice.csv"

ice_data <- read.table(ice_path, header = TRUE, sep = ";")


values <- c(ice_data$T)
time <- as.numeric(gsub(",", ".", values))

num_ice <- ice_data$Ice


plot(time, num_ice, xlab = "Time", ylab = "Ice",
     main = "Time vs. Ice", col = "blue", pch = 19)


pearson_cor3 <- cor(time, num_ice, method = "pearson")
spearman_cor3 <- cor(time, num_ice, method = "spearman")
kendall_cor3 <- cor(time, num_ice, method = "kendall")

print("Q 5")
cat("Pearson Correlation Coefficient:", pearson_cor3, "\n")
cat("Spearman Correlation Coefficient:", spearman_cor3, "\n")
cat("Kendall Correlation Coefficient:", kendall_cor3, "\n")




# Question 6

ant_path <- "/home/sam/Documents/my_files/technical_biology/technical_biology_2/scientific_methodology/homework/correlation/antilope.csv"

antilope <- read.csv(ant_path, header = TRUE, sep = ";")

kitze <- as.numeric(gsub(",", ".", c(antilope$Kitze)))
population <- as.numeric(gsub(",", ".", c(antilope$Population)))
niederschlag <- as.numeric(gsub(",", ".", c(antilope$Niederschlag)))

pearson_kitze <- cor(kitze, population)
pearson_niederschlag <- cor(niederschlag, population)

print("Q 6")

print("Pearson correlation between Kitze and Population:")
print(pearson_kitze)
print("Pearson correlation between Niederschlag and Population:")
print(pearson_niederschlag)


pearson_test <- cor.test(population, kitze, method = "pearson")

print("Pearson correlation test for Population and Kitze:")
print(pearson_test)

pearson_test_niederschlag <- cor.test(population, niederschlag, method = "pearson")

print("Pearson correlation test for Population and Niederschlag:")
print(pearson_test_niederschlag)


cor_matrix <- cor(cbind(kitze, niederschlag, population), method = "spearman")

print("Correlation matrix:")
print(cor_matrix)



# Question 7

blood_path <- "/home/sam/Documents/my_files/technical_biology/technical_biology_2/scientific_methodology/homework/correlation/blood.csv"


blood <- read.csv(blood_path, header = TRUE, sep = ",")

model <- lm(sys ~ age + weight, data = blood)

print("Q 7")

summary(model)




