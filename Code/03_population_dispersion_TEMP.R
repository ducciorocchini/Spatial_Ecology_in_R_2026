# install.packages("sdm")
# install.packages("terra")
# install.packages("viridis")

library(terra)
library(sdm)
library(viridis)

file <- system.file("external/species.shp", package="sdm")

rana <- vect(file)
plot(rana)


# Assuming 'rana' is your SpatVector with points and attributes
# Extract coordinates using the geom() function
coordinates <- geom(rana)

# Convert the coordinates to a data frame
coordinates_df <- as.data.frame(coordinates)

# Extract the 'Occurrence' attribute from the SpatVector
occurrence_df <- as.data.frame(rana$Occurrence)

# Combine the coordinates and the occurrence data into one data frame
final_df <- cbind(coordinates_df, occurrence_df)

# Export the final data frame to a CSV file
write.csv(final_df, "coordinates_with_occurrence.csv", row.names = FALSE)

# View the first few rows of the final table (optional)
head(final_df)

# Add the attribute column (e.g., Occurrence) to the data frame
coordinates_df$Occurrence <- rana$Occurrence

# Export the data frame to a CSV file
write.csv(coordinates_df, "coordinates_with_occurrence.csv", row.names = FALSE)

# Occurrences
rana$Occurrence

# Selection of presences
pres <- rana[rana$Occurrence==1]

# Exercise: select all absences
abse <- rana[rana$Occurrence==0]
# or
abse <- rana[rana$Occurrence!=1]

# Ecercise: plot the presences with a color together with the absences with another color
plot(pres, col="#76EE00") # chartreuse1
# or
plot(pres, col="chartreuse1") 

plot(abse, col="#FF1493") # deeppink
# I cannot use plot but, rather, I would prefer using points()

plot(pres, col="chartreuse1") 
points(abse, col="#FF1493") # deeppink

# Exercise: do the same in a multiframe with the two sets: pres on top of abse
par(mfrow=c(2,1))
plot(pres)
plot(abse)

# Covariates
elev <- system.file("external/elevation.asc", package="sdm")
# [1] "/usr/local/lib/R/site-library/sdm/external/elevation.asc"

elevmap <- rast(elev)

# Exercise: change the colors of the elevation map by the colorRampPalette function
cl <- colorRampPalette(c("green","hotpink","mediumpurple"))(100)
plot(elevmap, col=cl)

# Exercise: plot the presnces together with elevation map
points(pres, pch=19)

# Exercise: import temperature and plot presences vs. temperature
temp <- system.file("external/temperature.asc", package="sdm")

tempmap <- rast(temp)
plot(tempmap)
points(pres)

plot(tempmap, col=mako(100))

# Exercise: plot elevation and temperature with presences one beside the other
par(mfrow=c(1,2))
plot(elevmap, col=mako(100))
points(pres)
plot(tempmap, col=mako(100))
points(pres)

# precipitation
prec <- system.file("external/precipitation.asc", package="sdm")

precmap <- rast(prec)
points(pres)

# vegetation
vege <- system.file("external/vegetation.asc", package="sdm")
vegemap <- rast(vege)
plot(vegemap)
points(pres)

# Exercise: plot all the ancillary variable in a multiframe
par(mfrow=c(2,2))
plot(elevmap)
plot(tempmap)
plot(precmap)
plot(vegemap)

anci <- c(elevmap, tempmap, precmap, vegemap)
plot(anci)
plot(anci, col=magma(100))
