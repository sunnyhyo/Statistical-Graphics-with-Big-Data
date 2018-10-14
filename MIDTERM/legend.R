#그래프 커스텀하기
#0. 기본 그래프 만들기
#1. 타이틀(Title) 커스텀 하기
#▶ 타이틀 입력하고 꾸미기
#▶ 타이틀 여러 줄로 나누기
#2. 축(Axis) 커스텀 하기
#▶ 축 타이틀 꾸미기 
#▶ 축 타이틀 바꾸기 
#▶ 축 타이틀에 수식 넣기 
#▶ 축 표현 범위 설정하기 
#▶ 축 라벨 잘게 쪼개기 
#▶ 축 라벨 바꾸기 
#▶ 축 라벨 옆으로 눕히기 
#▶ 축 위치 바꾸기
#3. 범례(Legend) 커스텀 하기
#▶ 범례 지우기 #
#▶ 범례 꾸미기
#▶ 범례 테두리 꾸미기 
#▶ 범례 위치 바꾸기 
#▶ 범례 위치를 그래프 안으로 넣기 
#▶ 범례 타이틀만 지우기 
#▶ 범례 타이틀 바꾸기
#4. 그래프(Plot) 커스텀 하기
#▶ 그래프 안에 글자/선/도형 넣기 
#▶ 그래프 X축, Y축 바꿔 그리기 
#▶ 흑백으로 나타내기 
#▶ 팔레트 적용하기 
#▶ 원하는 색상으로 바꾸기 
#▶ 테마 적용하기
#[부록] theme() 함수의 elements 설명
#[첨부파일] 소스 코드 첨부
#[Reference] 참고 문헌
#[출처] [R] ggplot2 그래프 커스텀 (customized) 하기|작성자 nife0719


#################################33
#
library(ggplot2)
library(MASS)


data("Cars93")
Basic_Plot<- ggplot(Cars93, aes(x= Price, y= Horsepower)) +
  geom_jitter(aes(color= DriveTrain) ) 
Basic_Plot
ggsave("basic_plot.jpg", plot=Basic_Plot, dpi= 300)


##################################
#타이틀 커스텀하기
Basic_Plot + ggtitle("Jitter plot Cars93 Dataset") + 
  theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "darkblue"))
#글씨체, 글씨모양, 가운데 정렬, 크기, 색상

#타이틀 여러 줄로 나누기
Basic_Plot + ggtitle("Jitter plot Cars93 Dataset \n coloring with Drive Train") + 
  theme(plot.title = element_text(family = "serif", face = "bold", hjust = 0.5, size = 15, color = "darkblue"))



################################
#축 타이틀 꾸미기
Basic_Plot + theme(axis.title= element_text(face = "bold", size= 13, color= "darkblue"))
#축의 글자모양, 크기, 색상

#축 타이틀 바꾸기
Basic_Plot + labs(x= "Average og Max and Min Price", y = "Maximum Housepower")

#축 타이틀에 수식넣기
Basic_Plot + labs(x = expression("Average of Price"["Max"]*"and Price"["Min"]), y = "Maximum Hoursepower")

#축 표현 범위 설정하기 
Basic_Plot + lims(x= c(0,40))
Basic_Plot + xlim(0,40)
Basic_Plot + xlim(c(0,40))

#축 라벨 잘게 쪼개가
Basic_Plot + scale_x_continuous(breaks = c(10,20,30,40,50,60))
#축을 10 단위로 쪼갠다

#축 라벨 바꾸기기
Basic_Plot + scale_x_continuous(breaks = c(10,20,30,40,50,60), labels = paste0("$",c(10,20,30,40,50,60)))
#축을 10 단위로 쪼갠다.앞에 $를 붙여서 라벨 명칭을 바꾼다.

#축 라벨 옆으로 눞히기
Basic_Plot + scale_x_continuous(breaks = c(10,20,30,40,50,60), labels = paste0("$", c(10,20,30,40,50,60)))+
  theme(axis.text.x= element_text(angle = 270, hjust = 1, vjust = 0.5))
#hjust=
#vjust=

#축 위치 바꾸기
Basic_Plot + scale_x_continuous(position = "top")
#x 축을 위로 옮긴다

##########################
#범례 legend 커스텀하기

#범례 지우기 
Basic_Plot + theme(legend.position= "none")
Basic_Plot + theme(legend.position= NULL)  #안됨

#범ㄹㅖ를 지운다
Basic_Plot + xlab(NULL) + ylab(NULL) 
#x 축 y 축 지운다

#범례 꾸미기
Basic_Plot+ theme(legend.title = element_text(face = "bold", size= 13, color = "darkblue"))+
  #범례 타이틀의 글자 모양, 크기, 색상을 설정
  theme(legend.text = element_text(face = "bold", size = 11, color= "pink")) +
  #범례 항목 글자의 글자 모양, 크기, 색상을 설ㅈ
  theme(legend.key = element_rect(color = "red", fill= "white"))
  #범례 항목 아이콘의 테두리 색상, 내부 색상, 크기를 설정

#범례 테두리 꾸미기
Basic_Plot + theme(legend.box.background= element_rect(fill = "skyblue"), legend.box.margin = margin(6,6,6,6))
#범례의 테두리 색상, 여백 크기를 설정

#범례 위치 바꾸기
Basic_Plot + theme(legend.position = "top")
Basic_Plot + theme(legend.position = "bottom")
Basic_Plot + theme(legend.position = "right")
Basic_Plot + theme(legend.position = "left")
Basic_Plot + theme(legend.position = "none")
Basic_Plot + theme(legend.position = element_blank())#오류
ggplot(Cars93, aes(x= Price, y= Horsepower)) +
  geom_jitter(aes(color= DriveTrain), show.legend = FALSE)


#범례 위치를 그래프 안으로 넣기   #그래프 내부의 X, Y 좌표를 설정함으로써 그래프 내부로 옮긴다
Basic_Plot + theme(legend.position = c(0.85, 0.2))
#범례 위치를 그래프 내부로 설정

#범례 타이틀만 지우기
Basic_Plot + theme(legend.title = element_blank())

#범례 타이틀 바꾸기 
#범례가 연속형인지 범주형인지에 따라서 scale_color_continuous() discrete() 사용
Basic_Plot + scale_color_discrete(name = "This is \n Driver Train Type")



##################################
#그래프Plot 커스텀하기

#그래프 안에 글자/선/도형 넣기
Basic_Plot + annotate("text", x = 52, y=100, label = "price Limit \n Line") + 
  annotate("text", x = 10, y = 230 , label = "Candidate \nGroup")+
  annotate("rect", xmin=0 , xmax=40, ymin=0, ymax=250, alpha = 0.2, fill = "skyblue")+ 
  annotate("segment", x = 60, xend =60, y = 0, yend = 300, color = "black", size = 1)

#그래프 x축 y 축 바꿔 그리기
Basic_Plot +coord_flip()

#흑백으로 나타내기
Basic_Plot + scale_color_grey()

#팔레트 적용하기 
Basic_Plot + scale_color_brewer(palette= "Dark2")

#원하는 색상으로 바꾸기
Basic_Plot + scale_color_manual(values=c("red", "pink", "blue"))


#[부록]
#theme() 함수에서 그래프, 축, 범례, 패널, 스트립을 수정하기 위해서 elements를 통해 
#원하는 설정값을 입력해줘야 한다.

#element_blank()  아무것도 그리지 않음
#element_rect()  테두리와 배경
elemet_rect(fill= 배경채움색상, color= 색상 , size= 크기, linetype=선 종류)
#element_line()  선
element_line(color= 색상, size=크기, linetype=선종류, lineend=선끝스타일, arrow=화살표종류)
#element_text()  글자
element_text(family= 글자종류 , face= 글자모양 , color=색상 , size=크기 , 
             hjust= 수평맞춤, vjust= 수직맞춤, angle= 각도 ,margin= 글자주위 공간 )



ggplot(midwest, aes(percwhite, percbelowpoverty))+
  geom_point(aes(size = poptotal/1e6))#+
#  scale_size_area(breaks=c(0.5,1,2,4))




ggplot(diamonds, aes(depth)) +
  geom_histogram()+xlab(expression(paste("depth=2*",frac(z,(x+y)))))

quote(paste("depth=2*",frac(z,(x+y))))
expression(paste("depth=2*",frac(z,(x+y))))
a

1:(12*5)



########################
ggplot(mpg, aes(displ, hwy,color=drv)) + 
  geom_point(aes(shape=drv)) +
  scale_color_discrete("DT")
#  scale_shape_discrete("DT")
