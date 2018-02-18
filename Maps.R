setwd("~/Documents/Maps/PreMaps")
library(maps)
library(mapdata)
library(mapproj)
library(maptools)

map('nzHires', xlim=c(165,179), ylim=c(-50,-35))
nz<-map('nzHires')


samps <- read.csv("Sampling.csv",
    header=TRUE,
    stringsAsFactors=T,
    strip.white=TRUE,
    na.strings=c("NA", "na", "nan", "inf", "", "."))

#plot all city names of NZ onto
#map.cities(country="New Zealand", label=TRUE, cex=1,xlim=c(165,179), ylim=c(-50,-35), pch=20)

map('nzHires', xlim=c(165,179), ylim=c(-50,-35))
points(samps$Lat, samps$Long, pch=19, col="red",cex=1)

## == Other Mapping Tools == ##

library(ggmap)

#Currently missing something, probably to do with aquiring the map

nz<-map_data("nzHires", zoom = 20, .null, .default=NULL)

gg1 <- ggplot() + geom_polygon(data = nz, aes(x=long, y = lat, group = group), fill = "white", color = "black") + coord_fixed(1.3)

gg2<-gg1 + geom_point(data = samps, aes(x = samps$Lat, y = samps$Long),
                color = "red", size = 2) +
                coord_fixed(xlim = c(165, 179), ylim=c(-50,-33), ratio=1/cos(pi*30/180))
gg2

## == Code for detaching all packages == ##

detachAllPackages <- function() {
  basic.packages <- c("package:stats","package:graphics","package:grDevices","package:utils","package:datasets","package:methods","package:base")
  package.list <- search()[ifelse(unlist(gregexpr("package:",search()))==1,TRUE,FALSE)]
  package.list <- setdiff(package.list,basic.packages)
  if (length(package.list)>0)  for (package in package.list) detach(package, character.only=TRUE)
}

detachAllPackages()
