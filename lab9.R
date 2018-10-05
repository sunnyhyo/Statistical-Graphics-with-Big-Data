#lab9 
#1004

df <- data.frame(x = 1:3, y = 1:3, color = c(1,3,5))
df

ggplot(df, aes(x, y, color= color)) + geom_point()    #점의 색 순서대로 진해졌다 연해짐 (연속)
ggplot(df, aes(x, y, color= factor(color))) + geom_point()  #factor 로 하면 각 점이 색깔로 변함
ggplot(df, aes(x, y, color= color)) + geom_line() + geom_point()   
# 점도, 선도 연속이다. 

ggplot(df, aes(x, y, color= factor(color))) + geom_line() + geom_point()   
#color 에 cartegorical variable 이 들어가면 color 옵션이group 으로 작동한다.
#점만 찍어주고 선 색깔은 내가 지정한다. 
ggplot(df, aes(x, y, color= factor(color))) + geom_line() + geom_point()   
#fill, shape, color 등 group 형태로 잡히면, group 처럼 작동한다. 

ggplot(df, aes(x, y, color= factor(color))) + geom_line(aes(group=1)) + geom_point()   
#group 이라는 정보를 새로 줬다. 전체 데이터가 하나의 데이터다. 변수 이름이 아닌 하나의 그룹이 생성
#ggplot 에서 지정된 색깔의 영향을 받음/

ggplot(df, aes(x, y, color= factor(color))) + geom_line(aes(group = 3), size =2)+ 
  geom_point(size=5)
#geom_line(size= 2) 선 굵게 하기
#geom_point(size= 5) 점 굵게 하기 



############################
#shape 모양
df1<- data.frame(x= 1:6, y=1:6, color = c(1,1,3,3,5,5))
df1

ggplot(df1, aes(x, y, color= factor(color)))+ geom_line() + geom_point(size=3)
ggplot(df1, aes(x, y, color= factor(color)))+ geom_line() + geom_point(size=3, shape =2)
#geom_point(shape= )  점의 모양을 바꿀 수 있다. 

ggplot(df1, aes(x, y, color= factor(color)))+ geom_line() + geom_point(aes(shape=3))
#모양을 연속형 변수로 표현할 수 없다. 

ggplot(df1, aes(x, y, color= factor(color)))+ geom_line() + geom_point(size=3)  #1번
#처음 ggplot 을 만나면서 지정된 아이들 다 mapping 맞춰준다. color 에 범주형 변수들어가면, 그룹대로 지정해준다
#geom_line()에서 이전에 지정했던 그룹대로 선을 그어준다. 
ggplot(df1, aes(x, y, color= factor(color)))+ geom_line(aes(group=1)) + geom_point(size=3)  #2번
#geom_line(group=1) 여기서 그룹을 새로 잡아서, 앞서 지정한 그룹은 없어지고, 
#특정 geom 에서 지정한 그룹대로 만들어준다 

#group 잡는 법. 
#1번) 전체에서 overall 하게 그룹잡아주기
#2번) 각 geom 에서 그룹잡아주기

?as.factor
?factor

###################
#fill 채우기

table(mpg$class)
table(mpg$drv)
table(mpg$class, mpg$drv)   #이거 그림에 나타내고 싶다!!!!!

ggplot(mpg, aes(class)) + geom_bar()
ggplot(mpg, aes(class, fill = drv)) + geom_bar()   
#밑에서부터 stack 한 bar chart 나온다..
ggplot(mpg, aes(class, fill = drv)) + geom_bar() + 
  theme(axis.text.x= element_text(angle=45, hjust=0))
#x축의 text 부분 = element_text(각도를 45도로 정렬, 위쪽에서부터 정렬 (0 옵션은 시작부분부터 정렬됨))


###################
# contour
# eruptions 와 wating, 어디서 많이 일어나니?

ggplot(faithfuld, aes(eruptions, waiting)) + geom_contour(aes(z=density, color=..level..)) #내부함수
ggplot(faithfuld, aes(eruptions, waiting)) + geom_contour(aes(z=density))

ggplot(faithfuld, aes(eruptions, waiting)) + geom_raster()
ggplot(faithfuld, aes(eruptions, waiting)) + geom_raster(aes(fill=density)) #범주형/연속형이니?


###################
# buble plot

ggplot(faithfuld, aes(eruptions, waiting)) + geom_point()  #점 졸라많당
ggplot(faithfuld, aes(eruptions, waiting)) + geom_point(size=0.1)
ggplot(faithfuld, aes(eruptions, waiting)) + geom_point(aes(size=density))

small<- faithfuld[seq(1, nrow(faithfuld), by=10),]
dim(small)
dim(faithfuld)
ggplot(small, aes(eruptions, waiting)) + geom_point(aes(size=density))
ggplot(small, aes(eruptions, waiting)) + geom_point(aes(size=density), alpha=0.5)
#실제로 자료가 없는 부분도 scaling 해서 자동으로 plot에 보여주기 때문에 plot 을 볼 때 주의해야한다. 
#density 없는 것을 없다고 보여주기
ggplot(small, aes(eruptions, waiting)) + geom_point(aes(size=density), alpha=0.3) + 
  scale_size_area()



###################
# 그림 다양하게 그리기!
#가운데 평균, 주변에 다른거.. 더하고 빼기

df2<- data.frame(x=1:3, y=c(18, 11, 16), se= c(1.2,.5, 1.0))
df2

g<- ggplot(df2, aes(x, y, ymin= y-se, ymax= y+se))
#y 의 min, max 잡아주기 

g+ geom_crossbar()  
g+ geom_errorbar()  
g+ geom_linerange()  
g+ geom_pointrange()  

g+ geom_smooth(stat= 'identity')
# 준 값 그대로 그려..
g+ geom_ribbon()



###################################
###################################
#그림을 그리는 목적 - 통계자료분석
#summary 된 데이터를 보고 싶다. 
#weight 조정해서 봅시다 

#각각의 백인의 비율과 하위계층의 비율

midwest
table(midwest$state)

ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point()

#뚝 떨어진 주. 다른 성격의 주. 
#일반적으로 적어진다. population 보고싶어! -> size 추가하기

ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point(aes(size = poptotal / 1000000), alpha=0.3)
#대도시로 갈수록 백인의 비율은 떨어지는구만?

#pdf 과 다른부분? legend 가 달라진다. 
#예쁜 legend 를 만들어보자 
ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point(aes(size = poptotal / 1000000), alpha=0.3)#+
  #geom_size_   ????

ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point() +
  geom_smooth(method=lm, size=1)


ggplot(midwest, aes(percwhite, percbelowpoverty)) + 
  geom_point(aes(size = poptotal / 1000000), alpha=0.3) +
  geom_smooth(aes(weight = poptotal), method=lm, size=1)



















