% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{baseball_births}
\alias{baseball_births}
\title{The birth dates of MLB players}
\format{
A data frame with columns:
\describe{
 \item{player}{The variable is character. Player's name}
 \item{birthday}{The variable is Date. Player's birthdate}
 \item{yrs}{The variable is numeric. Number of years played}
 \item{from}{The variable is numeric. Year started}
 \item{to}{The variable is numeric. Year ended}
 \item{month}{The variable is integer. birth month}
 \item{day}{The variable is integer. birth_day}
 \item{country}{The variable is character. birth country}
}
}
\source{
\url{https://github.com/cdalzell/Lahman}
}
\usage{
baseball_births
}
\description{
Data obtained from Lahman http://www.seanlahman.com/baseball-archive/statistics/
}
\examples{
\dontrun{
baseball_births
}
}
\keyword{datasets}
