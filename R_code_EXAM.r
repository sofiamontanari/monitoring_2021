setwd("C:/lab/")

library(rasterVis)
library(rasterdiv)
library(raster)
library(RStoolbox)
library(ncdf4)

#CHANGES IN NDVI (JAN 2019-JAN 2020)

#Upload the .nc files
NDVI19 <- raster ("c_gls_NDVI300_201901210000_GLOBE_PROBAV_V1.0.1.nc")
plot(NDVI19)

NDVI20 <- raster ("c_gls_NDVI300_202001210000_GLOBE_PROBAV_V1.0.1.nc")
plot(NDVI20)

#Crop Australia
ext <- c()
NDVI19_au <- crop(NDVI19, ext)
NDVI20_au <- crop(NDVI20, ext)

#plot them together
par(mfrow= c(1,2))
plot(NDVI19_au)
plot(NDVI20_au)










#Temperature anomaly 

#Images upload 

TAN_global <- list.files(pattern="TAN")
TAN_global
list_TAN <- lapply(TAN_global, raster)
list_TAN

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


