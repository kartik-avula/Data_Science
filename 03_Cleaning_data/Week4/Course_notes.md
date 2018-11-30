# JHU Data Science - Course 03 - Getting and Cleaning Data - Week 4

## Editing text variables  
Good practice in variable names 
* All lower case if possible 
* Descriptive (Diagnosos vs Dx)
* Not duplicated 
* Not have underscores or dots or whitespace 
* <My own> should not be too long (for readability of console output)

Variable with character values 
* Should try to be made into factor variables 
* The levels should be descriptive e.g., Male/Female instead of 0/1

* simple functions are ```tolower, strsplit```
* Combine strsplit with sapply to remove .s
sub("_","",names(data)) # replaces first underscore in each name 
gsub("_","",names(data)) # replaces all underscores in each name 

# For everything below i
grep("search string", vector) # This acts like which("search string" in vector)
grep("search string", vector, value=TRUE) # This acts like vector(which("search string" in vector))
grepl("search string", vector) # This acts like ("search string" in vector)

# Length with grep is a good way to check that the string does not appearn 

str_trim #in stringr 

## Can you write a function that scrubs variable names ?? Check in the janitor package  

## Reg expressions
* **\^** - Beginning of line
* **\$** - End of line
* **\[\]** - Alternatives e.g. ```[Bb][Uu][Ss][Hh]```
* **[0-9][a-zA-z]** - Ranges also work
* **[^?.]$** - This is searches for lines NOT ending in period or question mark. Note that the caret is a negation when used inside square brackets 
* **\.** - Outside square brackets the period corresponds to any 1 character
* **\|** - Alternatives e.g., flood|fire . Multiple alternatives allowed 
* The two sides of the pipe operator are evaluated first. e.g. **^Good|Bad** searches for Good at the beginning of the line OR Bad anywhere in the line 
* **\?** - makes the preceding character or expression in parenthesis is optional 
* **\*** - repeated at least once or more (always matches longest possible string). **\+** is repeated at least once or more 
* **\{m\,n\}** Cutly brackets with 2 numbers indicate the number of repetitions allowed
* **\\\1** searches for the same thing that got matches with the regular brackets 

[Good Summary Here](http://astrostatistics.psu.edu/su07/R/html/base/html/regex.html)

## Working with dates
* **today()** gives todays date and **now()** current time 
* Other useful basic date function functions are **year, month, day, wday** 
* Other useful basic time function functions are **hour, minute, second** 
* Parsing real world data and time notations is a big PITA. Functions like **ymd, dmy, hms, ymd_hms** can parse them 
* POSIXlt stores as a list
* **update** command allows you to update/set one or more components of date-time 
* Addition can be done after conversion e.g., ```new_time <- old_time + days(2) + hours(5)```
* **with_tz** changes timezone 
* There are 4 classses of time related objects - instants, intervals, durations, periods 
* **interval** creates an interval type of time 