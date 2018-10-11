library(tidyverse)

diamonds

ggplot(diamonds, aes(depth)) + geom_histogram()
range(diamonds$depth)
#범위를 보니 43, 79
#짤리는 범위가 있다...
ggplot(diamonds, aes(depth)) + 
  geom_histogram() +xlim(55, 70)
ggplot(diamonds, aes(depth)) + 
  geom_histogram(binwidth = 0.1) +xlim(55, 70)
#예쁜 종모양 !!
?diamonds
#total depth percentage = z / mean(x, y) = 2 * z / (x + y) (43–79)
ggplot(diamonds, aes(depth)) +
  geom_histogram()+xlab(quote(paste("depth=2*",frac(z,(x+y))))) 
# xlab을 예쁘게 쓰고 싶어 integral 
# quote 인용해라
# paste A, B 하면 
paste("A","B")  #space 띄우고 두 문자열 합치기
# frac 함수는 ???????
#depth = 2* z/ (x+y)

#컷별로 depth 다른것을 보고 싶다
#1. 
ggplot(diamonds, aes(depth)) +
  geom_freqpoly(aes(colour = cut), binwidth = 0.1, na.rm = TRUE) +
  xlim(58, 68) +   #na.rm =TRUE 뜻? missing 자료는 빼라
  theme(legend.position = "none") #legend.position ="none" 뜻?
#2.
ggplot(diamonds, aes(depth,colour = cut)) +  #legend 여기에 있다...
  geom_freqpoly(binwidth = 0.1, na.rm = TRUE)
#color : 선, 점의 색깔이 바뀜
#fill : 영역의 색깔이 바뀜

ggplot(diamonds, aes(depth,fill=cut)) + geom_density( binwidth=0.1) +
  xlim(58, 68)
ggplot(diamonds, aes(depth)) + geom_density(aes(fill=cut), binwidth=0.1) +
  xlim(58, 68)
# y축은 density : 각 곡선의 면적이 1이 되도록 색칠
# 문제는 가려진 애들 알 수 없다. 투명하게 그려보자
ggplot(diamonds, aes(depth)) + geom_density(aes(fill=cut), binwidth=0.1, alpha=0.3) +
  xlim(58, 68)
#fill, color 까지 다르게 ???  aplha 는 fill에만 적용된다
ggplot(diamonds, aes(depth)) + geom_density(aes(fill=cut, color= cut), binwidth=0.1, alpha=0.3) +
  xlim(58, 68)

#왜 density 밑면의 넓이를 맞춰주나요?
#count 로 세어진 것은 분포의 비교를 할 수 없다. 
#count 가 워낙 작기 때문에 그림이 바닥에 깔린다... 

table(diamonds$cut)
#각각 population 차이 까지 함께 고려하자

ggplot(diamonds, aes(depth)) +
  geom_histogram(aes(fill = cut))+xlim(58, 68)
#전체 자료를 bin 나눈다. 각 bin 에서 색칠을 idel 몇개인지 세서 칠하고 premiun 세서 그만큼 색칠한다..
#각각의 자료를 stak으로 쌓는 것이 기본옵션임                 
ggplot(diamonds, aes(depth)) +
  geom_histogram(aes(fill = cut), position = "fill")+xlim(58, 68)
#position = "fill" 다 칠해버려라...
#모지:? 전체 fill을 퍼센트로 채워줘라!!! 
#컷별로 분포를 알 수 있다. histogram 보다 

#position ="identity" 
#바 차트를 그릴 떄 자료가 categorical 자료가 아닐 떄 . 그린다.  범주형 자료가 아닐 때 바로 그려버려라 
#우리가 넣어준 그대로 써라.



ggplot(diamonds, aes(depth)) +
  geom_histogram(aes(fill = cut), 
                 binwidth = 0.1, position = "fill",
                 na.rm = TRUE) +
  xlim(58, 68) +
  theme(legend.position = "none")

ggplot(diamonds, aes(depth)) +
  geom_density(na.rm = TRUE) +
  xlim(58, 68) +
  theme(legend.position = "none")


ggplot(diamonds, aes(depth, fill = cut, colour = cut)) +
  geom_density(alpha = 0.2, na.rm = TRUE) +
  xlim(58, 68) +
  theme(legend.position = "none")

ggplot(diamonds, aes(clarity, depth)) +
  geom_boxplot()



######################
ggplot(diamonds, aes(carat, depth)) + 
  geom_boxplot(aes(group = cut_width(carat, 0.1)))
###????
diamonds$AA<- cut_width(diamonds$carat, 0.1)
#다이아몬드 캐럿을 0.1 단위로 짤라서 붙여라
table(diamonds$AA)


ggplot(diamonds, aes(AA, depth)) + geom_boxplot()
#원래 범주였던 애들은 group 지정 안해줘도 ㅇㅋ
ggplot(diamonds, aes(carat, depth)) + geom_histogram()
#ERROR 뜬다. 연속형- 연속형이라서 그ㅐㄹ
ggplot(diamonds, aes(carat, depth)) + geom_boxplot(aes(group = cut_width(carat, 0.1)))
# 범주형에 들어갈 부분에 연속형이 들어가소 문제가 생긴다.
#group 을 씌워주면서 바꿔줘라


#######################
df<- data.frame(x= rnorm(2000), y = rnorm(2000))
ggplot(df, aes(x,y))+geom_point()
ggplot(df, aes(x,y))+geom_point(shape="A")
ggplot(df, aes(x,y))+geom_point(shape=1)
ggplot(df, aes(x,y))+geom_point(shape=".")
ggplot(df, aes(x,y))+geom_point(size=3, alpha= 0.3)

#independent 이기 때문에 전혀 관계 없어 보인다. 
#어느정도로 그려야 겹쳐진 것을 볼 수 있을 까???

'''
jittering 이 유용한 것?
  수십개가 겹쳐져있을떄 
이 예시에서는 이미 수십개가 겹쳐져 있기 때문에 소용없을 수 잇따
오히려 aplha 옵션을 조정해서 농도를 조정해하!
   아니면 점 모양을 바꿔보시던가.!'''

ggplot(df, aes(x,y))+geom_bin2d()
ggplot(df, aes(x,y))+geom_bin2d(bins= 10)
#카운트가 낮은 것은 진하게, 낮은 것은 높게 하고 싶엉
#디폴트갖이 어둡 -> 밝은 이유는? 경계가 불명확할까바
ggplot(df, aes(x,y))+geom_bin2d() + 
  scale_fill_gradient(low='skyblue', high= 'black')
#값 낮음 -> 높음, 흰색-> 어둡
#절대 끝까지는 안감!!!!!

#다양하게 원하는 형태의 색깔을 그릴ㄹ 수 있엉!!!!


####################
ggplot(df, aes(x,y))+geom_hex()
#육각형 그림! 앞에서 네모난 것보다는 스무스하게 그릴 수 가 있지.
#점을 크게 찍어놓은 것 만 같구만~ 영역을 지정하고 그 안에 들어가는 bin 수 를 센다능.



##############
#상자그림 그릴 때 조심해야할것은? 
ggplot(, aes())


#중앙값은 비슷하고 ㄲ리가 비슷비슷
#똑같은 상자를 그렸지만, 상자그림을 그릴 때 만들었던 데이터 자료 수 가 다르다
#그림 자체 수로 비료할 수 있기 때문에 ㅜㅜ 조심해야한다
#이럴 때는 점을 같이 찍어주는 것이 좋다. 


#########################
#각 color 별로 price 다른 것은 몰까?!?!!??!?!?!?!?!?
#원 자료만 가지고 있는데 평균을 계산해서 나타내주고 싶어

summary(ggplot(diamonds, aes(color)) + geom_bar()  )
#원래 범주 자료 하나만 널던가..
                      #cartegorical / continu
#count 를 각 bar 별로 나타낸다. 
#summary 해서 보면 stat_count 가 기본 값이다. 
#bin 에 대한 summary 를 보여준다구 

ggplot(diamonds, aes(color, price)) + 
  geom_bar(stat="summary_bin", fun.y=mean)
#price를 color 별로 나눠서 평균을 내고 싶다.
#y 변수에 대해서 stat- bin을 보여주시오 
# bar차트를 그리는데 y (color) 별로 평균을 그려내!
ggplot(diamonds, aes(color, price)) + 
  geom_bar(stat="summary_bin", fun.y=max)

#####################

#평균적으로 어디가 가장 높은지 알고 싶다

ggplot(diamonds, aes(color, depth, z= price))+
  geom_raster(binwidth= 1, stat= "summary_2d", )












