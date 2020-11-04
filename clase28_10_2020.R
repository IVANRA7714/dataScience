library(tidyverse)
library(nycflights13)

str(iris)

tiris <- as_tibble(iris)

select(flights, year, month, day)
names(flights)

str(mtcars)
filter(mtcars, cyl == 8)

filter(mtcars, cyl == 4)

flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time) %>%
              mutate(gain = arr_delay - dep_delay,
                     speed = distance / air_time * 60) %>%
              select(-(year:air_time))

library(plyr) 

baseball <- as_tibble(baseball)
detach(package:plyr)
library(dplyr)
str(baseball)
summary(baseball$year)

summarise(baseball,duration = max(year) - min(year), nteams = length(unique(team)))

by_player <- group_by(baseball, id)
summarise(group_by(baseball, id), mean_hits = mean(h, na.rm = TRUE))

by_player_year <- group_by(baseball, id, year)
summarise(by_player_year, mean_hits = mean(h, na.rm = TRUE))

by_player_year_team <- group_by(baseball, id, year, team)
summarise(by_player_year_team, mean_hits = mean(h, na.rm = TRUE))


adult <- read.csv("C:/Users/IVAN/Desktop/adult.data")


