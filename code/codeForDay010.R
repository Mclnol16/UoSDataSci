library(nycflights13)
library(tidyverse)
# tidyverse contains dplyr  which is what we will mainly use

# there are several ``verbs'' for manipulting data:
# select - Pick variables (columns) by their names
# filter - Pick observations (rows) by their values
# arrange - Reorder the rows
# summarize - Collapse many values down to a single summary
# rename - Renames variables
# mutate - Create new variables with functions of existing variables
# the dplyr package contains functions that correspond to these verbs

# the flights dataset from the nycflights13 package is great for illustrating 
# the use of dplyr

# first let's look at the flights data
head(flights)

# notive that the variable time_hour has class dttm - date-time

# filter() will allow us to select only certain ROWS 
# show diagram of using filter

# here is an example use
filter(flights, month == 1, day == 1)
# takes only 842 rows out of 336,776
# notice that this does not change the original dataset but
# we could have assigned this to a new variable
jan1 <- filter(flights, month == 1, day == 1)

# To use filtering effectively, you have to know how to select the observations 
# that you want using the comparison operators. R provides the standard suite: 
# >, >=, <, <=, != (not equal), and == (equal).
# There are also logical (Boolean) operators:
# & is “and”, | is “or”, and ! is “not”.

# example
nov_dec <- filter(flights, month == 11 | month == 12)

# A useful short-hand for this problem is x %in% y. This will select every row where x is one of the values in y. 
# We could use it to rewrite the code above:
nov_dec2 <- filter(flights, month %in% c(11, 12))
# we can check that these are the same:
identical(nov_dec,nov_dec2)

# we do have to be careful about missing values 
# because almost any operation involving an unknown value will also be unknown
# for example
2 == NA
# produces NA
# a better way is to use the is.na function
x <- NA
is.na(2)
is.na(x)

# now consider this example
df <- tibble(x = c(1, NA, 3))
filter(df, x > 1) # will not keep row with NA
# but this will
filter(df, is.na(x) | x > 1)


# one very clever aspect to dplyr is the pipe operator
# for example, suppose we want to plot the number of different
# carriers with flights on Jan 1 2013
ggplot(data=filter(flights,month==1,day==1),mapping = aes(x=carrier)) + geom_bar()
# alternatively
flights %>% filter(month==1,day==1) %>% ggplot(mapping = aes(x=carrier)) + geom_bar()
# the pipe %>% chains together multiple functions

# arrange() works similarly to filter() except that instead of selecting rows, 
# it changes their order.
head(diamonds)

arrange(diamonds,carat)
# or 
diamonds %>% arrange(carat)

# we can do it in descending order
diamonds %>% arrange(desc(carat))
# or order according to more than one variable
diamonds %>% arrange(carat,table)

# Missing values are always sorted at the end:
df <- tibble(x = c(5, 2, NA))
arrange(df, x)

# while filter subsets by rows, select subsets by column
# for example
head(diamonds)

diamonds %>% select(carat,price)
# alternatively
diamonds %>% select(c(carat,price))

# you can select a range of columns
diamonds %>% select(color:price)

# or leave out a column
diamonds %>% select(-table)

# notice that none of the dplyr functions change the original data frame

# notice that select places columns in the order they are given:
diamonds %>% select(table, carat, price)
# versus
diamonds %>% select(price, table, carat)

# an application of select is if you want to place certain variables in the first few columns
flights %>% select(distance, air_time, everything())

# there are some clever helper functions that can be used with select:
diamonds %>% select(starts_with('c'))

diamonds %>% select(ends_with('e'))

diamonds %>% select(contains('l'))


