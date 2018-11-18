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


### Introduction to data.table 
* inherits from data.framew but written in C 
* Subsetting based on 1 index => subsets rows 
* DT[,c(2,3)] - Subsetting columns actually does not subset columns. You can actually pass a list of functions, it will run those function and returns the values 
* you can use := in this and add new columns 
* Unless you use a "copy function" explicitly, only pointer assignment happens 
* you can "set keys" to do much more rapid operations . Key is the common merging variable 
[r-bloggers data table](https://www.r-bloggers.com/intro-to-the-data-table-package/)
[data table tutorial](https://www.dezyre.com/data-science-in-r-programming-tutorial/r-data-table-tutorial)

## Databases and formats 

Format | Rpackage | Description | Key operations | Other sources 
-------|----------|-------------|----------------|--------------
CSV    | base     | read simple tabular data | ```read.table(file,quote="")``` ```read.csv(file,quote="")```|
XLSX   | xlsx     | read xlsx data; can choose specific worksheets, rows, column | ```read.xlsx(file,sheetIndex=,rowIndex=,colIndex=)``` | 
XML    | XML      |Tags, elements, attributes: Basis for webscraping| ```docx<-xmlTreeParse(file)```;```root<-xmlRoot(doc)```;```xpathSApply(root,"//<tag syntax>",xmlValue)``` | [Omegahat XML](http://www.omegahat.net/RSXML/), [Outstanding guide](https://www.stat.berkeley.edu/~statcur/Workshop2/Presentations/XML.pdf)
JSON   | jsonlite |Javascript Object Notation (JSON); Light weight data storage, common in                             APIs | ```jsonData <- fromJSON(url)```, ```jsonData$owner$login``` - nested list | [R-blogger JSON lite](https://www.r-bloggers.com/new-package-jsonlite-a-smarter-json-encoderdecoder/), [JSON vignetter](https://cran.r-project.org/web/packages/jsonlite/vignettes/json-aaquickstart.html) 
GIS    | rgdal,rgeos,raster
mp3    | tuneR
image  | jpeg,png,readbitmap 
Stat   | foreign

Databases | Rpackage | Description | Key operations | Other sources 
-------|----------|-------------|----------------|--------------
SQL  | RMySQL | Databases - Tables(dataframe) - Fields(col) | ```dbGetQuery(uscscDb, "<SQL query>")```: ```query <- dbSendQuery(uscsDb, "<SQL query>")```:```fetch(query)```:```dbDisconnect(uscsDb)``` | [vignette](http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf); [command_list](http://www.pantz.org/software/mysql/mysqlcommands.html);
[command_summary](http://www.r-bloggers.com/mysql-and-r/)
HDF5 | rhdf5(bio) | groups - datasets - (header + array(dataframe)) | ```h5CreateFile()```:```h5CreateGroup()```:```h5read()```:```h5write()```| [rhdf5_tutorial](http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf)
Web  | httr | Multiple options - base, XML, httr | ```pg2 = GET("http://httpbin.org/basic-auth/user/passwd",authenticate("user","passwd")) ```: ```google = handle("http://google.com")``` | [r-blogger](http://www.r-bloggers.com/?s=Web+Scraping):[cran-help](http://cran.r-project.org/web/packages/httr/httr.pdf)
Other| RpostgreSQL, Rmongo, RODBC 

### APIs
* APIs are a combination of 
    * Web data queries (usually with authentication)
    * Parsing into a useful data format (XML, JSON, csv)

Typical web data query involves authentication 
```myapp = oauth_app("twitter",key="yourConsumerKeyHere",secret="yourConsumerSecretHere")```
```sig = sign_oauth1.0(myapp,token = "yourTokenHere",token_secret = "yourTokenSecretHere")```
```homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)```

And then conversion to a useful file 
```json1 = content(homeTL)```
```json2 = jsonlite::fromJSON(toJSON(json1))```





### Other things
