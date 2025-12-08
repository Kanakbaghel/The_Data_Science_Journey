# Basics of R Programming
# 1. Objects : Vector
# Vector is a 1d homogeneous
name <- c("kanak","kanika","karan")
name
class(name)
vec <- 1:20
vec

# Matrix is 2d homogeneous
mat <- matrix(1:20, nrow = 4, ncol = 5)
mat
# to check the dimensions
dim(mat)
class(mat)

# the print statement in R takes in only 1 element
paste("The Dimension is :", dim(mat)) # concatenation
mat <- matrix(1:20, nrow = 4, ncol = 5, byrow = F)
mat
mat <- matrix(1:20, nrow = 4, ncol = 5, byrow = TRUE)
mat

# arrays : 1 to n dimensional
arr_3d <- array(1:27, c(3,3,3))
arr_3d

# data frames : 2 dimensional data where each column is a vector
name   <- c("Alice", "Bob", "Charlie", "Diana")
age    <- c(25, 30, 22, 28)       
sex    <- c("F", "M", "M", "F")
height <- c(165, 175, 180, 160)   
weight <- c(55, 70, 80, 50) 
df <- data.frame(name, age, sex, height, weight)
df

## Length of all vector need to be same to be combined as a data frame
# - numerical : any number c(1,2,3.5,4.3255,-534)
# - integer : no decimal part 56L
# - Boolean : TRUE | FALSE | T | F
# - character : ".....", '....'
# - factor : categorical vector
num <- 45.345
paste("The Class of num is: ", class(num))
int <- 45L
paste("The Class of num is: ", class(int))

# lists : heterogeneous can contain any and all kinds of data
list_ex <- list(num = 12.43, char = "A", string = "Kanak", bool = TRUE,
                vector = name, matrix = mat, array = arr_3d,
                dataframe = df)
list_ex

# Access data in these objects
# indexing in R starts with 1
# indexing is position
## vectors : vec[4]
vec <- 100:121
vec
vec[5]
vec[c(1,5,3,7)]
# for matrix : row no. and col no.
paste(" Element at row no. 3 and col no. 3 :" , mat[3,3])
mat[c(4,2), c(3,1)]

# Accessing data in Dataframe
# to access a column 
df$name # as a vector
df["name"] # as a dataframe with 1 col

# Multiple Col
df[c("name", "height")]
# rows and columns
df[c(1,3,5), c("name","height")]
df[1,]

# multiple values : vector c(1,2,3,4)
# for multiple indices : vector of indices [rows and columns]

# Control Statements: conditional Statements, loops: for and while 
num1 <- 56
if (num1%%2 == 0){
  "Even" # when condition is True
}else{
  "odd" # when condition is false
}

for (i in 1:10){
  print("Kanak")
} 

grocery <- c("Oranges","Apples","Eggs", "Bread", "Mangoes","Milk" , "Bananas")
i <- 1
for (items in grocery){
  print(paste("Items No.", i, ":", items))
  i <- i+1
}

i <- 1
while (i <= 7) {
  items <- grocery[i]
print(paste("Items No. ", i, ":", toupper(items)))  
  i <- i+1
}

summary(df)

# type conversion
df$sex <- as.factor(df$sex)
summary(df$sex)
class(df$sex)

# Working with external data
# setting up the working directory
getwd() # Current Working directory
path <- "/cloud/project/03. RStudio/Notebooks"

# changing the working directory
setwd('path')

# loading the data
retail <- read.csv('df.csv')

# Basic Analysis
head(retail)

# Cleaning:
# 1. check for missing
# 2. check datatypes and do necessary conversions
sum(is.na(retail$InvoiceNo))
names(retail)
for (column_name in names(retail)){
  print(paste(column_name, ":", sum(is.na(retail[column_name]))))
}

# function name <- function(parameters){function body}
missing <- function (x){
  sum(is.na(x))
}

for (column_name in names(retail)){
  col_vec <- retail[column_name]
  print(paste(column_name,":", missing(col_vec)))
}

#lapply applies a function on each item of list or each column of a dataframe
lapply(retail, missing) # output is a list
sapply(retail, missing) # simplified output depends on the function output

# - if the same function is applied using lapply and the output is a list with n elements of size 1.
# - in that case sapply creates a vector

# 2nd case : 
# - if the same function is applied using lapply and the output is a list with n elements of size 1
# - in that case sapply creates a vector
lapply(retail, range) # output is a list (two values - min/max)
sapply(retail, range) # output is matrix

# to just get the class of each class
sapply(retail, class)
lapply(retail,class)

# dplyr : Grammar of manipulation
# ggplot : visualization
# readxl : functions to import excel files
# lubridate : datetime

retail$InvoiceDate[1]
library(lubridate)

retail$InvoiceDate <- dmy_hm(retail$InvoiceDate)

# dplyr Package
library(dplyr)

# 1. Select  -> selecting columns
select(retail,InvoiceDate,InvoiceNo, CustomerID)

# 2. Filter -> for row filtering
filter(retail, Country== "United Kingdom")

# 3. Mutate
# 4. Arrange
# 5. Group by
# 6. Summary
