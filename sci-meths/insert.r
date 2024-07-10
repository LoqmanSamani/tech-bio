library(RPostgreSQL)
library(readxl)


host <- "82.165.61.139"
port <- 5430
dbname <- "Veg"
user <- "TechBio"
password <- "T3chB10!"


con =  dbConnect(dbDriver("PostgreSQL"), host = host, port = port, dbname = dbname, user = user, password = password)


# drop a table from database

dbRemoveTable(con, table_name)



# Get the list of all tables in the Veg database
tables <- dbListTables(con)

print(tables)

my_table <- dbReadTable(con, "body.MeasurementResults")
print(my_table)




# insert into body.Project

new_data <- data.frame(project="BodyPro11")

dbWriteTable(con, name = "body.Project", value = new_data, row.names = FALSE, append = TRUE)

cat("Additional data inserted successfully.\n")





# insert into body.Author table

author_table <- data.frame(given_name="Loghman", family_name="Samani", matrikel_nr="3585810", project_id=2)

dbWriteTable(con, name = "body.Author", value = author_table, row.names = FALSE, append = TRUE)






# insert into body.Person
id1 = seq(1, 40)
number1 = c('Participant 1', 'Participant 2', 'Participant 3', 'Participant 4', 'Participant 5', 'Participant 6', 'Participant 7', 'Participant 8', 'Participant 9', 'Participant 10', 'Participant 11', 'Participant 12', 'Participant 13', 'Participant 14', 'Participant 15', 'Participant 16', 'Participant 17', 'Participant 18', 'Participant 19', 'Participant 20', 'Participant 21', 'Participant 22', 'Participant 23', 'Participant 24', 'Participant 25', 'Participant 26', 'Participant 27', 'Participant 28', 'Participant 29', 'Participant 30', 'Participant 31', 'Participant 32', 'Participant 33', 'Participant 34', 'Participant 35', 'Participant 36', 'Participant 37', 'Participant 38', 'Participant 39', 'Participant 40')

gender1 = c('male', 'male', 'male', 'male', 'male', 'male', 'male', 'male', 'male', 'male','male', 'male', 'male', 'male', 'male', 'male', 'male', 'male', 'male', 'male',
            'female', 'female', 'female', 'female', 'female', 'female', 'female', 'female', 'female', 'female', 'female', 'female', 'female', 'female', 'female', 'female',
            'female', 'female', 'female', 'female')


age1 = c(26, 39, 48, 34, 30, 27, 48, 40, 26, 45, 38, 42, 30, 30, 43, 40, 23, 27, 43, 22, 55, 19, 17, 21, 57, 19, 44, 33, 41, 59, 49, 25, 51, 29, 46, 30, 23, 29, 38, 55)
measured_weight1 = c(74.0, 77.8, 75.5, 85.8, 71.4, 82.2, 88.3, 77.1, 70.8, 89.5, 83.3, 77.4, 82.4, 75.9, 83.7, 71.1, 82.0, 84.1, 73.1, 86.8, 62.2, 59.8, 64.7, 61.7, 64.4, 60.5, 64.0, 60.7, 66.0, 56.3, 53.7, 61.2, 60.1, 67.9, 61.9, 58.6, 55.3, 66.5, 61.0, 58.6)
measured_height1 = c(175.7, 173.4, 169.4, 177.1, 175.3, 170.7, 174.3, 169.5, 178.6, 174.3, 176.1, 168.3, 177.1, 171.9, 174.9, 172.5, 178.7, 170.7, 173.2, 172.3, 171.1, 167.7, 170.2, 167.9, 165.8, 171.5, 169.1, 157.7, 163.5, 164.0, 157.7, 167.8, 164.5, 167.7, 172.3, 162.8, 158.1, 158.6, 157.5, 161.7)


person_table <- data.frame(id=id1, number=number1, gender=gender1, age=age1, measured_weight=measured_weight1, measured_height=measured_height1)


dbWriteTable(con, name = "body.Person", value = person_table, row.names = FALSE, append = TRUE)

cat("Additional data inserted successfully.\n")


"""
   id         number gender age measured_weight measured_height
1   1  Participant 1   male  26            73.1           175.5
2   2  Participant 2   male  39            79.1           172.9
3   3  Participant 3   male  48            76.3           168.5
4   4  Participant 4   male  34            85.8           176.9
5   5  Participant 5   male  30            71.0           175.0
6   6  Participant 6   male  27            82.7           170.2
7   7  Participant 7   male  48            91.5           174.1
8   8  Participant 8   male  40            77.6           169.0
9   9  Participant 9   male  26            72.2           178.1
10 10 Participant 10   male  45            91.6           173.7
11 11 Participant 11   male  38            83.9           175.1
12 12 Participant 12   male  42            80.8           167.4
13 13 Participant 13   male  30            85.7           176.1
14 14 Participant 14   male  30            76.0           171.5
15 15 Participant 15   male  43            85.0           174.3
16 16 Participant 16   male  40            71.4           172.0
17 17 Participant 17   male  23            82.3           178.6
18 18 Participant 18   male  27            83.3           170.0
19 19 Participant 19   male  43            74.9           172.6
20 20 Participant 20   male  22            88.0           172.0
21 21 Participant 21 female  55            62.3           170.7
22 22 Participant 22 female  19            60.4           167.2
23 23 Participant 23 female  17            66.5           169.9
24 24 Participant 24 female  21            62.2           167.5
25 25 Participant 25 female  57            64.7           165.8
26 26 Participant 26 female  19            61.4           171.4
27 27 Participant 27 female  44            65.9           168.9
28 28 Participant 28 female  33            61.2           157.6
29 29 Participant 29 female  41            67.4           163.4
30 30 Participant 30 female  59            57.8           163.6
31 31 Participant 31 female  49            54.2           157.7
32 32 Participant 32 female  25            62.6           167.6
33 33 Participant 33 female  51            60.8           164.4
34 34 Participant 34 female  29            69.2           167.7
35 35 Participant 35 female  46            63.2           172.0
36 36 Participant 36 female  30            59.7           162.3
37 37 Participant 37 female  23            55.5           157.7
38 38 Participant 38 female  29            68.2           158.3
39 39 Participant 39 female  38            61.6           157.5
40 40 Participant 40 female  55            58.9           161.6
"""








# insert into body.MeasurementResults

id1 = seq(1, 40)
project_id1 = rep(2, 40)
person1 = seq(1, 40)

estimated_height1 = c(175, 174, 171, 177, 175, 171, 174, 170, 179, 175, 178, 170, 179, 172, 176, 173, 178, 172, 174, 172, 172, 169, 171, 169, 165, 171, 169, 157, 163, 165, 157, 168, 164, 167, 173, 164, 159, 159, 157, 161)
estimated_weight1 = c(76, 78, 76, 87, 73, 83, 87, 78, 71, 89, 84, 76, 81, 77, 84, 72, 83, 86, 73, 87, 64, 61, 64, 63, 66, 61, 63, 62, 66, 56, 55, 61, 61, 68, 62, 59, 57, 66, 62, 60)

measure_table <- data.frame(id=id1, estimated_height=estimated_height1, estimated_weight=estimated_weight1, project_id=project_id1, person=person1)

# Insert dataframe into the table
dbWriteTable(con, name = "body.MeasurementResults", value = measure_table, row.names = FALSE, append = TRUE)

cat("Additional data inserted successfully.\n")



"""
    id estimated_height estimated_weight project_id person
1   1              175               76          2      1
2   2              174               78          2      2
3   3              171               76          2      3
4   4              177               87          2      4
5   5              175               73          2      5
6   6              171               83          2      6
7   7              174               87          2      7
8   8              170               78          2      8
9   9              179               71          2      9
10 10              175               89          2     10
11 11              178               84          2     11
12 12              170               76          2     12
13 13              179               81          2     13
14 14              172               77          2     14
15 15              176               84          2     15
16 16              173               72          2     16
17 17              178               83          2     17
18 18              172               86          2     18
19 19              174               73          2     19
20 20              172               87          2     20
21 21              172               76          2     21
22 22              169               78          2     22
23 23              171               76          2     23
24 24              169               87          2     24
25 25              165               73          2     25
26 26              171               83          2     26
27 27              169               87          2     27
28 28              157               78          2     28
29 29              163               71          2     29
30 30              165               89          2     30
31 31              157               84          2     31
32 32              168               76          2     32
33 33              164               81          2     33
34 34              167               77          2     34
35 35              173               84          2     35
36 36              164               72          2     36
37 37              159               83          2     37
38 38              159               86          2     38
39 39              157               73          2     39
40 40              161               87          2     40
"""


dbDisconnect(con)