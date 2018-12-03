##############
# 11 월 15 일
##############

library(tidyverse)
library(nycflights13)

ls(pos = 2)

airlines   # 항공사에 대한 정보
airports
planes
weather

airlines %>% count(carrier)    # 항공사 수 찾기 
airlines %>% count(carrier) %>% filter(n > 1)   # primary key 
# 각각의 obs 별로 다른 값을 가지는 변수 

airports %>% count(faa) %>% filter(n > 1)       # primary key
planes %>% count(tailnum) %>% filter(n > 1)     # primary key

weather %>% count(year, month, day, hour) %>% filter(n > 1)
weather %>% count(year, month, day, hour, origin) %>% filter(n > 1)
weather %>% filter(year == 2013, month == 11, day == 3)
weather %>% filter(year == 2013, month == 11, day == 3, origin == "EWR")  # Foreign Key

flights %>% count(year, month, day, flight) %>% filter(n > 1)
flights %>% count(year, month, day, tailnum) %>% filter(n > 1)

flights2 <- flights %>% select(year:day, hour, origin, dest, tailnum, carrier)
flights2
flights2 %>% left_join(airlines, by="carrier")
flights2 %>% mutate(name = airlines$name[match(carrier, airlines$carrier)])



# Mutating joins
# 두 테이블을 이용하여 변수를 합성하는 방법
# 먼저 key 를 이용하여 observation을 맞추고 한 table 에서 다른 table 로 변수를 copy
# mutate 함수와 같이 join 함수는 변수를 오른 쪽에 추가. 새로운 변수는 인쇄되지 않음
x <- tribble(~key, ~val_x, 
             1, "x1",
             2, "x2",
             3, "x3")
x

y <- tribble(~key, ~val_y, 
             1, "y1",
             2, "y2",
             3, "y3")
y

left_join(x, y)
left_join(x, y, by = "key")

inner_join(x, y)
full_join(x, y)

x  <- tribble(~key, ~val_x,
              1, "x1",
              2, "x2")
x

x <- tribble(~key, ~val_x,
             1, "x1",
             2, "x2",
             3, "x3",
             1, "x4")
y <- tribble(~key, ~val_y,
             1, "y1",
             2, "y2")
x
y

left_join(x, y)
left_join(y, x)


x <- tribble(~key, ~val_x,
             1, "x1",
             2, "x2",
             2, "x3",
             3, "x4")
y <- tribble(~key, ~val_y,
             1, "y1",
             2, "y2",
             3, "y3",
             4, "y4")
left_join(x, y)



