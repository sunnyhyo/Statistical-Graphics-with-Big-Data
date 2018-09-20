install.packages('tidyverse')
library(tidyverse)

mpg
head(iris)

class(iris)
class(mpg)  #dataframe 에 다른 정보 저장해놔서 더 많은 정보를 보여준다. 

?mpg

plot(mpg$displ, mpg$hwy)
mpg %>% ggplot(aes(x=displ, y=hwy)) + geom_point()
mpg %>% ggplot(aes(displ, hwy)) + geom_point()

#dataframe 데이터
#aesthetic mapping 심미적 요소 할당, x, y축 그림그리는 것의 기본
#at least one layer - geom function

summary(mpg)
#tibble  factor 로 저장이 안되어 있고 character 로 저장되있음
summary(mpg$class)
#보고싶으면 
table(mpg$class)
summary(factor(mpg$class))

#color 
mpg %>% ggplot(aes(x=displ, y= hwy, color=class)) + geom_point()
#카테고리가 너무 많아서 잘 안보임
#효율이 제일 좋은 차 sub compact 
#기름 젤많이 드는 차 suv
#2seater 은 스포츠카 


tapply(mpg$hwy, mpg$drv, mean)
tapply(mpg$hwy, mpg$drv, length)

X11()
win.graph()
mpg %>% ggplot(aes(x=displ, y= hwy)) + geom_point() + facet_wrap(~class)
mpg %>% ggplot(aes(x=displ, y= hwy, color=class)) + geom_point() + facet_wrap(~class)
#class 변수에 따라서 graph 따로 그리기

#자료를 어떻게 표현할 것인지. 자료 뭐보여줄건지? 
#자료를 가지고 어떻게 잘 보여주나. 어떤 표현을 한 그림을 그릴 것인지

#density plot 
#count 가 다를 때 분포를 확인하기 위해 밀도함수를 그린다.

#histogram
#x 변수 하나만 지정.
mpg %>% ggplot(aes(x=hwy)) +geom_histogram()
mpg %>% ggplot(aes(x=hwy)) +geom_histogram(binwidth= 2.5)
#stat_bin() bin=30 디폴트값 . bin size 에따라서 그림이 달라짐.  

#freqpoly
#각 꼭짓점의 가운데를 이어서 그린 점 
#히스토그램보다 분포에 가까운 그림. 여러 개를 겹쳐서 그릴 때 ㄱㅊ
mpg %>% ggplot(aes(x=hwy)) +geom_freqpoly()

#barchart
#하나의 범주형 자료일 때
mpg %>% ggplot(aes(x=class)) + geom_bar()

#정리된 자료일때는? 
drugs<-  data.frame(drug=c('a','b','c'),
                    effect=c(4.2,9.7,6.1))
drugs

drugs %>% ggplot(aes(drug, effect)) + geom_bar(stat='identity')


#하나의 범주형 자료와 하나의 연속형 자료
ggplot(mpg, aes(drv, hwy)) +geom_point()
ggplot(mpg, aes(drv, hwy)) +geom_boxplot()
ggplot(mpg, aes(drv, hwy)) +geom_jitter()
ggplot(mpg, aes(drv, hwy)) +geom_violin()
