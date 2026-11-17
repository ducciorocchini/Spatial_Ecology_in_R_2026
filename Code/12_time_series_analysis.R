# R code for developing ecosystem monitoring in different times

# Packages
library(terra)
library(imageRy)
library(patchwork)
library(viridis)

# Listing data
im.list()

#------------------

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

#------------------

# Time serie analysis with several images at a time
# Exercise: import directly in a stack the NDVI data from 2020
ndvi <- im.import("NDVI_2020")
ndvi

names(ndvi) <- c("02_feb", "05_may", "08_aug", "11_nov")
ndvi

# Ridgeline plots
im.ridgeline(ndvi)

# Changing the scale parameter inside im.ridgeline()
im.ridgeline(ndvi, scale=1)

# Increasing scale 
im.ridgeline(ndvi, scale=10)

# Changing the palette
im.ridgeline(ndvi, palette="magma")

# Changing the direction of colors
im.ridgeline(ndvi, palette="magma", direction=-1)

#------------------

# Ice melt in Greenland

# Exercise: import the greenland data altogether in a stack

gr <- im.import("greenland")

# Exercise: plot only the tenperature of 2000 with the inferno legend from the viridis package
plot(gr[[1]], col=inferno(100))

# Plotting the data from 2015
plot(gr[[4]], col=inferno(100))

# Difference between 2000 and 2015
dif <- gr[[1]] - gr[[4]]
plot(dif)

# RGB plot with three different layers in time
# on the red = 2000, all of the parts becoming red will have high temperatures in 2000
# on the green = 2005, all of the parts becoming green will have high temperatures in 2005
# on the blue = 2015, all of the parts becoming blue will have high temperatures in 2015

im.plotRGB(gr, 1, 2, 4)


