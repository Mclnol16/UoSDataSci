# start with going through first section of R Programming swirl course
library(swirl)
swirl()

# starting to learn plotting with ggplot2
library(ggplot2)
library(dplyr)
library(gapminder)

# creating a ggplot
# e.g.
ggplot(data=gapminder) + 
  geom_point(mapping=aes(x=gdpPercap,y=lifeExp))
# or equivalently
ggplot(data=gapminder,mapping = aes(x=gdpPercap,y=lifeExp)) + 
  geom_point()

# the function ggplot creates a coordinate system
# the geom_point function adds a specific geometric 
# feature to the coordinate system that is related to the data

# most basic uses of ggplot start out following the basic template:
# ggplot(data=<DATA>) + <GEOM_FUNCTION>(mapping=aes(<MAPPING>))

# there are other geom functions besides geom_point
# e.g.
x <- seq(-1,1,by=0.01)
y <- x^2
ggplot(data=NULL) + geom_line(mapping=aes(x=x,y=y))
# or 
ggplot(data=NULL) + geom_path(mapping=aes(x=x,y=y))

# consider this
t <- seq(0,2*pi,by=0.01)
x <- cos(t)
y <- sin(t)
ggplot(data=NULL) + geom_line(mapping=aes(x=x,y=y))
# that looks weird, why? 
# but now if we do this
ggplot(data=NULL) + geom_path(mapping=aes(x=x,y=y))
# or to make it square
ggplot(data=NULL) + geom_path(mapping=aes(x=x,y=y)) + 
  coord_fixed()

# adding aesthetics
gapminder_1992 <- filter(gapminder,year == 1992) # this uses a function from dplyr to be explained later
ggplot(data=gapminder_1992) + geom_point(mapping=aes(x=gdpPercap,y=lifeExp,color=continent,size=pop))

# we can change the scale of an axis, e.g.
ggplot(data=gapminder_1992) + 
  geom_point(mapping=aes(x=log10(gdpPercap),y=lifeExp,color=continent,size=pop)) 

# other aesthetics are possible, e.g. shape
ggplot(data=gapminder_1992) + geom_point(mapping=aes(x=gdpPercap,y=lifeExp,shape=continent,size=pop))

# one thing that can be particularly useful is facets
ggplot(data=gapminder_1992) + geom_point(mapping=aes(x=gdpPercap,y=lifeExp,size=pop)) + 
  facet_wrap(~continent)
# or with x as log scale
ggplot(data=gapminder_1992) + geom_point(mapping=aes(x=log10(gdpPercap),y=lifeExp,size=pop)) + 
  facet_wrap(~continent)

# some exercises:
# 1) Use the mpg dataset to map a continuous variable to color, size, and shape. How do these
# aesthetics behave differently for categorical versus continuous variables? 

# 2) What does the stroke aesthetic do? 

# 3) What happens if you facet on a continuous variable? 

# 4) Consider the diamonds dataset from ggplot2 package. What are the variables for this data? 

# 5) Use ggplot to see the relationship between the carat and the price of diamonds. 

# 6) What additional insight or information is obtained if you again plot the relationship
# between carat and price but now distinguish by cut as a category as well? What if you use clarity instead 
# of cut? 



