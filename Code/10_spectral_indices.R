# Code to develop spectral indices

library(terra)
library(imageRy)
library(viridis)

# Listing the data
im.list()

# Importing the image of Mato Grosso in 1992
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m1992

# Layers of m1992
# layer 1 = NIR
# layer 2 = red
# layer 3 = green

# Exercise: put the NIR infrared in a im.plotRGB in the green component
# Make a multiframe with the NIR ontop of the red component and ontop of the green component
im.multiframe(1,2)
im.plotRGB(m1992, r=1, g=2, b=3) 
im.plotRGB(m1992, r=2, g=1, b=3) 

# RGB scheme: you can remove r= g= b=
im.multiframe(1,2)
im.plotRGB(m1992, 1, 2, 3) 
im.plotRGB(m1992, 2, 1, 3) 

# using NIR ontop of the blue component
im.multiframe(1,3)
im.plotRGB(m1992, 1, 2, 3) 
im.plotRGB(m1992, 2, 1, 3) 
im.plotRGB(m1992, 2, 3, 1) 

# Calculating DVI in 1992
# NIR layer 1
# red layer 2

nir1992 <- m1992[[1]]
red1992 <- m1992[[2]]
dvi1992 = nir1992 - red1992
plot(dvi1992, col=rocket(100))
plot(dvi1992, col=inferno(100))




