# This code wil develop user based functions

# This is the first function
summa <- function(num1,num2){
  z <- num1 + num2
  return(z)
  }

summa(3, 5)

# Exercise: build a function to muiltiply (*) two numbers 
multiply <- function(num1,num2){
  z = num1 * num2
  return(z)
  }

multiply(3,4)

# Exercise: develop your own function to make the sum of three numbers
summation <- function(num1,num2,num3){
  z = num1 + num2 + num3
  return(z)
  }

summation(4, 5666, 7788)

# A very annoying situation is realted to the par function which is difficult to understand
mf <- function(nx,ny){
  par(mfrow=c(nx,ny))
  }

mf(1,2)
plot(3,5)
plot(6,7)

# Putting default values inside functions
mfdef <- function(nx=2,ny=1){
  par(mfrow=c(nx,ny))
  }

mfdef()
plot(3,5)
plot(6,7)

mfdef(3,1)
plot(3,5)
plot(6,7)
plot(4,5)

# Using the operators if else to look if a number is positive or negative
amIpositive <- function(x){
  if(x>0){
    print("This number is positive, are you drunk?")
    }
  else {
    print("This number is negative, idiot!")  
    }
  }

amIpositive(98)

# Considering all the potential cases
amIpositive <- function(x){
  if(x>0){
    print("This number is positive, are you drunk?")
    }
  else if(x<0){
    print("This number is negative, idiot!")  
    }
  else {
    print("Zero is nor positive nor negative")
    }
  }

amIpositive(98)
amIpositive(-98)
amIpositive(0)

# Developing for loops
loop <- function(){
  for (i in 1:10) {
    print(i)
    }
  }

loop()

# Exercise: develop a loop which will print 13000 numbers from 1 to 13000
loop <- function(){
  for (i in 1:13000) {
    print(i)
    }
  }

loop()

# Loop with an opeartion inside
loop2 <- function(){
  for (i in 1:10) {
    multi <- i * 4
    print(multi)
    }
  }

loop2()

# Make a loop with the power opeator
loop2 <- function(){
  for (i in 1:10) {
    multi <- i ^ 4
    print(multi)
    }
  }

loop2()

# making an output
sink("numbers.txt")
loop2()





