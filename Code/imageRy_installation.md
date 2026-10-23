# Remote sensing for ecosystems

## Installation of the imageRy package from GitHub

<img width="5712" height="4284" alt="IMG_9020" src="https://github.com/user-attachments/assets/9779c3a7-34dc-445a-b39f-371140fef1d0" />

In order to install packages from GitHub you need to use a function coming out from the remote spackage.

Hence:
+ install the remotes package
+ install imageRy

### 1. Install remotes

``` r
install.packages("remotes")
```

### 2. Install imageRy from GitHub

``` r
library(remotes)
install_github("ducciorocchini/imageRy") # GitHub account and package
```

During the installation do not update previous packages (just pressing enter)

Write:
``` r
library(imageRy)
```

to check that the package has been properly installed.
