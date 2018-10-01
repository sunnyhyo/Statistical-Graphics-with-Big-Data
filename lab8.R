getwd()
library(tidyverse)

#미국 실업률 데이터 
ggplot(economics, aes(date, unemploy))+geom_line()

#67년 이후의 데이터만 뽑아서, 두 dataset 의 날짜를 맞추기 위함  
presidential <- subset(presidential, start > economics$date[1])

#미국대통령 정당 바뀔때마다 색깔 다르게 하기 
ggplot(economics) + 
    geom_line(aes(date, unemploy)) +   # x,y 축 지정
    geom_rect(   #직사각형 만들기, x범위 지정해주기. 
    aes(xmin = start, xmax = end, fill = party), #fill party 에 따라서 변수색 다르게 칠해주기
    ymin = -Inf,  ymax = Inf, alpha = 0.2,  #infinity
    data = presidential
    #끝까지 채워주기. aes(ymin=-Inf)하면 변수로 인식하기 때문에 aes() 바깥에서 지정
  ) +
  geom_vline( #vertical line : x축에 대한 정보를 지정해줘야함
    aes(xintercept = as.numeric(start)),  
    data= presidential,  #start 변수는 presidential 데이터셋안에 있어서 데이터 다시 잡아줌
    color = 'gray50', alpha = 0.5  
    #아까 그려진 것 까지 선이 그려짐
  ) + 
  geom_text(
    aes(x = start, y = 2500, label = name), 
    data = presidential, 
    size = 3, vjust = 0, hjust = 0, nudge_x = 50  #just글씨 위아래, 좌우정렬 
    #0 means left-justified
    #1 means right-justified
    #x 50떨어진 곳에 글쓰기
  ) + 
  scale_fill_manual( values= c('blue', 'red'))
  #democratic 할당된 색깔 바꿔주기
  #fill 로 party 채워져있음. fill 색깔 조정하는 함수. 순서대로 넣어준다. 
  
#핸드아웃과 다른 점, x, y축의 이름
#우리가 geom을 한 순서대로 그려진다. 




############################
#annotate()


yrng <- range(economics$unemploy)  #y 변수의 범위
xrng <- range(economics$date)      #x 변수의 범위
caption <- paste(strwrap("Unemployment rates in the US have
                         varied a lot over the years", 40), collapse = "\n") #enter와 같다 줄바꾸

A<-strwrap("Unemployment rates in the US have
                         varied a lot over the years", 40)
paste(A, collapse = '\n') #두개의 문장을 \n 으로 이어라
print(paste(A, collapse = '\n')) #print문 : 1번에 1가지만 가능, 결과 출력한 뒤 개행(줄바꿈)이 일어남
cat(paste(A, collapse = '\n'))   #cat문 : 여러개 출력 가능, 복잡한 형태 출력 불가. 확장 문자열을 해석된 그대로 문자열 출력하기 



############################
#diamonds

ggplot(diamonds, aes(carat, price)) + geom_point()
ggplot(diamonds, aes(carat, price)) + geom_point(alpha=0.2)
ggplot(diamonds, aes(log10(carat), log10(price))) + geom_point()
ggplot(diamonds, aes(log10(carat), log10(price))) + geom_point(alpha=0.2)
#선들이 보이는 이유? 소비자가 선호하는 n캐럿 숫자 맞추려구 ~ 

ggplot(diamonds, aes(log10(carat), log10(price))) + 
         geom_bin2d() #2차원 분포로 보여줘!
         #연한 쪽 많고, 진한쪽 count 적다
ggplot(diamonds, aes(log10(carat), log10(price))) + 
  geom_bin2d() + facet_wrap(~cut, nrow = 1)  
  #컷 별로 알아보기 위해 facet 사용. 나란히 비교하기 위해 1줄로 정렬

#음...price의 상한이 이상한걸? 일정 상한까지 자료가 있나보다. 확인 필요함


#보조선 추가하기
mod_coef <- coef(lm(log10(price)~log10(carat), data = diamonds))  #lm의 coef 만 추출해서 저장
#(Intercept) log10(carat) 
#3.669207     1.675817 
ggplot(diamonds, aes(log10(carat), log10(price))) + 
  geom_bin2d() + 
  geom_abline(intercept = mod_coef[1], slope = mod_coef[2], color='white', size=1)+
  facet_wrap(~cut, nrow = 1)  


#그룹별로 mapping 하기
data(Oxboys, package = 'nlme')
head(Oxboys)
#grouped data  class 를 보면 26명의 소년에 대한 자료
#각 소년마다 9 번 관측하고 , 측정 할 때 나이, 키 저장되어있다!
#궁금한거 : 각 소년마다 얼마나 자랐는지 알아보자 
#profile plot 그리기 !


ggplot(Oxboys, aes(age, height, group= Subject)) +
  geom_point() + geom_line( )   #각 그룹별로 따로따로 그림을 그려준다. 
#색깔 다르게 하고 싶으면? color= Subject?!?!?
ggplot(Oxboys, aes(age, height)) +
  geom_point() + geom_line()

ggplot(Oxboys, aes(age, height, group = Subject)) +  #aeS(group) 하위의 모든 그림에 group 정용된다. 
  geom_line()+
  geom_smooth(method = 'lm', size = 2, se=FALSE)
  #자료에 linear fitting  
  #힝 근데 나는 전체적인 linear line 을 보고 싶다구...
ggplot(Oxboys, aes(age, height)) +  #aeS(group) 하위의 모든 그림에 group 정용된다. 
  geom_line(aes(group = Subject ))+  #FALSE 하면 색깔 안나오
  geom_smooth( method = 'lm', size = 2, se=FALSE)


#상자그림 위에 Subject 별 profile line 그리기
ggplot(Oxboys, aes(Occasion, height))+ 
  geom_boxplot()
ggplot(Oxboys, aes(Occasion, height))+ 
  geom_boxplot()+
  geom_line(colour = "#3366FF", alpha = 0.5)

#occasion 이 categorical 변수로 인식된다 ㅠㅠ그 자체가 그룹이 됨

ggplot(Oxboys, aes(Occasion, height))+ 
  geom_boxplot()+
  geom_line(aes(group= Subject), colour = "#3366FF", alpha = 0.5)


ggplot(Oxboys, aes(age, height)) + geom_boxplot()
   # x 변수를 그룹으로 인식하고 boxplot 그림
   # x 변수가 연속형이면 warning 알려주고 하나의 그룹으로 생각하기


