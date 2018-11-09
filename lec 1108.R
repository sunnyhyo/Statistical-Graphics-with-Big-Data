setwd("C:/Users/HS/Documents/GitHub/Statistical-Graphics-with-Big-Data")
library(tidyverse)
challenge2 <- read_csv(readr_example("challenge.csv"), guess_max = 1001)
challenge2 <- read_csv(readr_example("challenge.csv"),
                       col_types = cols(.default = col_character())
)
write_csv(challenge2, "challenge.csv")
write_rds(challenge2, "challenge.rds")
A <- read_rds("challenge.rds")
challenge3 <- type_convert(("challenge.csv"))
df <- tribble(
  ~x, ~y,
  "1", "1.21",
  "2", "2.32",
  "3", "4.56"
)
df

#저장된 자료의 형식 다르다
table1
table2
table3  #각 나라의 비교하려면 rate. 식만표혀
table4a  #case 
table4b  #population


table1 %>% mutate(rate = cases/population*10000)
table1 %>%  count(year, wt = cases)
table1 %>% ggplot(aes(year, cases, color = country)) + 
  geom_line() + geom_point()
#사실 비교하려는건 이게 아니다! 몇배씩 증가했나?
table1 %>% mutate(rate = cases/population*10000) %>% 
  ggplot(aes(year, rate, color = country)) +geom_line()+geom_point()

table2 #하나의 관측이 두줄에 나와있다
table3 #두개의 관측이 한줄에 나와있다
table4 #두개의 데이터셋으로 나와있다

A <- table4a %>% gather(`1999`, `2000`, key = "year", value = "cases")
#key    1999, 1999, 1999, 2000, 2000, 2000
#value  745, 37737
#새로만드는 데이터셋의 변수명을 지정
B <- table4b %>% gather(`1999`, `2000`, key = "year", value = "population")

left_join(A, B)

#spread
table2
spread(table2, key = type, value = count)
#key = type 에 변수명이 될 cases, population 지정. type 의 값이 새 데이터셋의 변수명이 된다
#
#Separate
#rate를 cases와 population으로 분리한다
table3  #기본적으로 chr 로 저장해준다 
table3 %>% separate(rate, into = c("cases", "population"))
table3 %>% separate(rate, into = c("cases", "population"), sep = "/") #특정 문자로 분할
table3 %>% separate(rate, into = c("cases", "population"), convert = TRUE) #convert 옵션을 이용하여 알맞은 type으로 변경
table5<- table3 %>% separate(year, into = c("century", "year"), sep = 2)
table5 %>% unite(new, century, year)
table5 %>% unite(new, century, year, sep= "")

stocks <- tibble(
  year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr = c( 1, 2, 3, 4, 2, 3, 4),
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)

#입력오류 2016년 1행 은 입력이 안됐다
#missing value
stocks %>% spread(year, return)
stocks %>% spread(qtr, return)
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`, `2016`)
stocks %>%
  spread(year, return) %>%
  gather(year, return, `2015`:`2016`, na.rm = TRUE)
stocks %>% complete(year, qtr)
#한번에 나타내준다. explciting missing까지 나와준다구

treatment <- tribble(
  ~ person, ~ treatment, ~response,
  "Derrick Whitmore", 1, 7,
  NA, 2, 10,
  NA, 3, 9,
  "Katherine Burke", 1, 4
)
treatment
treatment %>%
  fill(person)   
#fill():missing 을 LOCF(Last Observation Carried Forward) 규칙에 따라 채워줌.

