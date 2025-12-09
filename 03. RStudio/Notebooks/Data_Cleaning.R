# Getting the file

# Option 1 : 
# 1. Setting up the working directory
# 2. Using data <- read.csv(file_name)

# Option 2 :
# 1. Using environment

head(titanic_2_)

# Checking up on data
str(titanic_2_)

# Checking missing values
is.na(titanic_2_$Age) # returns true and false 
sum(is.na(titanic_2_$Age))

ismissing <- function(x){
  sum(is.na(x))
}
sapply(titanic_2_, ismissing)
titanic_2_$Cabin

