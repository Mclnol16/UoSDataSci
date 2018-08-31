# make sure tidyverse and gapminder packages are installed
# if necessary, run install.packages("tidyverse") and install.packages("gapminder")

library(tidyverse)
# if you can't get tidyverse, at least get ggplot2, dplyr, readr, tibble

# let's examine some practices for getting data into R 

# first we will load csv file after downloading it from the web
# NOTE: you have to know where you have saved the file, e.g. in Documents folder
file_name <- "~/Documents/athlete_events.csv"
# obtained from https://www.kaggle.com/heesoo37/120-years-of-olympic-history-athletes-and-results
df1a <- read.csv(file_name)
# or 
df1b <- read_csv(file_name)

# make sure we have column names
names(df1a)
names(df1b)

# now we can also read a csv file from the web
dir <- "https://raw.githubusercontent.com/fivethirtyeight/data/master/alcohol-consumption/"
web_address <- paste0(dir,"drinks.csv")
df2a <- read.csv(web_address)
# or 
df2b <- read_csv(web_address)

# make sure we have column names
names(df2a)
names(df2b)

# usually we are interested in looking at how multiple variables across a data.frame relate
# to one another, but it is also often useful to know at least something about individual variables
# let's look at an example 
library(gapminder)

# remember the gapminder data
head(gapminder)
summary(gapminder)

# looking at the summary stats for individual variables may be misleading
# and out of appropriate context, for example looking at life expectancy
# across the entire globe misses many nuances

# let's look at life expectancy across a single continent, say Africa 

# one column of 
lifeExpectancyAfrica <- gapminder %>% filter(continent == "Africa") %>% select(lifeExp) %>% unlist()
# summary stats
summary(lifeExpectancyAfrica)

# we can visualize summary stats with a boxplot
boxplot(lifeExpectancyAfrica)
# or in ggplot
ggplot(data=NULL,mapping=aes(y=lifeExpectancyAfrica)) + geom_boxplot()

# a histogram gives insight into the distribution of values for a variable
hist(lifeExpectancyAfrica)
# or in ggplot 
ggplot(data=NULL,mapping = aes(x=lifeExpectancyAfrica)) + geom_histogram()
# notice that choices are made as to where and how wide the rectangles are
# but we can specify options if we want, e.g. 
ggplot(data=NULL,mapping = aes(x=lifeExpectancyAfrica)) + geom_histogram(binwidth = 5,boundary=20)

# it is very easy to compute mean and standard deviation
mean(lifeExpectancyAfrica)
sd(lifeExpectancyAfrica)


