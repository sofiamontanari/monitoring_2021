install.packages("sp")

library(sp)
data(meuse)

# Let's see how the meuse dataset is structured:
meuse

# let's look at the first row of the set
head(meuse)

# exercise: make the summary of the set
summary(meuse)

# lets' plot two variables
# let's see of the zinc concentration is realted to that of copper
attach(meuse)
plot(zinc,copper)
plot(zinc,copper,col="green")
plot(zinc,copper,col="green",pch=19)
plot(zinc,copper,col="green",pch=19,cex=2)

#plot altogether!
pairs(meuse)

#lecture2
#recall package and dataset
library(sp)
data(meuse)

pairs(meuse)
head(meuse)

#cadmium copper lead zinc
#pairs with soil variables

pairs(meuse[,3:6])

#use the columns' name 
pairs(~ cadmium + copper + lead + zinc, data=meuse)

#let's prettify the graph
#Exercise: change the colour 

pairs(meuse[,3:6], col="green")

#Exercise: change the symbol to filled triangles

pairs(meuse[,3:6], col="green", pch=17)

#Exercise: increase the size of triangles

pairs(meuse[,3:6], col="green", pch=17, cex=2)
