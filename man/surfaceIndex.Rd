\name{surfaceIndex}
\alias{surfaceIndex}
\title{Compute the 6 parameters needed to lay out the grid for the surfaces computed in estSurfaces}
\usage{
  surfaceIndex(localDaily = Daily)
}
\arguments{
  \item{localDaily}{string specifying the name of the data
  frame containing the daily values, default is Daily}
}
\value{
  surfaceIndexParameters a numeric vector of length 6,
  defining the grid for the surfaces
}
\description{
  The code here is a repetition of the first part of the
  code for estSurfaces
}
\examples{
Daily <- exDaily
surfaceIndex()
}
\keyword{statistics}
\keyword{water-quality}

