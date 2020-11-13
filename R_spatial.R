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
