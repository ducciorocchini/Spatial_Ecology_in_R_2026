# Code for performing time series analysis on satellite data

library(terra)
library(imageRy)
library(ggridges) # install.packages("ggridges")
library(ggplot2)
library(viridis)
library(patchwork)


# listing files
im.list()

EN01 <- im.import("EN_01.png")
EN01 <- flip(EN01)

EN01
# The radiometric resolution of EN01 is 8 bit.

EN13 <- im.import("EN_13.png")
EN13 <- flip(EN13)
plot(EN13)

diffEN = EN01[[1]] - EN13[[1]]
plot(diffEN)

# Ridgeline plots
ndvi <- im.import("NDVI_2020")

im.ridgeline(ndvi, scale=1)

names(ndvi) = c("02_feb", "05_may", "08_aug", "11_nov")
ndvi

im.ridgeline(ndvi, scale=1)
im.ridgeline(ndvi, scale=2)
im.ridgeline(ndvi, scale=3)
im.ridgeline(ndvi, scale=4)
im.ridgeline(ndvi, scale=10)

# Ice melt in Greenland
gr <- im.import("greenland")

gr

plot(gr)

names(gr) <- c("y2000", "y2005", "y2010")

difgr = gr[[1]] - gr[[3]] 

plot(difgr)
plot(difgr, col=magma(100))

im.ridgeline(gr, scale=2)

# ridgeline plotting with external images
# https://science.nasa.gov/video-detail/amf-9ed6be7f-0fbc-43f3-b689-e5fe24d8b21e/
setwd("~/Desktop/")
# C://Desktop/

p2 <- rast("p2.png")
p2
p2 <- c(p2$p2_1, p2$p2_2, p2$p2_3)
plot(p2)
im.plotRGB(p2, 1, 2, 3)
im.ridgeline(p2, scale=2)

p1 <- rast("p1.png")
p1
p1 <- c(p1$p1_1, p1$p1_2, p1$p1_3)
plot(p1)
im.plotRGB(p1, 1, 2, 3)
im.ridgeline(p1, scale=2)

# tidyverse
plot1 <- im.ggplot(p1[[1]])
plot2 <- im.ggplot(p2[[1]])
plot3 <- im.ridgeline(p1, scale=2)
plot4 <- im.ridgeline(p2, scale=2)

plot1 + plot2 + plot3 + plot4

# copy paste im.ggplotRGB from imageRy in GitHub
# https://github.com/ducciorocchini/imageRy/blob/main/R/im.ggplotRGB.R

plot5 <- im.ggplotRGB(p1, 1, 2, 3)
plot6 <- im.ggplotRGB(p2, 1, 2, 3)

plot5 + plot6 + plot3 + plot4

# you can also download the script with the function and then recall it by
source("im.ggplotRGB.R")
