library(RPostgreSQL)
library(readxl)
library(dplyr)


host <- "82.165.61.139"
port <- 5430
dbname <- "Veg"
user <- "TechBio"
password <- "T3chB10!"


#con =  dbConnect(dbDriver("PostgreSQL"), host = host, port = port, dbname = dbname, user = user, password = password)

#tables <- dbListTables(con)
#print(tables)



# Read data from CSV file
data <- read.csv("retrieved_data.csv")

# Print column names
print(colnames(data))

# Calculate height difference
h_diff <- data$estimated_height - data$measured_height
print(h_diff)
cat("Sum of Height Differences:", sum(h_diff), "\n")

# Calculate weight difference
w_diff <- data$estimated_weight - data$measured_weight
print(w_diff)
cat("Sum of Weight Differences:", sum(w_diff), "\n")


# Assuming h_diff and w_diff are vectors containing height and weight differences

par(mfrow=c(1,2), mar=c(4,4,2,1))  # Set up a 1x2 layout

# Plot for Height Difference
plot(1:40, h_diff, col="gray", xlab="Participant Index", ylab="Height Difference (cm)",
     main="Difference between Measured and Estimated Height")
abline(h=0, col="orange")

# Plot for Weight Difference
plot(1:40, w_diff, col="gray", xlab="Participant Index", ylab="Weight Difference (kg)",
     main="Difference between Measured and Estimated Weight")
abline(h=0, col="orange")

# Adjust layout
par(mfrow=c(1,1), mar=c(5,4,4,2)+0.1)










dbDisconnect(con)
