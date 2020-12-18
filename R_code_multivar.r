#R_code_multivar.r

setwd("C:/lab/")
library(vegan)

#RData=workspace
load("biomes_multivar.RData")
ls()

#plot per species matrix
head(biomes)

#detrended correspondance analysis
multivar <- decorana(biomes)
multivar

plot(multivar)

#biomes_types
head(biomes_types)

#biomes names in the graph:
attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind="ehull", lwd=3)
#or col=1:4

ordispider(multivar, type, col=c("black","red","green","blue"), label=T)

pdf("multivar.pdf")
plot(multivar)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind = "ehull", lwd=3)
ordispider(multivar, type, col=c("black","red","green","blue"), label = T)
dev.off()




