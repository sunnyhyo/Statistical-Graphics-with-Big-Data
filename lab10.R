library(tidyverse)

##########
#geom_* 
#그래프 위에 각 data mapping 하는 방식

##############
#stat_*
#산점도에 통계량 표시하기

ggplot(mpg, aes(trans, cty))+ geom_point()+
  stat_summary(geom= 'point', fun.y = 'mean', color = 'red', size=4)
ggplot(mpg, aes(trans, cty)) + 
  geom_point() + 
  geom_point(stat = 'summary', fun.y = 'mean', color= 'red', size = 4)
#trans 범주형 변수 
#각 trans 별로 통계량을 알고 싶다.
#geom_* 과 stat_* 왔다 갔다 할 수 있당 
#fun.y : y 변수에 통계량을 씌울건데, mean 통계량을 씌울 것이다. 
#geom = '' size =4인 red point 를 찍을게 
ggplot(mpg, aes(trans, cty))+ geom_point()+
  stat_summary(geom= 'point', fun.y = 'mean', color = 'blue', size=3) #옵션변화
B<- ggplot(mpg, aes(trans, cty))+ geom_point()+
  geom_point(stat= 'summary', fun.y = 'mean', color = 'blue', size=3)
A<- ggplot(mpg, aes(trans, cty))+ geom_point()
summary(A)   # 이 plot 이 어떻게 설정되어 있는지 확인 할 수 있다. 
#stat_identity 
summary(B)   #모든 geom 에 stat 이 걸려있음. stat 에는 geom이 걸려있지 않을 있 ㅇ다. 
#stat_summary fun.y = 'mean'


############
#내부 함수 
#- ..count..: 각 범주의 관측수
#– ..density..:각 범주의 관측에 대한 비율 (percentage of total / bar width)
#– ..x..: 각 범주의 중심


#생성된 새로운 변수 
ggplot(diamonds, aes(price))+ 
  geom_histogram(binwidth = 500)   #디폴트 y scale 는 ..count.. 이다

ggplot(diamonds, aes(price))+     # y scale 을 density 로 지정했음
  geom_histogram(aes(y = ..density..), binwidth = 500)  
# density 를 새로 계 ㅎ한 게 아니라 내부적으로 사용하는 함수이

ggplot(diamonds, aes(price, color = cut)) + geom_freqpoly(binwidth = 500)
ggplot(diamonds, aes(price, color = cut)) + 
  geom_freqpoly(binwidth = 500) +   #히스토그램 끝 이었다. 컷별로 다르게 그림
  theme(legend.position = 'none')
# legend 의 위치를 아예 없애라
#왜이럴까? 이런 식으로 그리면 다 덜러 보인다. 이 선은 비교하기가 힘들다.
#전체 면적이 1이 되는 density 를 그려서 각 cut 별로 price 를 비교해보자

ggplot(diamonds, aes(price, color = cut)) + 
  geom_freqpoly(aes(y= ..density..), binwidth = 500)+
  theme(legend.position = 'none')
#fair 가 이 근처 price 에서 좀 띈다.. 대부분은 1000 불레서 2000불 미만이다. 
#density로 비교불가능했던 것(count)을 비교가능하게 해보자!!!! 

########################
#title
df<- data.frame(x= 1:2, y= 1, x= 'a')
p<- ggplot(df, aes(x, y)) + geom_point(aes(color =2))
p + 
  xlab ("X axis") + 
  ylab("Y axis") + 
  ggtitle("TITLE")
  
p + labs(x = "X axis", y = "Y axis", colour = "Colour\nlegend")
#legend 의 color 다르게 한다. 범주처럼? 

p <- ggplot(df, aes(x, y)) +
  geom_point() +
  theme(plot.background = element_rect(colour = "grey50"))
p + labs(x = "", y = "")   #아무것도 안넣을 수 도 있음, x 레이블에 영역(위치)는 잡아주되 쓸 것이 없다
p + labs(x = NULL, y = NULL)   #영역(위치)도 안잡고, 아예 안쓰겠다 

#######################
df1<- data.frame(x=1:2, y = 1, z='a')
df1


p<- ggplot(df1, aes(x, y)) + geom_point(aes(color=Z))
p
p<- ggplot(df1, aes(x, y)) + geom_point()
p
p+theme(plot.background = element_rect(color='red'))
#plot 의 background 에서 가장자리 직사각형을 red 선으로 만든다


###########
#tips 조정하는 것 !

df2<- data.frame(x= c(1,3,5) *1000, y = 1)
df2

ggplot(df2, aes(x, y)) + geom_point() + labs(x= NULL, y= NULL)
# x 레이블을 보자. 1000, 2000, 3000, 4000, 5000
# y 레이블을 보자. 0.5, 0.75, 1.00, 1.25, 1.50
# 5 개 간격이 default 


#scale 간격을 바꾸고 싶다!!!!!
#scale_x_continuous()
ggplot(df2, aes(x, y)) + geom_point() + labs(x= NULL, y= NULL)+
  scale_x_continuous(breaks= c(2000,4000))
# x 변수가 연속형 변수: scale_x_continuous()
# x 변수가 범주형 변수: scale_x_discrete()
#breaks= tip 을 어디에 써줄것인지 결정
#labels= labels 에 해당되는 애들을 써줄게

ggplot(df2, aes(x, y)) + geom_point() +
  scale_x_continuous(breaks= c(2000,4000), labels= c('2k','3k'))
ggplot(df2, aes(x, y)) + geom_point() +
  scale_x_continuous(breaks= c(2000,4000), labels= c(1,1))


#####################
#

df3<- data.frame(x= 1:3, y= c('a','b','c'))
df3
ggplot(df3, aes(x, y))+ geom_point()
ggplot(df3, aes(x, y))+ geom_point() + 
  scale_y_discrete(labels= c(a= 'apple',b='banana', c='carrot'))
ggplot(df3, aes(x, y))+ geom_point() + 
  scale_y_discrete(labels= c(a= 'apple',b='banana'))
#y축의 scale에 이름을 붙여보자
#labels 안에서 지정해주는 것은 mapping 을 해주는 것이다. !
#지정을 안해주면 원래 lables 이름을 사용한다

################
#Legends

df4<- data.frame(x= 1, y=1:3, z= letters[1:3])
df4
p<-ggplot(df4, aes(x, y, color=z)) 
p + geom_point()
p + geom_point() + geom_path()
  #점 세개가 다르른 그룹을로 잡혀있는게 없다면
  #이전에 color = z 에서 지정된 그룹을 사용한다....
p + geom_point() + geom_path(aes(group=1))
  #이전에 사용했던 group 이 아니라 '1' 이라는 새로운 그룹으로 잡아준다.
  #전체가 같은 그룹인 것을 말해주고 싶어..
p + geom_point() + geom_path(aes(group=1), show.legend = FALSE)
  #각각의 선
  #path 에 대한 legend를 없애줄 수 있다. 

p + geom_point() + geom_path(aes(group=c(1, 1, 2)))
#처음 두개 점은 1번 그룹, 세번째 점은 2번 그룹
#같은 group의 path 만들어준다..

#############
#그룹별로 다르게 지정해주고 싶다
#color: 가장자리 색을 다르게 만들어줄래 
#fill: 색칠을 다르게 만들어줄래 

p + geom_raster()
p + geom_raster(aes(fill = z))

ggplot(df4, aes(x,y)) + 
  geom_point(size=4, color="grey20")+  #aes() ,color : legend 안그리는 것이 디폴트
  geom_point(aes(color=z), size=2)    #aes(color): legend 그리는 것이 디폴트
#까만점을 그릴떄는 legend 가 없엇져... aes() 안에 하냐 안하냐 차이
#legend 에는 까만점이 없어
#그리고 싶다면? 
ggplot(df4, aes(x,y)) + 
  geom_point(size=4, color="grey20", show.legend = TRUE)+
  geom_point(aes(color=z), size=2)


#순서대로 그린다.!!!
ggplot(df4, aes(x,y)) + 
  geom_point(aes(color=z), size=2)+ 
  geom_point(size=4, color="grey20", show.legend = TRUE)

# 바탕그리기 , color 점 그리기 , 까만점 그리기



















