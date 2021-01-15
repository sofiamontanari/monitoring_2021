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







