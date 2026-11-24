# Code to estimate spatial variability of an image

library(terra)
library(imageRy)
library(viridis)

# Listing the different avaialable sets in imageRy
im.list()

# Importing the data
sent <- im.import("sentinel.png")

# layer 1 # NIR
# layer 2 # red
# layer 3 # green

# Exercise: plot in RGB the image putting NIR ontop of the green component
# imageRy::im.plotRGB()
# ?im.plotRGB
im.plotRGB(sent, 2, 1, 3)

# Exercise: make the same plot with the terra::plotRGB function
plotRGB(sent, 2, 1, 3, stretch="lin")

# Measuring the mean: univariate statistics
meanNIR <- focal(sent[[1]], w=3, fun="mean")
plot(meanNIR)

# Exercise: plot the original NIR band beside the meanNIR
im.multiframe(1,2)
plot(sent[[1]])
plot(meanNIR)

# Another manner to do that:
stackNIR <- c(sent[[1]], meanNIR)

# Exerciuse: caulcate the mean of the NIR with a moving window of 7x7 pixels
meanNIR7 <- focal(sent[[1]], w=7, fun="mean")
plot(meanNIR7)

# Exerciwe: plot the images altogether making a stack
stackNIR <- c(sent[[1]], meanNIR, meanNIR7)
plot(stackNIR)

# Exercise: make the 13x13 mean, put in the stack and plot the stack with the inferno legend
meanNIR13 <- focal(sent[[1]], w=13, fun="mean")
stackNIR <- c(sent[[1]], meanNIR, meanNIR7, meanNIR13)
plot(stackNIR, col=inferno(100))













