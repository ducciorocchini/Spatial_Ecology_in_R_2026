# Code to visualize remote sensing data

# Zenodo set: https://zenodo.org/records/15645465
# library(remotes)
# install_github("ducciorocchini/imageRy")

library(imageRy)
library(terra)
library(viridis)

# Listing data inside imageRy
im.list()

# importing the first band
b2 <- im.import("sentinel.dolomites.b2.tif")
plot(b2)

# Change the palette thanks to the viridis package
plot(b2, col=inferno(100))

# Exercie: import the green band of sentinel and plot it with the mako legend
b3 <- im.import("sentinel.dolomites.b3.tif")
plot(b3, col=mako(100))

# Make a multiframe with one image beside the other
im.multiframe(1,2)
plot(b2, col=inferno(100))
plot(b3, col=mako(100))

# Exercise: plot the two bands one on top of the other
im.multiframe(2,1)
plot(b2, col=inferno(100))
plot(b3, col=mako(100))
# dev.off()

# Exercise: import the red band (band number 4)
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=cividis(100))

# Exercise: import the near infrared band 
b48 <- im.import("sentinel.dolomites.b8.tif")

# multiframe

# multiframe and colorRamp Palette

# stack by c()

# stack by im.import

# RGB



