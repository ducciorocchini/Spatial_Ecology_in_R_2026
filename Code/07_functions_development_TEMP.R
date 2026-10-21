# My functions!

somma <- function(x,y){
  z=x+y
  return(z)
  }

# Exercise: make the functuion called difference

differenzaselvaggia <- function(x,y){
  z=x-y
  return(z)
  }

# par(mfrow...) 
mf <- function(nx,ny){
  par(mfrow=c(nx, ny))
}

# par(mfrow...) with default
mf <- function(nx=1,ny=2){
  par(mfrow=c(nx, ny))
  }

# if else
numeri <- function(x){
  if(x>0){
    print("Questo numero è positivo, ciuco!")
    }
  else {
    print("Questo numero è negativo, se non sai queste cose, torna a scuola")  
    }
  }

# if else
numeri <- function(x){
  if(x>0){
    print("Questo numero è positivo, ciuco!")
    }
  else if(x<0) {
    print("Questo numero è negativo, se non sai queste cose, torna a scuola")  
    }
  else {
    print("Zero non è né negativo né positivo") 
    }
  }

# Cicli for
loop <- function(){
  for (i in 1:10) {
    print(i)
    }
  }

loop2 <- function(){
  for (i in 1:10) {
    op <- i * 2
    print(op)
    }
  }

loop3 <- function(){
  for (i in 1:1000) {
    op <- (i^3 * 2) / 3
    print(op)
    }
  }

sink("data.txt")
loop3()
sink()
