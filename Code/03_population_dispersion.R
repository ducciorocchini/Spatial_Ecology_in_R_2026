# Script for modelling the dispersion of individuals of a popultion

# New packages to be installed:
# install.packages("terra")
# install.packages("sdm")
# install.packages("viridis")

# Check the packages
library(terra)
library(sdm)
library(viridis) # https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html

# Path to the file
path <- system.file("external/species.shp", package="sdm")

# Import the vector data
rana <- vect(path)
rana

# Plotting the data
plot(rana)

# Looking at coordinates
coordinates <- geom(rana)

# SUBSET YOUR DATA!!!
# Subset the dataset extracting presences
presence <- rana[rana$Occurrence == 1] # take care of the capital letter!

# Exercise: select and assign absences
# option 1
absence <- rana[rana$Occurrence == 0]
# option 2
absence <- rana[rana$Occurrence != 1]

# Plot the presences
plot(presence)

# Plot the absences
plot(absence)

# Exercise: plot presences and absences with different colors in the same plot
plot(presence, col="blue", cex=2.5)
points(absence, col="violet", cex=2.5)

# Exercise: load the path to the elevation file
elev <- system.file("external/elevation.asc", package="sdm")

# Exercise: using the rast() function import the data
elevmap <- rast(elev)
plot(elevmap)

# Exercise: change the colors of the map
cl <- colorRampPalette(c("dark blue", "green", "light blue"))(100)
plot(elevmap, col=cl)

# Plotting presences vs. elevation
cl <- colorRampPalette(c("red", "orange", "yellow"))(100)
plot(elevmap, col=cl)
points(presence, cex=2)

# Exercise: import and plot temperature with the cl ramp palette
temp <- system.file("external/temperature.asc", package="sdm")
tempmap <- rast(temp)
plot(tempmap, col=cl)
points(presence, cex=2)

# Exercise: import and plot precipitation.asc with the cl ramp palette
prec <- system.file("external/precipitation.asc", package="sdm")
precmap <- rast(prec)
plot(precmap, col=cl)
points(presence, cex=2)

# Exercise: import and plot precipitation.asc with the cl ramp palette
vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <- rast(vege)
plot(vegemap, col=cl)
points(presence, cex=2)

# Plotting the elevation map with the virids package
plot(elevmap, col=viridis(100))
plot(elevmap, col=mako(100))

# Exercise: plot the four maps together in the sam multiframe
par(mfrow=c(2,2))
plot(elevmap, col=plasma(100), main="elevation")
plot(tempmap, col=plasma(100), main="temperature")
plot(precmap, col=plasma(100), main="precipitation")
plot(vegemap, col=plasma(100), main="vegetation")

# Making a stack: IMPORTANT CONCEPT!
drivers <- c(elevmap, tempmap, precmap, vegemap)
plot(drivers, col=inferno(100))

# Plot  asingle driverf from the stack
t <- drivers[[2]]
# t <- drivers$temperature
plot(t)
points(presence, cex=2)




