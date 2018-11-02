install.packages("nycflights13")
library(nycflights13)
library(tidyverse)


flights


not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))
not_cancelled %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))

delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarise(
    delay = mean(arr_delay)
  )

ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(binwidth = 10)
# 대부분 0 근처에 있지만 꼬리가 길다. 한 비행기가 한번 이상 늦어질 때 건수 함께 구하고자 한다. 
# delay 와 비행건수 간의 산점도를 그림

delays <- not_cancelled %>%  group_by(tailnum) %>% 
  summarise(delay= mean(arr_delay, na.rm= TRUE), n=n()) #count 계산

ggplot(delays, aes(n, delay)) + geom_point()
ggplot(delays, aes(n, delay)) + geom_point(alpha=0.1)
#100 이상은 예외적인 비행기들

#비행건수가 25 이상만을 그림 
delays %>% filter(n>25) %>% 
  ggplot(aes(n, delay)) + geom_point(alpha=0.1)
#대부분 100건 근처, 0~10분 정도

#useful summary functions
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),                #전체적인 평균
    avg_delay2 = mean(arr_delay[arr_delay > 0])  #실제로 늦은 비행기에 대한 평균
  )

#비행기의 건수를 붙이면 편할 것이다. 

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(
    avg_delay1 = mean(arr_delay),                #전체적인 평균
    n_delay1 = n(),                              #그룹에 대한 건수만 계산
    avg_delay2 = mean(arr_delay[arr_delay > 0]),  #실제로 늦은 비행기에 대한 평균
    n_delay2 = sum(arr_delay>0)   #true 인 것의 갯수를 세면 원하는 정보가 된다. 
  ) 
  
#destination과 distance
not_cancelled %>% group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd))   # 0의 의미는 목적지가 같은 곳, 뉴욕에 떠나서 뉴욕에 도착

not_cancelled %>% group_by(dest) %>% 
  summarise(distance_sd = sd(distance),
            distance_mean = mean(distance)) %>% 
  arrange(desc(distance_sd))   # 0의 의미는 목적지가 같은 곳, 뉴욕에 떠나서 뉴욕에 도착

#날짜별로 가장 이른시간 늦은시간 
not_cancelled %>% group_by(year, month, day) %>% 
  summarise(first = min(dep_time), last = max(dep_time))
#dep_time 이 이상한 형식으로 붙여저있군


#first(x), nth(x), last(x)
not_cancelled %>%
  group_by(year, month, day) %>%
  mutate(r = min_rank(desc(dep_time))) %>%
  select(year, month, day, dep_time, r)


not_cancelled %>%
  group_by(year, month, day) %>%
  mutate(r = min_rank(desc(dep_time))) %>%
  filter(r %in% range(r))

not_cancelled %>%
  group_by(year, month, day) %>%
  mutate(r = min_rank(dep_time)) %>%
  filter(r %in% range(r))
#같은 자료가 뽑힌다



#가장 다양한 항공사에서 노선을 제공하고 있는 목적지는?
#목적지 별로 grouping 목적지에서 다루고 있는 항공사 고르기 

not_cancelled %>%
  group_by(dest) %>%
  summarise(carriers = n_distinct(carrier)) %>%  #n_distinct
  arrange(desc(carriers))


not_cancelled %>% group_by(dest) %>%
  summarise(carriers = n_distinct(carrier),
            n = n())
table(not_cancelled[not_cancelled$dest =="ATL", ]$carrier)

not_cancelled %>% group_by(dest) %>%
  summarise(carriers = n_distinct(carrier),   #tibble dataset 에서 count
            n = n()) %>% 
  arrange(desc(carriers))

not_cancelled %>% count(dest)   #간단한 count



#5시 이전에 출발하는 비행기는 몇건?

not_cancelled %>%  group_by( year, month, day ) %>% 
  summarise( n_early = sum( dep_time < 500 ) )


#1시간 이상 지연된 비행기 비율?
not_cancelled %>% filter(arr_delay >= 60)
not_cancelled %>% group_by(year, month, day) %>% 
  summarise(hour_perc = mean(arr_delay > 60))  #그날의 비율


daily <- group_by(flights, )

per_day <- summarise(daily, flights = n())

