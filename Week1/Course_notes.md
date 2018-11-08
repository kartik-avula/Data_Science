# R programming - week 1 - markdown
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
* data.frame

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


