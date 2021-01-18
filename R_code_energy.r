#R_code_energy.r
# R code to view biomass over the world and calculate changes in ecosystem function

setwd("C:/lab/")

install.packages("rasterdiv")
install.packages("rasterVis")
library(rasterdiv)
library(rasterVis)

data(copNDVI)
plot(copNDVI)

#remove the blue values (because there are no data for them)
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

levelplot(copNDVI)

#change colours, the position of the yellow

clymin <- colorRampPalette(c('yellow','red','blue'))(100) #
plot(copNDVI, col=clymin)

clymed <- colorRampPalette(c('red','yellow','blue'))(100) #worst map
plot(copNDVI, col=clymed)

clymax <- colorRampPalette(c('blue','red','yellow'))(100) #best map
plot(copNDVI, col=clymax)

#join the two maps to see differences
par(mfrow=c(1,2))
clymed <- colorRampPalette(c('red','yellow','blue'))(100) #worst map
plot(copNDVI, col=clymed)
clymax <- colorRampPalette(c('blue','red','yellow'))(100) #best map
plot(copNDVI, col=clymax)


#zoom (crop)
plot(copNDVI, col=clymax) 
#declare the extension (xmin, xmax, ymin, ymax)
ext <- c(0,20,35,55) 
copNDVI_Italy <- crop(copNDVI, ext)
plot(copNDVI_Italy, col=clymax)

# Deforestation example
#https://earthobservatory.nasa.gov/
library(raster)
library(RStoolbox)

defor1 <- brick("defor1_.png")
#1=NIR, 2=Red, 3=Green
plotRGB(defor1, 1, 2, 3, stretch="Lin") #r=1, g=2, b=3
plotRGB(defor1, 2, 1, 3, stretch="Lin") #r=2, g=1, b=3

defor2 <- brick("defor2_.png")
plotRGB(defor2, 1, 2, 3, stretch="Lin") 

#put images together
par(mfrow=c(2,1))
plotRGB(defor1, 1, 2, 3, stretch="Lin")
plotRGB(defor2, 1, 2, 3, stretch="Lin") 

dev.off() 

# DVI for the first period (NIR-RED) -->  defor1_.1(defor1 -> names)
dvi1 <- defor1$defor1_.1 - defor1$defor1_.2 
plot(dvi1)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1, col=cl)

# DVI after the cut
dvi2 <- defor2$defor2_.1 - defor2$defor2_.2
plot(dvi2)

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl)

#put images together
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI before cut")
plot(dvi2, col=cl, main="DVI after cut")

dev.off()

#difference between dvi1-dvi12
difdvi <- dvi1 - dvi2
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld, main="Amount of energy lost")

hist(difdvi, col="darkred")

#### final part: 
#defor1
#defor2
#dvi1
#dvi2
#difdvi
#histogram

par(mfrow=c(3,2))
plotRGB(defor1, 1, 2, 3, stretch="Lin")
plotRGB(defor2, 1, 2, 3, stretch="Lin") 
plot(dvi1, col=cl, main="DVI before cut")
plot(dvi2, col=cl, main="DVI after cut")
plot(difdvi, col=cld, main="Amount of energy lost")
hist(difdvi, col="darkred", main="positive values mean change")
