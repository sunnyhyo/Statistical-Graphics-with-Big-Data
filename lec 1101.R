######################
#Lec 12
#11월 01일
######################

library(nycflights13)
library(tidyverse)

#년,월, 일 기준으로 도착지연시간이 제일 긴 9위
flights %>% group_by(year, month, day) %>% 
  filter(rank(desc(arr_delay))<10)


#기준조건 이상
flights %>% group_by(dest) %>% filter(n() > 365)

#365 미만의 비행기 도착
#대부분의 도시는 하루에 한번 정도는 가겠지...

flights %>% group_by(dest) %>% mutate(n=n()) %>% arrange(desc(n))

#각 그룹마다 새로운 변수 만들기
popular_dests <- flights %>% filter(arr_delay>0) 
popular_dests %>% filter(arr_delay>0)

############################
#Tibble
#tibble 만들기
class(iris)
iris_tb <- as_tibble(iris)
class(iris_tb)
iris_tb 

tb<- tibble(`:)` = "smile", ` `= "space", `2000` = "number")
tb

#tibble dataset names 특수문자, 공백, 숫자지정 하기 위해서는 
#변수명을 ``로 한다


A <- tibble(a = lubridate::now() + runif(1000)*86400,
            b = lubridate::today() + runif(1000)*30 ,
            c = 1:1000,
            d = runif(1000), 
            e = sample(letters, 1000, replace = TRUE))
#소문자 a-z까지 1000개를 복원추출
A




print(iris_tb)
iris_tb



df <- tibble( x = runif(5), 
              y = runif(5))
df

set.seed(20181101)
