#lab5 
library(tidyverse)


ggplot(mpg, aes(displ)) + geom_freqpoly(binwidth=0.5)
ggplot(mpg, aes(displ)) + geom_freqpoly(binwidth=0.5) + facet_wrap(~drv)
ggplot(mpg, aes(displ, color=drv, shape =drv))+ geom_freqpoly(binwidth=0.5)
ggplot(mpg, aes(displ, color=drv, shape =drv))+ geom_histogram(binwidth=0.5)
# color 가장자리 선을 다르게 한다. 
ggplot(mpg, aes(displ)) + geom_histogram(binwidth = 0.5) + facet_grid(drv~cyl)
# facet_grid 앞(세로) ~ 뒤(가로)
# facet_wrap 
# 자료를 나눠서 그려준다. 유의할 점 : 자료가 너무 적어서 잘 안나타난다. 
ggplot(mpg, aes(displ)) + geom_histogram(binwidth=0.5) + facet_wrap(~drv)   #가로축을 drv 로 나눔
ggplot(mpg, aes(displ)) + geom_histogram(binwidth=0.5) + facet_wrap(~drv, ncol=1)  
#colum number 지정해줄수도 있음

ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth()
#패턴을 알려주는 보조선을 그리고 싶다 geom_smooth
#오른쪽이 이상한 이유는 자료 수가 적기 때문이다. 한 자료가 너무 dominate
#쪼개서 fitting 시키는 것이 나을 수 있다.
#자료가 많은 쪽의 패턴을 보고, 자료가 적은 쪽은 믿으면 안된다. 
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(span=0.2)
#세세한 변화를 더 감지 
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(span=5)
ggplot(mpg, aes(displ, hwy)) + geom_point() + geom_smooth(method='lm')
#선형회귀식

#타임시리즈 
economics
#date  - 내부적으로 날짜 계산 되어있음

ggplot(economics, aes(date, unemploy/pop)) +geom_point()
#x축 date, y축 unemploy/pop
#실업률 상승, 하락 확인할 수 있음. 지금은 point로 위치만 확인함
#시계열자료임, 시간에 따라 정보 축적 
ggplot(economics, aes(date, unemploy/pop)) +geom_line()
#date 변수 그림을 그리면 연도만 딱 ! 찍어서 나타내줌. 세부 옵션으로 point 바꿀 수 있음 
#x, y label은 아무 옵션이 없다면 변수 명으로 그대로
#길이의 median 값
ggplot(economics, aes(date, uempmed)) + geom_line()
ggplot(economics, aes(date, uempmed)) + geom_path()
#지료 자체가 순서대로 되어있음
ggplot(economics, aes(unemploy/pop, uempmed)) + geom_point() 
#67년부터 라인으로 글면 복잡하긴 하지만, 전체적인 패턴을 볼 수 있다. 
ggplot(economics, aes(unemploy/pop, uempmed)) + geom_point() +geom_line()
#앗 원하는 그림이 아니네?!
ggplot(economics, aes(unemploy/pop, uempmed)) + geom_path()
#path : 자료 순서대로 이어주기
#line : 자료를 x값에 대해 sorting 먼저 한 후, 그 순서대로 이어주기
#날짜 순서대로 정렬이 안되어 잇어도, line 은 먼저 sorting 해준당. 
ggplot(economics, aes(unemploy / pop, uempmed)) +
  geom_path(colour = "grey50") +
  geom_point(aes(colour = lubridate::year(date)))
#path에는 색깔지정안하고, point에만 색깔 지정
#aes 를 앞에 잡아주면, 그 이후의 모든 geom 에 해당
#aes 를 geom 에서 잡아주면, 그 geom 에만 해당
temp<- lubridate::year(economics$date)
range(temp)

ggplot(economics, aes(unemploy / pop, uempmed, colour = lubridate::year(date))) +
  geom_path() +
  geom_point()



#축지정하기

#축의 이름
p<-ggplot(mpg, aes(cty, hwy))+geom_point()
p+xlab("city driving(mpg)")+ ylab("highway")
p+xlab(NULL)  
#NULL 아예 없는 상태, x label 을 쓸 공간조차 없다!
#label을 쓰지 않고 공간을 더 넓게 쓰기 위함

#축의 범위
range(mpg$cty)
range(mpg$hwy)


p+xlim(0,40) +ylim(0,30)
#x축범위(min, max)
#범위 외의 자료는 missing 처리한다


ggplot(mpg, aes(cty, hwy))+geom_jitter()
#noise 를 준다. 전체적인 패턴을 보는데 문제가 될 수 있다. 
ggplot(mpg, aes(drv, hwy))
ggplot(mpg, aes(drv, hwy))+geom_jitter()
ggplot(mpg, aes(drv, hwy))+geom_jitter(width=0.1)
#범주일때 사용하는 것이 좋다. 

#x변수가 cartegorical 변수 일 때는 어떻게 하나
#나타내고자 하는 것만 사용한다. 
ggplot(mpg, aes(drv, hwy))+geom_jitter(width=0.1) +xlim('4','f')+ylim(0, NA)
#위에 limit은 그대로 두고 아래 limit 만 조정하고 싶다
#NA 이 위치에 값이 잇긴 한데 내가 지정은 안해줄거야~



#missing 자료에 대한 handing
a<-rnorm(10)
a[1]<-NA
a

mean(a, na.rm=TRUE)
NA+1
#missing 데이터 제외하고 숫자 계산하기


# p <-  ggplot 저장

p
print(p)
class(p)
#그림을 그리기 위해 저장된 형식 
summary(p)
#data= manumfactu
#mpg 이름은 안가져 오지만, 그 안에 있는 자료갯수 등 다들고옴

drugs<-  data.frame(drug=c('a','b','c'),
                    effect=c(4.2,9.7,6.1))
ggplot(drugs, aes(drug, effect))+geom_bar(stat='identity')
ggplot(drugs, aes(drug, effect))+geom_bar()
ggplot(drugs, aes(drug))+geom_bar()

#stat=identity 안잡아주면 y값을 잡으면안된다

#stat count
#stat identity 

#bar 차트에 아무런 옵션이 없다면 기본stat count