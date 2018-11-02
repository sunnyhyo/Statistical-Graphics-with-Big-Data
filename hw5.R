library(nycflights13)
library(tidyverse)

head(flights)
names(flights)
summary(flights)

###* nycflights13 패키지에 있는 flights 자료를 이용
##1. flights자료에서 도착이 5시간 이상 늦어진 비행 자료 중 
##year, month, day,dep_delay, arr_delay, carrier, origin, dest 만을 뽑아서 Late5에 저장하시오.

Late5<- flights %>% filter(arr_delay >= 5*60) %>% 
  select(year, month, day,dep_delay, arr_delay, carrier, origin, dest)

##2. flights 자료에서 Houston으로의 비행만을 뽑아서 HOUIAH에 저장하시오.
##- Houston의 공항코드: IAH 혹은 HOU
##- 자료 중 year, month, day, carrier, origin, dest만을 저장
table(flights$dest)
HOUIAH <- flights %>% filter(dest == "IAH" | dest == "HOU") %>% 
  select(year, month, day, carrier, origin, dest)


##3. flights 자료에서 도착이 5시간 이상 늦어진 비행이 가장 많은 항공사를 알아보려고 한다. 
##Late5 자료를 이용하여 각 항공사별 5시간이상 늦어진 비행 건수를 구하고 
##이를 건수가 많은 항공사부터 나열하시오.
table(flights$origin)
summary(Late5$arr_delay)
Late5 %>% group_by(carrier) %>% summarise( delay_count = sum(arr_delay >= 5*60) ) %>%
  arrange(desc(delay_count))

##4. 겨울(12,1,2월)에 뉴욕에서 출발하는 비행의 /도착지 별/ 월평균 출발지연시간을 구하시오.

flights %>% filter(month == c(1, 2, 12) ) %>% group_by(dest, month) %>% 
  summarise(delay_mean = mean(dep_delay, na.rm = TRUE))


##5. 출발은 늦지 않았으나 도착이 2시간 이상 늦어진 비행의 도착공항 별 건수와
##도착공항별 평균 지연시간을 구하고 이를 건수가 많은 순으로 나열하시오.

flights %>% filter(dep_delay <= 0, arr_delay >= 2*50) %>% group_by(dest) %>% 
  summarise( n = n(),
             delay_time = mean(arr_delay)) %>% 
  arrange( desc(n) )



##6. 1시간 이상 늦게 출발했으나 늦어진 출발시간 중 30분 이상을 비행으로 단축한 비행을 
##비행거리가 큰 순서대로 나열
##- month, distance, dest, dep_delay,arr_delay 만 표시

flights %>% filter(dep_delay >= 1*60, dep_delay - arr_delay >= 30) %>% 
  arrange(desc(distance)) %>% 
  select(month, distance, dest, dep_delay, arr_delay)


##7. 60분 이상의 출발지연이 가장 많은 비행기(tailnum)를 찾으려고 한다. 
##비행기별로 60분 이상의 출발지연 건수와 평균 출발지연시간을 구하고, 
##60분 이상의 출발지연건수가 많은 순으로 나열하시오.

flights %>% group_by(tailnum) %>%  filter(dep_delay >= 60) %>%
  summarise( n = sum(dep_delay >= 0),
             mean  = mean(dep_delay)) %>% 
  arrange( desc(n))


##8. 평균 출발 지연시간이 가장 긴 항공사 찾기. (항공사, 그리고 비행건수를 함께표시)

flights %>% group_by( carrier ) %>% 
  summarise( dep_delay_mean = mean(dep_delay, na.rm = TRUE), n = n() ) %>% 
  filter( dep_delay_mean == max(dep_delay_mean) ) %>% 
  select( carrier, n, dep_delay_mean)

