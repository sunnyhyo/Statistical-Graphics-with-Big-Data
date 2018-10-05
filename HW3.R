library(ggplot2)
library(dplyr)
summary(mpg)
glimpse(mpg)

#1. 
##mpg 자료에서 drv 별로 cty와 hwy의 분포를 알아보려고 한다. 이를 위한 다양한 그림을 그리고 설명하시오.

mpg %>% ggplot(aes(cty, hwy))+geom_point(aes(color=drv))


#2. 
##manufacturer 중 "volkswagen" 에 대한 자료만 이용하려고 한다."volkswagen"만을 선택하여 volk에 저장하시오.
volk<- mpg %>% filter(manufacturer=="volkswagen")
volk

#3. 
##volk 자료에서 model 별 cty와 hwy의 관계를 비교하려고 한다. 이를 위한 그림을
그리고 설명하시오.

volk %>% ggplot(aes(cty, hwy))+geom_point(aes(color=model))

#4. 
##volk 자료에서 연도별 cty와 hwy의 관계를 비교하려고 한다. 이를 위한 그림을 그리고 설명하시오.
table(volk$year)
volk %>% ggplot(aes(cty, hwy, color=factor(year)))+geom_point()
#5. 
##class가 “suv”인 차들의 hwy를 manufacture 별로 비교하려고 한다. 이를 위한 그
림을 그리고 설명하시오. 

mpg %>% filter(class=="suv") %>% 
  ggplot(aes(manufacturer, hwy))+geom_jitter()+ geom_boxplot(alpha=0.3) 


#6. 
##Theoph 자료를 이용하여 12명의 시간 별 혈중농도 곡선을 그리시오
##Theoph 자료는 12명의 사람으로부터 시간별로 측정한 약물의 혈중농도에 관한 자료이다.
- Subject : 12명의 ID
- Wt : 몸무게
- Dose : 복용양
- Time : 시간
- conc : 혈중농도

class(Theoph$Subject)
Theoph %>% ggplot(aes(Time, conc, color=factor(Subject))) + geom_line()
Theoph %>% ggplot(aes(Time, conc, color=factor(Subject))) + geom_line() +facet_wrap(~Subject)


