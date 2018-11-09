## R programming - week 1 - markdown
### R objects and attributes
# Atomic - character, numeric (like double) <default>, integer, complex, logical

# The most object is a vector
# Higher order objects are lists and can contain other objects (e.g., lists and different atomic data types)

# R objects have attributes. Can be set or modified through attributes() function 
#* names, dimnames, length, dimensions, class

### Creating vectors
# using c 
x1 <- c(0.5, 0.6)    #numeric
x2 <- c(TRUE, FALSE) #logical
x3 <- c(1+1i, 2+3i)  #complex
x4 <- 2:11

# Creating vector using vector()
x5 <- vector(mode = "numeric", length = 10)

# Coercion rules - will get to lowest common denominator 
# Character << complex << numeric << integer << logical
x5 <- c("a","b",1.2,2.3,1,2,T,F)
class(x5)

# Creating list using list()
x6 <- list("a", 1+2.1i, 2.1, 2, T)


# Matrices - Vectors with a dimension attribute
## creating matrix through matrix function
x7 <- matrix(1:10, nrow=5, ncol=2)
x7 
## notice that matrices are created columnwise i.e. j=1:n (outer loop), i=1:m (inner loop) 

dim(x7)
attributes(x7)

# Name attributes are in dimnames. row.names also works for rows. names however takes the columnnames and pads with NA till length = length of matrix
# Best strategy is to use rownames and colnames 

## converting to a matrix through dim 
x7 <- 1:20
dim(x7) <- c(5,4)

## creating matrices through rbind and cbinding 
x7 <- 1:10 
rbind(x7, x4)
cbind(x7, x4)

# Factors
# 2 types - ordered and unordered. THey make a difference for some functions like lm / glm
## Creating factors
x8 <- factor(c("yes", "yes","no","yes"), levels = c("yes","no"))

## Printing a factor also shows elvel 
x8

## table tabulates by the cross-classifying factors
table(x8)

# Factors are captured as numbers internally 
unclass(x8)

# If not explicitly declared the levels attribute captures the categories in alphabetical order e.g., c("no", "yes")
x9 <- factor(c("yes", "yes","no","yes"))
attr(x9, which = "levels", exact = FALSE)
attr(x9, which = "levels") <- c("yes","no")
x9

# Missing value NA/NaN
## NA has class also 
## NaN is a type of NA but not vice versa 

# Data frames are lists of lists .. often used to store tabular data 
# Name attributes are -- names (for columns) and row.names. They can also be accessed through dimnames function. 
x10 <- data.frame(char_col = c("a","b","c"), numeric_col = 3:5)
row.names(x10) <- c("row1", "row2", "row3")
attributes(x10)aat
x10

# can also do this using attr
attr(x10, which = "row.names") <- c("r1", "r2", "r3")
x10
dim(x10)


## Reading data

y <- data.frame(a=1,b=T)
dput(y)
z <- data.frame(a=T, b=1)
dump(c("y","z"), file = "dumptest.R")


## Subsetting 

### Vectors 
#### 


### Lists
x11 <- list (a = 1:10, b = "element_2", c(T,F,T))
x11
length(x11)
class(x11)
names(x11)

x11[[1]]
x11$a
x11[1]

class(x11[[1]])
class(x11$a)
class(x11[1])

length(x11[[1]])
length(x11$a)
length(x11[1])


x11[["a"]] # This is same as x$a
x11[["a"]] == x11$a
x11["a"] # This is same as x11[1] and returns a list of 1 element 
x11[[c(1,4)]] # each elements goes to the next level of nest

## Quiz output
quiz_data <- read.csv("quiz1_data/hw1_data.csv")
### Question 11
names(quiz_data)
### Question 12
quiz_data[1:2,]
### Question 13
nrow(quiz_data)
### Question 14
quiz_data[152:153,]
### Question 15
quiz_data$Ozone[47]
### Question 16
sum(is.na(quiz_data$Ozone))
### Question 17
mean(quiz_data$Ozone[!is.na(quiz_data$Ozone)])
### Question 18
subset1_quiz_data <- quiz_data[quiz_data$Ozone > 31,][quiz_data$Temp > 90,] ## THIS DOES NOT WORK BECAUSE THE ROW NUMBERS HAVE NOW CHANGED 
subset1_quiz_data <- quiz_data[(quiz_data$Ozone > 31)&(quiz_data$Temp > 90),]
subset1_quiz_data <- subset1_quiz_data[complete.cases(subset1_quiz_data),]
mean(subset1_quiz_data$Solar.R)
### Question 19
subset2_quiz_data <- quiz_data[quiz_data$Month == 6,]
#subset2_quiz_data <- subset2_quiz_data[complete.cases(subset2_quiz_data),] # This is not correct because it maybe removing cases where Temp exists but a 4th variable is NA 
subset2_quiz_data <- subset2_quiz_data[!is.na(subset2_quiz_data$Temp),]
mean(subset2_quiz_data$Temp)

### Question 20
subset3_quiz_data <- quiz_data[quiz_data$Month == 5,]
subset3_quiz_data <- subset3_quiz_data[!is.na(subset3_quiz_data$Ozone),]
max(subset3_quiz_data$Ozone)
