# JHU Data Science - Course 03 - Getting and Cleaning Data - Week 4

## Importing data to play around with 

## Editing text variables  
tolower
strsplit
# Combine strsplit with sapply to remove .s
sub("_","",names(data)) # replaces first underscore in each name 
gsub("_","",names(data)) # replaces all underscores in each name 

# For everything below i
grep("search string", vector) # This acts like which("search string" in vector)
grep("search string", vector, value=TRUE) # This acts like vector(which("search string" in vector))
grepl("search string", vector) # This acts like ("search string" in vector)

# Length with grep is a good way to check that the string does not appearn 

str_trim #in stringr 