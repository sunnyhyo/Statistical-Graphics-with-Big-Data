##############
# 11 월 12 일
##############
# 물어볼 것 tidy 라고 할 수 있는지?
library(tidyverse)
library(nycflights13)

who       # tidy 아님! # 7,240 x 60
tail(who)

who1 <- who %>% gather(new_sp_m014:newrel_f65, key = "KEY", value = "cases")
who1     # 405,440 x 6

who1 <- who %>% gather(new_sp_m014:newrel_f65, key="KEY", value="cases", na.rm=TRUE)
who1     # 76,046 x 6   # NA 제거

who1 %>% count(KEY)
who2 <- who1 %>% mutate(KEY = str_replace(KEY, "newrel", "new_rel"))

# 각 값은 하나의 셀에 저장되어야 한다. 하지만 한 셀에 4가지 정보가 있음 문제!
# seperate 여러 셀로 column 을 나눠준다
who3 <- who2 %>% separate(KEY, c("new", "type", "sexage"), sep = "_")
who3

who3 %>% count(new)    # new 한가지 타입 뿐이네
who3 %>% count(type)   # 4가지 type 이 있다
who3 %>% count(sexage) # 성별과 나이 붙어져서 문제다!

who4 <- who3 %>% select(country, year, type, sexage, cases)  # 필요한 변수만 골라서 저장
who4
who5  <- who4 %>% separate(sexage, c("sex", "age"), sep = 1)  # sep = 1 앞에서 한자리 분리
who5

who4 %>% separate(sexage,c("sex","age"),sep=2)  # sep = 2 앞에서 두자리 분리
who4 %>% separate(sexage,c("sex","age"),sep=-1) # sep = 

who5 %>% count(age)

who5 %>% mutate(age = str_replace(age, "65", "6500")) %>% 
  separate(age, c("ageL","ageU"), sep = -2, convert = TRUE) %>% 
  mutate(ageU = ifelse(ageU == 0 , 80, ageU))


####과제 7
whoTidy <‐ who %>% gather(code,value,new_sp_m014:newrel_f65,na.rm=TRUE) %>%
  mutate(code=str_replace(code,"newrel","new_rel")) %>%
  separate(code,c("new","type","genderage")) %>%
  select(‐new,‐iso2,‐iso3) %>%
  separate(genderage,c("gender","age"),sep=1) %>%
  mutate(age=str_replace(age,"65","6500")) %>%
  separate(age,c("ageL","ageU"),sep=‐2,convert=TRUE) %>%
  mutate(ageU=ifelse(ageU==0,80,ageU),
         age=(ageL+ageU)/2) %>%
  select(country,year,type,gender,ageL,age, ageU,value)
