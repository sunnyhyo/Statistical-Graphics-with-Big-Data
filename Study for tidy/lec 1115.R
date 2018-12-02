##############
# 11 월 15 일
##############

library(tidyverse)
library(nycflights13)

ls(pos = 2)

airlines
airports
planes
weather

airlines %>% count(carrier)
airlines %>% count(carrier) %>% filter(n > 1)
airports %>% count(faa) %>% filter(n > 1)
planes %>% count(tailnum) %>% filter(n > 1)
weather %>% count(year, month, day, hour) %>% filter(n > 1)
weather %>% count(year, month, day, hour, origin) %>% filter(n > 1)
weather %>% filter(year == 2013, month == 11, day == 3)
weather %>% filter(year == 2013, month == 11, day == 3, origin == "EWR")

flights %>% count(year, month, day, flight) %>% filter(n > 1)
flights %>% count(year, month, day, tailnum) %>% filter(n > 1)

flights2 <- flights %>% select(year:day, hour, origin, dest, tailnum, carrier)
flights2
flights2 %>% left_join(airlines, by="carrier")
flights2 %>% mutate(name = airlines$name[match(carrier, airlines$carrier)])

x <- tribble(~key, ~val_x, 
             1, "x1",
             2, "x2",
             3, "x3")
x
