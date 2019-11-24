test_that("coefficients are the same as lm", {
  set.seed(77)
  X1 = rnorm(1000)
  X2 = rnorm(1000)
  Y = 2*X1+ 3*X2 + rnorm(1000,sd=2)
  model_lm = lm(Y~X1+X2)
  X= cbind(X1,X2)
  model_me = linearReg(Y,X)
  expect_equal(unname(model_lm$coefficients), unname(model_me$coefficients))

  Y = matrix(c(2,3,4,5),4,1)
  X = matrix(c(1.1,2.2,3.3,4.5),4,1)
  model_lm = lm(Y~X)
  model_me = linearReg(Y,X)
  expect_equal(unname(model_lm$coefficients), unname(model_me$coefficients))
})

test_that("if X is a vector, transform to matrix", {
  Y = rnorm(7)
  X = Y+rnorm(7,sd=3)
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

  Y = c(2,NA,4,5)
  X = c(1.1, 2.2 , 3.3, 4.5)
  model_lm= lm(Y~X)
  model_me= linearReg(Y, X)
  expect_equal(unname(model_lm$coefficients), unname(model_me$coefficients))
})

test_that("dimension check", {
  show_condition <- function(code) {
    tryCatch(code,
             error = function(c) "error",
             warning = function(c) "warning",
             message = function(c) "message"
    )
  }
  # Y is longer than X
  Y = matrix(c(2,3,4,5,6),5,1)
  X = matrix(c(1.1,2.2,3.3,4.5),4,1)
  expect_equal(show_condition(linearReg(Y, X)),"error")

  # q is greater than n (3>2 in the following case)
  Y = matrix(c(2,3),2,1)
  X = matrix(c(1.2,2.2,3.4,2.3,3.5,4.4),2,3)
  expect_equal(show_condition(linearReg(Y, X)),"error")
})
