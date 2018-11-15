# HW #6 (2018. 11. 15(화) 14:00pm까지 제출)
# * tidyverse 에서 제공하는 table2 자료를 이용

library(ggplot2)
library(tidyverse)
table2

# 1. 각 연도별, 나라별, TB 수를 뽑아내시오.
a <- spread(table2, key = type, value = count) %>% select(-population);a

# 2. 각 연도별, 나라별로 population 수를 뽑아내시오.
b <- spread(table2, key = type, value = count) %>% select(-cases);b

# 3. 1,2의 결과를 이용하여 비율을 계산하시오.
left_join(a, b) %>% mutate(rate = cases/population) %>% select(-cases, -population)

# * tidyverse의 table4a와 table4b를 이용.
# 4. 각 연도별, 나라별, TB 수를 뽑아내시오.
a <- table4a %>% gather(`1999`, `2000`, key = "year", value = "cases");a

# 5. 각 연도별, 나라별로 population 수를 뽑아내시오.
b <- table4b %>% gather(`1999`, `2000`, key = "year", value = "population");b

# 6. 1,2의 결과를 이용하여 비율을 계산하시오.
left_join(a, b) %>% mutate(rate = cases/population) %>% select(-cases, -population)


# 7. 시간에 따른 TB 수의 변화를 나라별로 나타내는 그림을 table2를 이용하여
# 그리시오.
table2 %>% spread(key = type, value = count) %>% 
  ggplot(aes(year, cases)) +
  geom_line(aes(group = country), colour = "grey50") +
  geom_point(aes(colour = country)) + 
  scale_x_continuous(breaks = c(1999, 2000), labels = c("1999", "2000"))
             
 
# 8. gather()과 spread()는 대칭적인 함수인가?
#   아래의 예를 실행시켜보고 이를 이용하여 설명하시오.
stocks <- tibble(
  year = c(2015, 2015, 2016, 2016),
  half = c( 1, 2, 1, 2),
  return = c(1.88, 0.59, 0.92, 0.17)
);stocks
stocks %>%
  spread(year, return) %>%
  gather("year", "return", `2015`:`2016`)

# 대칭적이라고 할 수 있다.
# spread 한 뒤에 gather 을 한 자료를 보면 원자료의 rows와 columns 가 같기 때문이다. 
