# JHU Data Science - Course 03 - Getting and Cleaning Data - General

## Thoughts and musings 
At end of course lectures I am still not fully comfortable with a few topics although
I am by and large ok with the dplyr commands.
* Tables, cross-tabulations and interactions 
* Melt, dcast, ddply and cut - DONE
* Working with dates - DONE 
* Tidy data theory (read dplyr vignette) - DONE
* Data resources - create a list of data resources 
* APIs (rather than downloads)

This document tries to address data resources.  

## Reshape 
* Melt converts from wide to long format (i.e. takes n columns and converts them into a long format which has nX previous number of rows. You need to specify id variables which should not be melted
* (d)cast converts from long to wide format 
* 

## Data resources 

## Tidy data must reads 
* [Tidy Data Philosophy](http://vita.had.co.nz/papers/tidy-data.pdf)
* [Lubridate paper](https://www.jstatsoft.org/article/view/v040i03/v40i03.pdf)

## Tidy data principles 
* Condition for tidy data
    1. Each variable forms a column
    2. Each observation forms a row
    3. Each type of observational unit forms a table
* Symptoms of messy data 
    1. Column headers are values, not variable names e.g., _male, female_
    2. Variables are stored in both rows and columns e.g., alternating rows of _midterms, finals_
    3. A single observational unit is stored in multiple tables e.g., variables like __class\_1__
    4. Multiple types of observational units are stored in the same table e.g., (sex, id) and (course, grade) are all in same table. This causes repetition/ Only index should get repeated
    5. Multiple variables are stored in one column e.g., separate tables for pass, fail 
* 
