# Example code to download external data and upload them to R

# Packages
library(terra)

# Linux
setwd("~/Downloads")

# Mac
setwd("/Users/ducciorocchini/Downloads")
# Mac users can also make use of the tilde ~
setwd("~\Downloads")

# Windows: \ in the path, the correct one is the slash! /
setwd("c://....../Downloads")

# Check your working directory
getwd()

# Importing the image
ozone <- rast("ozone_geos5_20260918_hires.jpg")
ozone

# Plot the image
ozone <- flip(ozone)
plotRGB(ozone, 1, 2, 3, stretch="lin")
plotRGB(ozone, 1, 3, 2, stretch="lin")
plotRGB(ozone, 3, 1, 2, stretch="lin")

