#HW4
library(tidyverse)

#1. 
##mpg 자료의 displ과 hwy를 이용하여 아래의 그림을 그리기 위한 code를 작성하시오.
##분수를 나타내기 위해 frac(miles, gallon))를 이용하면 됨.

ggplot(mpg, aes(displ, hwy)) + geom_point() + 
  ylab(quote(paste("Highway","(",frac(miles,gallon),")")))+ 
  xlab("Displacement") + 
  scale_x_continuous(breaks= c(2,3,4,5,6,7), labels= paste0(c(2,3,4,5,6,7),"L"))


#2. 
##아래의 code를 실행시키고 문제점을 파악한 후 문제점을 수정한 그림을 그리시오.

ggplot(mpg,aes(displ,hwy))+   
  geom_point(aes(colour=drv,shape=drv))+   
  scale_colour_discrete("Drive train") 

#Drive train 범례가 같은 단위임에도 불구하고 
#색깔별 범례와 모양별 범례가 각각 그려져 있어 전달하는데 문제가 있다. 

##해결
ggplot(mpg, aes(displ, hwy, color= drv)) + 
  geom_point(aes(shape= drv), show.legend = TRUE) +
  scale_colour_discrete("Drive train") + 
  scale_shape_discrete("Drive train")



#3. 
##mpg 자료에서 drv 별로 cyl와 hwy의 분포를 알아보려고 한다. 
##이를 위한 다양한 그림을 그리고 설명하시오
table(mpg$cyl)
#drv 별로 cyl의 분포
ggplot(mpg, aes(factor(cyl), fill= drv)) + geom_bar() + facet_wrap(~drv)
#drv 4는 cyl이 4,6,8만 존재. 5는 값이 없음. cyl 높은 것의 수가 많음
#drv f는 cyl이 4,6 수가 많은 것에 비해 5,8은 없다
#drv r은 cyl이 6,8만 존재함. drv 중 r 의 수가 가장 적ㄷ

mpg %>% group_by(drv) %>% summarise(min(hwy),max(hwy))
#drv 별로 hwy의 분포
ggplot(mpg, aes(hwy, fill= drv)) + geom_histogram(bins=20) + facet_wrap(~drv)
#drv 4는 12<= hwy <= 28 사이에 존재
#drv f는 17<= hwy <= 44
#drv r는 15<= hwy <= 26


#drv 별로 cyl와 hwy의 분포
ggplot(mpg, aes(cyl, hwy, group= drv)) + geom_jitter(aes(color=drv)) + facet_wrap(~drv)

ggplot(mpg, aes(factor(cyl),hwy ))+geom_jitter(aes(color=drv), alpha=0.3)+
  geom_boxplot(aes(fill = drv), alpha=0.8) + facet_wrap(~drv)
#모든 drv에서 cyl 이 클수록 hwy 작아지는 경향을 보인다. 
#다만 drv 4와 r dml hwy는 대략 30 이하에 많이 분포된 것에 반해
#drv f의 hwy 는 25이상에 많이 분포하고 있다


#4. 
##mpg 자료의 displ(x변수)와 hwy(y 변수)의 산점도에서 
##class 별로 선형회귀직선을 그려 아래와 같은 그림을 얻고자 한다. 이에 맞는 code를 작성하시오.


ggplot(mpg, aes(displ, hwy, color=class))+ geom_point()+
  geom_smooth(method="lm", se= FALSE) + 
  theme(legend.position = "bottom")






