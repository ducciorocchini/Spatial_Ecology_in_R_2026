# Script for modelling the dispersion of individuals of a popultion

# New packages to be installed:
# install.packages("terra")
# install.packages("sdm")

# Check the packages
library(terra)
library(sdm)

# Path to the file
path <- system.file("external/species.shp", package="sdm")

# Import the vector data
rana <- vect(path)
rana

# Plotting the data
plot(rana)
