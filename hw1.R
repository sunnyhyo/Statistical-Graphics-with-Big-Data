##################
#Statistic graphics with Big Data
#HW1 
#1585063 박효선

##################
#1. mtcars data

#1)
str(mtcars)

#2) 
dim(mtcars)

#3)
write.csv(mtcars, "mtcars.csv")

#4)
mtcars.read<- read.csv("mtcars.csv")

#5) 
head(mtcars); tail(mtcars)
head(mtcars.read); tail(mtcars.read)
str(mtcars)
#6) 
mtcars.read$isAuto <- ifelse(mtcars.read$transmission == 'automatic', TRUE, FALSE)
