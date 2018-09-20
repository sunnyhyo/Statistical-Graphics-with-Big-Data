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
ggplot(mpg, aes(displ)) + geom_histogram(binwidth=0.5) + facet_wrap(~drv, ncol=1)  #

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
