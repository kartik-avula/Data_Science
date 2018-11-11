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