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
#>  Call:
#>  linearReg(Y = X*beta)
#> 
#> Residuals:
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>  -6.197  -1.199  -0.063   0.000   1.516   5.660 
#> 
#> Coefficients:
#>             Coefficients Std.error  t.value P.value
#> (Intercept)     -0.09401   0.21957 -0.42815 0.66949
#> X1               0.87602   0.22572  3.88107 0.00019
#> X2               3.31357   0.22805 14.52991 0.00000
#> 
#> ---
#> 
#> Residual standard error: 21.20694 on 97 degrees of freedom
#> Multiple R-squared: 0.7009,	Adjusted R-squared: 0.6948
#> F- statistic: 114 on 2 and 97 DF, p-value: < 2.2e-16 
#> [1] "X values are significantly associated with Y (p < 0.05)"
```

## Getting help
There are help pages for each function, use `help(linearReg)` and `help(summary_linearReg)` to see more examples.

Otherwise, try `browseVignettes("linearReg")` to checkout the tutorial.
