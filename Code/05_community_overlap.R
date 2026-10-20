# Once we have seen how species are related to each other is space we can proceed to look at how they are related to each other in time

# install.packages("overlap")
library(overlap)

# Using the dataset
data(kerinci) # https://it.wikipedia.org/wiki/Parco_nazionale_di_Kerinci_Seblat

kerinci
head(kerinci)

# If you want to look at the end of the dataset: tail()
tail(kerinci)

# Getting a summary of the dataset
summary(kerinci)

# Circular time
circulartime <- kerinci$Time * 2 * pi

# Putting the circular time inside the dataset
kerinci$Timecirc <- kerinci$Time * 2 * pi

# Loing at the new column
head(kerinci)

# Subsetting the dataset with the selection of the species tiger
tiger <- kerinci[kerinci$Sps=="tiger",]

summary(tiger)

# Density plot of spreading of the tiger in the area in different times
densityPlot(tiger$Timecirc)

# Alternative method: create the time variable from the tiger dataset and use it in the calculation
tigertime <- tiger$Timecirc
densityPlot(tigertime)




