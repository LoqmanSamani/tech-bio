
library(RPostgreSQL)
library(readxl)


host <- "82.165.61.139"
port <- 5430
dbname <- "Veg"
user <- "TechBio"
password <- "T3chB10!"


con =  dbConnect(dbDriver("PostgreSQL"), host = host, port = port, dbname = dbname, user = user, password = password)

csv_data <- read.csv("/home/sam/Desktop/data.csv")

dbWriteTable(con, name = "BodyInfo", value = csv_data, row.names = FALSE, append = TRUE)

cat("CSV/Excel data inserted successfully.\n")

my_table <- dbReadTable(con, "BodyInfo")
print(my_table)




tables <- dbListTables(con)
print(tables)




table_name = "body.Person"


data_schema = dbReadTable(con, table_name)
print(data_schema)




dbRemoveTable(con, table_name)
