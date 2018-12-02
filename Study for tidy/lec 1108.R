################
# 11 월 8 일
################

library(tidyverse)
library(nycflights13)

challenge2 <- read_csv(readr_example("challenge.csv"),
                       col_types=cols(.default=col_character()))
challenge2
tail(challenge2)

challenge3 <- type_convert(challenge2)
challenge3
tail(challenge3)
getwd()
write_csv(challenge3, "ch.csv")
read_csv("ch.csv")

write_rds(challenge3, "ch.rds")
A <- read_rds("ch.rds")
A

table1
table2
table3
table4a
table4b

table1 %>% mutate
table1 %>% mutate(rate = cases/population*10000)
table1 %>% ggplot(aes(year, cases)) +
  geom_line(aes(group = country)) + 
  geom_point(aes(color = country))
table1 %>% mutate(rate = cases/population*10000) %>% 
  ggplot(aes(year, rate, group = country)) + 
  geom_point() + geom_line()
gather(table4a, `1999`, `2000`, key = "YEAR", value = "CASES")
A <- gather(table4a, `1999`, `2000`, key = "YEAR", value = "CASES")
B <- gather(table4a, `1999`, `2000`, key = "YEAR", value = "POPULATION")
A
B
left_join(A, B)
table2
spread(table2, key = type, value = count)
table3
separate(table3, rate, into = c("A", "B"))
separate(table3, rate, into = c("cases", "population"))
table1
separate(table3, rate, into = c("cases", "population"), sep = "/")
separate(table3, rate, into = c("cases", "population"), sep = "/", convert = TRUE)
separate(table3, rate, into = c("cases", "population"), sep = 2)
separate(table3, rate, into = c("cases", "population"), sep = 2, convert = TRUE)
table5
table5 %>% unite(new, century, year)
table5 %>% unite(new, century, year, sep = "")
table5 %>% unite(new, century, year, sep = "", convert = TRUE)

stocks <- tibble(year = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
                qtr = c(1, 2, 3, 4, 2, 3, 4),
                return(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66))
# 다중인자 반환은 허용되지 않는다

stocks <- tibble(year = c(2015,2015,2015,2015,2016,2016,2016),
                 qtr = c(1,2,3,4,2,3,4),
                 return = c(1.88,0.59,0.35,NA,0.92,0.17,2.66))
stocks
stocks %>% spread(year, return)
stocks %>% spread(year, return) %>% gather(year, return, `2015`, `2016`)

stocks %>% complete(year, qtr)

treatment<-tribble(    # row - by -row 는 tribble
   ~person, ~treatment,~response,
   "DW",1,7,
   NA,2,10,
   NA,3,9,
   "KB",1,4)

treatment
fill(treatment, person)
 
     