#CONSEQUENCES OF 2019-2020 AUSTRALIAN BUSHFIRE SEASON ON VEGETATION AND CORRELATION WITH TEMPERATURE ANOMALY
#maps downloaded from https://earthobservatory.nasa.gov/

setwd("C:/lab/")

library(raster)
library(RStoolbox)

#CHANGES IN NDVI (JAN 2019-JAN 2020)

#Upload the imges
NDVI19 <- raster ("NDVI19.png")
NDVI19
NDVI20 <- raster ("NDVI20.png")
NDVI20

#eliminate ocean
NDVI19_1 <- reclassify(NDVI19, cbind(253:255, NA))
NDVI20_1 <- reclassify(NDVI20, cbind(253:255, NA))

#Crop Australia
ext <- c(3100,3400,400,800) #establish the extent
NDVI19_au <- crop(NDVI19_1, ext)
NDVI20_au <- crop(NDVI20_1, ext)

#change colors to highlight areas with high NDVI index and plot
cl <- colorRampPalette(c('white', 'orange', 'red','darkred'))(100) #change the color
par(mfrow=c(1,2))
plot(NDVI19_au, col=cl, main= "NDVI 2019")
plot(NDVI20_au, col=cl, main= "NDVI 2020")
dev.off()

#difference between NDVI: jan2020 - jan2019
difNDVI <- NDVI20_au - NDVI19_au
cldif <- colorRampPalette(c('#FFFF00', '#ffe100', '#ff0000', '#0000ff', '#120078'))(100) #HEX color code
#yellow (#FFFF00): areas with the highest decrease in NDVI
plot(difNDVI, col=cldif)

##plot them together an save
jpeg('Loss_vegetation.jpg')

par(mfrow=c(1,3))
plot(NDVI19_au, col=cl, main= "NDVI 2019")
plot(NDVI20_au, col=cl, main= "NDVI 2020")
plot(difNDVI, col=cldif, main= "LOSS OF VEGETATION 2019-2020")

dev.off()

#saving like this the image is too small, it is better to export from "File" -> "Save as" -> ...

# histogram
hist(difNDVI, col="#ccffe8", main= "NDVI differences between 2019 and 2020 bushfire seasons")
#boxplot
NDVI <- stack(NDVI19_au, NDVI20_au)
plot(NDVI)
boxplot(NDVI,horizontal=T,axes=T,outline=F, col="lightgreen",xlab="NDVI", ylab="Year")

#plot histogram and boxplot together, and save
par(mfrow=c(1,2))
hist(difNDVI, col="lightgreen", xlab="Changes in NDVI", main= "Histogram")
boxplot(NDVI,horizontal=T,axes=T,outline=F, col="lightgreen",xlab="NDVI", ylab="Year", main="Boxplot")

dev.off()

#comparison with fire activity
fire2020 <- raster ("fire2020.png") #upload
fire2020_1 <- reclassify(fire2020, cbind(253:255, NA)) #remove ocean
#crop australia
ext <- c(3100,3400,400,800)
fire2020_au <- crop(fire2020_1, ext)
#change colors
cl_fire <-colorRampPalette(c('grey', 'orange', 'red','darkred'))(100)
plot(fire2020_au, col=cl_fire)

#plot fire activity together with the difference in NDVI)
par(mfrow=c(1,2))
plot(difNDVI, col=cldif)
plot(fire2020_au, col=cl_fire)


#Temperature anomaly 

#Images upload 
TAN_global <- list.files(pattern="TAN")
TAN_global
list_TAN <- lapply(TAN_global, raster)
list_TAN
 
#CROP Australia
#crop all the images at once: first I establish the extent (ext) and I create an empty list. Then, for every element in list_TAN, 
#I append to the empty list the cropped images with that extent.
ext <- c(1100,1440,100,400)
rasterList <- list()
for (i in list_TAN) {  
 rasterList <- append(rasterList, crop(i, ext))
 }

rasterList #see what is inside the list after the cycle

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
