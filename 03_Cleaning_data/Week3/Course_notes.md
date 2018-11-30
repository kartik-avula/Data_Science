# JHU Data Science - Course 03 - Getting and Cleaning Data - Week 3

## Subsetting and sorting  
* Which identifies only those elements which are evaluated to TRUE (ignores NAs)
* By default, sort removes the NAs. To keep them (at the end) make _na.last = T_
* To sort a data frame by a particular column you can use DF[order(DF$Var1),] 
* The same functionality is obtained through arrange in plyr
* **stringsAsFactors = FALSE ** in read.csv simplifies further processing

## Summarizing data 
* Apart from head, tails, summary, str - ```quantile``` is a useful function for int / numeric variables 
* table function coerces variables to factors. It can also be used with 2 factors for a 2D table 
* Default with table is not to show NA. To make it show NA as well you can use _useNA=ifany_
* Cross tabs function ```xtabs(Freq ~ Gender + Dept, data=DF)``` is also useful
* With more than 2 variables output is difficult to read. ```ftable(<xtab output>)``` makes it readable.
* xtabs is just a derived function (check exact terminology) which is specifically for cross-tabulation of data frames with a formula interface 

## Creating new variables 
The most common reasons for creating new variables are 
1. missingness indicators 
2. factorization of (a) numeric or even (b) factor variables (think of adding and "other" category). You can also simply convert numeric to factor (e.g., zipCode)
3. Transforming variables

### Example of capturing missingness 
``` restData$zipWrong <- ifelse(restData$zipCode > 0,T,F) ``` 

### Example of 2a factorization
One interesting example of re-factoring as a motivation for a new variable is 
``` restData$zipGroups <- cut(restData$zipCode, breaks = quantile(restData$zipCode)) ```
``` table(restData$zipGroups, restData$zipCode) ``
* An alternative is to use cut2 from Hmisc library
* Often mutate (from plyr) is combined with cut/cut2 to automatically add transformed variables like this


### Example of 2b factorization
One interesting example of re-factoring as a motivation for a new variable is 
``` restData$NearMe <- restData$neighborhood %in% c("Roland Park", "Homeland") ```
``` table(restData$NearMe) ```

## Reshaping data  
* Melt reshapes the data in a tall and skinny format. Benefits are 
    * Removing unwanted columns 
    * Combining of multiple columns into a single one - could be very useful for survey data     * Clear distinction
* The biggest benefit is that it can be recast into a pivot table using dcast function 
* tapply is basically a combination of split and lapply 
* ddply in dplyr is very useful way of doing split-apply on data frames 
* Key links 
    * [Tutorial from Hadley](http://plyr.had.co.nz/09-user/)
    * [Jeffrey Breen's - Reshaping data in R tutorial](https://www.slideshare.net/jeffreybreen/reshaping-data-in-r)
    * [R-bloggers - split-apply-combine](https://www.r-bloggers.com/a-quick-primer-on-split-apply-combine-problems/)
    
## Intro to dplyr
* Provides grammar for working with tabular data 
* Same tools are applicable for data frames, data tables, multidimensional arrays and databases
* an object can have multiple class e.g., tbl_df() converts argument to a tbl, tbl_df and retains data.frame. This is the standard object type processed within dplyr \
* The main advantage of using a tbl_df over a regular data frame is the printing
* In addition tibbles can contain grouping metadata which can be used with summarize 

* 5 fundamental **verbs** in the dplyr grammar of manipulating tidy data 
    * arrange - sort the data frame rows by particular variable(s)
    * filter - select a subset of rows satisfying a particular logical condition
    * select - select a subset of columns and/OR rearranges them and/OR renames them
    * mutate - add or modify columns based on calculation of other columns 
    * rename - change name of column
    * summmarize - apply and combine 
* group_by - split by a particular categorical/factor variable
* The **verbs** thinking is useful as there is a consistency to how they are used
    * The first argument is always a data frame 
    * The next few arguments describe what to do with it. You can refer to columns in the data frame directly
    * The result is a new data frame
* Looks like it does not matter if the variable names are in **\"\"** or not in dplyr functions. Just gets converted to the name of a variable (column) 
* You can also specify columns through indices or names (true in general in R) or names separated by the **\:** operator

* **select()** has 4 ways of specifying columns 
    * Individual names with or w/o negation e.g., ```select(df, col1,col2)```, ```select(df, -col3)```
    * Indices with or w/o negation e.g., ```select(df, 3:5)```,```select(df, -(6:8))``` 
    * Named sequence with or w/o negation e.g., ```select(df, col1:col2)```, ```select(df, -(col1:col2))```
    * A number of functions - e.g. contains - which work inside select  
* Inherent in **select** is the ability to rearrange columns

* **arrange** orders based on the first variable and tie-breaks based on remaining 
* **arrange** can use a new variable / column created in one of its args in subsequent args

* **summarize** - You can give multiple arguments to summarize each of which will create a separate column e.g. ```summarize(data, a = n(), b = n_distinct(ip_id), c=mean(size))```
* Available useful functions to use for summarizationa are **n(), n_distinct()** 

* **View** can help us see the entire tbl_df

* dplyr can work with other data frame backends e.g., DBI package, data.table package 
* You have to be very careful when converting factors to numeric. Direct conversion does not work because it will convert to the underlying number. Rather you can use ```as.numeric(as.character(<factor vector>))```

## Additional functions in dplyr or tidyr
* **gather** is used when you have columns that are not variables (or column names actually contain data e.g., male, female)
* **gather** takes multiple columns and collapses key value pairs 
* **separate** is used when a single column with character data is used to code multiple variables 
* **spread** spreads a key value pair across multiple columns. You need to identify which columns to spread (like gather). In fact spread and gather are complements.
* **spread** - Other arguments like drop and fill tell whether to drop factor combinations that are not present in data, and if we decide to keep them what to fill them with
* **unique** removes dublicate rows . You might need to use it after select 