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

n<-10
1:n-1
1:(n-1)
10:1
seq(-5, 5, by=1.5)
#-5에서 5를 넘지 않는 선에 서 1.5씩 증가하며 sequence 만들기 

seq(-5, 5, length =3)
seq(-5, 5, length =5)
#-5, 5 가 start, end point 등간격으로 sequence 만들기 

?seq
#help file 볼 수 있음 
  

x<-c('A','B')
rep(x,2)
rep(x,each=2)  
rep(x,times=2)
x<-1:5
x>3
x==3
x!=3
as.numeric(x!=3)

x1<- 'A is the first letter \n ahhah'
cat(x1)

x2<- 'A is \t the first letter'
cat(x2)


paste(c('X','Y'), 1:2, sep='')
paste(c('X','Y'), 1:4, sep='')
paste(c('X','Y'), 1:5, sep='')


#개체(objects)의 타입들 







