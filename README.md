# linearReg
<!-- badges: start -->
  [![Travis build status](https://travis-ci.org/LitianZhou/linearReg.svg?branch=master)](https://travis-ci.org/LitianZhou/linearReg)
  [![codecov](https://codecov.io/gh/LitianZhou/linearReg/branch/master/graph/badge.svg)](https://codecov.io/gh/LitianZhou/linearReg)
<!-- badges: end -->

## Overview

linearReg is a simplified version of R function lm(), which stands for linear regression.

It currently has two functions:
- `linearReg()` reads dependant and independant values and calculate a list of parameters of the linear model.
- `summary_linearReg()` reads the return value of `linearReg()` and mimic an output of `summary()` function of base R `lm()`. It also returns the conclusion of the fitted model.

## Installation
```r
#install useing devtools from GitHub website:
devtools::install_github("LitianZhou/linearReg")
```

## Use
```r
library(linearReg)

load("data/Y.Rdata")
load("data/X.Rdata")
model = linearReg(Y, X)
summary_linearReg(model)
```

## Getting help
There are help pages for each function, use `help(linearReg)` and `help(summary_linearReg)` to see more examples.

a tutorial for the overall use.
