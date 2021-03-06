################
# 10 월 22 일
################
# 물어볼거: group_by 정보 없어지는거

library(tidyverse)
library(nycflights13)

flights
# 이 자료에서 특이한 것, dep_time, arr_time 시간분
# useful creation functions
# • Arithmetic operators: +, -, *, /, ^.
# • Modular arithmetic
# – %/% (integer division)
# – %% (remainder), x == y * (x %/% y) + (x %% y)

32 %/% 3  # 몫
32 %% 3   # 나머지
x == y * (x %/% y) + (x %% y)

transmute(flights, 
            dep_time, 
            hour = dep_time %/% 100,   # 시간만 남는다. (정수몫)정수 나누기 연산자
            minute = dep_time %% 100)  # 분만 남는다. 나머지 연산자

# %% 나머지 연산자
# %/% 정수 나누기 연산자 (정수 몫 반환)
# %*% 행렬 곱하기 연산자
# %in% 벡터 내 특정 값 포함 연산자

# Arithmetic operators
#  +, -, *, /, ^

# Modular arithmetic
x <- c(1:10); y <- c(5)
x %% y
x %/% y
x %in% y
y %in% x
x == y * (x %/% y) + (x %% y)


# Logs
log(2)
log2(2)
log10(2)
x<- 1:10
x

# Offsets
lag(x); lead(x)

# Cumulative and rolling aggregates
cumsum(x); x


# Logical comparisons
# <, <=, >, >=, !=
y <- c(1, 2, 2, NA, 3, 4)
y 
rank(y) # 2 와 3의 중앙값 2.5 위
min_rank(y)  # min_rank() : 순위(ranking) index 반환, 동일값에 대해서는 '1, 1, 1, 4, 4,...' 처리
min_rank(desc(y))
row_number(y) # row_number() : 순위(ranking) index 반환, 동일값에 대해서는 '1, 2, 3, ...' 처리


yy <- c(1, 2, NA, 3, 4, 2)
yy 
row_number(yy)
dense_rank(yy)  # dense_rank() : 순위(ranking) index 반환, 동일값에 대해서는 '1, 1, 1, 2, 2,...' 처리

percent_rank(yy)
yy

min_rank(yy)
dense_rank(yy)
percent_rank(yy)
(min_rank(yy) - 1) / (length(yy) - 1)
(min_rank(yy) - 1) / (length(yy, na.rm = TRUE) - 1)


####
yyy <- yy[!is.na(yy)]  # NA 값이 없는 값만 인덱싱
yyy
percent_rank(yyy)
(min_rank(yyy) - 1) / (length(yyy) - 1)
c(0,1,3,4,1)/4
cume_dist(yyy)

###
# Grouped summarises 
# summarise() : 요약 통계량 계산
flights
# flight 자료에서 delay time의 평균
summarise(flights, 
          delay = mean(dep_delay, na.rm = TRUE))  

# flight 자료를 연, 월, 일로 그룹화를 한 뒤에 (각 날짜마다) delay 시간의 평균
# group_by() 와 summarise() 함께 사용할 경우 유용
by_day <- group_by(flights, year, month, day);head(by_day)  # 365 개의 그룹
AA <- summarize(by_day,     # 각 날짜별로 summarise
                delay = mean(dep_delay, na.rm = TRUE));AA
# day 별 평균....[?]: day = row 수. group_by 변수와 새 변수
# group의미가 없어진다.

# AA 자료를 ???이건 왜 이렇게 되는 거지?
summarize(AA,       # 각 월별로 summarise
          delay1 = mean(delay, na.rm=TRUE))
# month 별로 delay 평균. day 라는 정보 없어짐.. 