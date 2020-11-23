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
cl <- colorRampPalette(c('blue','yellow','orange','red','magenta'))(100)
plot(density_map, col= cl)

#countries onto the map 
install_package("rgdal")
library(rgdal)

coastline <- readOGR("ne_10m_coastline.shp")
cl <- colorRampPalette(c('pink','green','orange','red','magenta'))(100)
plot(density_map, col= cl)
points(covid_planar, pch=19)
plot(coastline, add=TRUE)

png("figure1.png")
cl <- colorRampPalette(c('pink','green','orange','red','magenta'))(100)
plot(density_map, col= cl)
points(covid_planar, pch=19)
plot(coastline, add=TRUE)
dev.off()

pdf("figure1.pdf")
cl <- colorRampPalette(c('pink','green','orange','red','magenta'))(100)
plot(density_map, col= cl)
points(covid_planar, pch=19)
plot(coastline, add=TRUE)
dev.off()

### interpolate case data

marks(covid_planar) <- cases 
cases_map <- Smooth(covid_planar)

plot(cases_map, col=cl)
points(covid_planar)
plot(coastline, add=TRUE)

