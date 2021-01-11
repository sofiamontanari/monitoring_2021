#R code for the exam

setwd("C:/lab/")

#ncdf4 library!!
install.packages("ncdf4")

library(ncdf4)
library(raster)

#january
tjan <- raster("c_gls_LST10-DC_202101010000_GLOBE_GEO_V1.2.1.nc")
plot(tjan)

#exercise: change the colours and thn replot
cltjan <- colorRampPalette(c('blue','yellow','red'))(100)
plot(tjan, col=cltjan)

#october
toct <- raster("c_gls_LST10-DC_202008010000_GLOBE_GEO_V1.2.1.nc")
plot(toct)

#change colours
cltoct <- colorRampPalette(c('blue','yellow','red'))(100)
plot(toct, col=cltoct)

#difference in temperature: jan-oct
dift <- tjan-toct
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(dift, col=cldif)
