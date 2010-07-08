\name{plotsimexaft}
\alias{plotsimexaft}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Plot the Extrapolation Curve
}
\description{
A function to give the plot of the extrapolation curve for any covariables of the AFT model.
}
\usage{
plotsimexaft(obj, var, extrapolation = c("linear", "quadratic", "both"), ylimit)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{obj}{an object returned by the function "simexaft".}
  \item{var}{a character string of any covariate used in the AFT model.}
  \item{extrapolation}{a character string giving the type of the extrapolation method, the default is set to be linear extrapolation.}
  \item{ylimit}{the y limits of the plot.}
}

\details{
 The green points are the average of estimates of B iteration for each labmda. 
 
 The linear extrapolation curve is in blue, the corresponding SIMEX estimate is the solid red circle.
 
 The quadratic extrapolation curve is in red, the corresponding SIMEX estimate is the solid blue circle.

 The "both" option of the extrapolation method gives both linear and quadratic extrapolation curves.  
}


\author{ Juan Xiong, Wenqing He and Grace Y. Yi}

\seealso{
\code{\link[survival]{survreg}}
}

\examples{
###########example for the dataset with known variance.################
library(simexaft)
data(rhDNase)

###############sensitive analysis###############
set.seed(120)
error.sd <- 0.8*sd(rhDNase$fev)

fev.error <- rhDNase$fev + rnorm(length(rhDNase$fev), mean=0,sd=error.sd)

dataset<-cbind(rhDNase$time2, rhDNase$status, rhDNase$trt, fev.error)

colnames(dataset)<-c("time2","status","trt","fev.error")

dataset <- as.data.frame(dataset)

formula <- Surv(time2, status)~trt + fev.error

ind <- c("fev.error")

err <- matrix(error.sd^2)

#######use simexaft to adjust the effect of measurement error and apply the quadratic extrapolation######
fit1 <-simexaft(formula=formula, data=dataset,SIMEXvariable=ind,repeated="FALSE",err.mat=err,B=50,lambda=seq(0,2,0.1),extrapolation="quadratic",dist="weibull")

fit1

summary(fit1)


plotsimexaft(fit1,"fev.error","both",ylim=c(-0.01,0.02))

}


