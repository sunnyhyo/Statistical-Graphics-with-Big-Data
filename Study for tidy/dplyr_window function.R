# dplyr window function

# dplyr
# Window function 
# n 개의 input 을 받아서 n 개의 output 반환하는 함수
# 순위(rank)를 구하거나 누적합(cummulative sum)을 구하는 함수가 대표적임
#
# Aggregarion function
# n 개의 input 을 받아서 1 개의 output 을 반환하는 함수 
# 요약통계량의 평균, 합계, 개수세기 등


# Window function (dplyr)
# (1) Ranking and Ordering : row_number(), cume_dist(), min_rank(), per_rank(), dense_rank(), ntile()
# (2) Lead and Lag : lead(), lag()
# (3) Cumulative aggregates : cumall(), cumany(). cummean()
# (4) Recycled aggregates : filter(dataframe, G > mean(G)), filter(dataframe, G > median(G))


# (1) Ranking and Ordering
# - row_number(), min_number(), dense_rank() : 순위에 대한 index 반환
# - cume_dist(), percent_rank() : 순위에 대한 0-1 사이의 비율 반환
# - ntile() : n 개의 동일한 개수로 데이터셋 나눔

x <- c(1, 1, 1, 5, 5, 9, 7, NA, NA) 
x

# rank(): Returns the sample ranks of the values in a vector, missing value
# rank는 순위대로 정렬해주는게 아니라 순위의 색인을 나타내줍니다.missing value 도 색인 처리
# 중복순위는 중앙값 처리, NA 중복은 순서대로
rank(x)

# row_number() : 순위(ranking) index 반환, 동일값에 대해서는 '1, 2, 3, ...' 처리
# 순위 중복을 observation 순서대로 순위를 매긴다. NA는 NA
row_number(x)        # 작은 값부터 1 순위
row_number(desc(x))  # 큰 수 부터 1순위

# min_rank() : 순위(ranking) index 반환, 동일값에 대해서는 '1, 1, 1, 4, 4,...' 처리
# 일반적인 내신처리
# (공백준다) 없는 등수O. 동순위는 상위 rank, 그 다음 순위는 하위 rank 
min_rank(x)
min_rank(desc(x))

# dense_rank() : 순위(ranking) index 반환, 동일값에 대해서는 '1, 1, 1, 2, 2,...' 처리
# 올림픽순위
# (공백안준다) 
dense_rank(x)
dense_rank(desc(x))

# cume_dist() : 현재 값보다 작거나 동일한 값의 순위(ranking) 상의 비율 (0~1)
cume_dist(x)
3/7; 5/7; 6/7; 7/7
cume_dist(desc(x))
# dplyr::cume_dist 
rank(x, ties.method = "max", na.last = "keep")/sum(!is.na(x))

# percent_rank() : min_rank() 기준의 순위(ranking)에 대한 비율(0~1)
# 내 위에 몇프로 있는가? 
percent_rank(x)
#dplyr::percent_rank 
(min_rank(x) - 1)/(sum(!is.na(x)) - 1)

# ntile() : 동일한 개수를 가진 n개의 sub 데이터로 나누기


# (2) Lead and Lag
# - lead()
# - lag() 
# 시계열 데이터를 분석할 때 많이 사용하는 편입니다. 특정 그룹id와 날짜/시간 기준으로 정렬(sorting)을 해놓은 다음에, lead() 나 lag() 함수를 가지고 행을 하나씩 내리구요, 직전 날짜/시간 대비 이후의 값의 변화, 차이(difference)를 구하는 식으로 말이지요.


# lead(x, n = 1L, default = NA, ...) in {dplyr} package
# lead() 함수는 벡터 값을 n = 1L (양의 정수값) 의 값 만큼 앞에서 제외하고, 제일 뒤의 n = 1L 값만큼의 값은 NA 로 채워놓은 값을 반환합니다.  이때, n  표기는 생략할 수 있습니다.
x <- 1:10
lead(x)

# lag(x, n = 1L, default = NA, ...) in {dplyr} package
# lag() 함수는 lead() 함수와 정반대로 생각하시면 됩니다.  lag() 함수의 n = 1L(양의 정수값) 만큼 제일 앞자리부터 뒤로 옮기고, n = 1L 개수 만큼의 자리에 NA 값을 채워넣은 값을 반환합니다.

x <- 1:10
lag(x, n = 1)
lag(x, n = 2)
lag(x, n = 2, default = ".")


# [문제] 위의 x_df 데이터 프레임의 group 별로 직전 대비 직후 값의 차이가 가장 큰 값(max)과 가장 작은 값을 각각 구하시오. (What are the max and min difference values between x and lag(x) of x_df dataframe by group?)

# (0) 예제 데이터 프레임 만들기
group <- rep(c("A", "B"), each = 5)
seq_no <- rep(1:5, 2)
set.seed(1234)
x <- round(100* runif(10), 1)
x_df <- data.frame(group, seq_no, x)
x_df

# (1) lag() 하려고 하는 기준대로 정렬이 안되어 있으면 -> 먼저 정렬(sorting)부터!
x_df_random <- x_df[sample(nrow(x_df)),]
x_df_random

x_df_seq <- arrange(x_df_random, group, seq_no)
x_df_seq

# (2) mutate() 함수와 lag() 함수로 group_x, x_lag 변수 만들기
x_df_seq_lag <- mutate(x_df_seq,
                       group_lag = lag(group, 1),
                       x_lag = lag(x, 1))
x_df_seq_lag

# (3) group 과 group_lag 의 값이 서로 다르면 그 행 (row)은 filter() 함수로 제외하기
x_df_seq_lag_2 <- x_df_seq_lag %>% 
  filter(group == group_lag)
x_df_seq_lag_2

# (4) group 별로 x 와 x_lag 값의 차이가 가장 큰 값(max)과 가장 작은 값(min) 구하기
x_df_seq_lag_2 %>% 
  group_by(group) %>% 
  summarise(max_lag = max(x - x_lag, na.rm = TRUE),
            min_lag = min(x - x_lag, na.rm = TRUE))
