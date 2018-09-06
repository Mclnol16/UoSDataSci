# here we will look at some further plotting using ggplot2

# load the libraries
library(ggplot2)
library(gapminder)

# let's create a bar plot
ggplot(data=gapminder) + geom_bar(mapping=aes(x=continent))

# sometimes it is convenient to re-orient the axes, e.g.
ggplot(data=gapminder) + geom_bar(mapping=aes(x=continent)) + coord_flip()

# here is an important observation about bar plots:
# it plots count versus continent but count is not a variable in the dataset
# so behind the scenes geom_bar is doing a computation, there are other geom functions 
# that also carry out computations behind the scenes, ggplot refers to algorithms
# that carry out these behind the scences computations as a "stat"
# so geom_bar has stat=stat_count()
# let's look at the documentation
?stat_count

# note that we can achieve the same thing as before with
ggplot(data=gapminder) + stat_count(mapping=aes(x=continent))
# this works because every geom has a default stat and every stat has a default geom
# there are reasons to use a stat explicitly for example 
# to override a default stat and look at explicit values associated to a variable

# consider this as an example
ggplot(data=gapminder) + geom_bar(mapping=aes(x=continent,y=pop),stat="identity")
# or
ggplot(data=gapminder) + geom_col(mapping=aes(x=continent,y=pop))


# what is the fundamental difference between the result of
# ggplot(data=gapminder) + geom_bar(mapping=aes(x=continent))
# and ggplot(data=gapminder) + geom_col(mapping=aes(x=continent,y=pop))?

# sometimes is can be interesting and useful to use color with bar plots
ggplot(data=gapminder) + geom_bar(mapping=aes(x=continent,color=continent))
# or 
ggplot(data=gapminder) + geom_bar(mapping=aes(x=continent,fill=continent))

# we can also add additional variables as aesthetics
ggplot(data=mpg) + geom_bar(mapping=aes(x=class,fill=as.character(cyl)))
# or 
ggplot(data=mpg) + geom_bar(mapping=aes(x=class,fill=as.character(cyl)),position="dodge")

# now let's go through the swirl lesson on matrices and data.frames
library(swirl)
swirl()

