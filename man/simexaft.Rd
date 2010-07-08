\name{simexaft}
\alias{simexaft}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ SIMEX Algorithm for Accelerated Failure Time Model with Covariates Subject to Measurement Error }
\description{
  Implementation of the SIMEX algorithm for Accelerated Failure Time model with covariates subject to measurement error.
}
\usage{
simexaft(formula = formula(data), data = parent.frame(), SIMEXvariable, repeated = "FALSE", repind = list(), err.mat = err.mat, B =50, lambda = seq(0, 2, 0.1), extrapolation = "quadratic", dist = "weibull")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{formula}{ the model to fit in the survreg function, with the variables coming with data.  }
  \item{data}{ optional data frame in which to interpret the varialbes occurring in the formula.  }
  \item{SIMEXvariable}{ vector contains the names of the variables subject to meansurement error.  }
  \item{repeated}{ the indicator of repeat measurement, set to "TRUE" or "FALSE".  }
  \item{repind}{ list contiains the names of the repeat measument variables. If repeated = "TRUE", repind must be specify.  }
  \item{err.mat}{ covariance matrix of the variables with measurement error, If repeated = "FALSE", err.mat must be specify. }
  \item{B}{ number of iterations for each lambda, The default is set to 50.  }
  \item{lambda}{ vector of lambdas, the grids for the extrapolation step.  }
  \item{extrapolation}{ extrapolation method: linear, quadratic are implemented(first 4 letters are enough) }
  \item{dist}{ specifies a distribution that is assumed in AFT model. This argument is the same as the "dist" option in the existing R function "survreg". These include "weibull", "exponential", "gaussian", "logistic", "lognormal", and "loglogistic". }
}
\details{
  If the SIMEXvariable is repeated measured then you only need to use arguments repeated and repind without mention err.mat. The summary.simex will contain repind. 
}
\value{
  \item{coefficient}{the corrected coefficients of the AFT model}
  \item{se}{the standard deviation of each coefficient}
  \item{pvalue}{p-value for the hypothesis of that coefficient equal zero}
  \item{scalreg}{the estimate of the scale}
  \item{theta}{estimates for every B and lambda}
  \item{lambda}{ vector of lambdas for which the simulation step should be done }
  \item{B}{ number of iterations for each lambda  }
  \item{formula}{ the model to fit in the survreg function }
  \item{err.mat}{ covariance matrix  of the variables with measurement error}
  \item{repind}{ list contiains the names of the repeat measument variables }
  \item{extrapolation}{ extrapolation method: linear ,quadratic are implemented(first 4 letters are enough)}
  \item{SIMEXvariable}{ vector contains the names of the variables with meansurement error }

}

\references{
He WQ, Yi GY, Xiong J.(2007) Accelerated Failure Time Models with Covariates Subject to Measurement Error. \emph{Statistics in Medicine}, 26, 4817-4832.
}
\author{ Juan Xiong, Wenqing He and Grace Y. Yi}

\seealso{\code{\link[survival]{survreg}}, \code{\link[simexaft]{plotsimexaft}}}

\examples{
###example for the dataset with known variance.
library(simexaft)
data(rhDNase)

#########fit dataset to the aft model weibull distribution#############

output <- survreg(Surv(rhDNase$time2, rhDNase$status) ~ rhDNase$trt + rhDNase$fev, dist='weibull')

summary(output)


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


###########naive fit a AFT model##########
output1 <- survreg(formula=formula, data=dataset,dist='weibull')

summary(output1)


#######use simexaft to adjust the effect of measurement error and apply the quadratic extrapolation######
fit1 <-simexaft(formula=formula, data=dataset,SIMEXvariable=ind,repeated="FALSE",err.mat=err,B=50,lambda=seq(0,2,0.1),extrapolation="quadratic",dist="weibull")

fit1

summary(fit1)








#######################example for dataset with unknown variance but replicate measurements for error-prone covairates are availabel#############
library(simexaft)
data(rhDNase)

####sensitive analysis#####
set.seed(120)
error.sd <- 0.8*sd(rhDNase$fev)

error.sd2 <- 0.8*sd(rhDNase$fev2)

fev.error <- rhDNase$fev + rnorm(length(rhDNase$fev), mean=0,sd=error.sd)

fev.error2 <- rhDNase$fev2 + rnorm(length(rhDNase$fev2), mean=0,sd=error.sd2)

dataset2<-cbind(rhDNase$time2, rhDNase$status, rhDNase$trt, fev.error, fev.error2)

colnames(dataset2)<-c("time2","status","trt","fev.error","fev.error2")

dataset2 <- as.data.frame(dataset2)

formula <- Surv(time2, status)~trt + fev.error

ind <- c("fev.error")

#####naive model#######
fev.error.c = (fev.error + fev.error2)/2
output2 <- survreg(Surv(rhDNase$time2, rhDNase$status) ~ rhDNase$trt + fev.error.c, dist='weibull')
output2
summary(output2)


#######use simexaft to adjust the effect of measurement error and apply the quadratic extrapolation######
fit2=simexaft(formula=formula,data=dataset2,SIMEXvariable=ind,repeated="TRUE",repind=list(c("fev.error","fev.error2")),err.mat=NULL,B=50,lambda=seq(0,2,0.1),extrapolation="linear",dist="weibull")

fit2

summary(fit2)

}






