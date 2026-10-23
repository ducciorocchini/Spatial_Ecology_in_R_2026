# Code to develop graphs from species as nodes

# install.packages("igraph") # run once
library(igraph)


# The nodes
# species <- c("Algae", "Zooplankton", "Small Fish", "Large Fish", "Bird")
# Putting real species:
species <- c("Algae", "Zooplankton", "Aphia minuta", "Cyprinus carpio", "Larus")

# Interactions
# predator <- c("Zooplankton", "Small Fish", "Large Fish", "Bird", "Bird")
# prey <- c("Algae", "Zooplankton", "Small Fish", "Small Fish", "Large Fish")
# Putting real species:
predator <- c("Zooplankton", "Aphia minuta", "Cyprinus carpio", "Larus", "Larus")
prey <- c("Algae", "Zooplankton", "Aphia minuta", "Aphia minuta", "Cyprinus carpio")

# Exercise: create a dataframe with predators and preys inside
interactions <- data.frame(predator, prey)

# Building the graph
graph <- graph_from_data_frame(interactions, vertices=species) # directed=TRUE is the default
plot(graph)

# Building the graph without diretcions
graph <- graph_from_data_frame(interactions, vertices=species, directed=FALSE) # directed is the default
plot(graph)

# The graph will maintain the same interactions but with a different representation
# The seed!!!
set.seed(42)
graph <- graph_from_data_frame(interactions, vertices=species) # directed=TRUE is the default
plot(graph)





