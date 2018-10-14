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

bb<-drugs %>% ggplot(aes(drug, effect)) + geom_bar(stat='identity')
summary()

#하나의 범주형 자료와 하나의 연속형 자료
pp<-ggplot(mpg, aes(drv, hwy)) +geom_point()
summary(pp)
ggplot(mpg, aes(drv, hwy)) +geom_boxplot()
ggplot(mpg, aes(drv, hwy)) +geom_jitter()
ggplot(mpg, aes(drv, hwy)) +geom_violin()


a<-ggplot(data = mpg, aes( hwy))
a + geom_histogram(binwidth = 5)
a + geom_histogram(binwidth = 10)

aa<-a + geom_histogram(bins = 4)
a + geom_histogram(bins = 7)
summary(aa)
summary(pp)
a + geom_freqpoly(bins = 4)
a + geom_freqpoly(bins = 7)

#연속, 연속
f<- ggplot(mpg, aes(cty, hwy))
f+ geom_text(aes(label=cty))  #geom_text에는 label 옵션 필수
f+ geom_text(aes(label=cty), check_overlap = TRUE) #중복된 것을 적지 않는 옵션수
#범례가 나오지 않음

f+ geom_smooth(method="lm")
f+ geom_smooth(method="lm", se=FALSE)
f+ geom_smooth(span=1)
f+ geom_smooth(span=10)  #숫자가 클수록 smooth
f+ geom_line()
f+ geom_path()

#연속, 범주
g<- ggplot(mpg, aes(class, hwy))

bb<-g + geom_bar()
summary(bb)

bb<-g + geom_bar(stat = "identity") # y변수의 값이 count 
summary(bb)


####stat 할때 다시보기
g+ geom_boxplot() #카운트가 고려안되어있음 point 랑같ㅇ
g+ geom_violin()
g+ geom_jitter(width=0.1)

#범주, 범주
h <- ggplot(diamonds, aes(cut, color))
h+ geom_point()
h+ geom_jitter()

#연속형 변수 분포 
dfi<- data.frame(x=rnorm(2000), y=rnorm(2000))
i<- ggplot(dfi, aes(x,y))
i + geom_bin2d()
i + geom_bin2d(binwidth=1, na.rm = TRUE)
i+ geom_bin2d(bins=1)
i + geom_bin2d(bins=50)
i + geom_hex()

#연속형
j <- ggplot(economics, aes(date, unemploy)) 
j+geom_line()
j+geom_area()

#면적놈들
dfd<- data.frame(x=c(6,2,12),y=c(4,8,12))
d<- ggplot(dfd,aes(x,y))
d+geom_polygon()
d+geom_ribbon(aes(ymin=y-1, ymax=y+1)) + geom_line(color="red")
dfd$z<- c(1,5,10)
d+ geom_tile()+geom_point(color="red")
d+ geom_raster(stat="identity")
d+ stat_identity(geom="raster")

+geom_point(color="red")
d+ geom_rect(aes(xmin=1, xmax=5, ymin=2, ymax=5)) +
  geom_point(color="red")

library(tidyverse)
# 3가지 변수들
ggplot(faithfuld, aes(eruptions, waiting)) %>% + geom_contour(aes(z=density, color=..level..)) #내부함수
ggplot(faithfuld, aes(eruptions, waiting)) +
  geom_contour(aes(z=density))  #z 로 잡아줌 
ggplot(faithfuld, aes(eruptions, waiting)) +
  geom_contour(aes(z=density, color=..level..))  #z 로 잡아줌


ggplot(faithfuld, aes(eruptions, waiting)) + 
  geom_raster()   #암것도 안나옴
ggplot(faithfuld, aes(eruptions, waiting)) + 
  geom_raster(aes(fill=density)) #full 로 잡아줌..
#전체를 잘게 쪼개서 제 3의 변수 색칠해주기



####
#stat
?stat_summary
?geom_smooth

#####
dfc<-data.frame(x=1:3, y=1:3, se=c(1.2,0.5,1.0))
base<- ggplot(dfc, aes(x,y, ymin=y-se, ymax=y+se))
base+geom_point()+geom_smooth()
base+geom_point()+geom_smooth(stat="identity")             
AAA<-base+geom_smooth(stat="identity")             
summary(AAA)




