# Here we explore writing functions in R

# a very simple example:
# no input simply performs a task
hello_world <- function(){
  print("Hello, World!")
}

# with an argument:
hello_name <- function(name){
  print(sprintf("Hello %s",name))
}

# by default, functions return the value of the last line of code
# e.g.
complex_computation <- function(x){
  a <- 1
  b <- -2
  c <- 10
  y <- a*x
  y <- y*x
  y <- y + b*x
  y + c
}

# call the function
complex_computation(2) # prints an output

# what if we make the following change
complex_computation <- function(x){
  a <- 1
  b <- -2
  c <- 10
  y <- a*x
  y <- y*x
  y <- y + b*x
  y <- y + c
}

# call the function
complex_computation(2) # does not print an output
# but can make an assignment
y <- complex_computation(2)
print(y)

# remove the variable y from workspace
rm(y)

# an easier way is
complex_computation <- function(x){
  a <- 1
  b <- -2
  c <- 10
  y <- a*x^2 + b*x + c
  return(y)
}

# note the role of variables defined inside a function
complex_computation(3)

# note that we can evaluate this function at a vector
complex_computation(c(1,2,3))

# using default arguments
complex_computation <- function(x=0){
  a <- 1
  b <- -2
  c <- 10
  y <- a*x^2 + b*x + c
  return(y)
}

# call with no argument
complex_computation()

# now again with an argument
complex_computation(12)

# can have multiple arguments
complex_computation <- function(x,a,b,c){
  y <- a*x^2 + b*x + c
  return(y)
}

# call function 
complex_computation(2,1,0,0)


# default arguments are particularly helpful when you have parameters
complex_computation <- function(x,a=1,b=0,c=0){
  y <- a*x^2 + b*x + c
  return(y)
}

# example calls to the function 
complex_computation(0)
complex_computation(0,c=1)
complex_computation(0,1) # what is the difference? 
# here is an application
x <- seq(-2,3,by=0.01)
y <- complex_computation(x,a=-1,b=2,c=-3)
library(ggplot2)
ggplot(data=NULL,mapping=aes(x=x,y=y)) + geom_line()


# as an application of functions let's look at scores and rankings
# for example consider BMI = mass(kg)/height(m)^2
my_bmi <- function(mass,height){
  return(mass/height^2)
}

# to test this, we can simluate some data
height <- rnorm(1,1.74,0.18)
mass <- rnorm(1,60.2,12)
# then call the function
my_bmi(mass,height)
# what the heck is this rnorm thing? 
# use ?rnorm to find out

# here is a data frame of simluated data
mass_height_df <- data.frame(mass=rnorm(150,60.2,12),height=rnorm(150,1.74,0.18))

# then can use the function as
df_bmi <- my_bmi(mass_height_df$mass,mass_height_df$height)
# can compute the mean of this
mean(df_bmi)

# or can use some real data


# what we will see later is that it is very easy to apply a function
# like this to every row of a data frame and then record the result as a new column



