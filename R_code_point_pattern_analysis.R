#Point pattern analysis
setwd("C:/lab/")
covid <- read.table("covid_agg.csv", header= TRUE)
covid

install.packages("spatstat")
library(spatstat)

#density of the covid data 
#planar point pattern in spatstat, before it is better to attache our dataset

attach(covid)
#x, y and ranges
covid_planar <- ppp(lon, lat, c(-180, 180), c(-90, 90))

density_map <- density(covid_planar)
plot(density_map)
points(covid_planar)

#change colors, the 100 is related to the amount of color in the palette
cl <- colorRampPalette(c('yellow', 'orange', 'red'))(100)
plot(density_map, col= cl)

#countries onto the map 
install_package("rgdal")
library(rgdal)
