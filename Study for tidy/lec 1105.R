################
# 11 월 5 일
################

library(tidyverse)
library(nycflights13)


df <- tibble(A = rep(LETTERS[1:3], each = 4),
             B = rpois(12, 10))
df
df %>% mutate(prop_B = B / sum(B), 
              sum_B = sum(B))
popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n()>365)

popular_dests %>% filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay),
         sum_delay = sum(arr_delay)) %>% 
  select(year:day, arr_delay, prop_delay, sum_delay)

popular_dests %>% filter(arr_delay > 0 ) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay),
         sum_delay = sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay, sum_delay)
setwd("C:/Users/HS/Documents/GitHub/Statistical-Graphics-with-Big-Data/data")
heights <- read_csv("heights.csv")
heights

heights1 <- read.csv("heights.csv")
heights2 <- read.csv("heights.csv", skip = 3)
head(heights2)
heights <- read_csv("heights.csv", col_names = FALSE)
heights

class(heights1)
class(heights)

heights <- read_csv("heights.csv", col_names = paste("A",1:6))
heights


heights2 <- read_csv("heights-1.csv", na=".")
heights2


x <- parse_integer(c("123", "345", "abc", "123.45"))
x
problems(x)
problems(heights)

challenges <- read_csv(readr_example("challenge.csv"))
problems(challenges)
challenges[999:1002,]
challenge <- read_csv(readr_example("challenge.csv"),
                      col_types = cols(x = col_double(),
                                       y = col_date()))
challenge[999:1002,]
challenge <- read_csv(readr_example("challenge.csv"))
problems(challenge)
