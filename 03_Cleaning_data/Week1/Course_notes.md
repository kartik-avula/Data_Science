# JHU Data Science - Course 03 - Getting and Cleaning Data - Week 1

## Motivation and Key Principles 
* Getting and cleaning data is part of the analysis 
* Raw data: The most fundamental data you have, with 0 processing of any sort 
* *Output/Processed data* - This consists of 3 things: 
    * Raw data processed into a _tidyr_ format
    * A code book which describes the variables, their units and other relevant metadata
    * A _processing script_ (should not have any parameters) which when run on the raw data will give the processed data 
* Every processing done to the raw data should be recorded/documented to ensure reproducability
* Ideally any know information about the source of raw data and methodology of collection are also relevant 

## Downloading and Reading Files
* Checking for and creating directors - *file.exists()*, *dir.create()*

### Downloading files from the internet 
* Downloading files (tab-limited, csv etc.) from the internet - *download.file()*
* Critical parameters for *download.file()* are - _url_, _destfile_, _method_
* Sample - ``` fileURL <-  "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileURL, destfile="cameras.csv", method = "curl") ```
* Always record the date on which the data was downloaded 
* _Method = "curl"_ is required if you are using a MAC and its a _https_ link

### Reading local files
* quote is an important parameter in read.csv/read.table. quote = "" typically solves a lot of issues
* The above just tells R that there are not quotes in the data so that R does not get confused 
* *read.xlsx / write.xlsx* are quite good. They have at least 3 other useful parameters - _sheetIndex, rowIndex, colIndex_
* _XLConnect_ package has a lot of good tools to write/manipulate excel files

### Reading XML 
* Extracting XML is the basis of most of web-scraping work. Has _tags, elements and attributes_

### Reading JSON


### Introduction to data.table 
* inherits from data.framew but written in C 
* Subsetting based on 1 index => subsets rows 
* DT[,c(2,3)] - Subsetting columns actually does not subset columns. You can actually pass a list of functions, it will run those function and returns the values 
* you can use := in this and add new columns 
* Unless you use a "copy function" explicitly, only pointer assignment happens 
* you can "set keys" to do much more rapid operations . Key is the common merging variable 

* RmySQL 
* httr - facebook,google, twitter, httr
* foreign package for all other files 
* Packages to load images also exist . So for GIS, musical data
* Using handles is useful