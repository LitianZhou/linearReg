#test1, SLR
# matrix input
Y = matrix(c(2,3,4,5),4,1)
X = matrix(c(1.1,2.2,3.3,4.5),4,1)
# vector input
Y = rnorm(6)
X = Y+rnorm(6,sd=0.3)
model0 = lm(Y~X)
summary(model0)
model0_me = linearReg(Y,X)
summary_linearReg(model0_me)
#test2, MLR
set.seed(7)
X1 = rnorm(100)
X2 = rnorm(100)
Y = X1+ 3*X2 + rnorm(100,sd=2)
model2 = lm(Y~X1+X2)
summary(model2)
X= cbind(X1,X2)
model2_me = linearReg(Y,X)

#test3, MLR with NAs
#test4, SLR with one categorical predictor
#test5, MLR with one categorical predictor
