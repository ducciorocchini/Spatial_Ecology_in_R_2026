# R code for developing ecosystem monitoring in different times

# Packages
library(terra)
library(imageRy)
library(patchwork)

# Listing data
im.list()

# European nitrogen
EN01 <- im.import("EN_01.png")
EN01 <- flip(EN01)
plot(EN01)

# Exercise: import and plot the final image
EN13 <- im.import("EN_13.png")
EN13 <- flip(EN13)
plot(EN13)

# Plloting the two situations one ontop of the other thanks to the patchwork package
p1 <- im.ggplot(EN01[[1]])
p2 <- im.ggplot(EN13[[1]])
p1 / p2

# Differencing images
diffEN <- EN01[[1]] - EN13[[1]]
difEN # info on the output
plot(diffEN)

# Plotting everything together
p3 <- im.ggplot(diffEN)
p1 + p2 + p3

# Time serie analysis with several images at a time
# Exercise: import directly in a stack the NDVI data from 2020
ndvi <- im.import("NDVI_2020")

# Ridgeline plots
im.ridgeline(ndvi)

names(ndvi) <- c("02_feb", "05_may", "08_aug", "11_nov")
ndvi




