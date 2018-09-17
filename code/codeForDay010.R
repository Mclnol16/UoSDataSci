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

# we do have to be careful about missing values:


