\name{getJulian}
\alias{getJulian}
\title{A utility program to determine the Julian day for any given date}
\usage{
  getJulian(date)
}
\arguments{
  \item{date}{character string specifying a date.  In
  quotes as "yyyy-mm-dd"}
}
\value{
  Julian a numeric value, representing the julian day since
  1850-01-01
}
\description{
  Julian days are computed with an origin of "1850-01-01".
  Data input is, in quotes, something like "1949-09-30"
}
\examples{
getJulian("1949-09-30")
}
\keyword{quality,}
\keyword{statistics}
\keyword{streamflow,}
\keyword{water}

