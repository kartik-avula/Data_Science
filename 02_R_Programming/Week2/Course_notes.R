# R programming - week 2 

## Control structures 

### Use of if-then-else through an assignment (unique to R and better to read)

x <- 1

y1 <- if(x<=5) {
    "<=5"
} else {
    ">5"
}

if(x<=5) {
    y2 <- "<=5"
} else {
    y2 <- ">5"
}

#### The above 2 notations are identical 
identical(y1,y2)

#### If you want to cycle through vectors, you can use ifelse instead of if-else 
x <- 1:10
y3 <- ifelse(x<=5, "<=5",">5")

## Functions - largely straightforward 

## Scoping - Illustration of lexical scoping within global env 

free_var <- 10
lexscoping1 <- function(x) {
    free_var <- 1 
    free_var + lexscoping_tens(x)
}
lexscoping_tens <- function(x) {
    x*free_var
}

lexscoping1(3)

### Changing variable in this environment changes the function 
free_var <- 100
lexcoping1(3)

## Scoping - Illustration of lexical scoping through a constructor function which 
## returns another function 

### Defining constructor function (very similar to lexscoping 1 above)

free_var_local_env <- 1000
lexscoping_constructor <- function(x, setpoint = 0) {
    free_var_local_env <- setpoint
    lexscoping_func <- function(x) {
        free_var_global_env + x*free_var_local_env
    }
    lexscoping_func
}

### Clearing the environment for this exercise 
remove(free_var_global_env)

### Iteration 1: Running the constructor without global env. variable defined 
lexscoping_test <-  lexscoping_constructor(3, setpoint = 10)
### The returned function closure would tell R to (a) pick the global free variable 
### from .GlobalEnv and (b) set local free variable to 10 

### This will give an error because free_var_global_env is not defined 
lexscoping_test(3)

### So lets define it 
free_var_global_env <- 1

### Iteration 2: Running the constructor with global env. free variable defined 
lexscoping_test(3) # Voila it works 

### Lets change the other free variable and see what happens 
free_var_local_env <- 100

### Iteration 3: Running the constructor after changing variable which was local 
### to constructor
lexscoping_test(3) 
### voila - no change in result! Becase the local free variable is set to 10 during
### in the function closure that is assigned to lexscoping_test


### Changing global env. free variable 
free_var_global_env <- 2

### Iteration 4: Running the constructor after changing global env. free variable 
lexscoping_test(3) # Voila - you get 32
### Becase the global free variable is set to be pulled from .GlobalEnv
### in the function closure that is assigned to lexscoping_test
