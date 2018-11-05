##############
#lec 1105
#
##############
library(tidyverse)
library(nycflights13)
setwd("C:/Users/HS/Documents/GitHub/Statistical-Graphics-with-Big-Data")


df <- tibble(A = rep(LETTERS[1:3], each = 4),
             B = rpois(12,10))
df
df %>% mutate(prop_B = B/sum(B), sum_B = sum(B))
df %>% group_by(A) %>% mutate(prop_B = B/sum(B), sum_B = sum(B))

popular_dests <- flights %>% group_by(dest) %>% filter(n()>365)
popular_dests %>% filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay/sum(arr_delay),
         sum_delay = sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay, sum_delay) 
  #arr_delay 별로 sum_delay 같다


heights <- read_csv("data/heights.csv")  #맨 첫번째 줄을 변수명으로 받는다 
heights2 <- read_csv("data/heights.csv", skip = 3)  #3번 째 줄을 변수명으로 받는다

read_csv("The first line of metadata
 The second line of metadata
         x,y,z
         1,2,3", skip = 2)

read_csv("# A comment I want to skip
         x,y,z
         1,2,3", comment = "#")

#자료 전처리나 이상치 전처리 할때 유용한 옵션들

heights <- read_csv("data/heights.csv", col_names = FALSE)
heights  #컬럼 이름을 지정하지 않았음 제일 첫줄 보고 변수타입 자동으로 지정해줌
heights <- read_csv("data/heights.csv", col_names = paste0("A",1:6))
heights2 <- read_csv("data/heights-1.csv", na = ".")  #제대로 integer 로 넣기
heights2

x <- parse_integer(c("123","345","abc","123.45"))  
#Warning: 2 parsing failures. 두개의 parsing 실패 
x

charToRaw()



#시간은 
