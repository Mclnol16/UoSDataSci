# make sure tidyverse and gapminder packages are installed
# if necessary, run install.packages("tidyverse") and install.packages("gapminder")

library(tidyverse)
library(gapminder)

# some R packages contain data, we can learn about this using
data()


# we will take a look at the gapminder and mpg data frames


# let's take a look at these data
head(gapminder)

head(mpg)

# what do you notice about each 

# an alternative is to use glimpse
glimpse(gapminder)

glimpse(mpg)

# we can look at subsets of a data frame
# e.g.
# a row
gapminder[1, ]

# a column 
gapminder[ ,1]
# or
gapminder$country
# although this prints out in a slightly different format

# multiple subrows and columns
gapminder[1:3,2:4]

# later we will see more sophisticated ways of doing this!

# we can even "view" the whole thing
View(gapminder)



# for numeric variables it makes sense to compute numerical summaries
gapminder$lifeExp %>% unlist() %>% mean() # mean life expectency

gapminder$lifeExp %>% unlist() %>% fivenum() # life expectency five number summary
# what is a five number summary? google if necessary

# what is wrong with the following? 
mpg$cyl %>% unlist() %>% mean()

# even though cylinder is recorded as a number it is really categorical

# how can we summarize a categorical variable? e.g. with a table
table(mpg$cyl)


# R is pretty smart, it can summarize an entire data frame
summary(gapminder)

summary(mpg) # be careful with e.g. cylinder

# for numeric variables we get a five number summary
# for categorical we get essentially a table


# since income and life expectency are numeric it makes sense to 
# create a scatter plot with each variable corresponding to an axis
# first in base R
plot(gapminder$gdpPercap,gapminder$lifeExp)
# now with ggplot
ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp)) + geom_point()

# we can add a categorical variable with e.g. color
ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp)) + geom_point(mapping = aes(color=continent))

# sometimes an additional numeric variables can be included
ggplot(data=gapminder,mapping=aes(x=gdpPercap,y=lifeExp)) + 
  geom_point(mapping = aes(color=continent,size=pop))

# what about with a categorical variable? 

# one thing is to turn a table into a bar plot
# first with base R
barplot(table(mpg$cyl))
# now with ggplot
ggplot(data=mpg,mapping = aes(x=cyl)) + geom_bar()

# notice the place for 7 becuase it thinks it is numeric
# one way to fix is to convert cyl to a character 
ggplot(data=mpg,mapping = aes(x=as.character(cyl))) + geom_bar()
