# JHU Data Science - Course 03 - Getting and Cleaning Data - Week 3

## Subsetting and sorting  
which(c(TRUE, FALSE, NA,TRUE, FALSE)) # [1 4]

X <- sample(0:10,11)
sort(X)
sort(X,decreasing = TRUE)
OnebyX <- 1/X
OnebyX[length(OnebyX)+1] <- NA
sort(OnebyX) # This just removes the NAs
sort(OnebyX,na.last = TRUE) # This keeps the NAs but at the end 

## Summarizing  data
### Downloading and reading in Baltimore city restaurant data file 
if(!file.exists('./data/Balt_restaurant.csv')) {
    fileURL <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
    download.file(fileURL, destfile = "./data/Balt_restaurant.csv", method = "curl")
}
restData <- read.csv("./data/Balt_restaurant.csv")
head(restData,n=3)
tail(restData,n=3)
summary(restData)
str(restData)

#### New functions 
# Quantile is almost like percentile 
quantile(restData$councilDistrict, na.rm = TRUE)
quantile(restData$councilDistrict, na.rm = TRUE, probs = c(0.1,0.3,0.5,0.7,0.9))

# Gives a 1D table. Note that a c vector got coerced to factor
table(restData$zipCode, useNA = "ifany") #NAs will not be displayed without the arg

# Gives a 2D table
table(restData$policeDistrict, restData$zipCode,  useNA = "ifany") 

# Another use is the %in% to avoid complicated and 
table(restData$zipCode %in% c("21212","21213"))

# You can also this type of construct for a subset 
restData[restData$zipCode %in% c("21212","21213"),]

#### Using cross tabs 
data(UCBAdmissions)
DF <- as.data.frame(UCBAdmissions)

# Cross tabulation 
xtabs(Freq ~ Gender + Dept, data=DF)

# more than 2 dimensions becomes difficult to read
xt <- xtabs(Freq ~ Gender + Dept + Admit, data=DF)
xt

# Flatten table to make it readable 
ftable(xt)

## Creating new variables 
### Example 1
restData$zipWrong <- ifelse(restData$zipCode > 0,T,F)
table(restData$zipWrong, restData$zipCode > 0 )

### Example 2a
restData$zipGroups <- cut(restData$zipCode, breaks = quantile(resData$zipCode))
table(restData$zipGroups, restData$zipCode)
#### An alternative is to use cut2 from Hmisc library. 
#### Often mutate (from plyr) is combined with cut/cut2 to automatically add transformed variables like this


### Example 2b
restData$NearMe <- restData$neighborhood %in% c("Roland Park", "Homeland")
table(restData$NearMe)


## Reshaping data
install.packages("reshape2")
library(reshape2)
data(mtcars)
head(mtcars)

### melt the data 
mtcars$carname <- row.names(mtcars)
carMelt <- melt(mtcars, id = c("carname","gear","cyl"), measure.vars = c("mpg","hp") )
melt(mtcars, id = c("gear","cyl"), measure.vars = c("mpg") )
sapply(carMelt, class)

carPivot <- dcast(carMelt, variable ~ gear + cyl, sum)
carPivot2 <- dcast(carMelt, gear + cyl ~ variable, sum)

## Basic tools of dplyr
#install.packages("dplyr")
library(dplyr)
chicago <- readRDS("chicago.RDS")
