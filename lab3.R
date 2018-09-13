#Statistic graphics 
#lab3
head(iris)


getwd()
setwd("C:/Users/HS/Documents/GitHub/Statistical-Graphics-with-Big-Data")
write.csv(iris, 'irisfile.csv')
iris<- read.csv("irisfile.csv")
head(iris)


iris12<- read.table("irisfile.csv")
#옵션이 없으면 space 를 seperation 이라고 생각한다
iris12<- read.table("irisfile.csv", sep=',')
#맨 첫줄부터 변수이름이라고 생각함. 



#벡터함수 

y<- c(8,3,5,7,6,6,8,9,2,3,9,5,10,4,11)
mean(y)
range(y)
fivenum(y)
quantile(y)
table(y)


counts<- rnbinom(10000,mu=0.92, size=1.1)
counts[1:30]
table(counts)

which(y>5)
#5보다 큰 것이 어느 곳에 위치하고 잇는지 알아보는 함수 
#y 벡터에서 조건을 만족하는 인덱스 추출함수
y[which(y>5)]
y[y>5]
y>5
sum(y>5)
length(which(y>5))

######
#정렬, 순위, 순서

library(MASS)
#기초 통계에서 배우는 거의 모든 통계함수
data(mtcars)
head(mtcars)

ranks<- rank(mtcars$wt)
sorted<- sort(mtcars$wt)
ordered<- order(mtcars$wt)

view<- data.frame(mtcars$wt, ranks, sorted, ordered)
#데이터 프레임 만들기 

rev(sort(mtcars$wt))
sort(mtcars$wt, decreasing = TRUE)
sort(mtcars$wt) #decreasing = FALSE 가 defualt 값임
# 순서: 입력값을 오름차순으로 정렬한ㄴ 순열, 데이터 프레임을 정렬하는데 유용하게 쓰입

sort(mtcars$wt)
mtcars$wt[ordered]

#weight 의 order로 다른 변수들도 sorting 가능함

#######
N<- c(55,6,6,3,4,16,7,85)
seq(0.04, by=0.01, along=N)
#along 특정벡터의 크기 와 맞게 조정해줌 

seq(c(1,2,3))
sequence(c(1,2,3))

seq(c(4,3,4))
#rlfdlrk ....?
sequence(c(4,3,4))
#1부터 시작해서 길이가 4개, 3개, 4개인 함수를 만들어준다
c(1:4, 1:3, 1:4)
rep(9,5)
#9를 다섯번 반복
rep(1:4, each=2)
rep(1:4, times=2)
rep(1:4, each=2, times=2)
rep(1:4, times=1:4)  #매칭되는 수- 반복횟수
rep(1:4, times=4:1)



z- ifelse(x==y)









