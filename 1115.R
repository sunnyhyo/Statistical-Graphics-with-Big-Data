library(tidyverse)
library(nycflights13)
count <- dplyr::count

ls(pos = 2)
airlines
airports
flights
planes
weather

# primary key
# table 의 observation 을 각각 구별하는 변수.
# tailnum 은 plane table 의 각 비행기를 구별
# airlines  - carrier
# airports - faa
# flights - primary key 없음
# planes - tailnum
# weather - 5개의 변수가 합쳐져서 하나의 primary key 

# foreign key 
names(airlines)

# primary key 인지확인해보기
# 

airlines %>% count(carrier)
airlines %>% count(carrier) %>% filter(n>1)
airports %>% count(faa) %>% filter(n>1)
planes %>% count(tailnum) %>% filter(n>1)
weather %>% count(year, month, day, hour, origin) %>% filter(n>1)
flights %>% count(year, month, day, flight) %>% filter(n>1)
flights %>% count(year, month, day, flight, tailnum) %>% filter(n>1)

# Mutating joins
# 두 table 을 이용하여 변수를 합성하는 방법
# 먼저 key 를 이용하여 observation 을 맞추고 한 table 에서 
# 다른 table 로 변수를 copyㄴ
# mutate 함수와 같이 join 함수는 변수를 오른쪽에 추가. 새로운 변수는 인쇄되지 않음

flights2 <- flights %>% 
  select(year:day, origin, dest, tailnum, carrier)
flights2

flights2 %>% 
  select(-origin, -dest) %>% 
  left_join(airlines, by = "carrier")

flights2 %>%
  select(-origin, -dest) %>%
  mutate(name = airlines$name[ match(carrier, airlines$carrier) ]) 

x <- tribble(~key, ~val_x, 
               1, "x1",
               2, "x2",
               3, "x3")
x
y <- tribble(~key, ~val_y, 
             1, "y1",
             2, "y2",
             4, "y3")

x;y
left_join(x, y)  # x를 중심으로 key 값 맞춰서 join
right_join(x, y) # y를 중심으로 key 값 맞춰서 join

left_join(x, y, by = "key") # key 변수를 기준으로 join 한다
inner_join(x, y)  # 양쪽에 다 있는 것을 가져온다. 교집합

# Outer_ join
# 모든 observation 을 유지 
x %>% left_join(y, by = "key")
x %>% right_join(y, by = "key")
x %>% full_join(y, by = "key")

# Duplicate key 
x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2"
)
x;y
left_join(x, y, by = "key")


# 2. 두 table 모두 duplicated key 를 갖는 경우. 일반 DB에서는 error로 처리하나 dplyr 에서는 모든 가능한 조합을 모두 표시

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  3, "x4"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  2, "y3",
  3, "y4" #,
  #4, "y5"
)
x;y
left_join(x, y, by = "key")


# Defining the key columns
# by = "key" 에 의해 key 정의

flights2 %>% left_join(weather)
flights2 %>% left_join(planes)
#잘못됐음 
# planes$year 비행기 연식
# flights2$year 비행 날짜
flights2 %>% left_join(planes, by = "tailnum")
flights2 %>% left_join(airports, c("dest" = "faa"))
flights2 %>% left_join(airports, c("origin" = "faa"))

top_dest <- flights %>% 
  count(dest, sort = TRUE) %>% 
  head(10)
top_dest

flights %>% filter(dest %in% top_dest$dest)
#top_dest 에 있는 상위 10개 목적지, flights 의 dest 열에서 뽑아오기

flights %>% semi_join(top_dest)
