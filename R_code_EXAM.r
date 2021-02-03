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
cl <- colorRampPalette(c('white','orange','red'))(100) 
plot(NDVI19_au, col=cl)
plot(NDVI20_au, col=cl)

#plot them together
par(mfrow=c(1,2))
plot(NDVI19_au, col=cl)
plot(NDVI20_au, col=cl)

dev.off()

#difference between NDVI: jan2020 - jan2019
difNDVI <- NDVI20_au - NDVI19_au

#plot
cldif <- colorRampPalette(c('#ffee00', '#ffd000', '#ff5500', '#bf1600'))(100) #HEX color code
plot(difNDVI, col=cldif, main= "LOSS OF VEGETATION 2019-2020")

dev.off()

# histogram
hist(difNDVI, col="#ccffe8", main= "NDVI differences between 2019 and 2020 bushfire seasons")




#Temperature anomaly 

#Images upload 

TAN_global <- list.files(pattern="TAN")
TAN_global
list_TAN <- lapply(TAN_global, raster)
list_TAN

#BOXPLOT
boxplot(TAN,horizontal=T,axes=T,outline=F, col="red", xlab="Temp_anomaly", ylab="Period")
 
#CROP Australia
#FUNCTION to crop all the images at once: first I establish the extent (ext) and I create an empty list. Then, for every element in the function's argument(list_TAN), 
#I append to the empty list the cropped images with that extent. The function finally returns the new rasteList. 

rasterListCrop <- function (list_TAN) {
 ext <- c(1100,1440,100,400)
  rasterList <- list()
  for (i in list_TAN) {  
    rasterList <- append(rasterList, crop(i, ext))  
    }
  return (rasterList)
}

#FUNCTION to save all the cropped images: cycle through raster list elements and save every raster object as .png
#index is used to assign the progressive number to the file name

rasterListToPng <- function (rasterList) {
  index <- 1
  for(i in rasterList){
    fileName <- paste("TAN", index, "au.png", sep="")
    png(file=fileName)
    plot(i)
    dev.off()
    index <- index + 1
    }
}

rasterListToPng(rasterListCrop(list_TAN)) #call function to save the images: the argument is the function which returns the list with the cropped images

#make a video
au_png <- sprintf("TAN%01dau.png", 1:12)
av::av_encode_video(au_png, 'TAN_video.mp4', framerate = 1)
utils::browseURL('TAN_video.mp4') #to open the video



