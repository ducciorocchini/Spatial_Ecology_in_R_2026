# Copy paste the prevous code (04_community_overlap.R)

# Plot the two densities of the tiger and the macaque one beside
par(mfrow=c(1,2))
densityPlot(tigertime)
densityPlot(macaquetime)

# Get the species names
species <- unique(kerinci$Sps)

# Set up the plotting window with two columns
par(mfrow = c(ceiling(length(species) / 2), 2))

# Draw one density plot for each ith species 
for (i in species) {
  times <- kerinci$Timecirc[kerinci$Sps == i]
  densityPlot(times, main = i)
}

# Reset the plotting window
par(mfrow = c(1, 1))
