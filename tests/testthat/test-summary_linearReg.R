test_that("F_statistic equal", {
  set.seed(777)
  X1 = rnorm(1000)
  X2 = rnorm(1000)
  Y = 2*X1+ 3*X2 + rnorm(1000,sd=2)
  model_lm = lm(Y~X1+X2)
  X= cbind(X1,X2)
  model_me = linearReg(Y,X)
  expect_equal(unname(summary(model_lm)$fstatistic[1]), summary_linearReg(model_me))
})

test_that("when sample size smaller or equal to 7", {
  Y = rnorm(7)
  X = Y+rnorm(7,sd=3)
  model_lm = lm(Y~X)
  model_me = linearReg(Y,X)
  expect_equal(unname(model_lm$coefficients), unname(model_me$coefficients))
})
