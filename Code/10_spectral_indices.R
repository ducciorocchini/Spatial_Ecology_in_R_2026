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

# Plotting a single layer
plot(m1992[[1]])
# otherwise: m1992$matogrosso~2219_lrg_1
# Why the image is ranging from 0 to 255?
# See the "Reflectance" presentation in Virtuale
# 8 bits = 2^8 = 256 (range: 0-255)
# This is called radiometric resolution

# Types of resolution:
# Spatial: dimension of the pixel
# Spectral: number of bands
# Temporal: number of images in time
# Radiometric: number of bits

# Imporing the recent image
# make the list of data
im.list()

# Atser image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

# Exercise: make a multiframe with the two images in RGB 
# putting the NIR ontop of the green component of the RGB scheme
# layer 1 = NIR
# layer 2 = red
# layer 3 = green

im.multiframe(1, 2)
im.plotRGB(m1992, r=2, g=1, b=3)
im.plotRGB(m2006, r=2, g=1, b=3)

# Putting the NIR ontop of the blue component

im.multiframe(1, 2)
im.plotRGB(m1992, r=2, g=3, b=1)
im.plotRGB(m2006, r=2, g=3, b=1)

# DVI of 2006
nir2006 <- m2006[[1]]
red2006 <- m2006[[2]]
dvi2006 = nir2006 - red2006

plot(dvi2006)
plot(dvi2006, col=inferno(100))

# Exercie: make a multiframe in wchich you will put the dvi1992 beside the dvi2006
im.multiframe(1, 2)
plot(dvi1992, col=inferno(100), main="DVI 1992")
plot(dvi2006, col=inferno(100), main="DVI 2006")

# DVI with different number of bits (different radiometric resolution)
# 8 bits
# range of DVI
# maximum
# NIR = 255, RED = 0, DVI = 255 - 0 = 255
# minimum
# NIR = 0, RED = 255, DVI = 0 - 255 = -255
# range of DVI 8 bits: -255 - 255

# 4 bits
# range of DVI
# maximum 
# NIR = 15, RED = 0, DVI = 15 - 0 = 15
# minimum 
# NIR = 0, RED = 15, DVI = 0 - 15 = -15
# range of DVI 8 bits: -15 - 15

# Solution: NDVI

# NDVI = (NIR - RED) / (NIR + RED)
# 8 bits
# maximum
# NDVI = (255 - 0) / (255 + 0) = 1
# minimum
# NDVI = (0 - 255) / (0 + 255) = -1
# rnage NDVI 8 bits: -1 - 1

# 4 bits
# maximum
# NDVI = (15 - 0) / (15 + 0) = 1
# minimum
# NDVI = (0 - 15) / (0 + 15) = -1
# rnage NDVI 4 bits: -1 - 1

# Exercise: calculate the range of NDVI with a 3 bits image

# 3 bits
# maximum
# NDVI = (7 - 0) / (7 + 0) = 1
# minimum
# NDVI = (0 - 7) / (0 + 7) = -1
# rnage NDVI 3 bits: -1 - 1

# NDVI
ndvi1992 = dvi1992 / (nir1992 + red1992)
plot(ndvi1992, col=inferno(100))

ndvi2006 = dvi2006 / (nir2006 + red2006)
plot(ndvi2006, col=inferno(100))

# Simple way to calculate NDVI
ndvi1992 <- im.ndvi(m1992, 1, 2)
ndvi2006 <- im.ndvi(m2006, 1, 2)

plot(ndvi1992)
plot(ndvi2006)


