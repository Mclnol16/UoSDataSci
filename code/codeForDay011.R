library(nycflights13)
library(tidyverse)
# tidyverse contains dplyr which is what we will mainly use

# previously, we used the mlb baseball player data available at
# https://raw.githubusercontent.com/jmgraham30/UoSDataSci/master/code/mlb_data.csv
# to look at how the physical fitness of players varies with aging. 

# we used the following function to compute the bmi for each of the players:
my_bmi <- function(mass,height){
  return(mass/height^2)
}

# one thing that would be nice is to add the bmi to the mlb_data data frame
# the mutate function in the pplyr package will allow us to easily do this. 
# first e gain some experience using the mutate function. 
# begin with documentation 
?mutate

# Besides selecting sets of existing columns, it’s often useful to 
# add new columns that are functions of existing columns. That’s the job of mutate().

# here is an example use:
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)

mutate(flights_sml,
       gain = dep_delay - arr_delay,
       speed = distance / air_time * 60
)

# Note that you can refer to columns that you’ve just created:
mutate(flights_sml,
       gain = dep_delay - arr_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)

# If you only want to keep the new variables, use transmute():
transmute(flights,
          gain = dep_delay - arr_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)


# let's apply mutate to the mlb_data data set:
# load the data
df <- read.csv("https://raw.githubusercontent.com/jmgraham30/UoSDataSci/master/code/mlb_data.csv")

head(df)

df_bmi <- df %>% mutate(BMI = my_bmi(Weight,Height))

head(df_bmi)

# now we can easily plot BMI versus age:
df_bmi %>% ggplot(mapping = aes(x=Age,y=BMI)) + geom_point()

# notice that the way we used mutate to create the new variable BMI was by applying a function to 
# existing variables in the data frame. This is a very common task and any vectroized function can 
# be used in a way similar to how we used my_bmi

# here is a one variable data frame containing time values:
time_df <- data.frame(time=seq(0,10,by=0.01))

# add corresponding speed and position variables determined by the functions
position_func <- function(t){
  return(-0.9*t^2 + 2*t + 8)
}

speed_func <- function(t){
  return(-0.9*2*t + 2)
}


motion_df <- time_df %>% mutate(position=position_func(time),speed=speed_func(time))

head(motion_df)

# lets use the resulting data frame to plot both speed and position both as a function of time
motion_df %>% ggplot() + geom_line(mapping = aes(x=time,y=position))
motion_df %>% ggplot() + geom_line(mapping = aes(x=time,y=speed))

# now watch this:
library(gridExtra)
p1 <- motion_df %>% ggplot() + geom_line(mapping = aes(x=time,y=position))
p2 <- motion_df %>% ggplot() + geom_line(mapping = aes(x=time,y=speed))
grid.arrange(p1,p2,nrow=1)


