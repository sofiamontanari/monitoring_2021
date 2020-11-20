# R spatial

library(sp)

data(meuse)
head(meuse)

coordinates(meuse) = ~x+y
plot(meuse)

#spplot is used to plot elements, like zinc, spread in space 
spplot(meuse, "zinc", main="Concentration of zinc")

#Exercise: plot the concentration of copper
spplot(meuse, "copper", main= "Concentration of copper")

#Exercise:plot zinc and copper
spplot(meuse,c("copper", "zinc"), main= "Concentration")

#let's make use of bubbles:the dimensions change based on the amount of certain elements 
bubble(meuse, "zinc")

#Exercise: same for lead
bubble(meuse,"lead", col="red")

#### installing ggbiplot library
install.packages("ggbiplot")
library(ggbiplot)

#ecological dataframe

biofuels <- c(120,200, 350, 570, 750)#array of values: c
oxidative <- c(1200, 1300, 21000, 34000, 50000)

#dataframe
d <- data.frame(biofuels, oxidative)

#to plot the data
ggplot(d, aes (x= biofuels, y=oxidative)) + geom_point()

ggplot(d, aes (x= biofuels, y=oxidative)) + 
geom_point(size = 5, col= "red")

#lines
ggplot(d, aes (x= biofuels, y=oxidative)) + geom_line()

#poits+lines
ggplot(d, aes (x= biofuels, y=oxidative)) + 
  geom_point(size=3, col="green") +
  geom_line()

#polygons
ggplot(d, aes (x= biofuels, y=oxidative)) + geom_polygon()

##import data
setwd("C:/lab/")
covid <- read.table("covid_agg.csv", header= TRUE)
covid

head(covid)

summary(covid)

#ggplot2
ggplot(covid, aes (x= lon, y=lat)) + geom_point()

#change the size of the points, according to the n. of cases
ggplot(covid, aes (x= lon, y= lat, size= cases)) + geom_point()
