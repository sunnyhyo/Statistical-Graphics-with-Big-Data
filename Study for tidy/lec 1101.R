#############
# 11 월 1 일
#############

library(tidyverse)
library(nycflights13)

# 기준 조건 이상의 그룹 찾기
popular_dest <- flights %>%     
  group_by(dest) %>%   # 목적지별로   
  filter(n() > 500)      # 운행건수가 500 이상인 목적지
popular_dest

# 각 그룹마다 새로운 변수 생성하기
popular_dest %>%               # 목적지별로  (시간의 비율)
  filter(arr_delay > 0) %>%    # 진짜 지연된 운행만 뽑아서
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%  # 해당운행 지연된시간/목적지별총지연된시간합
  select(year:day, dest, arr_delay, prop_delay)

popular_dest %>%             # mean(조건문) :비율        # 목적지별 (지연여부의 비율)
  mutate(prop_delay = mean(arr_delay>0, na.rm = T)) %>%  # 실제 지연여부 비율
  select(year:day, dest, arr_delay, prop_delay)

popular_dest %>%             # mean(data[조건문]) :평균   # 목적지별 (지연된 시간의 평균)
  mutate(prop_delay = mean(arr_delay[arr_delay>0], na.rm = T)) %>%  #실제로 딜레이된 시간의 평균
  select(year:day, dest, arr_delay, prop_delay)

##########################################################
# 각 그룹에서 최하위 찾기 
# 일별로 도착연착이 큰 순서대로 top10
flights %>% group_by(year, month, day) %>%   # 날짜별로 
  filter(rank(desc(arr_delay)) <= 10 )       # 도착지연시간이 큰것부터 순서대로 top 10 비행

flights %>% group_by(year, month, day) %>%   # 날짜별로 
  filter(rank(desc(arr_delay)) < 10)         # 도착지연시간이 큰 순서대로 top9      

# 운항건수가 365회 이상인 목적지로 간 운항만 추출하기
flights %>% group_by(dest) %>% 
  filter( n() > 365 ) %>% 
  select(year:day, dest, everything())
flights %>% group_by(dest) %>% 
  filter( n() > 365 ) %>% summarise(n= n()) %>% arrange(desc(n))

# 목적지별 운항 건수가 많은 것부터 정렬
flights %>% group_by(dest) %>% 
  mutate( n = n() ) %>% arrange(desc(n)) %>% 
  select(year:day, dest, n, everything())

# flights 자료에서 목적지별로 365 회 이상 운항한 data 를 popular_dest
popular_dest <- flights %>% group_by(dest) %>%    
  filter(n() > 365)   # 인기있는 목적지 추출

# 도착지연된 운항 시간 중에 해당운항이 딜레이된 시간비율?
popular_dest %>% filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year, month, day, dest, arr_delay, prop_delay)

popular_dest %>% summarise(a = sum(arr_delay))  # NA 가 있는데 arregate 하면 결측
popular_dest %>% summarise(a = sum(arr_delay, na.rm = TRUE))  # NA 제외 후 계산
popular_dest %>% filter(arr_delay > 0) %>%                # NA 는 제외된다
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%     # 여기서는 왜 na.rm  =TRUE 안하는지? 아 하네
  select(year, month, day, dest, arr_delay, prop_delay)
flights %>% summarise(a = sum(arr_delay, na.rm = TRUE))
11/30046
11/2257174

# 각 그룹마다 새로운 변수 생성하기
A <- popular_dest %>%         # 목적지별로 
  filter(arr_delay > 0) %>%   # 실제로 도착이 지연된 운항
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%    # 지연시간 비율
  select(year, month, day, dest, arr_delay, prop_delay)  
A
A %>% summarise(n = sum(arr_delay, na.rm = TRUE))   # 목적지별로 지연시간 총합

class(flights)
class(popular_dest)   # 그룹화된 tdf


##################
# tibble, readr, and tidyr

# tibbles 
# - data frame 을 좀 더 편하게 사용할 수 있도록 변형시켜 놓은 class
# - data frame 과 상호교환 가능

# tibbles 만들기
# as_tibble() : data frame 을 tibble 로 바꿔주는 함수 

head(iris)
as_tibble(iris)

# tibble() 을 이용하여 만들기
# data frame 과의 차이점 
# - character 가 factor 로 바뀌지 않음
# - R 에서 허용하지 않는 형태의 변수 이름 가능 
# - printing 에서 처음 10줄과 화면에 맞는 변수만을 보여줌

tb <- tibble( `:)` = 'smile', 
              ` ` = 'space',
              `2000` = 'number' )
tb
tb$`:)`
iris.tb <- as_tibble(iris)

# Printing
# - data frame 모든 자료를 보여줌
# - tibble : 처음 10 줄과 화면에 맞는 만큼의 변수만을 보여주며 변수의 type 도 함께 보여줌
A <- tibble( a = lubridate::now() + runif(1000)*86400,
             b = lubridate::today() + runif(1000)*30,
             c = 1:1000,
             d = runif(1000),
             e = sample(letters, 1000, replace = TRUE))
A             

lubridate::now()    # 현재 시각
lubridate::today()  # 오늘 날짜

sample(letters); sample(LETTERS)
86400/60     #초 -> 분
86400/60/60  #초 -> 분 -> 시간

# n, width 옵션을 이용하여 자료 전체를 볼 수 있음
# defualt print option 을 바꿀 수도 있음
# - options(tibble.print_max = n, tibble.print_min = m) :
# 자료가 m 줄 이상인 경우 처음 n 줄만을 인쇄
# - options(dplyr.print_min = Inf) : 항상 모든 자료를 인쇄
# - options(tibble.width = Inf) : 항상 모든 변수를 인쇄
# - View() : 자료 전체를 보여줌
print(A)
print(A, n = 20)                       # n = Inf     모든 행 인쇄
flights %>% print(n = 5, width = Inf)  # width = Inf 모든 변수 인쇄

summary(lm(Sepal.Length ~ Sepal.Width, data =iris))
summary(iris)
print(iris)
print(iris.tb)

# tribble() : SAS 의 cards 문과 같은 형태의 자료 입력도 허용
# Create tibbles using an easier to read row-by-row layout.
tribble(
  ~x, ~y, ~z,
  #--/--/--
  "a", 2, 3.6,
  "b", 1, 8.5
)
tribble(~x,~y,~z,#--/--/--"a",2,3.6,"b",1,8.5))
)   # row by row

tribble(~x,~y,~z,#--/--/--
        "a",2,3.6,"b",1,8.5) 
tribble(~x,~y,~z,
        "a",2,3.6,"b",1,8.5) 

df <- tibble(x = runif(5), 
             y = runif(5))
df

# tibble 일 때 출력되는 형식
set.seed(20181101)
df <- tibble(x = runif(5), 
             y = runif(5))
df
df$x
df[['x']]
df[,'x']

# data frame 일 때 출력되는 형식
df1 <- data.frame(x = runif(5), 
                  y = runif(5))
df1
df1$x
df1[['x']]
df1[,"x"]
df1[,c('x','y')]
df1[,'x',drop = FALSE]

df.tbl <- tibble( xx = runif(5), 
                  y = runif(5))
df.DF <- data.frame( xx = runif(5),
                     y = runif(5))
df.tbl
df.DF

df.DF$xx
df.DF$xx
df.tbl$xx
as.data.frame(df.tbl)

