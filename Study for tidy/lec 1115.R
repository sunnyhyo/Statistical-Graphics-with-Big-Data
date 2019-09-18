##############
# 11 월 15 일
##############

library(tidyverse)
library(nycflights13)

# Relational data
# Introduction
# 대부분 자료는 하나의 table 이 아니라 여러개의 table 로 나타남.
# 여러 table 들은 각각의 자료가 아니고 관계가 있으므로 relational data 라고 부름.
# 만나는 대부분의 관계형 data 는 RDBMS(relational data base management
#                             system)으로 SQL 을 이용.
# dplyr 은 SQL 보다 사용하기 용이.
# 관계형 data 에 대하여 작업을 하기위해 알아야 하는 용어들
# 1. mutation joins: 하나의 data frame 에 다른 data frame 을 matching 시켜 새로운 변수만들기.
# 2. filtering joins : 하나의 data frame 에서 다른 data frame 의 자료와 맞는 관측이 있는지를 확인하여 자료를 걸러내기.
# 3. set operations: 관측을 마치 set element 인것처럼 다루기


   
airlines     # airlines : 비행사 code 자료. carrier 의 full name 정보.
airports     # airports: 공항 자료, 공항 code 인 faa 와 각 공항의 정보들.
planes       # planes: 각 비행기 정보. tailnum 으로 비행기 구분
weather      # weather`: NYC 공항의 시간별 날씨 정보

# flights 는 planes 와 tailnum 으로 연결
# flights 는 airlines 와 carrier 로 연결
# flights 는 airports 와 origin, dest 로 연결
# flights 는 weather 과 origin, year, month, day, hour 로 연결


####################
# Keys
# 각 table 을 연결시켜주는 변수를 key 라고 함.
# key 는 관측을 하나씩 연결시켜주는 변수.
# 하나의 변수로 충분할 수도 있고 여러 변수가 필요할 수도 있음.
# 두가지 종류의 key 가 있음.
# 1. primary key: table 의 observation 을 각각 구별하는 변수. tailnum 은 plane table 의 각 비행기를 구별
# 2. foreign key: 다른 table 에서의 한 관측을 구별. flights 의 tailnum 은 foreign key.

# primary key 에 대해서는 count 를 이용하여 unique 한지 확인하는 것이 필요.
airlines %>% count(carrier)    # 항공사 수 찾기 
airlines %>% count(carrier) %>% filter(n > 1)   # primary key 
# 각각의 obs 별로 다른 값을 가지는 변수 

airports %>% count(faa) %>% filter(n > 1)       # primary key
planes %>% count(tailnum) %>% filter(n > 1)     # primary key

# 때로는 명확한 primary key 를 갖지 않을수도 있음.
# 각 row 는 observation 이지만 변수의 combination 으로도 primary key 를 만들 수 없는 경우도 있음.
weather %>% count(year, month, day, hour) %>% filter(n > 1)
weather %>% count(year, month, day, hour, origin) %>% filter(n > 1)
weather %>% filter(year == 2013, month == 11, day == 3)
weather %>% filter(year == 2013, month == 11, day == 3, origin == "EWR")  # Foreign Key

flights %>% count(year, month, day, flight) %>% filter(n > 1)
flights %>% count(year, month, day, tailnum) %>% filter(n > 1)

# - table 에 prime key 가 없다면 mutate 나 row_number 함수를 이용하여 만드는 것이 유용. 이를 surrogate key 라고 함.
# - prime key 와 이에 대응되는 foreign key 는 또 다른 형태의 relation.
# - relation 은 대부분 1:다 대응임. 각 flight 는 하나의 비행기이지만 하나의 비행기는 여러 flight 를 나타냄.
# - 다:다 대응, 또는 다:1 대응도 가능.


######################
# Mutating joins
# - 두 table 을 이용하여 변수를 합성하는 방법.
# - 먼저 key 를 이용하여 observation 을 맞추고 한 table 에서 다른 table 로 변수를 copy.
# - key 지정을 안하면 같은 이름의 변수명으로 join 을 한다. 
# - mutate 함수와 같이 join 함수는 변수를 오른쪽에 추가. 새로운 변수는 인쇄되지 않음.

flights2 <- flights %>% select(year:day, hour, origin, dest, tailnum, carrier)
flights2

# flights2 자료에 airline 의 full name 정보를 추가하기 위해서는 airlines 과 flights2 를 left join.
flights2 %>% left_join(airlines, by="carrier")    # carrier 를 기준으로 두 dataset 연결
# mutate 로 같은작업 할 수 있음
flights2 %>% mutate(name = airlines$name[match(carrier, airlines$carrier)])  

# join 이해하기
# 색으로 표현된 부분이 같은 key 를 나타냄.
# join 은 아래의 그림에서 선으로 나타난 연결 중 필요한 부분을 연결하는 것.
x <- tribble(~key, ~val_x, 
             1, "x1",
             2, "x2",
             3, "x3")
x

y <- tribble(~key, ~val_y, 
             1, "y1",
             2, "y2",
             3, "y3")
y

left_join(x, y)
left_join(x, y, by = "key")

inner_join(x, y)
full_join(x, y)

x  <- tribble(~key, ~val_x,
              1, "x1",
              2, "x2")
x

x <- tribble(~key, ~val_x,
             1, "x1",
             2, "x2",
             3, "x3",
             1, "x4")
y <- tribble(~key, ~val_y,
             1, "y1",
             2, "y2")
x
y

left_join(x, y)
left_join(y, x)


x <- tribble(~key, ~val_x,
             1, "x1",
             2, "x2",
             2, "x3",
             3, "x4")
y <- tribble(~key, ~val_y,
             1, "y1",
             2, "y2",
             3, "y3",
             4, "y4")
left_join(x, y)



