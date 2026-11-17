# This code will calculate spatial variability in remotely sensed imagery

library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)
library(viridis)

# list of files
im.list()

# import the file
sent <- im.import("sentinel.png")
# layer 1 = NIR, layer 2 = red, layer 3 =green

im.plotRGB(sent, r=1, g=2, b=3)
im.plotRGB(sent, r=2, g=1, b=3)
im.plotRGB(sent, r=2, g=3, b=1)

sentmean <- focal(sent[[1]], w=3, fun="mean")

nir <- sent[[1]]
sd3 <- focal(sent[[1]], w=3, fun="sd")

p1 <- im.ggplot(nir)
p2 <- im.ggplot(sentmean)
p3 <- im.ggplot(sd3)

p1 + p2 + p3

plot(sd3, col=magma(100))

# copy the im.ggplotRGB function from:
# https://github.com/ducciorocchini/imageRy/blob/main/R/im.ggplotRGB.R

p0 <- im.ggplotRGB(sent, r=2, g=1, b=3)

p0 + p1 + p2 + p3

sd5 <- focal(nir, w=5, fun="sd")

p4 <- im.ggplot(sd5)

p3 + p4

p0 + p3 + p4
