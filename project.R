library(RPostgreSQL)
library(readxl)
library(dplyr)
library(nortest)
library(multcomp)
library(igraph)
library(PerformanceAnalytics)
library(multcompView)
library(ggplot2)
#library(car)

host <- "82.165.61.139"
port <- 5430
dbname <- "Veg"
user <- "TechBio"
password <- "T3chB10!"


#con =  dbConnect(dbDriver("PostgreSQL"), host = host, port = port, dbname = dbname, user = user, password = password)

#tables <- dbListTables(con)
#print(tables)



# Read data from CSV file
data <- read.csv("retrieved_data1.csv")

# Print column names
print(colnames(data))
print(summary(data))

# Calculate height difference
h_diff <- data$measured_height - data$estimated_height
#print(h_diff)
#cat("Sum of Height Differences:", sum(h_diff), "\n")

# Calculate weight difference
w_diff <- data$measured_weight - data$estimated_weight
#print(w_diff)
#cat("Sum of Weight Differences:", sum(w_diff), "\n")

data$height_dev = data$measured_height - data$estimated_height
data$weight_dev = data$measured_weight - data$estimated_weight
# Assuming h_diff and w_diff are vectors containing height and weight differences

#par(mfrow=c(1,2), mar=c(4,4,2,1))  # Set up a 1x2 layout

# Plot for Height Difference
#plot(1:40, h_diff, col="gray", xlab="Participant Index", ylab="Height Difference (cm)",
     #main="Difference between Measured and Estimated Height")
#abline(h=0, col="orange")

# Plot for Weight Difference
#plot(1:40, w_diff, col="gray", xlab="Participant Index", ylab="Weight Difference (kg)",
    #main="Difference between Measured and Estimated Weight")
#abline(h=0, col="orange")

# Adjust layout
#par(mfrow=c(1,1), mar=c(5,4,4,2)+0.1)



#par(mfrow = c(1, 2))

# Plot Q-Q plot for the first dataset


#qqnorm(h_diff, col = "darkgray", pch = 20, cex = 2, main = "Q-Q Plot - h_diff")
#qqline(h_diff,  col = "orange", lty = 1, lwd = 2.5)

# Plot Q-Q plot for the second dataset
#qqnorm(w_diff, col = "darkgray", pch = 20, cex = 2, main = "Q-Q Plot - w_diff")
#qqline(w_diff, col = "orange", lty = 1, lwd = 2.5)

# Reset par settings to default
#par(mfrow = c(1, 1))



#qqnorm (h_diff)
#qqline (h_diff)



#nh_diff = shapiro.test(h_diff)
#nh_diff_sqrt = shapiro.test((h_diff))
#nh_diff_log = shapiro.test(log2(h_diff))

#nw_diff = shapiro.test(w_diff)

#print(nh_diff)
#print(nh_diff_sqrt)
#print(nh_diff_log)

#print(nw_diff)






# Assuming h_diff is the differences in heights
t_test_height <- t.test(h_diff, mu = 0, alternative = "greater")
print(t_test_height)




t_test_weight <- t.test(w_diff, mu = 0, alternative = "less")
print(t_test_weight)
#print(sum(w_diff))
#print(sum(h_diff))


g_split = split(data, data$gender)

m_data = g_split$Male
f_data = g_split$Female


mh_diff <- m_data$estimated_height - m_data$measured_height
fh_diff <- f_data$estimated_height - f_data$measured_height



mw_diff <- m_data$estimated_weight - m_data$measured_weight
fw_diff <- f_data$estimated_weight - f_data$measured_weight

mh_shapiro = shapiro.test(mh_diff)$p.value
fh_shapiro = shapiro.test(sqrt(fh_diff))$p.value
mw_shapiro = shapiro.test(mw_diff)$p.value
fw_shapiro = shapiro.test(fw_diff)$p.value



print(mh_shapiro)
print(fh_shapiro)
print(mw_shapiro)
print(fw_shapiro)
print(mh_diff)
print(fh_diff)
print(mw_diff)
print(fw_diff)




# Check for equal variances (Levene's test)
# Check for equal variances (Levene's test)
#p_value_height <- var.test(mh_diff, fh_diff)$p.value
#p_value_weight <- var.test(mw_diff, fw_diff)$p.value

#print(p_value_height)
#print(p_value_weight)

# Perform Welch's t-test
t_test_height <- t.test(mh_diff, fh_diff, var.equal = FALSE)
t_test_weight <- t.test(mw_diff, fw_diff, var.equal = FALSE)

print(t_test_height)
print(t_test_weight)



#data$height_dev <- data$estimated_height - data$measured_height
#data$weight_dev <- data$estimated_weight - data$measured_weight



# Adding 'age_group' column
data$age_group = cut(data$age,
                      breaks = c(-Inf, 28, 42, Inf),
                      labels = c("young", "middle age", "old"),
                      include.lowest = TRUE)

# Assuming 'height_dev' and 'weight_dev' are the variables of interest
#model_height <- lm(height_dev ~ gender + age_group + gender:age_group, data = data)
#model_weight <- lm(weight_dev ~ gender + age_group + gender:age_group, data = data)

#print(summary(model_height))
#print(summary(model_weight))


#height_aov <- aov(height_dev ~ age_group, data = data)
#weight_aov <- aov(weight_dev ~ age_group, data = data)

#h_summ = summary(height_aov)
#w_summ = summary(weight_aov)
#print(h_summ)
#print(w_summ)







# Fit ANOVA model for height differences with interaction effect
#model_interaction_height <- aov(height_dev ~ gender * age_group, data = data)
#print(summary(model_interaction_height))

# Fit ANOVA model for weight differences with interaction effect
#model_interaction_weight <- aov(weight_dev ~ gender * age_group, data = data)
#print(summary(model_interaction_weight))

# Perform TukeyHSD tests for height
#ht = TukeyHSD(model_interaction_height, "age_group:gender", ordered=TRUE)
#print(ht)

# Perform TukeyHSD tests for weight
#wt = TukeyHSD(model_interaction_weight, "age_group:gender", ordered=TRUE)
#print(wt)


#cor1 = cor(data[, c(4, 12, 13)], method="kendall")
#print(cor1)

#net = graph_from_data_frame(d=cor1, directed=F)
#plot(net)
#plot(net, layout=layout_with_fr(net))

#col = colorRampPalette(c("red", "white", "blue"))(20)
#heatmap(x = cor1, col = col, symm = TRUE)

#print(data)






#t_test_height <- t.test(mh_diff, fh_diff)
#print(t_test_height)

#t_test_height <- t.test(mw_diff, fw_diff)
#print(t_test_height)


#sd_height_male <- sd(mh_diff)
#sd_height_female <- sd(fh_diff)

#sd_weight_male <- sd(mw_diff)
#sd_weight_female <- sd(fw_diff)

#print(paste("Standard Deviation of Height Differences (Male):", sd_height_male))
#print(paste("Standard Deviation of Height Differences (Female):", sd_height_female))

#print(paste("Standard Deviation of Weight Differences (Male):", sd_weight_male))
#print(paste("Standard Deviation of Weight Differences (Female):", sd_weight_female))


#subdata <- data[c("number", "height_dev", "weight_dev", "gender", "age_group")]
#print(subdata)


# Assuming your data frame is named 'data' with columns 'height_diff', 'weight_diff', 'age_group', and 'gender'
# Install the 'car' package if not already installed: install.packages("car")


# Fit the ANOVA model for height differences
model_height <- aov(height_dev ~ age_group * gender, data = data)

# Print summary of the ANOVA for height differences
#h_summ = summary(model_height)
#print(h_summ)
# Fit the ANOVA model for weight differences
model_weight <- aov(weight_dev ~ age_group * gender, data = data)

# Print summary of the ANOVA for weight differences
#w_summ = summary(model_weight)


#print(w_summ)

#dbDisconnect(con)

ht = TukeyHSD(model_height, "age_group:gender", ordered=TRUE)
wt = TukeyHSD(model_height, "age_group:gender", ordered=TRUE)
print(ht)
print(wt)




pdf("/home/sam/Desktop/plot_ht.pdf")
plot(ht, las=1, col="#2b2929")
dev.off()

pdf("/home/sam/Desktop/plot_wt.pdf")
plot(wt, las=1, col="#2b2929")
dev.off()
 
 


# Assuming 'model_height' is your ANOVA model
# You should replace this with your actual ANOVA model

# Check normality of residuals
#residuals_height <- residuals(model_height)
#hist(residuals_height, main="Histogram of Residuals")

# Shapiro-Wilk test for normality
#print(shapiro.test(residuals_height))

# Check homogeneity of variances
#plot(model_height, which=1)  # Residuals vs Fitted
#plot(model_height, which=2)  # Scale-Location plot

# Levene's test for homogeneity of variances
#leveneTest(model_height)






