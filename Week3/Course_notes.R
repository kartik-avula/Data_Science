# R programming - week 3 

## Apply functions 

### lapply, sapply

y <- 1:10
lapply(y, function(x){x+1})

#### It is important at this stage to see the difference between 3 ways of 
#### making lists

# list - Each arg. to list() becomes 1 list element
list(1:5,list(6), "a") 
# as.list() - Each of element of vector becomes 1 element of list
as.list(1:5)  
# c() - Each element is converted to list - implicit as.list() - and 
# appended to previous
c(list(1:5, "a"), 6:10) 


### apply 
### 
### The returned vector 
my_array <- array(rnorm(600), c(2,3,10))

mean_rects12 <- apply(my_array, c(1,2), mean)
dim(mean_rects)
# 2 3

mean_rects23 <- apply(my_array, c(2,3), mean)
dim(mean_rects23)
# 3 10

mean_rects13 <- apply(my_array, c(1,3), mean)
dim(mean_rects13)
# 2 10

mean_rects3 <- apply(my_array, 3, mean)
dim(mean_rects3)
# NULL

my_mat <- matrix(rnorm(100), c(5,20))

mean_vect1 <- apply(my_mat, 1, mean)
length(mean_vect1)
# 5
dim(mean_vect1)
# NULL

mean_vect2 <- apply(my_mat, 2, mean)
length(mean_vect2)
# 20
dim(mean_vect2)
# NULL

quant_vect1 <- apply(my_mat, 1, quantile, probs=c(0.25, 0.75))
dim(quant_vect1)
# 2 5
quant_vect2 <- apply(my_mat, 2, quantile, probs=c(0.25, 0.75))
dim(quant_vect2)
# 2 20


# Refining understanding of lexical scoping in the context of "<<-" operator
# Here I define 2 levels of free variables (in globalenv, parent) and a conflict 
# with a local var to illustrate how lexical scoping operates 

# My ingoing understanding is that at the time of function definition a closure
# mapping of variables::environment (think of them as pointers) are created 
# along with their values. <<- changes the value corresponding to these 
# pointers. <- changes a local copy
# ------------------------------- CONFIRMED ------------------------------------

# Setting global free variables
global_free_name <- "global"
global_free_iteration <- 0L

# defining constructor function 
parent <- function(name1, name2) {
    parent_free_name <- "parent"
    parent_free_iteration <- 0L
    
    parent_free_name <- paste(name1,"'s parent")
    child1 <- function() {
        # Points to and changes same var for a given R session. Changes carry 
        # across multiple <parent> function calls
        global_free_iteration <<- global_free_iteration + 1    
        # Points to and changes same var for a given environment (constructor
        # function call)
        parent_free_iteration <<- parent_free_iteration + 1
        print(paste(name1, ": global name - ", global_free_name, 
                    " - parent name - ", parent_free_name) )
        print(paste(name1, ": global iter - ", global_free_iteration, 
                    " - parent iteration - ", parent_free_iteration) )
    } 
    
    parent_free_name <- paste(name2,"'s parent")
    child2 <- function() {
        # This always accesses the same variable in a single R session
        global_free_iteration <<- global_free_iteration + 1    
        # Changes only locally - think of it as a var change (not pointer)
        parent_free_iteration <- parent_free_iteration + 1

        print(paste(name2, ": global name - ", global_free_name, 
                    " - parent name - ", parent_free_name) )
        print(paste(name2, ": global iter - ", global_free_iteration, 
                    " - parent iteration - ", parent_free_iteration) )
    } 
    
    return(c(child1, child2))
}

children_1 <- parent("Jon1", "Danny1")
children_2 <- parent("Jon2", "Danny2")

Jon1 <- children_1[[1]]
Danny1 <- children_1[[2]]

Jon2 <- children_2[[1]]
Danny2 <- children_2[[2]]

Jon1()
# global = 1, parent = 1 # parent_free_iteration changes from 0 to 1
Danny1()
# global = 2, parent = 2
Jon1()
# global = 3, parent = 2 # parent_free_iteration changes from 1 to 2
Danny1()
# global = 4, parent = 3

global_free_iteration <- 10
global_free_name <- "modified_global"
Jon2()
# global = 11, parent = 1 # parent_free_iteration changes from 0 to 1 because 
# this the first time any function returned from 2nd constructor call is being 
# used  
Danny2()
# global = 12, parent = 2
Jon2()
# global = 13, parent = 2
Danny2()
# global = 14, parent = 3

# Note that this persistence occurs forever till that function object remains 
# The free variables are held in the function names
ls(environment(Jon2))
ls(environment(Danny2))
