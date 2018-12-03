###############
# 10 월 28 일 #
###############
# 물어볼 것 : count(wt) 누적합인가?

library(tidyverse)
library(nycflights13)

# Combining multiple operations with the pipe
# • 각 지역에서 distance 와 average delay 의 관계 살펴보기.

by_dest <- group_by(flights, dest) # 도착지별로 group
delay <- summarise(by_dest,        # 도착지별로
                   count = n(),    # 비행건수
                   dist = mean(distance, na.rm = TRUE),    # 뉴욕-목적지 거리, NA처리
                   delay = mean(arr_delay, na.rm = TRUE))  # 도착지연 평균
delay <- filter(delay, count > 20, dest != "HNL")   # 비행건수 20 이상이고 호놀롤루 가아닌 것 만 뽑아내기
ggplot(data = delay, aes(x = dist, y = delay)) +    # 거리- 연착시간 산점도
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)   # 파이프를 통해 ggplot 동시에 쓸 수 이으


# Missing values 
# na.rm = TRUE 옵션은 통계량 계산 전에 NA 를 모두 제거한 후 계산
flights %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay))음  # na.rm = 옵션을 안주면 NA 값으로 계산된다.
flights %>%
  group_by(year, month, day) %>%
  summarise(mean = mean(dep_delay, na.rm = TRUE))

# 아래와 같이 계산해도 같은 결과
# dep_delay, arr_delay 가 missin기g value 가 아닌 데이터 추출
not_cancelled <- flights %>%          # 아니면 아예 필터링 해버리기
  filter(!is.na(dep_delay), !is.na(arr_delay)) # 지연정보가 NA인 행 제외
not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarise(mean = mean(dep_delay))

# Counts 
# n() : 총 자료의 갯수
# sum(!is.na(x)) : missing 이 아닌 자료의 갯수
# (TRUE/ FALSE 로 나오니까. TRUE 값만 합쳐진다)

x <- c(1,2,3,NA,5)
is.na(x); sum(is.na(x))
!is.na(x); sum(!is.na(x))    # NA 값이 아닌 자료의 개수는 4 개 이다

# delay 분포 살펴보기
# 비행기별(tailnum)로 도착딜레이의 평균을 구하기
delays <- not_cancelled %>% 
  group_by(tailnum) %>%              # 비행기별
  summarise(delay = mean(arr_delay))  # 도착지연 평균
delays

# 300분 이상의 평균 delay 인 비행기가 있음.
ggplot(delays, aes(delay)) + geom_freqpoly(binwidth = 10)

# 좀 더 자세히 살펴보기 위해 아래와 같이 delay 와 비행건수 간의 산점도를 그림
# 한번 늦었는데 많이 늦은 경우도 있으니까... delay 건수 적은데 많이 늦은 케이스 찾아보기
delays <- not_cancelled %>% 
  group_by(tailnum) %>%   # 비행기 별로
  summarise(delay = mean(arr_delay, na.rm = TRUE), # 도착 연착의 평균
            n = n())  # 운항 건수
delays

#평균 300 이상이긴 하지만, 비행건수가 매우 작음을 알 수 있다.
# 0 근처에 너무 많네..
ggplot(delays, aes(n, delay)) + geom_point(alpha = 0.1)

# 비행건수 25 이상만을 그림
# 많아봐야 60 분 연착된다.  # 간단한 ggplot 
delays %>% filter(n > 25) %>%  
  ggplot(aes(n, delay)) + 
  geom_point(alpha = 0.1)


# Useful summary functions
# mean(), median()
# delay 음수인 애들은 지연이 안된애들임. 실제로 지연된 애들만 고려하자
not_cancelled %>% filter(arr_delay > 0) %>%       # 실제로 지연된 것만
  select(year:day, arr_delay)
not_cancelled %>% group_by(year, month, day) %>%  # 날짜별
  summarise(avg_delay1 = mean(arr_delay),         # arr_delay 의 평균
            avg_delay2 = mean(arr_delay[arr_delay > 0]))  # 연착한 것만 가지고 arr_delay 평균 

not_cancelled %>% group_by(year, month, day) %>%   # 날짜별
  summarise(avg_delay1 = mean(arr_delay),  # 모든 운항기록의 arr_delay 의 평균
            n_delay1 = n(),                # 모든 운항건수
            avg_delay2 = mean(arr_delay[arr_delay > 0]),  # 지연도착한 비행 arr_delay 의 평균 (중요)
            n_delay2 = sum(arr_delay > 0))                # 지연도착한 비행 건수  -> arr_delay > 0 건수 (중요)

# sd(), IQR(), mad()
# 목적지 별로 거리의 표준편차 구하기. 내림차순으로 정렬
not_cancelled %>% group_by(dest) %>%          # 목적지 별로
  summarise(distance_sd = sd(distance)) %>%   # 거리의 표준편차
  arrange(desc(distance_sd))                  # 내림차순 정렬

# sd=0 아닌 애들은 출발하는 공항이 여러개인 목적지
not_cancelled %>% group_by(dest) %>%          # 목적지별로
  summarise(distance_sd = sd(distance)) %>%   # 거리의 표준편차
  arrange(distance_sd)                        # 오름차순 정렬

# 목적지 별로 거리의 표준편차와 거리의 평균을 구하기
# 거리평균 기준으로 내림차순 정렬
not_cancelled %>% group_by(dest) %>%            # 목적지별로
  summarise(distance_sd = sd(distance),         # 거리의 표준편차
            distance_mean = mean(distance)) %>% # 거리의 평균
  arrange(desc(distance_mean))                # 내림차순 정렬(큰 순서대로)

not_cancelled %>% group_by(dest) %>% 
  summarise(distance_sd = sd(distance)) %>% 
  arrange(distance_sd)

not_cancelled %>% group_by(dest) %>% 
  summarise(distance_sd = sd(distance),
            distance_mean = mean(distance)) %>% 
  arrange(desc(distance_mean))

# min(), quantile(x, 25), max()
# 일별로 가장 먼저, 가장 늦게 출발하는 시간은?
not_cancelled %>% group_by(year, month, day) %>%  # 날짜별로
  summarise(first = min(dep_time),  # 출발시간의 최솟값 (하루중 첫 비행기)
            last = max(dep_time))   # 도착시간의 최솟값 (하루중 마지막 비행기)

# first(), nth(x, 2), last()   정렬이 되어 있어야 한다. 
not_cancelled %>% group_by(year, month, day) %>% 
  summarise(first_dep = first(dep_time),  # first() : 첫번째 값
            last_dep = last(dep_time))    # last() : 자료의 마지막 값

not_cancelled %>% group_by(year, month, day) %>% 
  arrange(desc(dep_time)) %>%     ### 오..정렬!!!!!!! 그래서 첫비행과 마지막비행 달라짐
  summarise(first_dep = first(dep_time),  # first() : 첫번째 값, 각 날짜별로 첫 비행시간
            last_dep = last(dep_time))    # last() : 자료의 마지막 값

# 출발시간이 늦은 것부터 순위를 매긴다.
not_cancelled %>% group_by(year, month, day) %>%  # 날짜별로
  mutate(r1 = min_rank(desc(dep_time)),           # 첫 비행기 
         r2 = min_rank(dep_time)) %>%        
  select(year, month, day, dep_time, r1, r2)

##### 위와 비교?? 중요!!!!
# 하루중 첫번째 출발과 마지막 출발한 비행을 뽑은 것이다!
not_cancelled %>% group_by(year, month, day) %>%  # 날짜별로
  mutate(r = min_rank(desc(dep_time))) %>%        # 순위매겨서 첫 비행기와 마지막 비행기 뽑아내기
  filter(r %in% range(r)) %>%      # range() 첫값과 끝값 반환 1월1일 1~831 
  select(year:day, dep_time, r)    

# n() 자료의 갯수
# 목적지 별로 얼마나 갔는지
not_cancelled %>% group_by(dest) %>%  # 목적지 별로  
  summarise(n = n())                  # 운항건수 

# 인덱싱으로 filter 해보기
flights[flights$dest == "ANC",]       # flights %>% filter(dest == "ANC")
not_cancelled[not_cancelled$dest == "ANC", ]   # not_cancelled %>% filter(dest == "ANC")

# 목적지별로 운항하는 항공사 보기
flights[flights$dest == "ANC", ]$carrier   # ANC로 간 항공사를 보면 UA 뿐임
table(not_cancelled[not_cancelled$dest == "AVL",]$carrier)  # AVL로 간 항공사는 9E, EV
table(not_cancelled[not_cancelled$dest == "ATL", ]$carrier) 


# 가장 다양한 항공사에서 노선을 제공하고 있는 목적지는?
not_cancelled %>% group_by(dest) %>%        # 목적지별로
  summarise(carriers = n_distinct(carrier), # 운항하는 항공사 갯수
            n = n())                        # 운항건수

not_cancelled %>% group_by(dest) %>%  #목적지별로 
  summarise(carriers = n_distinct(carrier),
            n = n()) %>%     
  arrange(desc(carriers))    # 항공사가 제일 많은 순서대로 정렬 

# 가장 많은 비행기(운항이)가 제공되는 목적지는? 
not_cancelled %>% count(dest) %>% # 목적지별로
  arrange(desc(n))                # 운항건수가 제일 많은 순서대로 정렬

as.data.frame(table(not_cancelled$dest))

# weighted count 도 가능 : 가중치가 적용된 빈도?
# 비행기별 누적 운항 거리. the total miles flown by each tail number.
not_cancelled %>% count(tailnum)                 # 비행기별 운항건수
not_cancelled %>% count(tailnum, wt = distance)  # 비행기별 누적 운항 거리
not_cancelled %>% count(tailnum, wt = distance) %>% arrange(desc(n))  # 내림차순
not_cancelled %>% count(tailnum, wt = distance) %>% arrange(n)  # 오름차순

flights %>% group_by(tailnum) %>% 
  summarise(sum(distance)) %>% arrange(desc(`sum(distance)`))
 
# dplyr::count

# sum(x > 10) : 횟수   sum 안에 조건문 - 합계  (TRUE개수)  x가 10보다 큰 것의 갯수
# mean(y == 0) : 비율. mean 안에 조건문 - 비율 (TRUE/(TRUE+FALSE개수))   x가 0 인 것의 비율
# 5 시 이전에 출발하는 비행기는 몇 대? 
not_cancelled %>% group_by(year, month, day) %>%   # 날짜별로
  summarise(n_early = sum(dep_time < 500))         # 다섯시 이전에 출발하는 비행 건수

# 1시간 이상 지연된 비행기 비율은?
# not_cancelled %>% filter(arr_delay > 60)
not_cancelled %>% filter(arr_delay >= 60)          # 1시간 이상 지연 도착한 운항만 뽑기
not_cancelled %>% group_by(year, month, day) %>%   # 날짜별로 
  summarise(hour_perc = mean(arr_delay > 60))      # 1시간 이상 지연된 운항건수 비율
not_cancelled %>% group_by(year, month, day) %>%   # 날짜별로
  summarise(hour_perc = sum(arr_delay > 60))       # 1시간 이상 지연된 운항건수 

x <- 1:10
mean(x>6); sum(x>6)

# 여러 변수를 이용한 그룹 지정
# 날짜 별로 그룹
# year, month, day [365]  365개의 그룹이 있다. 
(daily <- group_by(flights, year, month, day))  # 각 년, 월, 일 별로 group by로 지정되어 있다. 

# 모든 obs가 다른 그룹이 됐음.. day라는 그룹의 의미가 없어진다 [?]
# year, month [?]
(per_day <- summarise(daily,            # 각 년, 월, 일별로
                     flights = n()))    # 운항건수를 flights 변수에 저장

# year [?]
(per_month <- summarise(per_day,                 # 각 연, 달별로 
                       flights1 = sum(flights))) #월별 운항건수 합계
# year [?]
(per_year <- flights %>%      # 각 연도별로 
  group_by(year, month) %>% 
  summarise(flights2 = n()))

(per_year <- summarise(per_month, 
                      flights2 = sum(flights1)))

# ungroup() 을 이용하여 그룹 해제 
class(daily)            # 이미 grouped_dataframe 이다
class(flights)
class(daily %>% ungroup())
daily %>% summarise(n = n())   # 각 일별로 n을 찾는다
daily %>% ungroup() %>% # no longer grouped by date. 더이상 그룹이 지정되지 않아서 전체 sum을 찾는다
  summarise(n = n())    # all flights

# 각 그룹에서 변수 생성
# 그룹에서 최하위 찾기
flights %>% 
  group_by(year, month, day) %>% 
  mutate(delay_rank = rank(desc(arr_delay))) %>%  # 지연시간이 제일 큰 운항부터 순위를 매긴다
  select(year:day, arr_delay, delay_rank)

flights %>% group_by(year, month, day) %>% 
  filter(rank(desc(arr_delay)) <= 5) %>%   # 순위가 5 이하인 운항. 지연이 많이된 top 5
  select(year:day, arr_delay)

