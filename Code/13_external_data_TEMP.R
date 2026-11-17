setwd("youtpath")

files <- list.files(
  path = "path/to/your/folder",
  pattern = "\\.tif$",
  full.names = TRUE
)

data <- lapply(files, terra::rast)
