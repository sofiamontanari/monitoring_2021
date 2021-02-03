setwd("C:/lab/")

library(raster)
library(RStoolbox)


#CHANGES IN NDVI (JAN 2019-JAN 2020)

#Upload the imges
NDVI19 <- raster ("NDVI19.png")
NDVI20 <- raster ("NDVI20.png")

#eliminate ocean
NDVI19_1 <- reclassify(NDVI19, cbind(253:255, NA))
NDVI20_1 <- reclassify(NDVI20, cbind(253:255, NA))

#Crop Australia
ext <- c(3100,3400,400,800)
NDVI19_au <- crop(NDVI19_1, ext)
NDVI20_au <- crop(NDVI20_1, ext)

#plot
cl <- colorRampPalette(c('white', 'orange', 'red','darkred'))(100) 
plot(NDVI19_au, col=cl)
plot(NDVI20_au, col=cl)
dev.off()

#difference between NDVI: jan2020 - jan2019
difNDVI <- NDVI20_au - NDVI19_au
cldif <- colorRampPalette(c('#FFFF00', '#ffe100', '#ff0000', '#0000ff', '#120078'))(100)
plot(difNDVI, col=cldif)

##plot them together
par(mfrow=c(1,3))
plot(NDVI19_au, col=cl, main= "NDVI 2019")
plot(NDVI20_au, col=cl, main= "NDVI 2020")
plot(difNDVI, col=cldif, main= "LOSS OF VEGETATION 2019-2020")

dev.off()

# histogram
hist(difNDVI, col="#ccffe8", main= "NDVI differences between 2019 and 2020 bushfire seasons")
#boxplot
NDVI <- stack(NDVI19_au, NDVI20_au)
plot(NDVI)
boxplot(NDVI,horizontal=T,axes=T,outline=F, col="lightgreen",xlab="NDVI", ylab="Year")

#plot together
par(mfrow=c(1,2))
hist(difNDVI, col="lightgreen", xlab="Changes in NDVI", main= "Histogram")
boxplot(NDVI,horizontal=T,axes=T,outline=F, col="lightgreen",xlab="NDVI", ylab="Year", main="Boxplot")

#comparison with fire activity
fire20 <- brick("FIRMS_2020.jpg")
plotRGB(fire20, r=1, g=2, b=3, stretch="Lin")
#plot together
par(mfrow=c(1,2))
plotRGB(fire20, r=1, g=2, b=3, stretch="Lin")
plot(difNDVI, col=cldif)


#Temperature anomaly 

#Images upload 

TAN_global <- list.files(pattern="TAN")
TAN_global
list_TAN <- lapply(TAN_global, raster)
list_TAN
 
#CROP Australia
#crop all the images at once: first I establish the extent (ext) and I create an empty list. Then, for every element IN list_TAN, 
#I append to the empty list the cropped images with that extent.

ext <- c(1100,1440,100,400)
rasterList <- list()
for (i in list_TAN) {  
 rasterList <- append(rasterList, crop(i, ext))
 }

rasterList

#SAVE all the cropped images: cycle through raster list elements and save every raster object as .png
#index is used to assign the progressive number to the file name

index <- 1
for(i in rasterList){
 fileName <- paste("TANau", index, ".png", sep="")
 png(file=fileName)
 plot(i)
 dev.off()
 index <- index + 1
 }

#make a video
au_png <- sprintf("TANau%01d.png", 1:12)
av::av_encode_video(au_png, 'TAN_video.mp4', framerate = 1)
utils::browseURL('TAN_video.mp4') #to open the video
