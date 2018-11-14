# R programming - week 2 

## Control structures 

The control structures in R are 
* if-else 
* while, for
* repeat, next, break 

Key insights on control structures are:
* R has 2 ways of realizing the  _if-else_ structure
  * traditional 
  * ``` y <- if(x < 3) { T } else { F } ```
* The iterated variable _\i_ in ```for(i in x)``` basically cycles through the elements of the vector x 
* _seq\_along_ is frequently used in for loops
* _if\-else_ does not cycle through vectors. It just checks for the if condition for the first element of the vector 
* To cycle through vectors use function _ifelse(condition, if result, else result)_

## Functions
* The return value of a function is just the result of the last operation 
* A function is also a type of R object and is therefore "assigned" using *_\<\-_* . Functions can also return other functions (lisp type property!)
* R functions have named arguments or otherwise. For named arguments, the order in which R finds them is : (a) complete matching (b) partial matching (c) positional matching.
* Named arguments can be assigned default values during function definition 
* Naming an argument during a function call essentially removes that variable from the args list for the purpose of positionally matching the remaining arguments 
* R follows lazy execution i.e., it does not flag an error till there is one during execution. Hince it is ok to not pass all arguments etc. 
* This type of use (not all arguments used) is quite common in wrapper(generic?) functions. These  functions dispatch other functions based on which variables are passed to it. _seq_ is such an example. Underlying functions are _seq\.int_ , _seq\_along_ and _seq\_len_
* The _..._ argument is used for Generic functions which pass these on to other functions e.g., graphical functions. Any variable after _..._ has to be named explicitly during the call   
* R function can have functions as arguments. You can unpack _..._ by creating a list using ```arg_var<-list(...)```. You can access the named elements (assuming variables passed with name) using ``` arg_var[["var_name"]] ```
* R allows you to create new operators e.g., ``` %p% <- function(left, right){left*right+1} ``` 

## Lexical scoping 
* R uses *lexical or static scoping* rather than dynamic scoping. This means that variable context depends on the environment where the function is _defined_, not just called. If both definition and call happen in the same environment then it _looks_ like dynamic scoping which can be confusing. Also if the variable value changes in the _defined environment_ then the function changes 
* Variables which are used in a function but not defined locally or in the formal arguments are called _free variables_
* The binding of a value to free variables happens by searching through a hierarchy of environments for that variable. This happens in 2 steps (my understanding): 
  * succession of environments from local upto .GlobalEnv. Think of this as going up the nested function _definitions_ 
  * Down from _.GlobalEnv_ to _base package_ and the _empty environment_ . This ordered list is accessible through the _search()_ function 
* The output of search consists of the ordered sequence of environments searched 
  * .GlobalEnv first always 
  * new loaded packages (using _library()_). LIFO 
  * _stats_ down to _base_ packages and then _empty_ environment 
 * The _parent frame_ of a function is its calling environment 

## Why lexical scoping in statistics   
* At first glance, lexical scoping does not really seem useful because - what would be the case where you define a function in one environment and then change environments and call it. After all you the most likely use case is that you do both these in the same package or .GlobalEnv 
* *Insight, Insight, Insight\!* - This case is quite common if you do 2 things - (a) define a constructor function which returns a function (b) data and (some) params are passed to constuctor function but are free variables in returned function 
* *Insight, Insight, Insight\!* - The free variable values from the constructor function environment are *locked-in* into the returned function 
* *Insight, Insight, Insight\!* - This is variable in statistics where a lot of the computation is of the form of iteratively running a cost function for different parameters (e.g. _m_ and _c_ for linear regression) and same data.
* *Insight, Insight, Insight\!* - Essentially, when a function is returned actually the function closure is returned i.e. function + values/where to get values of free variables in the function 
* Please read the accompanying _Course_notes.R_ file as it is very descriptive. 
  
## Coding standards 
1. Always use a text editor 
2. Indent at least 8 tabs with 80 columns total 
3. Right size functions - Ideally each function should do 1 thing and should be <1 page. Also should not ideally be just 2-3 line code. 

## Dates and times 
* The classes for dates and times are _Date_, _POSIXct_ and _POSIXlt_
* Underlying storages - these can be accessed through _unclass()_ 
    * _Date_ stores an integer corresponding to number of days from 1970-01-01
    * _POSIXct_ stores a number with number of secs from 1970-01-01
    * _POSIXlt_ stores a list with Year, Month, Days etc. ```names(unclass(x))``` will show these elements
* _POSIXct_ is recommended for data frames because its an integer
* _strptime()_ is one of the most important function to convert to this format
* Other important ones are of the _as\.\<class_name\>_ format* 

## Logic functions 
* \& operates on entire vector while \&\& operates only on first element. Similarly for \|
* Order of oeprator is \&\& and then \|\|. Expressions around \&\& get evaluated first 
* Identical needs matching of attributes also 
* _which()_ takes a logical vector and returns a vector of indices which are TRUE. OTher such functions are _any()_ and _all()_