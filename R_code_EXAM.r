setwd("C:/lab/")

library(rasterVis)
library(rasterdiv)
library(raster)

#Temperature anomaly 
#Images upload 

TAN01 <- raster("tan_jun19.png")
TAN02 <- raster("tan_jul19.png")
TAN03 <- raster("tan_aug19.png")
TAN04 <- raster("tan_sep19.png")
TAN05 <- raster("tan_oct19.png")
TAN06 <- raster("tan_nov19.png")
TAN07 <- raster("tan_dec19.png")
TAN08 <- raster("tan_jan20.png")
TAN09 <- raster("tan_feb20.png")
TAN10 <- raster("tan_mar20.png")
TAN11 <- raster("tan_apr20.png")
TAN12 <- raster("tan_may20.png")

#CROP Australia
ext <- c(1100,1440,100,400)
TAN01_1 <- crop(TAN01, ext)
plot(TAN01_1)




