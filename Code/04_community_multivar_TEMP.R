# Code for performing multivariate analysis with community abundance matrices

# install.packages("vegan")
library(vegan)

data(dune)
head(dune)

# Multivariate analysis
multivar <- decorana(dune)
multivar

dcal1 = 3.7004
dcal2 = 3.1166 
dcal3 = 1.30055
dcal4 = 1.47888

total = dcal1 + dcal2 + dcal3 + dcal4
# or:
total <- sum(c(dcal1, dcal2, dcal3, dcal4))

percdca1 = dcal1 * 100 / total
percdca2 = dcal2 * 100 / total

percdca1 + percdca2

plot(multivar)

# Principal component analysis
multipca <- pca(dune)
plot(multipca)











multivar <- decorana(dune)
multivar

dca1l = 3.7004
dca2l = 3.1166
dca3l = 1.30055
dca4l = 1.47888

# get the percentage of the range detected (explained variability) by each axis

total = dca1l + dca2l + dca3l + dca4l

total = sum(c(dca1l, dca2l, dca3l, dca4l))

percdca1 = dca1l * 100 / total
percdca2 = dca2l * 100 / total

percdca1 + percdca2
#  71.03683

multipca <- pca(dune)

plot(multivar)
plot(multipca)
