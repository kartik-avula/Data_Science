# R programming - week 4 - markdown

## Simulation

### Overview of str

* *str* - Gives one line/simple description of any object (including functions)
* *str* stands for structure 
* gl() creates factors


### Generating random numbers
There are a number of functions for different standard probability distributions
* norm - normal 
* gamma - gamma
* pois - poisson 
* binom - binomial distribution 

Each distribution has 4 types of functions typically 
* *d*\<norm\> -  for density
* *r*\<norm\> -  for random number generation
* *p*\<norm\> -  for cumulative distribution (gives a probability)
* *q*\<norm\> -  for quantile function (inverse of p) 

Other things to remember
* Good to set seed using ```set.seed(n)``` before generating randomv variables
* This allows you to reproduce issues / bugs at least during development 
* *sample* can also be used to permute by leaving out no. of samples and replace args
* *replicate* is helpful in creating distributions with multiple random number _groups_
* *order* is a useful function for ranking 

### Simulating a linear model and sampling 
* *sample(vector to sample from,replace=FALSE)*

## Profiling 

Key principles:
* Efficacy (getting it working) and readability are the priority
* Premature optimization is the root of all evil 
* The most important step for optimizing is understanding is where the code is spending most of its time 
* You can use suppressWarnings() to avoid known warnings

### USing system.time
Profiling is a program optimization tool. Key tools are 
* *system.time(\{\<R expression\>\})* - Returns the time taken (user time, elapsed time) to execute the expression
* User time may be higher than elapsed time if you have multiple cores + use parallel programming libraries
* User time may be lesser than elapsed time if the system is busy with something else 

### Using Rprof
* Requires compiled with profiler support (usually the default)
* summaryRprof makes the output readable 
* DO NOT use Rprof and system.time() together 
* Samples the function call stack every 0.02 seconds. the Rprof output just prints out the call stack so not very useful. 
* summaryRprof can summarize time spent in each function 
    * by.total - total time when the particular function is in the call stack 
    * by.self - time spent in a given function alone (removing time spent in lower level functions)

### Looking at Data
* *object.size()* gives size of objects in memory 
* *summary* also gives number of NAs for each column of a data frame 1
* *LETTERS and letters* are pre-defined variables in R

### PLotting 
* In addition to *\?plot*, *\?\.par* and *\?points* are also very useful

