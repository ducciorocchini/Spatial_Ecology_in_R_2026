# This code can be used to classify satellite data

library(terra)
library(imageRy)
library(ggplot2) # install.packages("ggplot2")
# install.packages(patchwork)
library(patchwork) 

im.list()

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
# from outside the imageRy package: rast() function from terra
# layers: 1 = NIR, 2 = red; 3 = green

plot(m1992) # rgb 123

# Exercise: import the image from 2006
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
plot(m2006)

# testing classification
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
plot(sun)

sunc <- im.classify(sun, num_clusters=3) # unsupervised classification

par(mfrow=c(2,1))
plot(sun)
plot(sunc)

# Apply the classification process to the Mato Grosso area

m1992c <- im.classify(m1992, num_clusters=2)
# class 1: human + water
# class 2: rainforest

# Exercise: classify the 2006 image
m2006c <- im.classify(m2006, num_clusters=2)
# class 1: rainforest
# class 2: human + water

# Calculating frequcnies
f1992 <- freq(m1992c)

# Proportions
# f/tot
tot1992c <- ncell(m1992c)
prop1992 = f1992$count / tot1992c

# Percentages
perc1992 = prop1992 * 100
# 1992: human = 17%, forest = 83%

# You can calculate everything in a single line
perc1992 = freq(m1992c) * 100 / ncell(m1992c)

# Exercise: calculate percentages of the image from 2006
perc2006 = freq(m2006c) * 100 / ncell(m2006c)
# 2006: forest = 45%, human = 55%

# Let's implement a dataframe withthree columns: 
# class
# perc1992
# perc2006

class <- c("forest", "human")
perc1992 <- c(83, 17)
perc2006 <- c(45, 55)
tabout <- data.frame(class, perc1992, perc2006)
tabout # the dataframe is ready to go!

# Using the ggplot2 package for the final graph
p1 <- ggplot(tabout, aes(x=class, y=perc1992, color=class)) + 
      geom_bar(stat="identity", fill="white") +
      ylim(c(0,100)) +
      theme(legend.position = "none")

# Exercise: make the same plot for 2006
p2 <- ggplot(tabout, aes(x=class, y=perc2006, color=class)) + 
      geom_bar(stat="identity", fill="white") +
      ylim(c(0,100))

p1 + p2
p1 / p2
