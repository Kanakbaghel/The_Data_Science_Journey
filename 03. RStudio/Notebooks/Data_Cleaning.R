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

sapply(titanic_2_ , function(x) {sum(is.na(x))})

"" == FALSE

# 1. [] : Square brackets -> indexing e.g. titanic_2_[]
# 2. () : Parentheses -> which always follow a function e.g. sum(), sapply(), head()
# 3. {} : Curly brackets -> to identify block of code e.g. in function f(x){block of code}, if (condition) {} loop :[]

# replace empty strings
titanic_2_$Cabin <- sapply(titanic_2_$Cabin, trimws)

trimws(titanic_2_$Cabin == "")

# Check for duplicates
sum(duplicated(titanic_2_))

# Create a dataframe in R
df <- data.frame(
  name   = c("Kanak", "Sapna", "Meera"),
  age    = c(23, 30, 27),
  sex    = c("F", "M", "F"),
  height = c(160, 175, 168),
  weight = c(55, 70, 60),
  mem    = c("TRUE", "FALSE", "TRUE")   
)

# View the dataframe
print(df)

list(name = "Simran",
     age = 25,
     sex = 'F',
     height = 165,
     weight = 49,
     mem = FALSE)

# add the row to df
df <- rbind(df,list(name = "Simran",
                    age = 25,
                    sex = 'F',
                    height = 165,
                    weight = 49,
                    mem = FALSE))
# to view data
df

duplicated(df)
sum(duplicated(df))

# to get location of duplicated
which(duplicated(df))

# if you want to consider the latest value as original 
duplicated(df, fromLast = TRUE)
which(duplicated(df, fromLast = TRUE))

# now, considering only id column for identifying duplicates
# name and sex 

duplicated(df[c('name','sex')])
which(duplicated(df[c('name','sex')]))

duplicate_rows <- which(duplicated(df[c('name','sex')]))
df[-c(duplicate_rows),]
df

# for dropping rows
df[-4,]

# removing duplicate rows
unique(df)

# adding a column
df$Country <- c('US','U.S.A','India','China')
df

# get the unique values from the column
unique(df$Country)

df$Country <- tolower(df$Country)
df

# to get frequency
table(df$Country)

#transform
df$Country <- sapply(df$Country, 
       function (Country) {ifelse((Country == "us") || (Country == 'u.s.a'),
                'us', Country)})
df

#--------------------------------
unique(titanic_2_$Embarked)

# define a function for treatment
replace_with_NAs <- function(col) {
  new_col <- c() # new vector
  for (x in col){ # iterate through the values in the column 
    if (x == ""){
      new_col <- c(new_col, NA)
    } else {
      new_col <- c(new_col, x)
    }
  }
  return(new_col)
}

sum(is.na((titanic_2_$Embarked)))
sum(is.na(replace_with_NAs(titanic_2_$Embarked)))

# perform for only character columns
sapply(titanic_2_, class)
library(dplyr)

# %>% pipeline operator 
# Select_if from dplyr --> select columns which follow the given condition
# is.character --> built in function which checks if the data type is character or not
char_cols <- titanic_2_ %>% 
  select_if(is.character) %>%
  names()
char_cols

lapply(titanic_2_[char_cols], replace_with_NAs)

titanic_2_ %>%
  mutate(across(where(is.character), ~ifelse(.x == "", NA, .x ) # anonymous function
                ))

titanic_2_ %>%
  mutate(across(where(is.character), 
                function(x) {ifelse(x == "", NA, x )} 
  ))

sapply(new_tit, ismissing)

titanic_2_ %>% mutate(Name = tolower(Name))

# treat the missing values
# 1. Deletion : Rows and columns
# *if there are high percentage of missing values
# 2. Imputation

(sapply(titanic_2_, ismissing))/891 *100

# >30% is non negotiable and you may delete the columns
# for imputation :
# 1. constant
# 2. statistical value : mean,median, mode
# 3. ML Imputers : KNN - k nearest neighbours
sum(is.na(titanic_2_$Age))
mean(titanic_2_$Age, na.rm = TRUE) # don't use missing in calculation of mean
summary(titanic_2_$Age)

# check age by sex
titanic_2_ %>%
  group_by(Sex) %>%
  summarize(Mean = mean(Age, na.rm = TRUE))

head(titanic_2_$Name)

# names() get the column  names in a dataframe
# colnames() or COLNAMES()

# pipeline : task 1 --> task 2 --> task 3

titanic_2_ %>% # calling the data
  select_if(is.character) %>% # using the select_if function to get only character cols from the data
  names() # getting names from the filtered data

temp <- select_if(titanic_2_, is.character)
names(temp)

titanic_2_ %>%
  summarise(across(where(is.numeric),
                   function(x) {sum(is.na(x))}
                   ))

titanic_2_ %>%
  summarise_all(mean, na.rm = TRUE)

# na.rm --> parameter which need to be set TRUE when missing value in the column


