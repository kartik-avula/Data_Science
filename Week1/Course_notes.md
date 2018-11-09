# R programming - week 1 - markdown

## General obervations on R

* [History of S by John Chambers](http://ect.bell-labs.com/sl/S/history.html)
* Drawbacks (according to me):
  * Objects generally need to be stored in memory 
	* Limited support for dynamic / 3D graphics 
* 4000 curated (Meet a minimum bar on quality) on CRAN 
* http://bioconductor.org also has a lot of bio stats related packages 
* https://cran.r-project.org/ has a lot of useful resources
* Getting help - https://www.r-project.org/help.html 
    * r-help@r-project.org 
    * r-devel@r-project.org
	


## R objects and attributes

### Atomic classes of objects
There are 5 basic atomic classes of objects in order of *_coercibility_* i.e. any of the other classes can be coerced into a character 
* character - _"a"_
* complex - _1+2i_
* numeric (like double) - _1.0_
* integer - _1L_
* logical - _TRUE OR T_

```r
x0  <- c("a")         #character
x1 <- c(1+1i, 2+3i)  #complex
x2 <- c(0.5, 0.6)    #numeric
x3 <- 2L:11L         #integer
x4 <- c(TRUE, FALSE) #logical
```

### Higher order objects 
There are 5 major objects (going from most basic to more complex)
* vector
* lists
* factor
* matrix
* array (n-dimensional vector)
* data.frame

Matrices, arrays, lists and data-frames (list of heterogenous vectors of same length) can be thought of deviations from vectors on the basis of order/dimensionality and homogeneity 

Each of these objects have attributes which are accessible through ```attributes()``` and ```attr()``` functions in addition to other functions which target specific attributes. The key types of attributes are:
* *class* - character, complex, numeric, integer, logical 
* *dimensions* - Number of rows and columns for matrices and data frames
* *dimension_names* - Names of rows or columns or elements 
* *others* - levels for factors is one example 

*Object Type* | *Instantiation* | *Dimension* | *Names attr* | *Others*
--------------|-----------------|--------------|---------|---------
vector        |```vector(mode="numeric",length=10) ```| NA | names(x) | NA
lists         |```list("a", 1+2.1i, 2.1, 2, T, c("a","b")) ```| NA | names(x) | NA
factors       |```factor(c("yes", "yes","no","yes"), levels = c("yes","no")))```| NA | names(x) | _levels_ defines the names/order of factor, _table_ tabulates by cross-classifying factors, _unclass_ shows underlying nos. 
matrix        |```matrix(1:10, nrow=5, ncol=2)```| _dim_ a list of 2 char vectors to set & get; nrow/ncol to get | _dimnames_ | _rbind_, _cbind_
data.frame    |```data.frame(column1 = c("a","b","c"), column2 = 3:5)```| _dim_ a list of 2 char vectors to set & get; nrow/ncol to get | _names_ and _row.names_ | _rbind_, _cbind_

#### Miscellaneous things to note
* Matrices are created columnwise i.e. j=1:n (outer loop), i=1:m (inner loop) 
* For matrices while _dimnames_ is the attribut, row.names also works for rows. names however takes the columnnames and pads with NA till length = length of matrix
* Best strategy is to use rownames and colnames for both data frames and matrices 
* Factors come in 2 types - ordered and unordered. They make a difference for some functions like lm / glm
* Printing a factor also shows level 
* If not explicitly declared the levels attribute captures the categories in alphabetical order e.g., c("no", "yes")
* A common attribute to all these objects is comment. Accessible through comment(x) allows the programmer to add a comment to an object. Does not get printed. 
* A nonsensical coercion leads to NA
* All NaNs are NAs but not vice versa. NAs also have a class. 

## Reading data

The key functions which help in data reading are:
* *read.table, write.table* - to read/write tabular data from file / connection 
* *read.csv, write.csv* - Same as above but separator is "," and the default header = TRUE
* *readLines, writeLines* - Reads specific lines from a text file 
* *dget, dput* - To read or write a variable/data + metadata through R source code
* *source, dump* - Same as above but for multiple variables 
* *load, save* - Reads and writes variable / data in binary 
* *unserialize, serialize* - Same as above with some nuance  

### Tabular data 

* The code runs much faster if you specify _colClasses_ (can use head + class to get that)
* You can also set comment.char = "" to reduce that part of the operation
* Memory required = *rows***variables***bytes/datapoint*/2^20 ; Typically *2X* (i.e. 100% overhead) this is required to be able to read this variable into memory 

### Textual format data 
* Data based on dput, dump is called textual format data (follows unix philosophy)
* This data can contain metadata (e.g. attributes) and is therefore more editable but requires more memory 
* More compatible with version control (where you can see the log of changes better)

#### Illustration 

*The following code ...*
```r
y <- data.frame(a=1,b=T)
dput(y)
z <- data.frame(a=T, b=1)
dump(c("y","z"), file = "dumptest.R")
```

*Creates this output in the dumptest.R file*
```r
y <-
structure(list(a = 1, b = TRUE), class = "data.frame", row.names = c(NA, 
-1L))
z <-
structure(list(a = TRUE, b = 1), class = "data.frame", row.names = c(NA, 
-1L))
```

### Connections to external interfaces
This is like _streams_ in C. there are 4 main functions, which can be called by ```r function (description = "", open = "r/w/a/rb/wb/ab") ```:
* *file* 
* *url* 
* *gzfile* 
* *bzfile*

## Subsetting 

### Subsetting Operators 
* *\[n\]* - outputs the nth element of the vector (including a list). The output will be of the same type as the vector e.g., a list gives a list. Also can be used to pull out multiple elements using logical / vectorized indices
* *\[\[n\]\]* - Pulls out the specific element of the list or data frame. Only 1 element. Class may not be list or data frame
* *\$* - Sames as above 

### Vector indexing 
* There are 2 types of indexing for _\[\]_ operator
  * *numeric indexing* e.g., x[1], x[2], x[1:4]
  * *logical indexing* e.g., x[is.NA(x)], x[x>"a"], x[x>1]
* Note that numeric indexing also works for something lile x[c(1,3)] if you want only the first and third element 
* To get 2 elements of a list x11, you can do x11[c(1,3)]

### Double bracket operator or $<name> operator (for lists)
* This operator can be used with a "computed index" i.e. the index can be a variable. However it has to give only 
* Giving a vector of indices leads to recursive subsetting i.e., ```x11[[c(1,3)]]``` will access the 3rd element of the 1st element of the list 
* Partial match works for $<name> but is recommendable only from the command line. For _\[\[\]\]_ you have to set the flag _exact = FALSE_ to get the same behavior 

### Subsetting a matrix 
* Subsetting a matrix e.g. ```x12[1,2]``` or ```x12[1,]``` does not return a matrix, but a vector. This is contrary to the general behavior of the _\[\]_ block. 
* To instead return a matrix you can use set _drop = False_ e.g., ```x12[1,,drop = FALSE]```


### Subsetting missing values 
* complete.cases() is a useful function to identify rows where all the arguments are not NA * something like ```airqualitydataframe[good,][1:6,]``` is allowed ! 

## Vectorized operations 
* By default R just does the operation like a dot or scalar operation i.e adding/multiplying corresponding elements 
* For true matrix muultiplication the operator is *\%\*\%*