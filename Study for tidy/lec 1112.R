##############
# 11 월 12 일
##############

library(tidyverse)
library(nycflights13)

who      # 7,240 x 60
tail(who)

who1 <- who %>% gather(new_sp_m014:newrel_f65, key = "KEY", value = "cases")
who1     # 405,440 x 6

who1 <- who %>% gather(new_sp_m014:newrel_f65, key="KEY", value="cases", na.rm=TRUE)
who1     # 76,046 x 6

who1 %>% count(KEY)
who2 <- who1 %>% mutate(KEY = str_replace(KEY, "newrel", "new_rel"))

who3 <- who2 %>% separate(KEY, c("new", "type", "sexage"), sep = "_")
who3

who3 %>% count(new)
who3 %>% count(type)
who3 %>% count(sexage)
who4 <- who3 %>% select(country, year, type, sexage, cases)
who4
who5 <- who4 %>% separate(sexage, c("sex", "age"), sep = 1)
who5

who4 %>% separate(sexage,c("sex","age"),sep=2)
who4 %>% separate(sexage,c("sex","age"),sep=-1)

who5 %>% count(age)
