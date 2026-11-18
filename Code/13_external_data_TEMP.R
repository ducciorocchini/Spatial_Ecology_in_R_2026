library(terra)

# Single files

setwd("youtpath")

input <- rast("yourdta")

# Zenodo link to the data taken by drones:
# https://zenodo.org/records/24343819

bolonir <- rast("DJI_20261118105819_0004_MS_NIR.TIF")
bolonir <- flip(bolonir)

bolored <- rast("DJI_20261118105819_0004_MS_RE.TIF")
bolored <- flip(bolored)

bologre <- rast("DJI_20261118105819_0004_MS_G.TIF")
bologre <- flip(bologre)

bolo <- c(bolonir, bolored, bologre)
plot(bolo)
plotRGB(bolo, 1, 2, 3, stretch="lin")

# Several files at a time

files <- list.files(
  path = "yourpath",
  pattern = "DJI_20261118105819_0004_MS",
  full.names = TRUE
)

ms <- rast(files)
ms <- flip(ms)

plot(ms)

# Uploading directly from GitHub or Zenodo

# Directly from GitHub

gitgroup <- rast("https://raw.githubusercontent.com/ducciorocchini/Spatial_Ecology_in_R_2026/main/Data/group_photo/DJI_20261118105938_0002_D.JPG")

# Directly from Zenodo
# zenodo <- rast("https://zenodo.org/records/24343819/files/DJI_20261118105819_0004_MS_R.TIF")
# plot(zenodo)
