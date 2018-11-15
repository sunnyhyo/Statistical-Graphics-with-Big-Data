library(tidyverse)
library(nycflights13)

who
head(who)
tail(who)


# tidy 자료가 되기 위해 필요한 변수들
# contry, year, ?==>


who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)
who1 %>% print(n = 30)
who1 %>% count(key) %>% print(n = 46)

who2 <- who1 %>% 
  mutate(key = str_replace(key, "newrel", "new_rel"))
who2 %>% count(key) %>% print(n = 46)

who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3

who3 %>% count(new) #new가 같은지 확인해보고 싶어
who4 <- who3 %>% select(-new, -iso2, -iso3)

who5 <- who4 %>% separate(sexage, c("sex", "age"), sep = 1)
#sep = 1 : 한글자 뒤에 띄우기
who5

#age 맘에 안들어

who5 %>% count(age)

who5 %>% mutate(age = str_replace(age, "65", "6599")) %>% 
  separate(age, c("ageLower", "ageUpper"), sep = -2) %>% count(ageUpper)

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>%
  mutate(code = stringr::str_replace(code, "newrel", "new_rel")) %>%
  separate(code, c("new", "var", "sexage")) %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1)