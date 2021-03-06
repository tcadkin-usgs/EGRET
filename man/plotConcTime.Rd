\name{plotConcTime}
\alias{plotConcTime}
\title{Plot of Observed Concentration versus Time}
\usage{
  plotConcTime(localSample = Sample, localINFO = INFO,
    qUnit = 2, qLower = NA, qUpper = NA, paLong = 12,
    paStart = 10, tinyPlot = FALSE, concMax = NA,
    concMin = NA, printTitle = TRUE, logScale = "", ...)
}
\arguments{
  \item{localSample}{string specifying the name of the data
  frame that contains the concentration data, default name
  is Sample}

  \item{localINFO}{string specifying the name of the data
  frame that contains the metadata, default name is INFO}

  \item{qUnit}{object of qUnit class \code{\link{qConst}},
  or numeric represented the short code, or character
  representing the descriptive name.}

  \item{qLower}{numeric the lower bound on values of
  discharge used to select the data points to be plotted,
  units are those specified by qUnit, default = NA which is
  equivalent to a lower bound of zero but if the desired
  lower bound is zero use qLower = NA}

  \item{qUpper}{numeric the upper bound on values of
  discharge for selection of data points to be plotted,
  units are those specified by qUnit, default = NA which is
  equivalent to an upper bound of infinity}

  \item{paLong}{numeric, this is the length of the portion
  of the year from which data should be included in the
  plot, paLong must be an integer between 1 and 12.  The
  default is 12, which prints data from all months.}

  \item{paStart}{numeric, this is the starting month of the
  portion of the year from which data should be included in
  the plot, paStart must be an integer between 1 and 12.
  The default is 10, which corresponds to the water year,
  which starts in October.  If paLong = 12 then the choice
  of paStart is of no consequence.  All months will be
  included.}

  \item{tinyPlot}{logical variable, if TRUE plot is
  designed to be plotted small as part of a multipart
  figure, default is FALSE.}

  \item{concMax}{number specifying the maximum value to be
  used on the vertical axis, default is NA (which allows it
  to be set automatically by the data)}

  \item{concMin}{number specifying the minimum value to be
  used on the vertical axis, only appropriate for log
  scale.}

  \item{printTitle}{logical variable if TRUE title is
  printed, if FALSE title is not printed (this is best for
  a multi-plot figure)}

  \item{logScale}{string, default "", "y" indicates y axis
  is in log scale, "xy" indicates both x and y in log
  scale, "x" is only x}

  \item{...}{arbitrary functions sent to the generic
  plotting function.  See ?par for details on possible
  parameters}
}
\description{
  Data come from a data frame named Sample which contains
  the sample data. The metadata come from a data frame
  named INFO. This function allows the user to plot all of
  the data, but also to limit it in two ways.  The data can
  be limited to only those observed concentrations
  collected in a specified discharge range.  The data can
  also be limited to only those observed in certain months
  of the year.  These two selection criteria can be
  combined. For example, we may only want to plot data for
  discharges between 100 and 500 cubic feet per second in
  the months of March, April and May.
}
\examples{
Sample <- exSample
INFO <- exINFO
plotConcTime(qUnit = 1, qLower = 100, qUpper = 10000, paLong = 3, paStart = 4)
plotConcTime()
}
\keyword{graphics}
\keyword{statistics}
\keyword{water-quality}

