\name{quadraticextrapolation}
\alias{quadraticextrapolation}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Quadratic Extrapolation Method}
\description{
  Quadratic extrapolation step of SIMEX algorithm.
}
\usage{
quadraticextrapolation(A1, A2, A3, lambda)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{A1}{ estimates obtained from each level of labmda. }
  \item{A2}{ variances estimates obtained from each level of lambda.  }
  \item{A3}{ scale estimates obtained from each level of lambda.  }
  \item{lambda}{ vector of lambdas, the grids for the extrapolation step.  }
}

\value{
  \item{reg1 }{extrapolation back to lambda=-1 yield the SIMEX estimates }
  \item{reg2 }{extrapolation back to lambda=-1 yield the SIMEX estimates of variances }
  \item{scalereg }{extrapolation back to lambda=-1 yield the SIMEX estimates of scale }
}

\references{
He WQ, Yi GY, Xiong J.(2007) Accelerated Failure Time Models with Covariates Subject to Measurement Error. \emph{Statistics in Medicine}, 26, 4817-4832.
}

\seealso{\code{\link[simexaft]{linearextrapolation}}}
\author{ Juan Xiong, Wenqing He and Grace Y. Yi}


