library(tidyverse)
library(ggplot2)

flights$missing <- ifelse(is.na(flights$arr_time), "cancelled", "non-cancelled")
flights %>% ggplot(aes(dep_time, color = missing)) + 
  geom_density()
# 5시부터 12시 비행이 비교적 많이 취소된다

flights %>% group_by(month) %>% summarise(n = n()) %>% 
  ggplot(aes(factor(month), n)) + geom_bar(stat = "identity")
# 1, 2월은 비교적 작다

flights %>% mutate(Date = as.Date(paste(year, month, day, sep = "-"))) %>%
  group_by(Date, missing) %>% summarise(n = n()) %>% 
  ggplot(aes(Date, n, color = missing))+geom_line()
# 취소된 비행은 1000건 아래이다. 


Q4 <- flights %>% group_by(tail_num) %>% 
  summarise(n = mean(missing=="cancelled", na.rm = TRUE)) %>% 
  arrange(desc(n))
Q4 %>% mutate(r = dense_rank(desc(n))) %>% filter(r<=10) %>% 
  arrange(r) %>% 
  ggplot(aes(tail_num, n)) +geom_bar(stat = "identity")+coord_flip()
# 비행기별 취소율 상위 10위 뽑아낸 결과이다. 특정 비행기는 취소율이 높다. 

