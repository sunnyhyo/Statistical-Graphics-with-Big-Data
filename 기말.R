library(tidyverse)
library(nycflights13)
library(ggplot2)
table1
table2
table3
table4a
table4b

?cut_width
?rep
table2 %>% spread(key = type, value = count)

table3 %>% separate(rate, into = c("cases", "population"))
table3 %>% separate(rate, into = c("cases", "population"), convert = TRUE)
table4a %>% gather(`1999`, `2000`, key = "year", value = "cases")
table4a %>% gather(`1999`, `2000`, key = "year", value = "cases", convert = TRUE)
table4b %>% gather(`1999`, `2000`, key = "year", value = "pop", convert = TRUE)  # 열 이름은 chr 처리된다

t4a <- table4a %>% rename(first = `1999`,
                          second = `2000`)
t4a %>% gather(first, second, key = "year", value = "cases")

table2 %>% spread(key = type, value = count)
table2 %>% spread(key = year, value = count)

stocks
stocks %>% spread(key = half, value = return)
stocks %>% spread(key = year, value = return)

stocks %>% spread(key = half, value = return) %>% 
  gather(`1`, `2`, key = "HALF", value = "RETURN")
stocks %>% spread(key = half, value = return) %>% 
  gather(`1`, `2`, key = "HALF", value = "RETURN", convert = TRUE)

table1[,1:3] %>% spread(key = year, value = cases) %>% 
  gather(`1999`, `2000`, key = "YEAR", value = "COUNT")
table1[,1:3] %>% spread(key = year, value = cases) %>% 
  gather(`1999`, `2000`, key = "YEAR", value = "COUNT", convert = TRUE)

stock1 <- tibble(year = rep(c(2015, 2016), c(4,3)),
                 qtr = c(1:4, 2:4),
                 return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66))
stock1
stock1 %>% spread(key = year, value = return)
stock1 %>% spread(key = year, value = return) %>% 
  gather(`2015`, `2016`, key = "YEAR", value = "RETURN")
stock1 %>% spread(key = year, value = return) %>% 
  gather(`2015`, `2016`, key = "YEAR", value = "RETURN", convert = TRUE)

stock1 %>% spread(key = year, value = qtr)
stock1 %>% spread(key = qtr, value = return)
stock1 %>% spread(key = qtr, value = return) %>% 
  gather(`1`, `2`, `3`, `4`, key = "QTR", value = "RETURN")
stock1 %>% spread(key = qtr, value = return) %>% 
  gather(`1`, `2`, `3`, `4`, key = "QTR", value = "RETURN", convert = TRUE)
stock1 %>% complete(year, qtr)

table3 %>% separate(rate, into = c("cases", "population"))
table3 %>% separate(rate, into = c("cases", "population"), sep = "/")
table3 %>% separate(rate, into = c("cases", "population"), sep = "/", convert = TRUE)



who %>% gather(new_sp_m014:newrel_f65, key = "KEY", value = "cases") %>% 
  filter(!is.na(cases)) %>% 
  mutate(KEY = str_replace(KEY, "newrel", "new_rel")) %>% 
  separate(KEY, into = c("new", "type", "sexage"), sep = "_") %>% 
  separate(sexage, into= c("sex", "age"), sep = 1) %>% 
  mutate(age = str_replace(age, "65", "6500")) %>% 
  separate(age, into = c("ageL", "ageU"), sep = -2, convert = TRUE) %>% 
  mutate(age = (ageL+ageU)/2) %>% select(-iso2, -iso3, -new)

who %>% gather(new_sp_m014:newrel_f65, key = "KEY", value = "cases") %>% count(cases) %>% arrange((cases)) %>% tail()
who %>% gather(new_sp_m014:newrel_f65, key = "KEY", value = "cases") %>% 
  filter(!is.na(cases)) %>% 
  mutate(KEY = str_replace(KEY, "newrel", "new_rel"),
         KEY = str_replace(KEY, "65", "6580")) %>%
  separate(KEY, into = c("new", "type", "sexage"), sep = "_") %>% 
  separate(sexage, into = c("sex", "age"), sep = 1) %>%   # 여기서 convert 하면 00 처리문제
  separate(age, into = c("ageL", "ageU"), sep = -2, convert = TRUE) %>%
  mutate(age = (ageL+ageU)/2) %>% 
  select(-iso2, -iso3, -new)


x <- tibble(key = c(1,2,3,4),
            val_x = c("x1","x2","x3","x4"))
y <- tibble(key = c(1,2,4,5),
            val_y = c("y1","y2","y3","y4"))
x
y
right_join(x, y)
left_join(x, y)
inner_join(x, y)
full_join(x, y)
semi_join(x, y)
anti_join(x,y)

x<-c(1,2,3,4,5)
y<-c(2,3,4,6)
intersect(x,y)
union(x,y)
setdiff(x,y)


x <- tibble(key = c(1,2,2,3,4,5),
            val_x = c("x1","x2","x3","x4","x5","x6"))
y <- tibble(key = c(1,2,2,3,6,7),
            val_y = c("y1","y2","y3","y4","y5","y6"))
x
y
left_join(x, y)
right_join(x, y)
full_join(x, y)
inner_join(x, y)
semi_join(x, y)
anti_join(x,y)

table2


x<- tribble(
  ~v1, ~v2, ~v3,
  1, 2, 6,
  1, 2, 7,
  2, 3, 8,
  3, 1, 9,
  4, 5, NA
)


sum(x, na.rm = TRUE)
mean(x$value, na.rm = TRUE)
range(x, na.rm = TRUE)
x %>% count(v1)
x %>% count(v1, wt = v2)
x %>% count(v1, wt = v3)
x %>% count(v2)
x %>% count(v2, wt = v1)
x %>% count(v2, wt = v3)
x %>% count(v3)
x %>% count(v3, wt = v1)
x %>% count(v3, wt = v2)
x %>% count(v3, na.rm = TRUE)
x %>% count(v3, wt = v1, na.rm = TRUE)
x %>% count(v3, wt = v2, na.rm = TRUE)

not_cancelled <- flights %>% filter(!is.na(dep_delay), !is.na(arr_delay)) 
not_cancelled %>% group_by(dest) %>% summarise(n= n())
not_cancelled %>% count(dest)
as.data.frame(table(not_cancelled$dest))

not_cancelled %>% group_by(dest) %>% summarise(n= n(), sum = sum(dep_delay))
not_cancelled %>% count(dest, wt = dep_delay)
as.data.frame(table(not_cancelled$dest))

not_cancelled %>% count(tail_num, wt= distance) %>% 
  left_join(
    not_cancelled %>% group_by(tail_num) %>% summarise(sum = sum(distance))
            )
not_cancelled %>% group_by(dest) %>% 
  summarise(carriers = n_distinct(carrier))
not_cancelled %>% group_by(carrier) %>% 
  summarise(tail_num = n_distinct(tail_num))



# cancelled flights 와 non-cancelled flights 의 scheduled departure time 을 비교하려고
# 한다. scheduled departure time 을 시각화하여 비교하고 차이를 기술하시오.
flights %>% mutate(status = ifelse(is.na(arr_time), "cancelled", "non-cancelled")) %>% 
  ggplot(aes(sched_dep_time, color = status)) + geom_freqpoly()
flights %>% mutate(status = ifelse(is.na(arr_time), "cancelled", "non-cancelled")) %>% 
  ggplot(aes(sched_dep_time)) + geom_bar(stat = "density")+ facet_wrap(~status)
flights %>% mutate(status = ifelse(is.na(arr_time), "cancelled", "non-cancelled")) %>% 
  ggplot(aes(sched_dep_time)) + geom_density(aes(color = status))
# cancelled flights 수와 non-cancelled flights 의 수를 월별로 구하여 시각화한 후
# 비교하시오. 특별한 점이 발견되는가?
flights %>% mutate(status = ifelse(is.na(arr_time), "cancelled", "non-cancelled")) %>% 
  group_by(month) %>% count(status) %>% 
  ggplot(aes(month, n, fill = status)) + geom_bar(stat= "identity", position = "fill")
flights %>% mutate(status = ifelse(is.na(arr_time), "cancelled", "non-cancelled")) %>% 
  group_by(month) %>% count(status) %>% 
  ggplot(aes(month, n, color = status)) + geom_freqpoly(stat = "identity")
flights %>% mutate(status = ifelse(is.na(arr_time), "cancelled", "non-cancelled")) %>% 
  group_by(month) %>% count(status) %>% 
  ggplot(aes(month, n)) + geom_bar(stat = "identity") + facet_wrap(~status, scale = "free_y")
#   cancelled flights 수와 non-cancelled flights 의 수를 날짜 별로 구하여 시각화한 후
# 비교하시오. 특별한 점이 발견되는가?
flights %>% mutate(status = ifelse(is.na(arr_time), "cancelled", "non-cancelled")) %>% 
  group_by(day, status) %>% summarise(n = n()) %>% 
  ggplot(aes(day, n)) + geom_line(aes(color = status))
flights %>% mutate(status = ifelse(is.na(arr_time), "cancelled", "non-cancelled")) %>% 
  group_by(day, status) %>% summarise(n = n()) %>% 
  ggplot(aes(day, n)) + geom_bar(stat = "identity") + facet_wrap(~status, scale = "free_y")
flights %>% mutate(status = ifelse(is.na(arr_delay), "cancelled", "non-cancelles")) %>% 
  group_by(day, status) %>% count(status) %>% 
  ggplot(aes(day, n, fill = status)) + geom_bar(stat = "identity", position = "dodge")+ 
  facet_wrap(~status, scale = "free_y")
#   특정 비행기에 대하여 cancel 이 자주 있는지를 알아보려고 한다. 이를 위한 자료를
# 추출하고 시각화 한 후 결과를 정리하시오.
flights %>% mutate(status = ifelse(is.na(arr_delay), "cancelled", "non_cancelled")) %>% 
  group_by(tail_num, status) %>% summarise(n = n()) %>% 
  spread(status, n) %>% mutate(rate = cancelled/non_cancelled) %>% 
  ggplot(aes(tail_num, rate)) + geom_bar(stat = "identity")

# “오래된 비행기 일수록 cancel 이 많다” 라는 가설에 대해 알아보고자 한다. 알맞은
# 자료를 추출, 그림을 그려 확인하시오.

flights %>% mutate(status = ifelse(is.na(arr_time), "cancelled", "non_cancelled")) %>% 
  group_by(tail_num, status) %>% summarise(n = n()) %>% 
  left_join(planes, by = c("tail_num" = "tailnum")) %>% 
  select(tail_num, status, n, year) %>% 
  ggplot(aes(year, n))+ geom_point(aes(size = n)) + 
  geom_smooth()+ ylim(0,500)+
  facet_wrap(~status)


stocks <- tibble(
  year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr = c( 1, 2, 3, 4, 2, 3, 4),
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)
stocks %>%
  spread(key = year, value = return) %>%
  gather(`2015`:`2016`, key = year, value = return )
stocks %>%
  spread(year, return) %>%
  gather(year, return, `2015`:`2016`, na.rm = TRUE)
stocks %>% complete(year, qtr)
parse_double("1.23")
parse_number("1.23")
parse_date("01/02/15", "%m/%d/%y")
guess_parser(c("12,352,561"))

