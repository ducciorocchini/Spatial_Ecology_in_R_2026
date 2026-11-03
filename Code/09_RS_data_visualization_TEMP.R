# Code to visualize remote sensing data

# Zenodo set: https://zenodo.org/records/15645465
# install.packages("imageRy")

library(imageRy)
library(terra)
library(viridis)

# Listing data inside imageRy
im.list()

# importing the first band
b2 <- im.import("sentinel.dolomites.b2.tif")
plot(b2)
plot(b2, col=magma(100))

# green band
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3)

cl <- colorRampPalette(c("black","grey","white"))(100)
plot(b3, col=cl)

# multiframe
par(mfrow=c(1,2))
# or
im.multiframe(1,2)
plot(b2, col=cl)
plot(b3, col=cl)

# the multiframe from the CRAN is not properly working, so use the GitHub version:
duccio <- function(x,y){
   par(mfrow=c(x,y))
   }

dev.off()
plot(b2,b3)

# Exercise: import band 4
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4)
plot(b4, col=cl)

# import band 8
b8 <- im.import("sentinel.dolomites.b8.tif")
plot(b8)

im.multiframe(1,2)
plot(b4)
plot(b8)

# build your own function for plotting
duccio <- function(x,y){
  par(mfrow=c(x,y))
  }

# Exercise: with the function duccio, build a multiframe of 2 rows and 2 columns and plot all the imported data
duccio(2,2)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

# Exercise: create a multiframe with 1 row and 2 columns, plot one against the other 
# b2 b3
# b2 b8

duccio(1,2)
plot(b2,b3)
plot(b2,b8)

# creating colored images
sent <- c(b2, b3, b4, b8)

# layer 1 = original (from Sentinel-2) b2 = blue
# layer 2 = original (from Sentinel-2) b3 = green
# layer 3 = original (from Sentinel-2) b4 = red
# layer 4 = original (from Sentinel-2) b8 = NIR

# natural color image
im.plotRGB(sent, r=3, g=2, b=1, title='natural color')

# false color image
im.plotRGB(sent, r=4, g=3, b=2, title='false color')
im.plotRGB(sent, r=3, g=4, b=2, title='false color')
im.plotRGB(sent, r=3, g=2, b=4, title='false color')

duccio(2,2)
im.plotRGB(sent, r=3, g=2, b=1, title='natural color')
im.plotRGB(sent, r=4, g=3, b=2, title='false color')
im.plotRGB(sent, r=3, g=4, b=2, title='false color')
im.plotRGB(sent, r=3, g=2, b=4, title='false color')


im.plotRGB(x, r, g, b, title = "")
