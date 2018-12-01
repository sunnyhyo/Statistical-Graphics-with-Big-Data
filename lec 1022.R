################
# 10 월 22 일
################

library(tidyverse)
library(nycflights13)

flights

# Useful creation functions
transmute(flights, 
            dep_time, 
            hour = dep_time %/% 100,   # (정수몫)정수 나누기 연산자
            minute = dep_time %% 100)  # 나머지 연산자

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
lag(x)
lead(x)

# Cumulative and rolling aggregates
cumsum(x)
x


# Logical comparisons
# <, <=, >, >=, !=
y <- c(1, 2, 2, NA, 3, 4)
y 
rank(y)  # rank(): Returns the sample ranks of the values in a vector, missing value
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

yyy <- yy[!is.na(yy)]
yyy
percent_rank(yyy)
(min_rank(yyy) - 1) / (length(yyy) - 1)
cume_dist(yyy)
summarise(flights, delay = mean(dep_delay, na.rm = TRUE))

by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))
by_day
AA <- summarize(by_day,
                delay = mean(dep_delay, na.rm = TRUE))
AA

summarize(AA,delay1=mean(delay,na.rm=TRUE))

