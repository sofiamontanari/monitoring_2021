setwd("C:/lab/")

library(rasterVis)
library(rasterdiv)
library(raster)
library(RStoolbox)


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
TAN1au <- crop(TAN01, ext)
TAN2au <- crop(TAN02, ext)
TAN3au <- crop(TAN03, ext)
TAN4au <- crop(TAN04, ext)
TAN5au <- crop(TAN05, ext)
TAN6au <- crop(TAN06, ext)
TAN7au <- crop(TAN07, ext)
TAN8au <- crop(TAN08, ext)
TAN9au <- crop(TAN09, ext)
TAN10au <- crop(TAN10, ext)
TAN11au <- crop(TAN11, ext)
TAN12au <- crop(TAN12, ext)

rasterList <- c(TAN1au, TAN2au, TAN3au, TAN4au, TAN5au, TAN6au, TAN7au, TAN8au, TAN9au, TAN10au, TAN11au, TAN12au) #add all raster objects to a list

#FUNCTION to save all the cropped images: cycle through raster list elements and save every raster object as .png
#index is used to assign the progressive number to the file name

rasterListToPng <- function (rasterList) {
  index <- 1
  for(i in rasterList){
    fileName <- paste("TAN", index, ".png", sep="")
    png(file=fileName)
    plot(i)
    dev.off()
    index <- index + 1
    }
}

rasterListToPng(rasterList) #call function to save the images 

#make a video
au_png <- sprintf("TAN%01d.png", 1:12)
av::av_encode_video(au_png, 'TAN_video.mp4', framerate = 1)
utils::browseURL('TAN_video.mp4')


