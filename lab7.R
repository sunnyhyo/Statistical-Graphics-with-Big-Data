library(tidyverse)
#lab7

df<- data.frame(x=c(6,2,12),
                y=c(4,8,23),
                label=c('a','b','c'))
df1<- data.frame(x=c(1,1,12,12), y=c(4,1,4,1))
df2<- data.frame(x=1,y=3:1, FAMILY=c("sans","serif","mono"))
FA<- data.frame(x=1,y=3:1, FAMILY=c("plain","bold","italic"))
class(df$label)

p<- ggplot(df, aes(x, y, label=label))
p
p + geom_point()
p + geom_point() + ggtitle("point")  #title은 그래프 위
p + geom_text() + ggtitle("text")    #geom_text 는 점 대신에 문자를 넣을 때 사용
p + geom_bar() + ggtitle("bar")      #geom_bar x변수 하나만 잡혀야 한다. y 변수 넣으면 안됨
p + geom_bar(stat="identity") + ggtitle("bar")      #있는 그대로 써라

p + geom_tile()  #geom_tile 점을 중심으로 정사각형을 그려준다
p + geom_tile() + geom_point(color="red") + ggtitle("tile")       #aes 밖에서 color 쓰면 정말 지정된 색깔or 숫자로 표현
p + geom_tile() + geom_point(aes(color="red")) + ggtitle("tile")  #aes 안에서 color mapping 해주면 변수 단위로 인식

p + geom_raster()  #geom_raster 점이 중심이 아니네? 전체 공간을 점에 맞게 나눈 것 
p + geom_raster() + geom_point(color="red") + ggtitle("raster")

p + geom_rect()   #error x와 y의 min, max를 지정해야한다. df 필요하지 않음
                  #geom_rect  우리가 지정한 범위 내에서 사각형을 그려주는 방법
p + geom_rect(aes(xmin=2.5, xmax=10, ymin=4, ymax=7)) + ggtitle("rect") 
p + geom_rect(aes(xmin=2.5, xmax=10, ymin=4, ymax=7), color='blue') + ggtitle("rect")  #color 가장자리가 바뀜
p + geom_rect(aes(xmin=2.5, xmax=10, ymin=4, ymax=7), fill='blue') + ggtitle("rect")  #fill 영역이 바뀜
p + geom_rect(aes(xmin=2.5, xmax=10, ymin=4, ymax=7, fill='blue')) + ggtitle("rect")  #aes(fill) 변수 단위로 인식 

p + geom_point() + geom_line() #x 축 순서대로 (sorting 해놓음), 시계열 자료일때 유용
p + geom_point() + geom_path()  #x 자료 순서대로 
p + geom_point() + geom_area()    #line 과 관련, 표준정규분포 일정 영역 색칠
p + geom_point() + geom_polygon() #path 와 관련

ggplot(df1, aes(x,y)) + geom_point()
ggplot(df1, aes(x,y)) + geom_line()
ggplot(df1, aes(x,y)) + geom_path()
ggplot(df1, aes(x,y)) + geom_polygon()
ggplot(df1, aes(x,y)) + geom_polygon(fill="yellow")

ggplot(df2, aes(x,y)) + geom_text()
ggplot(df2, aes(x,y, label=FAMILY)) + geom_text()  #ggplot(aes(옵션))  아래의 모든 geom 에 적용
ggplot(df2, aes(x,y)) + geom_text(aes(label=FAMILY)) #geom_(aes(옵션)) 해단 geom에만 적용
ggplot(df2, aes(x,y)) + geom_text(aes(label=FAMILY, family=FAMILY))  #범주ㅁ글씨체
ggplot(df2, aes(x,y)) + geom_text(aes(label=FACE, fontface=FA$FACE)) 

df3<- data.frame(x=c(1,1,2,2,1.5), y=c(1,2,1,2,1.5), text=c('bottom-left','bottom-right','top-left','top-right','center'))

ggplot(df3, aes(x,y)) + geom_text(aes(label=text))                    #글씨 바깥에 딱 맞춰져있음
ggplot(df3, aes(x,y)) + geom_text(aes(label=text), hjust='inward')    #글씨 안쪽으로 들어오게
ggplot(df3, aes(x,y)) + geom_text(aes(label=text), vjust='inward')
ggplot(df3, aes(x,y)) + geom_text(aes(label=text), hjust='inward', vjust='inward')
ggplot(df3, aes(x,y)) + geom_text(aes(label=text), hjust='left')  # 점-글씨
ggplot(df3, aes(x,y)) + geom_text(aes(label=text), hjust='right') # 글씨- 점
동

df4<- data.frame(trt=c('a','b','c'), resp=c(1.2, 3.4, 2.5)) 
ggplot(df4, aes(resp, trt)) + geom_point()
ggplot(df4, aes(resp, trt)) + geom_point() +
  geom_text(aes(label=paste0("(",resp,")")), nudge_y=0.25) #text를 nudge_y y 방향으로 0.25 이동

#문자열함수 #이 세개를 빈 칸 없이 붙여라 
df4$LABEL <-paste0("(",df4$resp,")")
paste("(",df4$resp,")")  #paste 스페이스 넣어서 붙이기가 defualt
paste("(",df4$resp,")", sep="")
paste0("(",df4$resp,")")  #paste0 스페이스 없이 붙이기가 디폴트

ggplot(df4, aes(resp, trt)) + geom_point() + 
  geom_text(aes(label=paste0("(",resp,")")), nudge_y=0.25, size=7, angle=30) +  #text의 size =5, 30도 기울이기
  xlim(1,3.5)

ggplot(mpg, aes(displ, hwy)) + geom_text(aes(label=model))  #글씨가 겹쳐서 잘안보인다
ggplot(mpg, aes(displ, hwy)) + geom_text(aes(label=model),check_overlap = TRUE)  #check_overlap 오버랩 되는 정보는 적않 ㅇ는다.
#점 순서대로 쓰다가 이미 그 공간에 자리가 있으면 안쓴다. 한두개 겹치는 경우는 괜찮은데 이 경우에서는 정소 손실 많다. 조심해서 쓰기

faithfuld  #미국 옐로우스톤에 간헐천
ggplot(faithful, aes(waiting, eruptions))+ geom_point()
ggplot(faithfuld, aes(waiting, eruptions))+ geom_point()  #변형된 자료
ggplot(faithfuld, aes(waiting, eruptions))+ geom_tile(aes(fill=density))
label<- data.frame(waiting=c(55,80),eruptions=c(2.0,4.3),label=c('peck one','peck two')) #글씨 쓸 위치만 지정
#peck 찍어주기 데이터셋 다시 만들어서 해보자!
ggplot(faithfuld, aes(waiting, eruptions))+ geom_tile(aes(fill=density)) +
  geom_text(data=label, aes(label=label))   #geom_text 에서 새로운 데이터 지정해서 사용했다
#aes() x,y 변수 따로 지정안했지만, 앞에서 지정한 x,y 변수와 mapping 된다. 이때 변수명이 다르면 error
ggplot(faithfuld, aes(waiting, eruptions))+ geom_tile(aes(fill=density)) +
  geom_label(data=label, aes(label=label))  #장단점, 가려지는 부분 but 글씨는 확실히 볼수 있음

ggplot(mpg, aes(displ, hwy, color=class)) + geom_point()
ggplot(mpg, aes(displ, hwy, color=class)) + geom_point() + 
  directlabels::geom_dl(aes(label=class), method="smart.grid")  #레이블을 예쁘게 그린다~
# 라이브러리 안에있는 :: 함수를 썼다 
