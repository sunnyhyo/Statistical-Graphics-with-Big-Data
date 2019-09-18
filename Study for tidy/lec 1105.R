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

# read_csv() : 첫 줄의 자료를 column 이름으로 사용
# parsing 결과로 나타나는 각 변수의 이름과 type을 보여줌
# inline 형태로도 이용 가능

heights1 <- read.csv("heights.csv")
head(heights1)

# skip = Number of lines to skip before reading data. 
# n번째 줄을 column 이름으로 하고 그 이후의 자료를 읽을 수도 있음
heights2 <- read.csv("heights.csv", skip = 3)  # skip = 3, 3번째 줄이 변수이름, X변수명 
head(heights2)  # x3000

heights3 <- read_csv("heights.csv", skip = 3)  # skip = 3, 3번째 줄이 변수이름, `변수명`
head(heights3)

# comment = "문자" : 특정 문자로 시작되는 줄을 빼고 읽을 수도 있음
read_csv("# A comment I want to skip
 x,y,z
 1,2,3", comment = "#", skip= 0)

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


# read_csv vs. read.csv()와 비교
# 1. read.csv 보다 10 배정도 빠르다. 파일이 큰 경우 progress bar 를 제공하여 상황을 알수 있게 한다.
# 2. tibble 자료를 생성. character 의 경우 factor 로 바뀌지 않고 character 로 남아있게 됨.
# 3. read.csv 은 OS 시스템마다 다르게 작동. read_csv 가 더 reproducible 하다.




##################
# Parsing a vector 
# parse type 함수 : character vector 로 읽은 후 type 의 형태로 바꿔줌
str(parse_logical(c("TRUE", "FALSE", "NA")))
str(parse_integer(c("1", "2", "3")))
str(parse_date(c("2010-01-01", "1979-10-14")))

# na=“문자”를 이용하여 특정 문자를 NA 로 처리.
parse_integer(c("1", "231", ".", "456"), na = ".")


# parsing 에 실패하는 경우 warning 을 주고 NA 로 처리.
# problems()로 문제점 파악 가능
x <- parse_integer(c("123", "345", "abc", "123.45"))
problems(x)   
x

# 3, 4 row 에 problems : integer 이 있어야 하는데 chr 가 들어가 있었다!

# parser 함수들
# 1. parse_logical() : logical value 를 parsing
# 2. parse_integer(): integers 를 parsing.
# 3. parse_double(): 숫자에 대한 엄격한 parser
# 4. parse_number(): 숫자에 대한 좀 덜엄격한 parser. 나라마다의 다른 형태까지 가능
# 5. parse_character(): 문자열 parsing. 문제는 characer encodings.
# 6. parse_factor(): factor 만들기. R 에서 범주형 변수에 대응.
# 7. parse_datetime(): 날짜와 시간
# 8. parse_date(): 날짜
# 9. parse_time(): 시간



##################
# problems() : 
# 큰 파일에서 발생가능한 문제들
# 1. 처음 1000 개의 자료가 특별한 상황일 수 있으므로 이를 이용하여 guess 한 것을 그 이후의 자료에 대한 변환에 이용하는 readr 에 문제가 발생할 수 있다.
# 2. missing 이 많은 column 이 있을 수 있다. 특정 column 이 처음 1000 개의 자료가 모두 NA 인 경우 type 을 지정할 수가 없게된다.

problems(x)        # 문제 가르쳐줌
problems(heights)

challenges <- read_csv(readr_example("challenge.csv"))
# 자료의 1000 줄에 대한 error 메세지와 그 다음 5줄에 대한 결과를 함께 보여줌
problems(challenges)   # no trailing characters,

challenges[999:1002,]  # 문제점 확인해보니 1000 줄 이후부터 자료 형태가 바뀐다!
# x축 : 1-1000 까지는 integer, 1001 -2000 까지 dbl 자료
# y축 : 1-1000 까지는 NA, 1001-2000 까지 date 자료 

# read_csv 함수 내에 col_types 옵션을 이용.
# col_type 으로 자료의 형식을 지정해준다
challenge <- read_csv(readr_example("challenge.csv"),
                      col_types = cols(x = col_double(),  # <dbl>
                                       y = col_date()))   # <date> y = col_date() 이용
challenge[999:1002,]


####################
# Other stretegies 
# guess_max = 에 이용할 줄 수를 지정
# Maximum number of records to use for guessing column types.
# 모든 자료를 character 로 읽은 후 확인.
challenge <- read_csv(readr_example("challenge.csv"),
                      guess_max = 1001)
challenge[999:1002,]
problems(challenge)   # 문제없음!
?read_csv
