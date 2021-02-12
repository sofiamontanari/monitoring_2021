#CONSEQUENCES OF 2019-2020 AUSTRALIAN BUSHFIRE SEASON ON VEGETATION AND CORRELATION WITH TEMPERATURE ANOMALY
#maps downloaded from https://earthobservatory.nasa.gov/ (global maps)

setwd("C:/lab/")

library(raster)
library(RStoolbox)

#CHANGES IN NDVI (JAN 2019-JAN 2020)

#Upload the imges
NDVI19 <- raster ("NDVI19.png")
NDVI19 #chack for the extension
NDVI20 <- raster ("NDVI20.png")
NDVI20 #chanck for the extension

#eliminate ocean
NDVI19_1 <- reclassify(NDVI19, cbind(253:255, NA))
NDVI20_1 <- reclassify(NDVI20, cbind(253:255, NA))

#Crop Australia
ext <- c(3100,3400,400,800) #establish the extent
NDVI19_au <- crop(NDVI19_1, ext) #crop the eastern part of Australia
NDVI20_au <- crop(NDVI20_1, ext)

#plot them together using the par function
jpeg('Loss_vegetation.jpg')#save

par(mfrow=c(1,2))
plot(NDVI19_au, main= "NDVI 2019")
plot(NDVI20_au, main= "NDVI 2020")
dev.off()
#saving like this the image is too small, it is better to export from "File" -> "Save as" -> ...

#change colors to highlight areas with high NDVI index and plot
cl <- colorRampPalette(c('grey','red', 'orange','yellow'))(100) #change the color
par(mfrow=c(1,2)) #plot them together
plot(NDVI19_au, col=cl, main= "NDVI 2019")
plot(NDVI20_au, col=cl, main= "NDVI 2020")
dev.off()

#difference between NDVI: jan2020 - jan2019
difNDVI <- NDVI20_au - NDVI19_au
cldif <- colorRampPalette(c('#FFFF00', '#ffe100', '#ff0000', '#0000ff', '#120078'))(100) #HEX color code
#yellow (#FFFF00): areas with the highest decrease in NDVI
plot(difNDVI, col=cldif)

##plot them together an save
par(mfrow=c(1,3))
plot(NDVI19_au, col=cl, main= "NDVI 2019")
plot(NDVI20_au, col=cl, main= "NDVI 2020")
plot(difNDVI, col=cldif, main= "LOSS OF VEGETATION 2019-2020")

dev.off() #close the plot

# histogram of the difNDVI map
> hist(difNDVI, col="lightgreen", xlab="Changes in NDVI", main= "Histogram")
#boxplot
NDVI <- stack(NDVI19_au, NDVI20_au) #stack of the two images
plot(NDVI)
boxplot(NDVI,horizontal=T,axes=T,outline=F, col="lightgreen",xlab="NDVI", ylab="Year", main="Boxplot") #create the boxplot with that stack

#plot histogram and boxplot together, and save
par(mfrow=c(1,2))
hist(difNDVI, col="lightgreen", xlab="Changes in NDVI", main= "Histogram")
boxplot(NDVI,horizontal=T,axes=T,outline=F, col="lightgreen",xlab="NDVI", ylab="Year", main="Boxplot")

dev.off()

#comparison with fire activity
fire2020 <- raster ("fire2020.png") #upload
fire2020_1 <- reclassify(fire2020, cbind(253:255, NA)) #remove ocean
#crop australia
ext <- c(3100,3400,400,800) #same extent as before
fire2020_au <- crop(fire2020_1, ext)
#change colors
cl_fire <-colorRampPalette(c('grey', 'orange', 'red','darkred'))(100) #show the burned area as red 
plot(fire2020_au, col=cl_fire)

#plot fire activity together with the difference in NDVI
par(mfrow=c(1,2))
plot(difNDVI, col=cldif)
plot(fire2020_au, col=cl_fire)
#highest density of reported wildfires match with the areas with the highest vegetation loss 

#Temperature anomaly 

#Images upload 
TAN_global <- list.files(pattern="TAN")
TAN_global #see the list
list_TAN <- lapply(TAN_global, raster)
list_TAN #see all the resterLayers
 
#CROP Australia
#crop all the images at once: first I establish the extent (ext) and I create an empty list. Then, for every element in list_TAN, 
#I append to the empty list the cropped images with that extent.
ext <- c(1100,1440,100,400)
rasterList <- list() #empty list
for (i in list_TAN) {  
 rasterList <- append(rasterList, crop(i, ext))
 }

rasterList #see what is inside the list after the cycle

#SAVE all the cropped images: cycle through raster list elements and save every raster object as .png

index <- 1 #index is used to assign the progressive number to the file name
for(i in rasterList){
 fileName <- paste("TANau", index, ".png", sep="") #create the name of the saved files 
 png(file=fileName)
 plot(i)
 dev.off()
 index <- index + 1 #when the cycle starts again, the index has to be augmented by one 
 }

#make a video
au_png <- sprintf("TANau%01d.png", 1:12) #upload of the 12 images in the au_png list
av::av_encode_video(au_png, 'TAN_video.mp4', framerate = 1) #create the video with a framerate of 1 (= one image per second)
utils::browseURL('TAN_video.mp4') #to open the video
