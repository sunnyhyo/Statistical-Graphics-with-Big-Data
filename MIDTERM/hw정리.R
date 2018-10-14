##################
library(tidyverse)
##문제풀이
setwd("C:/Users/HS/Documents/GitHub/Statistical-Graphics-with-Big-Data/data")
heights<- read.csv("heights.csv")
#2. 성별에 따라 연봉의 차이가 있는가?
#   (범주)     (연속)
#한개의 연속변수 그래프를, 두개그리기
ggplot(heights, aes(earn)) + geom_histogram() + facet_wrap(~sex)
ggplot(heights, aes(earn, fill= sex)) +geom_histogram()  #stack 기본옵션
ggplot(heights, aes(earn, fill= sex)) +geom_histogram(position = "dodge")
ggplot(heights, aes(earn, fill= sex)) +geom_histogram(position = "fill")
ggplot(heights, aes(earn, fill= sex)) +geom_histogram(position = "stack")

ggplot(heights, aes(earn, color= sex)) + geom_freqpoly()
ggplot(heights, aes(earn, fill= sex)) + geom_density()

#한개의 연속변수 , 한개의 범주형 변수
ggplot(heights, aes(sex, earn)) + geom_boxplot()
ggplot(heights, aes(sex, earn)) + geom_violin()
ggplot(heights, aes(sex, earn)) + geom_bar(stat="identity")
ggplot(heights, aes(sex, earn)) + geom_jitter()

#5. 연봉과 키가 관계가 있는가?
#    (연속)  (연속)

#두개의 연속형 변수
class(heights$ed)
ggplot(heights, aes(height, earn)) + geom_point()
ggplot(heights, aes(height, earn)) + geom_smooth()
ggplot(heights, aes(height, earn)) + geom_smooth(method="lm")
ggplot(heights, aes(height, earn)) + geom_smooth(method="lm", se=FALSE)
ggplot(heights, aes(height, earn)) + geom_jitter()
ggplot(heights, aes(height, earn)) + geom_text(aes(label= sex))
ggplot(heights, aes(height, earn)) + geom_text(aes(label= sex),  check_overlap = TRUE)

#6. 인종별로 성별에 차이가 있나?
# (범주)   (범주)
# 범주, 여러개 그리기
ggplot(heights, aes(race)) + geom_bar() + facet_wrap(~sex)
ggplot(heights, aes(race, fill= sex)) + geom_bar()
ggplot(heights, aes(race, fill= sex)) + geom_bar(position = "fill" )
ggplot(heights, aes(race, fill= sex)) + geom_bar(position = "dodge")

# 범주, 범주
ggplot(heights, aes(race, sex)) + geom_jitter()



#6-1인종별로 성별에 따라 연봉차이가 있는가?
#   (범주)     (범주)          (연속)

#범주& 연속, 그래프를 여러개
# x= 성별, y= 연봉 그래프를 인종별로 여러개 그리기
ggplot(heights, aes(race, sex)) + geom_jitter()

ggplot(heights, aes(sex, earn)) + geom_boxplot()
ggplot(heights, aes(sex, earn)) + geom_violin()
ggplot(heights, aes(sex, earn)) + geom_jitter()
ggplot(heights, aes(sex, earn)) + geom_bar(stat="identity")
ggplot(heights, aes(sex, earn)) + geom_bar()   #오류
ggplot(heights, aes(sex, earn)) + geom_histogram()  #오류

ggplot(heights, aes(sex, earn)) + geom_boxplot() + facet_wrap(~race, ncol=4)
ggplot(heights, aes(sex, earn)) + geom_violin()+ facet_wrap(~race)
ggplot(heights, aes(sex, earn)) + geom_jitter()+ facet_wrap(~race)
ggplot(heights, aes(sex, earn)) + geom_bar(stat="identity")+ facet_wrap(~race)

ggplot(heights, aes(sex, earn, fill= race)) + geom_bar(stat="identity")
ggplot(heights, aes(sex, earn, fill= race)) + geom_bar(stat="identity", position="dodge")
ggplot(heights, aes(sex, earn, fill= race)) + geom_bar(stat="identity", position="fill")

ggplot(heights, aes(sex, earn, color= race)) + geom_jitter()
ggplot(heights, aes(sex, earn, fill= race)) + geom_boxplot()   ############이거 그려보기
ggplot(heights, aes(sex, earn, color= race)) + geom_boxplot()
ggplot(heights, aes(sex, earn, fill= race)) + geom_violin()

ggplot(heights, aes(sex, earn, group= race)) + geom_jitter()
ggplot(heights, aes(sex, earn, group= race)) + geom_jitter(aes(shape=race))

#히트맵
ggplot(heights, aes(sex, race))+ geom_raster(aes(fill= earn))
ggplot(heights, aes(sex, race))+ geom_tile(aes(fill= earn))

ggplot(heights, aes(sex, cut_width(earn)))+ geom_raster(aes(fill= sex)) #NO
ggplot(heights, aes(sex, race))+ geom_contour(aes(z=earn))  #NO

#facet
ggplot(heights, aes(earn)) + geom_histogram() + facet_grid(sex~race)

####

#7. 조사된 자료에서 인종별로 나이의 분포가 같은가?
#                         (범주)    (연속)
#1범주 1연속
ggplot(heights, aes(race, age))+ geom_bar(stat="identity")
ggplot(heights, aes(race, age))+ geom_boxplot()
ggplot(heights, aes(race, age))+ geom_violin()
ggplot(heights, aes(race, age))+ geom_jitter()

#1연속 여러개
ggplot(heights, aes(age, fill=race))+ geom_histogram()
ggplot(heights, aes(age, fill=race))+ geom_histogram(position="fill")
ggplot(heights, aes(age, fill=race))+ geom_histogram(position="dodge")
ggplot(heights, aes(age, fill=race))+ geom_histogram() + facet_wrap(~race)
ggplot(heights, aes(age, fill=race))+ geom_freqpoly()

ggplot(heights, aes(age, colour=race))+ geom_density()


###########################
#HW3

#1. mpg 자료에서 drv 별로 cty와 hwy의 분포를 알아보려고 한다. 이를 위한 다양한 그림을 그리고 설명하시오.  
#  (범주)  (연속) (연속)
ggplot(mpg, aes(cty, hwy, color= drv)) + geom_point()
ggplot(mpg, aes(cty, hwy, color= drv)) + geom_jitter()
ggplot(mpg, aes(cty, hwy)) + geom_text(aes(label = drv))
ggplot(mpg, aes(cty, hwy)) + geom_text(aes(label = drv), check_overlap= TRUE)
ggplot(mpg, aes(cty, hwy, color= drv)) + geom_smooth()
ggplot(mpg, aes(cty, hwy, color= drv)) + geom_smooth(se= FALSE)
ggplot(mpg, aes(cty, hwy, color= drv)) + geom_smooth(method="lm")
ggplot(mpg, aes(cty, hwy, color= drv)) + geom_line()  #이상하지 ㅋㅅㅋ

ggplot(mpg, aes(cty, hwy)) + geom_point() + facet_wrap(~drv)
ggplot(mpg, aes(cty, hwy, color= drv)) + geom_point() + facet_wrap(~drv)
ggplot(mpg, aes(cty, hwy, color= drv)) + geom_point() + facet_grid(.~drv)
ggplot(mpg, aes(cty, hwy, color= drv)) + geom_point() + facet_grid(drv~.)

#2. manufacturer 중 "volkswagen" 에 대한 자료만 이용하려고 한다. "volkswagen"만을 선택하여 volk에 저장하시오.
volk <- mpg[mpg$manufacturer == "volkswagen", ]
volk1 <- subset(mpg, manufacturer == "volkswagen")
head(volk1)

ggplot(volk, aes(cty, hwy, color = model)) + geom_point()
ggplot(volk, aes(cty, hwy, color = model)) + geom_jitter()

ggplot(volk, aes(cty, hwy)) + geom_text(aes(label= model, color = model), check_overlap=TRUE) +
  ggtitle("volk")+
  scale_x_continuous(name="ctct", breaks=c(20,30), labels= c("banana","30!")) +
  scale_y_continuous(name="haha", breaks=c(30,40), labels= c("$30","$40"))+ 
  theme(plot.title=element_text(family="serif",face="bold", angle=90, hjust=1, vjust=0)) +
  theme(plot.background = element_rect(color="pink", fill= "grey")) + 
  theme(legend.position = "bottom") +
  theme(axis.title.x= element_text(color="blue")) +
  theme(axis.text.x= element_text(color="red")) +
  theme(axis.title.y= element_text(angle= 00, hjust= 0.5, vjust=0.5))+
  theme(axis.text.y= element_text(angle=45, color="yellow"))

ggplot(volk, aes(cty, hwy)) + 
  geom_text(aes(label= model, color = model), check_overlap=TRUE) +
  scale_x_continuous(name="ctct", breaks=c(20,30), labels= c("banana","30!")) +
  scale_y_continuous(name="haha", breaks=c(30,40), labels= c("$30","$40"))+
  scale_color_discrete(name="MODEL")


subset()
data(economics)


ggplot(mpg, aes(cty, hwy)) +geom_point(aes(color= drv, shape=drv), show.legend = FALSE)+
  geom_smooth(aes(color=drv))
ggplot(mpg, aes(cty, hwy)) +geom_point(aes(color= drv))+
  geom_point(aes(shape= drv))+
  geom_smooth(aes(color=drv))+
  theme(legend.position = c(0.85, 0.2)) + 
  annotate("text",x=10, y=45, label="hi", size=10)+
  annotate("rect", xmin=10 , xmax=15, ymin=10, ymax=30, alpha = 0.2, fill = "skyblue") +
  geom_label(data=DF , aes(label= LABEL))
geom_smooth(method = )
DF <- data.frame(cty=c(10,30), hwy=c(20,40), LABEL= c("peak1", "peak2"))
?geom_label()
?geom_abline(slope, intercept)

head(economics)
head(presidential)

economics$date[1]
presidential$start[1]

presidential<- subset(presidential, start > economics$date[1])
head(presidential)
presidential$start[1]

ggplot(volk, aes(cty, hwy, color = model)) + geom_smooth()

A<-matrix(c(1,0,1,2,3,5,1,4,6),ncol=3)
1<-1:3
A%*%x  #3x1
x%*%A  #1x3
x%*%A%*%x  #1x1
A%*%x%*%A  #오류
z<-1:24
class(z) 
dim(z) <-c(2,4,3)

z[1,,]
z[,1,]
z[,,1]

z[1,2,]
z[,1,2]

z[1,2,3]
zz<-1:12
dim(zz)<-c(2,6)
class(zz)


A<-array(1:6,dim=c(3,2))
B<-array(11:16,dim=c(3,2))
C<-array(6:1,dim=c(3,2))


A+B
A%*%t(B)
?mode


X1<-1:3
X2<-c("A","B","C")
b6<-data.frame(x1=X1,x2=X2)
mode(b6)  #자료의 저장형태 - list???   #문자&숫자라서
class(b6) #개체의 저장형태 - dataframe
class(X1) #개체의 저장형태 - int
mode(X1)  #자료의 저장형태 - num
class(X2)  #개체의 저장형태  - character  (vector의 경우에는 자료&개체형태가 character)
mode(X2)   #자료의 형태  - charater


b6<-data.frame(x1=c(1,2,3),x2=c(4,5,6))
mode(b6)   #list
class(b6)  #dataframe


Lst<-list(name="Fred",
          wife="Mary",
          no.children=3,
          child.ages=c(4,7,9))
Lst


Lst[5] <-list(A="hyosun")
Lst[[5]]<-list(A="hyosun")

Lst$jiin<- c("hi", "hello")

#list
#lapply(list, function)

apples <- c(4,4.5,4.2,5.1,3.9)
oranges <- c(TRUE, TRUE, FALSE)
chalk <- c("limestone", "marl","oolite", "CaC03")
cheese <- c(3.2-4.5i,12.8+2.2i)
list <- list(apples,oranges,chalk,cheese)
class(list)
lapply(list, length)
lapply(list, mean)
lapply(list, is.numeric)



################
x<-c(-5:5,NA)
x
x+1
(x+1)[!is.na(x)]
(x+1)[x>0]
(x+1)[!is.na(x)| x>0]
rep(c(1,2,2,1),times=4) #1221 1221 1221 1221
rep(c(1,2,2,1),each=4) #1111 2222 2222 1111
rep(c(1:4),c(1:4)) #1 22 333 4444

c("x","y")[rep(c(1,2,2,1),times=4)]


####################
#tapply
?tapply

income<-c(60,59,20,49,60,39,59,48,74,28)
statef<-factor(c("A","B","C","A","C","D","A","D","C","B"))

tapply(income,statef,mean)
tapply(income,statef,sd)
tapply(iris$Sepal.Length, iris$Species,mean)

tapply(x, index, function)
#    x를 index 에 대해 function 적용

data(Oxboys, package = "nlme")
library(tidyverse)
###########
summary(Oxboys$age)
ggplot(Oxboys, aes(age, height)) + geom_boxplot()
ggplot(Oxboys, aes(age, height)) + geom_boxplot(aes(group=cut_width(age,0.4)))
ggplot(Oxboys, aes(age, height)) + geom_boxplot(aes(fill=cut_width(age,0.4)))



#######
#lec9

df<- data.frame(x=1:3, y=1:3, color=c(1,3,5))
ggplot(df, aes(x,y, color= factor(color)))+ geom_point(size=5)
ggplot(df, aes(x,y, color= factor(color)))+ geom_point(size=5) + geom_line()
ggplot(df, aes(x,y, color= factor(color)))+ geom_point(size=5) + geom_line(aes(group=1))


ggplot(df, aes(x,y, color=color))+ geom_point(size=5)
ggplot(df, aes(x,y, color=color))+ geom_point(size=5) + geom_line(size=2, color="pink")

ggplot(df, aes(x,y, color=color))+ geom_point(size=5) +geom_line(size=2)
ggplot(df, aes(x,y, color=color))+ geom_point(size=5) +geom_line(aes(group=1),size=2)
?..*..

#####
#Bubble

small<- faithfuld[seq(1, nrow(faithfuld),by=10),]
ggplot(small, aes(eruptions, waiting)) + geom_point(aes(size = density), alpha=1/3)
ggplot(small, aes(eruptions, waiting)) + geom_point(aes(size = density), alpha=1/3)+
  scale_size_area()

ggplot(diamonds, aes(price, color= cut))+
  geom_freqpoly(binwidth=500)
ggplot(diamonds, aes(price, color= cut))+
  geom_freqpoly(aes(y=..density..), binwidth=500)
ggplot(diamonds, aes(price, color= cut))+
  geom_freqpoly(stat="density", binwidth=500)
ggplot(diamonds, aes(price, color= cut))+
  stat_density(geom="freqpoly", binwidth=500)



ggplot(diamonds, aes(price))+ 
  geom_histogram(binwidth=300)
ggplot(diamonds, aes(price))+ 
  geom_histogram(binwidth=300, aes(y=..density..))
ggplot(diamonds, aes(price))+ 
  geom_histogram(binwidth=300, stat="density")
ggplot(diamonds, aes(price))+ 
  stat_density(geom="bar", binwidth=300)


#############
df <- data.frame(x=1, y=1:3, z=letters[1:3])
ggplot(df, aes(y,y)) + 
  geom_point(size = 4, color= "gray20")+
  geom_point(aes(color = z), size = 2)

ggplot(df, aes(y,y)) + 
  geom_point(size = 4, color= "gray20", show.legend = TRUE)+
  geom_point(aes(color = z), size = 2)

ggplot(mpg, aes(displ, hwy)) + 
  geom_point(aes(color= drv, shape= drv))

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = drv, shape = drv)) +
  scale_colour_discrete("Drive train")

ggplot(mpg, aes(displ, hwy)) +
  geom_point(aes(colour = drv, shape = drv, size=cty)) +
  scale_colour_discrete("Drive train")+
  scale_shape_discrete("Drive train") +
  scale_size_continuous(name="HOHO", guide="none")

ggplot(diamonds, aes(color, price)) + 
  geom_bar()
ggplot(diamonds, aes(color, price)) + 
  geom_bar(stat="identity")
ggplot(diamonds, aes(color, price)) + 
  geom_bar(stat="summary_bin", fun.y=mean)


ggplot(mpg, aes(displ, hwy))+
  geom_bin2d(aes(fill=..density..))+
  scale_fill_gradient(name="DENSITY",low="white", high="red")+
  scale_x_continuous(name=NULL,position="top")
paste(1:7,"km", sep='')
paste0(1:7,"km")
c(1:7)
dflabel<-data.frame(displ=c(2.5,2,6),hwy=c(40,10,30), labels=c("4", "r", "r"))
ggplot(mpg, aes(displ,hwy))+
  geom_point(aes(color=drv, shape=drv, size=cty))+
  geom_smooth(aes(color=drv), method="lm",se=FALSE)+
  geom_label(data=dflabel, aes(label = labels))+
  scale_x_continuous(name=NULL, breaks = c(2,3,4,5,6,7), labels=paste0(2:7,"km"), position= "top")+
  scale_y_continuous(name=quote(paste("HIGHWAY=2*",frac(x, (x+z)))))+
  scale_color_discrete(name="DRV")+  #, guide="none" 하면 그 옵션만 안보임
  scale_shape_discrete(name="DRV")+
  scale_size_continuous(name="DRV", breaks = c(10,20,30), labels=c("십", "이십","삼십"))+
  ggtitle("HWHWH")+
  theme(legend.position = "bottom")+
  theme(plot.title = element_text(size=20, face="bold.italic"))+
  theme(axis.title= element_text(size=14,color="red"))+
  annotate("text", x=6.5, y= 40, size=10, label="hihi i am annotate")+
  annotate("rect", xmin=2, xmax=6, ymin=20, ymax=40, fill= "skyblue", alpha=0.2)
  

