#R_code_sdm.r

library(sdm)
library(raster)
library(rgdal)

#import the species data
file <- system.file("external/species.shp", package="sdm") 
species <- shapefile(file)
species

plot(species, pch=17)

#look at the occurrence
species$Occurrence

#different colors for present(1)/absent(0)
plot(species[species$Occurrence == 1,],col='blue',pch=17)
points(species[species$Occurrence == 0,],col='red',pch=16)

# predictors: look at the path
path <- system.file("external", package="sdm") 
# list the predictors
lst <- list.files(path=path,pattern='asc$',full.names = T) #
lst

# stack
preds <- stack(lst)
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

#prediction and occurrence
plot(preds$elevation, col=cl, main="Elevation")
points(species[species$Occurrence == 1,], pch=17)

plot(preds$temperature, col=cl, main="Temperature")
points(species[species$Occurrence == 1,], pch=17)

plot(preds$precipitation, col=cl, main="Precipitation")
points(species[species$Occurrence == 1,], pch=17)

plot(preds$vegetation, col=cl, main="Vegetation")
points(species[species$Occurrence == 1,], pch=17)

# model

# set the data for the sdm
data <- sdmData(train=species, predictors=preds)

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=data, methods = "glm")
# make the raster output layer
p1 <- predict(m1, newdata=preds) 
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# add to the stack
s1 <- stack(preds,p1)
plot(s1, col=cl)





