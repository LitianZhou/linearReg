#'Basic linear regression
#'
#'This function is used to build linear models. It can be used to carry out simple linear regression (SLR),
#'multiple linear regression (MLR).
#'
#'@param Y A vector or matrix (one column only) of outcome values.
#'@param X A vector or matrix (one or multiple columns) of predictors.
#'@param has_intercept A boolean variable determines whether the model includes a intercept.
#'
#'@return A list of attributes of the linear model.
#'
#'@export
linearReg = function(Y, X, has_intercept = TRUE) {

  # convert vector to matrix
  if(is.null(attributes(Y))) {
    attr(Y, "dim") = c(length(Y),1)
  }
  if(is.null(attributes(X))) {
    attr(X, "dim") = c(length(X),1)
  }

  # exclude all obs with NAs
  if(sum(Y[is.na(Y)]) > 0 || sum(X[is.na(X)]) > 0) {
    X = X[-which(is.na(Y)),, drop=FALSE]
    Y = Y[-which(is.na(Y)),, drop=FALSE]

    Y = Y[-unique(which(is.na(X),arr.ind = TRUE)[1]),, drop=FALSE]
    X = X[-unique(which(is.na(X),arr.ind = TRUE)[1]),, drop=FALSE]
  }

  # dimension check
  if(nrow(Y) != nrow(X)) {
    stop("Number of the outcomes and observations do not match.")
  } else if(nrow(X) < ncol(X)) {
    stop("Number of observations is less than predictors.")
  }

  # build the design matrix
  if(has_intercept) {
    X = cbind(rep(1,nrow(X)), X)
  }
  a = t(X)%*%X
  b = t(X)%*%Y

  # solve equation of coefficients, named beta:
  # t(X) %*% X %*% beta = t(X)%*%Y
  beta = solve(a, b, tol = 0, transpose = FALSE)
  Y_hat = X%*%beta

  # calculate dimensions
  n = nrow(Y)
  q = ncol(X)
  residuals = Y[,,drop=TRUE] - Y_hat[,,drop=TRUE]
  SSE = sum(residuals*residuals)
  SSY = sum((Y-mean(Y))*(Y-mean(Y)))
  SSR = SSY - SSE
  MSE = SSE/(n-q)
  R_sq = SSR/SSY
  Adj_R_sq = 1- MSE/(SSY/(n-1))

  # solve equation of variance matrix:
  variance_mat = solve(a, diag(MSE,q,q), tol = 0, transpose = FALSE)
  std.error = c(sqrt(diag(variance_mat)))
  t_statistic = beta[,,drop=TRUE]/std.error
  pt_value = 2*pt(-abs(t_statistic),(n-q))

  #F-test
  F_statistic = SSR/(q-1)/MSE
  pf_value = pf(F_statistic, (q-1), (n-q), lower.tail = FALSE)

  return(list(coefficients = beta[,,drop=TRUE], n=n, q=q, residuals=residuals,
              SSE=SSE, SSR=SSR,SSY=SSY, MSE=MSE, R_sq=R_sq, Adj_R_sq=Adj_R_sq,
              variance_mat=variance_mat, std.error=std.error, t_statistic=t_statistic, pt_value=pt_value,
              F_statistic=F_statistic, pf_value=pf_value))
}

#'Print the summary of the linear model
#'
#'This function print the attributes of the linear regression model, including coefficents, and their
#'stand error, t statistics and p values. As for the model, it will print out the residual standard error
#'and R square (both raw and adjusted). At last, it will print the F statistics and its degree of freedom.
#'
#'@param lm The object returned by the function linearReg.
#'
#'@export
summary_linearReg = function(lm) {
  cat("Call:\nlinearReg(Y = X*beta)\n")
  cat("\nResiduals:\n")
  lm$residuals = round(lm$residuals,6)
  if(length(lm$residuals)<=7) {
    names(lm$residuals) = c(1:length(lm$residuals))
    print(lm$residuals)
  } else {
    print(round(summary(lm$residuals),4))
  }
  cat("\nCoefficients:\n")


  coef_df = as.data.frame(list(round(lm$coefficients, 5),round(lm$std.error,5),round(lm$t_statistic,5),round(lm$pt_value,5)),
                          row.names = c("(Intercept)", sprintf("X%d", 1:(lm$q-1))), col.names = c("Coefficients","Std.error","t value", "P value"))
  print(coef_df)
  cat("\n---\n")
  cat(sprintf("\nResidual standard error: %.5f on %d degrees of freedom", sqrt(lm$SSE), (lm$n-lm$q)))
  cat(sprintf("\nMultiple R-squared: %.4f,\tAdjusted R-squared: %.4f",lm$R_sq,lm$Adj_R_sq))
  if(lm$pf_value < 2.2e-16) {
    cat(sprintf("\nF-statistic: %.0f on %d and %d DF, p-value: < 2.2e-16", lm$F_statistic, (lm$q-1),(lm$n-lm$q)))
  }else {
    cat(sprintf("\nF-statistic: %.0f on %d and %d DF, p-value: %f", lm$F_statistic, (lm$q-1),(lm$n-lm$q),lm$pf_value))
  }
  return(lm$F_statistic)
}
