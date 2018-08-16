# Jason M Graham
# 08/16/2018

# A simple look at baseball salary data

# Load library
library(tidyverse)
library(reshape2)

# Set working directory 
cwd <- setwd("~/Documents/UoSDataSci/code")

# Set data location 
dwd <- paste(cwd,"/Data/Salaries.csv",sep="")

# Load the data
salary_df <- read_csv(dwd)

# Take a look at the first few rows
head(salary_df)

# Take a look at the last few rows
tail(salary_df)

# Total size
dim(salary_df)

# Print column names
names(salary_df)

# Summary of data set
summary(salary_df)

# A table of all of the teams by ID
table(salary_df$teamID)

# We can plot this easily
barplot(table(salary_df$teamID))

# A better version with ggplot
salary_df %>% ggplot() + geom_bar(mapping = aes(x=teamID))

# Easier to see
salary_df %>% ggplot() + geom_bar(mapping = aes(x=teamID)) + coord_flip()

# Find average salary by year
avg_sal_by_year <- salary_df %>% group_by(yearID) %>% summarize(avg_sal = mean(salary))

# Let's take a look
head(avg_sal_by_year)

# We can kind of check this. For example keep only data with year 1985 and compute mean
salary_df %>% filter(yearID == 1985) %>% select(salary) %>% unlist() %>% mean()

# This agrees with what we saw in the first row for avg_sal_by_year

# Now let's plot the mean salary over time
avg_sal_by_year %>% ggplot(mapping = aes(x=yearID,y=avg_sal)) + geom_line()

# We should be careful regarding outliers so let's look at the median too
sal_stats_by_year <- salary_df %>% 
  group_by(yearID) %>% 
  summarize(avg_sal = mean(salary), med_sal = median(salary))

# We can plot both mean and median salaries over time but first we have to convert
# data to long format 
sal_stats_by_year %>% 
  melt(id="yearID") %>%
  ggplot(mapping=aes(x=yearID, y=value, colour=variable)) +
  geom_line()

# It is easy to look at the salary distributions by team 
salary_df %>% ggplot(mapping = aes(x=salary)) + geom_histogram() + facet_wrap(~ teamID)




