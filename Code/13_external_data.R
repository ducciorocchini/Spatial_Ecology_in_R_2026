# Example code to download external data and upload them to R

# Packages
library(terra)
library(imageRy)
library(viridis)

# Linux
setwd("~/Downloads")

# Mac
setwd("/Users/ducciorocchini/Downloads")
# Mac users can also make use of the tilde ~
setwd("~/Downloads")

# Windows: \ in the path, the correct one is the slash! /
setwd("C://....../Downloads")

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

# Group photo
gp <- rast("DJI_20261118105938_0002_D.jpeg")
gp

# Plot the RGB image
plot(gp)

# Plot changing the RGB sc heme
plotRGB(gp, 2, 3, 1, stretch="lin")

# Group photo NDVI
gpndvi <- rast("DJI_20261118105938_0002_F.jpeg") # This is not exactly NDVI but a sketch in RGB of NDVI
plot(gpndvi)

# Multiframe
im.multiframe(1, 2)
plot(gp)
plot(gpndvi)
plotRGB(gpndvi, 2, 3, 1, stretch="lin")

# Plotting just the first layer to avoid rainbow color
plot(gpndvi[[1]])

# Plotting single layers
im.multiframe(2,2)
plot(gpndvi[[1]])
plot(gpndvi[[2]], col=cividis(100)) 
plot(gpndvi[[3]])

# Import several images altogether
files <- list.files(path="~/Downloads",
          pattern="DJI_20261118105853_0005",
          full.names=TRUE)

bologna <- rast(files)
bologna <- flip(bologna)
plot(bologna[[2]], col=magma(100))

im.plotRGB(bologna, 1, 2, 3)

# Uploading dirctly from GitHub

# This is the link to the mirror of the data: put that in chatGPT and ask for the real data link
https://github.com/ducciorocchini/Spatial_Ecology_in_R_2026/tree/main/Data/group_photo/DJI_20261118105938_0002_D.JPG

# Use this link:
https://github.com/ducciorocchini/Spatial_Ecology_in_R_2026/raw/refs/heads/main/Data/group_photo/DJI_20261118105938_0002_D.JPG

groupphoto <- rast("https://github.com/ducciorocchini/Spatial_Ecology_in_R_2026/raw/refs/heads/main/Data/group_photo/DJI_20261118105938_0002_D.JPG
")

# The same holds for Zenodo

# Link to the image: put that in chatGPT
# https://zenodo.org/records/15730101/d59dfee7-17e7-4e50-9e17-f812ee3c5584.jpeg

sella <- rast("https://zenodo.org/records/15730101/files/d59dfee7-17e7-4e50-9e17-f812ee3c5584.jpeg")
