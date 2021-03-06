#' Create a table of the changes in flow-normalized values between various points in time in the record
#'
#' These tables describe trends in flow-normalized concentration and in flow-normalized flux. 
#' They are described as changes in real units or in percent and als as slopes in real units per year or in percent per year.
#' They are computed over pairs of time points.  These time points can be user-defined or
#' they can be set by the program to be the final year of the record and a set of years that are multiple of 5 years prior to that.
#'
#' @param localAnnualResults string specifying the name of the data frame that contains the concentration and discharge data, default name is AnnualResults
#' @param localINFO string specifying the name of the data frame that contains the metadata, default name is INFO
#' @param fluxUnit object of fluxUnit class. \code{\link{fluxConst}}, or numeric represented the short code, or character representing the descriptive name.
#' @param yearPoints numeric vector listing the years for which the change or slope computations are made, they need to be in chronological order.  For example yearPoints=c(1975,1985,1995,2005), default is NA (which allows the program to set yearPoints automatically)
#' @keywords water-quality statistics
#' @export
#' @examples
#' AnnualResults <- exAnnualResults
#' INFO <- exINFO
#' tableChange(fluxUnit=6,yearPoints=c(2001,2005,2008,2009))
#' tableChange(fluxUnit=9) 
tableChange<-function(localAnnualResults = AnnualResults, localINFO = INFO, fluxUnit = 9, yearPoints = NA) {
  ################################################################################
  # I plan to make this a method, so we don't have to repeat it in every funciton:
  if (is.numeric(fluxUnit)){
    fluxUnit <- fluxConst[shortCode=fluxUnit][[1]]    
  } else if (is.character(fluxUnit)){
    fluxUnit <- fluxConst[fluxUnit][[1]]
  }
  ################################################################################ 
  firstYear<-trunc(localAnnualResults$DecYear[1])
  numYears<-length(localAnnualResults$DecYear)
  lastYear<-trunc(localAnnualResults$DecYear[numYears])
  defaultYearPoints<-seq(lastYear,firstYear,-5)
  numPoints<-length(defaultYearPoints)
  defaultYearPoints[1:numPoints]<-defaultYearPoints[numPoints:1]
  yearPoints<-if(is.na(yearPoints[1])) defaultYearPoints else yearPoints
  numPoints<-length(yearPoints)
  # these last three lines check to make sure that the yearPoints are in the range of the data	
  yearPoints<-if(yearPoints[numPoints]>lastYear) defaultYearPoints else yearPoints
  yearPoints<-if(yearPoints[1]<firstYear) defaultYearPoints else yearPoints
  numPoints<-length(yearPoints)
  fluxFactor<-fluxUnit@unitFactor
  fName<-fluxUnit@shortName
  cat("\n  ",localINFO$shortName,"\n  ",localINFO$paramShortName)
  periodName<-setSeasonLabel(localAnnualResults = localAnnualResults)
  cat("\n  ",periodName,"\n")
  header1<-"\n           Concentration trends\n   time span       change     slope    change     slope\n                     mg/L   mg/L/yr        %       %/yr"
  header2<-"\n\n\n                 Flux Trends\n   time span          change        slope       change        slope"
  blankHolder<-"      ---"
  results<-rep(NA,4)
  indexPoints<-yearPoints-firstYear+1
  numPointsMinusOne<-numPoints-1
  write(header1,file="")
  
  for(iFirst in 1:numPointsMinusOne) {
    xFirst<-indexPoints[iFirst]
    yFirst<-localAnnualResults$FNConc[indexPoints[iFirst]]
    iFirstPlusOne<-iFirst+1
    for(iLast in iFirstPlusOne:numPoints) {
      xLast<-indexPoints[iLast]
      yLast<-localAnnualResults$FNConc[indexPoints[iLast]]
      xDif<-xLast - xFirst
      yDif<-yLast - yFirst
      results[1]<-if(is.na(yDif)) blankHolder else format(yDif,digits=2,width=9)
      results[2]<-if(is.na(yDif)) blankHolder else format(yDif/xDif,digits=2,width=9)
      results[3]<-if(is.na(yDif)) blankHolder else format(100*yDif/yFirst,digits=2,width=9)
      results[4]<-if(is.na(yDif)) blankHolder else format(100*yDif/yFirst/xDif,digits=2,width=9)
      cat("\n",yearPoints[iFirst]," to ",yearPoints[iLast],results)
    }}
  write(header2,file="")
  cat("              ",fName,fName,"/yr      %         %/yr")
  for(iFirst in 1:numPointsMinusOne) {
    xFirst<-indexPoints[iFirst]
    yFirst<-localAnnualResults$FNFlux[indexPoints[iFirst]]*fluxFactor
    iFirstPlusOne<-iFirst+1
    for(iLast in iFirstPlusOne:numPoints) {
      xLast<-indexPoints[iLast]
      yLast<-localAnnualResults$FNFlux[indexPoints[iLast]]*fluxFactor
      xDif<-xLast - xFirst
      yDif<-yLast - yFirst
      results[1]<-if(is.na(yDif)) blankHolder else format(yDif,digits=2,width=12)
      results[2]<-if(is.na(yDif)) blankHolder else format(yDif/xDif,digits=2,width=12)
      results[3]<-if(is.na(yDif)) blankHolder else format(100*yDif/yFirst,digits=2,width=12)
      results[4]<-if(is.na(yDif)) blankHolder else format(100*yDif/yFirst/xDif,digits=2,width=12)
      cat("\n",yearPoints[iFirst]," to ",yearPoints[iLast],results)
    }
  }
}