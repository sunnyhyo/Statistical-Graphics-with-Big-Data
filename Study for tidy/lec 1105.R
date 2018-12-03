################
# 11 월 5 일
################

library(tidyverse)
library(nycflights13)

# Tibble data 

df <- tibble(A = rep(LETTERS[1:3], each = 4),
             B = rpois(12, 10))
df
df %>% mutate(prop_B = B / sum(B), 
              sum_B = sum(B))
popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n()>365)

popular_dests %>% filter(arr_delay > 0) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay),
         sum_delay = sum(arr_delay)) %>% 
  select(year:day, arr_delay, prop_delay, sum_delay)

popular_dests %>% filter(arr_delay > 0 ) %>% 
  mutate(prop_delay = arr_delay / sum(arr_delay),
         sum_delay = sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay, sum_delay)


##################################
# Data import 
# readr package의 flat file 을 부르는 함수
# read.csv() : 데이터 프레임으로 읽는다.
# read_csv() : 자료가 , 로 분리된 형태의 파일을 읽는다. 티블데이터 
# read_csv2() : 자료가 ; 로 분리된 형태의 파일을 읽는다 
# read_table() : 공백으로 분리된 형태의 파일 읽기
# read_tsc() : 자료가 (tab)으로 분리된 형태의 파일을 읽는다
# read_delim() : delim 에 설정된 형태로 분리된 파일을 읽는ㄷ
# read_fwf() : 고정폭으로 된 파일을 읽는다


setwd("C:/Users/HS/Documents/GitHub/Statistical-Graphics-with-Big-Data/data")
heights <- read_csv("heights.csv")
heights

# read_csv() 를 실행시키면 parsing 결과로 나타나는 각 변수의 이름과 type을 보여줌
# inline 형태로도 이용 가능

heights1 <- read.csv("heights.csv")
head(heights1)

# skip = Number of lines to skip before reading data.
heights2 <- read.csv("heights.csv", skip = 3)  # skip = 3, 3번째 줄이 변수이름, X변수명 
head(heights2)  # x3000

heights3 <- read_csv("heights.csv", skip = 3)  # skip = 3, 3번째 줄이 변수이름, `변수명`
head(heights3)

# col_names = FALSE 첫줄을 자료로 읽기
heights4 <- read_csv("heights.csv", col_names = FALSE)  # 첫번째 줄부터 자료를 읽어라
heights4

class(heights1)
class(heights4)

# col_names 를 이용하여 column  이름지정가능
heights <- read_csv("heights.csv", col_names = paste0("A",1:6))  
heights     # # 첫번째 줄부터 자료를 읽고 변수명을 새로 지정한다

# na = "문자" 를 이용하여 특정 문자를 NA 처리
heights.na <- read_csv("heights-1.csv", na =".")
heights.na


##################
# Parsing a vector 
# parse type 함수 : character vector 로 읽은 후 type 의 형태로 바꿔줌
x <- parse_integer(c("123", "345", "abc", "123.45"))
x   
# 3, 4 row 에 problems : integer 이 있어야 하는데 chr 가 들어가 있었다!



##################
# problems() : 자료의 1000 줄을 읽고 데이터 자료형태를 추측한다. 
problems(x)        # 문제 가르쳐줌
problems(heights)

challenges <- read_csv(readr_example("challenge.csv"))
problems(challenges)   # no trailing characters

challenges[999:1002,]  # 문제점 확인해보니 1000 줄 이후부터 자료 형태가 바뀐다!
# x축 : 1-1000 까지는 integer, 1001 -2000 까지 dbl 자료
# y축 : 1-1000 까지는 NA, 1001-2000 까지 date 자료 

# col_type 으로 자료의 형식을 지정해준다
challenge <- read_csv(readr_example("challenge.csv"),
                      col_types = cols(x = col_double(),  # <dbl>
                                       y = col_date()))   # <date>
challenge[999:1002,]

# Other stretegies 
# guess_max = 에 이용할 줄 수를 지정
# Maximum number of records to use for guessing column types.
challenge <- read_csv(readr_example("challenge.csv"),
                      guess_max = 1001)
challenge[999:1002,]
problems(challenge)   # 문제없음!
?read_csv
