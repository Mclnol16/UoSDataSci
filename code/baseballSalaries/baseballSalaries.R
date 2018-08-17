# Jason M Graham
# 08/16/2018

# A simple look at baseball salary data

# Load library
library(tidyverse)
library(reshape2)

# Load the data
salary_df <- read_csv("Data/Salaries.csv")

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


# Let's write a function that plots the salary distribution for input year and team
team_year_sal <- function(yearID_val,teamID_val){
  salary_df %>% filter(teamID==teamID_val,yearID == yearID_val) %>%
    ggplot(mapping = aes(x=salary)) + 
    geom_histogram() + 
    ggtitle(paste(as.character(yearID_val),teamID_val,sep=" "))
}

# Example using the function
team_year_sal(2014,"TEX")

# Let's do something similar but produce a boxplot instead
team_year_sal_box <- function(yearID_val,teamID_val){
  salary_df %>% filter(teamID==teamID_val,yearID == yearID_val) %>%
    ggplot(mapping = aes(y=salary)) + 
    geom_boxplot() + 
    ggtitle(paste(as.character(yearID_val),teamID_val,sep=" "))
}

# Example using the function
team_year_sal_box(2014,"TEX")

# Perhaps we can see the boxplots across all teams for a given year
year_sal_box <- function(yearID_val){
  salary_df %>% filter(yearID == yearID_val) %>%
    ggplot(mapping = aes(x=teamID,y=salary)) + 
    geom_boxplot() + 
    coord_flip() + 
    ggtitle(as.character(yearID_val))
}

# Example using the function 
year_sal_box(2014)

# Let's find the total salary amount per team per year
tot_sal <- salary_df %>% group_by(yearID,teamID) %>% summarise(total_salary=sum(salary))

# Take a look at result
head(tot_sal)

# Let's determine for each year which team spent the most:
# First we find the max total salaries by year
tot_max <- tot_sal %>% group_by(yearID) %>% summarise(max_sal=max(total_salary))
# Then convert the max total salary values into a vector
max_vals <- tot_max$max_sal %>% unlist()
# Then pull out the rows where the max total salaries occur
high_price_teams <- tot_sal %>% filter(total_salary %in% max_vals)

# Let's look
head(high_price_teams)

# There's only 30 rows and 3 columns so we can look at the entire result
View(high_price_teams)

# Let's plot the maximum total salaries over time
high_price_teams %>% 
  ggplot() + 
  geom_point(mapping = aes(x=yearID,y=total_salary,color=teamID)) 

# It could be useful to fit a curve through the data 
high_price_teams %>% 
  ggplot() + 
  geom_point(mapping = aes(x=yearID,y=total_salary,color=teamID)) + 
  geom_smooth(mapping = aes(y=total_salary, x=yearID))

# It would be interesting to know the playoff and world series results for these
# high salary teams. 

