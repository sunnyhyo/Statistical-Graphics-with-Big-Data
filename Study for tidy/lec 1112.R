##############
# 11 월 12 일
##############

library(tidyverse)
library(nycflights13)

# 1980 년부터 2013 년까지의 WHO 의 TB 원자료.
# – country : 나라이름
# – iso2,iso2 : 나라이름에 대한 code
# – new_sp_m014 - new_rel_f65: 그룹별 새로운 결핵(TB:Tuberculosis)환자수
# – rel: relapse, sn:negative pulmonary smear, sp:extrapulmonary
# – f:female, m:male
# – 014:0~14 세, 1524:15~24 세, …, 65: 65 세이상

who       # tidy 아님! # 7,240 x 60
tail(who)


# tidy 자료를 위해 필요한 변수들.
# 1. country
# 2. year
# 3. ? ==> 일단 cases 로 new_sp_m014 부터 newrel_f65 변수를 합치기.

who1 <- who %>% gather(new_sp_m014:newrel_f65, key = "KEY", value = "cases")
who1     # 405,440 x 6

who1 <- who %>% gather(new_sp_m014:newrel_f65, key="KEY", value="cases", na.rm=TRUE)
who1     # 76,046 x 6   # NA 제거

# KEY 변수 살펴보기
who1 %>% count(KEY)
key 값의 의미
# 1. 첫부분 “new”
# 2. 두번째 부분
# – rel :cases of relapse
# – ep : cases of extrapulmonary TB
# – sn : cases of pulmonary TB that could not be diagnosed by a pulmonary smear
# (smear negative)
# – sp : cases of pulmonary TB that could be diagnosed be a pulmonary smear
# (smear positive)
# 3. 세번째 부분: 환자 성별 males (m) and females (f).
# 4. 나머지 숫자들: age group
# – 014 = 0 – 14 years old
# – 1524 = 15 – 24 years old
# – 2534 = 25 – 34 years old
# – 3544 = 35 – 44 years old
# – 4554 = 45 – 54 years old
# – 5564 = 55 – 64 years old
# – 65 = 65 or older


# 먼저 newrel 을 new_rel 로 변환
who2 <- who1 %>% mutate(KEY = str_replace(KEY, "newrel", "new_rel"))

# key 를 searate() 함수를 이용하여 분리
# 각 값은 하나의 셀에 저장되어야 한다. 하지만 한 셀에 4가지 정보가 있음 문제!
# seperate 여러 셀로 column 을 나눠준다
who3 <- who2 %>% separate(KEY, c("new", "type", "sexage"), sep = "_")
who3

who3 %>% count(new)    # new 한가지 타입 뿐이네
who3 %>% count(type)   # 4가지 type 이 있다
who3 %>% count(sexage) # 성별과 나이 붙어져서 문제다!

# 필요 없는 변수 new, iso2, iso3 제거
who4 <- who3 %>% select(country, year, type, sexage, cases)  # 필요한 변수만 골라서 저장
who4

# sexage 를 sex 와 age 로 분리
who5  <- who4 %>% separate(sexage, c("sex", "age"), sep = 1)  # sep = 1 앞에서 한자리 분리
who5

who4 %>% separate(sexage,c("sex","age"),sep=2)  # sep = 2 앞에서 두자리 분리
who4 %>% separate(sexage,c("sex","age"),sep=-1) # sep = 

who5 %>% count(age)
who5 %>% mutate(age = str_replace(age, "65", "6500")) %>% 
  separate(age, c("ageL","ageU"), sep = -2, convert = TRUE) %>% 
  mutate(ageU = ifelse(ageU == 0 , 80, ageU))


# pipe 를 이용하여 한 번에 처리하기
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>%
  mutate(code = stringr::str_replace(code, "newrel", "new_rel")) %>%
  separate(code, c("new", "var", "sexage")) %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1)


####과제 7

whoTidy <- who %>% gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>%
  mutate(code = str_replace(code, "newrel", "new_rel")) %>%
  separate(code, c("new", "type", "genderage")) %>%
  select(-new, -iso2, -iso3) %>%
  separate(genderage, c("gender", "age"), sep=1) %>%
  mutate(age = str_replace(age, "65", "6500")) %>%
  separate(age, c("ageL", "ageU"), sep = -2, convert = TRUE) %>%
  mutate(ageU = ifelse(ageU == 0, 80, ageU),
         age = (ageL + ageU)/2) %>%
  select(country, year, type, gender, ageL, age, ageU, value)

