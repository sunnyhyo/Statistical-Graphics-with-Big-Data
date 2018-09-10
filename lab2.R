library(dplyr)
library(tidyr)
library(ggplot2)

#lab2
#
x <- c(1,2,3,4,5)
log(x)
log10(x)
exp(x)
sin(2*pi)
pi
sqrt(x)

x<-c(-1,1)
log(x)
#NaN not a number, 계산을 못하는 아이들
x<-c(1:10)
range(x)
length(x)
prod(x)
sum(x)
sum(x)/length(x)
(x-mean(x))^2
sum((x-mean(x))^2)
sum(((x-mean(x))^2)/(length(x)-1))
var(x)
sqrt((sum(x-mean(x))^2)/(length(x)-1))
sd(x)

1:10
c(1,2,3,4,5,6,7,8,9,10)
2*1:10
#1에서 10까지 sequence에 2를 곱함






