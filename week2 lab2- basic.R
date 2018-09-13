b2<- matrix(1:6, ncol=3, nrow=2)
b3<- matrix(c('a','b',1,2), ncol=2)
A%*%t(B)



x1<-c(1,2,3)
x2<-c(4,5,6)
rbind(x1,x2)
cbind(x1,x2)


#array  3차원 이상의 자료 
#matrix 의 차원을 확장시킨 것 


#index
zz<- matrix(1:12, ncol=6)
zz
zz[1,6]
zz[,6]
zz[,6, drop=FALSE]
zz[1,3:5]
zz[1,3:5, drop=FALSE]


x1<-1:3
x2<-c('a','b','c')
x3<-1:6
b6<- data.frame(A1=x1, A2=x2)
class(b6$A1)
class(b6$A2)

#길이가 다른 경우 data frame 을 만들지 못한다 
#길이가 다르면 list 만들기

b7<- list(A1=x1, A2=x2, A3=x3)


length(b6)
length(b7)

Lst<-list(name= 'Fred', 
          wife= 'Mary', 
          no.children= 3, 
          child.ages= c(4,7,8))
Lst$name


items<- list(name=c('박효선', '박소현'),
             age=c(23,20),
             student=c(TRUE, FALSE),
             notes= c(1:5))

length(items$name)
length(items$age)
length(items$student)
length(items$notes)

#함수를 리스트 각각에 적용하라!
lapply(items, length)


summary(items)
str(items)

head(iris)



