test_that("coefficients are the same as lm", {
  set.seed(77)
  X1 = rnorm(1000)
  X2 = rnorm(1000)
  Y = 2*X1+ 3*X2 + rnorm(1000,sd=2)
  model_lm = lm(Y~X1+X2)
  X= cbind(X1,X2)
  model_me = linearReg(Y,X)
  expect_equal(unname(model_lm$coefficients), unname(model_me$coefficients))
})

test_that("if X is a vector, transform to matrix", {
  Y = rnorm(8)
  X = Y+rnorm(8,sd=0.3)
  model_lm = lm(Y~X)
  model_me = linearReg(Y,X)
  expect_equal(unname(model_lm$coefficients), unname(model_me$coefficients))
})

test_that("NAs are properly removed", {
  Y = c(2,3,4,5)
  X = c(1.1, NA, 3.3, 4.5)
  model_lm= lm(Y~X)
  model_me= linearReg(Y, X)
  expect_equal(unname(model_lm$coefficients), unname(model_me$coefficients))
})
