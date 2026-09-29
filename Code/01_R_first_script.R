# Script for using R

# operation
2 + 3 

# an object
samuele <- 2 + 3

# another object
gemma <- 4 + 6

# different ojects
samuele + gemma
samuele * gemma # instead of writing (2+3) * (4+6)
samuele ^ gemma

tma <- 5 * 4

tma + samuele + gemma # 20 + 5 + 10

# we are using the function c()
matteo <- c(5, 10, 20, 50, 80) # an array is a set of elements: this is the array of mammal species

sum(5, 10)
sum (5, 10) # I HATE THIS!!

elisa <- c(100, 80, 50, 20, 10) # an array of human deaths due to a disease 

plot(matteo, elisa)

# changing the point character
plot(matteo, elisa, pch=19)

# character exaggeration
plot(matteo, elisa, pch=19, cex=2)

# changing the color
plot(matteo, elisa, pch=19, cex=2, col="blue")
plot(matteo, elisa, pch=19, cex=2, col="chartreuse3")

# changing the labels
plot(matteo, elisa, pch=19, cex=2, col="chartreuse3", xlab="number of mamals", ylab="number of human deaths")

# increasing the axis dimension
plot(matteo, elisa, pch=19, cex=2, col="chartreuse3", xlab="number of mamals", ylab="number of human deaths", cex.axis=2)

# long function!
plot(matteo, 
     elisa, 
     pch=19, 
     cex=4, 
     col="maroon2", 
     xlab="number of mamals", 
     ylab="number of human deaths", 
     cex.axis=2,
     cex.lab=2)




