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

# Changin names to the stack
names(stackNIR) <- c("original", "mean_3", "mean_7", "mean_13")
stackNIR # check names
plot(stackNIR, col=mako(100))

# Plotting two sets in a scatterplot
plot(stackNIR[[2]], stackNIR[[4]], col="gray")
abline(0, 1, col="red") # y=x

# Exercise: given the statistical functon sd, calculate the standard deviation of the NIR with a moving window of 3x3
# sd 3x3
# sd <- focal(sent[[1]], w=3, fun="sd") # avoid this! Otherwise you will overwrite the statistical function sd (standard deviation) with the object sd
sdNIR <- focal(sent[[1]], w=3, fun="sd")
stacksd <- c(sent[[1]], sdNIR)
plot(stacksd, col=cividis(100))
plot(stacksd)

# Exercise: calculate standard deviation for:
# 7x7 pixles
# 13x13 pixels
# And make a stack of all of the data: original, 3x3, 7x7,13x13
# rename the inner layers of the stack

sdNIR7 <- focal(sent[[1]], w=7, fun="sd")
sdNIR13 <- focal(sent[[1]], w=13, fun="sd")
stacksd <- c(sent[[1]], sdNIR, sdNIR7, sdNIR13)
stacksd

names(stacksd) <- c("original", "sd_3", "sd_7", "sd_13")
stacksd

plot(stacksd, col=plasma(100))

# Measuring the variability of the whole original image

sentsd <- focal(sent, w=7, fun="sd")

# layer 1 # NIR
# layer 2 # red
# layer 3 # green

# The output image has three layers:
# Hypothesis: terra is calculating the sd on every single layer
# Test: potting the NIR sd vs. the sd of the first layer of sent

teststack <- c(sdNIR7, sentsd[[1]])
plot(teststack)

# Scatterplot
plot(sdNIR7, sentsd[[1]])
cor(sdNIR7, sentsd[[1]])

# The correlation could be done among vectors
x <- values(sdNIR7)
y <- values(sentsd[[1]])
cor(x, y, use="complete.obs")

# Since cor=1, the two data are the same!

# Loop
sdNIR <- list()

for (w in 1:27) {
  if (w %% 2 == 1 && w > 1) {
    sdNIR[[paste0("w", w)]] <- focal(
      sent[[1]],
      w = matrix(1, nrow = w, ncol = w),
      fun = "sd"
    )
  }
}








