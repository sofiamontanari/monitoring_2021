#R code for remote sensing data analysis in ecosystem monitoring

library(raster)
library(RStoolbox)

#no data?
install.packages(c("raster", "RStoolbox"))

setwd("C:/lab/") 

#upload to R remote sensing data 
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011

plot(p224r63_2011)

#put different colors

# B1: blue
# B2: green
# B3: red
# B4: NIR

cl <- colorRampPalette(c('black','grey','light grey'))(100) # 
plot(p224r63_2011, col=cl)

#Plot only the first 4 images with different colours 
par(mfrow=c(2,2))

clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) #blue 
plot(p224r63_2011$B1_sre, col=clb) #plot the first image with the blue palette

clg <- colorRampPalette(c('dark green','green','light green'))(100) #green
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) #red
plot(p224r63_2011$B3_sre, col=clr)

cln <- colorRampPalette(c('red','orange','yellow'))(100) #infrared
plot(p224r63_2011$B4_sre, col=cln)

#RGB (Red, Blue, Green -> corresponding bands)

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #stretch= stretch the colour to better see the image

#let's add the infrared band by shifting the bands by one
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#put them together
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #natural colours
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #false colours
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")




