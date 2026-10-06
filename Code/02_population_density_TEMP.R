# Code for studying population spread over space

# install.packages("spatstat")

library(spatstat)

bei

plot(bei)

# changing character
plot(bei, pch=15)

# decrease dimension
plot(bei, pch=15, cex=.5)

# ancillary variables
bei.extra

plot(bei.extra)

# selecting one layer, e.g., elev
el <- bei.extra$elev
plot(el)

el <- bei.extra[[1]]

# density map
dmap <- density(bei)
plot(dmap)
points(bei)

plot(el)
points(bei)

# Plotting together the density map and the elevation
el <- bei.extra[[1]]

# one object is dmap and the other is el
# how to plot the dmap beside el?
par(mfrow=c(1,2)) # we will solve this anti-human stuff soon!
plot(dmap)
plot(el)

# plot the dmap ontop of the el map
par(mfrow=c(2,1)) 
plot(dmap)
plot(el)

# if you want to close graphical devices this is your friend:
dev.off()

cl <- colorRampPalette(c("green", "red", "blue"))
plot(dmap, col=cl)

cl <- colorRampPalette(c("green", "red", "blue"))(100)
plot(dmap, col=cl)

# R colors are here:
# https://r-charts.com/colors/

cln <- colorRampPalette(c("chartreuse1", "brown2", "cyan", "lightblue"))
plot(dmap, col=cln)

# plot the dmap with two different color ramps one on top of the other
dev.off()

par(mfrow=c(2,1)) 
plot(dmap, col=cl)
plot(dmap, col=cln)
