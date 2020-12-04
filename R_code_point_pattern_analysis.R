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


### Plotting point with different size related to covid data together with interpolated map
#upload the dataset, do the ppp() 

setwd("C:/lab/")
covid <- read.table("covid_agg.csv", header= TRUE)
attach(covid)
covid_planar <- ppp(lon, lat, c(-180, 180), c(-90, 90))

marks(covid_planar) <- cases
cases_map <- Smooth(covid_planar)

cl <- colorRampPalette(c('lightpink2','lightsalmon','tomato1','red3','maroon'))(100)
plot(cases_map, col=cl)

###sf object= object taht the library can read
install.packages("sf")
library(sf)

Spoints <- st_as_sf(covid, coords= c("lon", "lat"))

## use as cex the n. of cases, lwd= external line of the points
plot(Spoints,  cex=Spoints$cases/10000, col= 'purple3', lwd= 3, add=T)

##add coastline
coastline <- readOGR("ne_10m_coastline.shp")
plot(coastline, add=TRUE)

####Leonardo Zabotti data
setwd("C:/lab/")
leo <- read.table("dati_zabotti.csv", header=T, sep=",")
head(leo)

#build ppp
attach(leo)
summary(leo) #to see what are the minimum and maximum lat and lon

leo_ppp <- ppp(x, y, c(2300000,2325000), c(5005000,5045000))
plot(leo_ppp)

density_map <- density(leo_ppp)
plot(density_map)
points(leo_ppp)

#####Interpolation of students' data
setwd("C:/lab/")
#load data from external file
load("point_pattern_analysis.RData")
#see the list of files inside the Rdata
ls()
head(leo)
library(spatstat)
attach(leo)
#explaining to R the variables that we want to use 
marks(leo_ppp) <- chlh
#smooth the data and plot the map
cl <- colorRampPalette(c('yellow','orange','red','green'))(100) 
chlh_map <- Smooth(leo_ppp)
plot(chlh_map, col= cl)
points(leo_ppp)
#the east side of the map is sea, so the amount of ch is lower with respect to the west side
#point in green part: highest production in terms of ch

#Exercide: do the same for ch in the sediments 
attach(leo)
marks(leo_ppp) <- chls
cl <- colorRampPalette(c('yellow','orange','red','green'))(100) 
chls_map <- Smooth(leo_ppp)
plot(chls_map, col= cl)
points(leo_ppp)

#function to make multipanel
par(mfrow=c(1,3))

#first graph: density map
plot(density_map, col=cl)
points(leo_ppp)

#second graph
plot(chlh_map, col=cl)
points(leo_ppp)

#third graph
plot(chls_map, col=cl)
points(leo_ppp)

#Exercise: 3 rows and 1 clumn
par(mfrow=c(3,1))

#first graph: density map
plot(density_map, col=cl)
points(leo_ppp)

#second graph
plot(chlh_map, col=cl)
points(leo_ppp)

#third graph
plot(chls_map, col=cl)
points(leo_ppp)
