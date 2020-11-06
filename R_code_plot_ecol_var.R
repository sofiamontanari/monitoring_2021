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


