#'
#' @title The count of births in the United States from 1994-2014
#' @description Data obtained from the CDC and Census parsed by FiveThirtyEight 
#' @format A data frame with columns:
#' \describe{
#'  \item{month_number}{The variable is numeric. The numeric month of the year}
#'  \item{month_name}{The variable is character. The name of the month}
#'  \item{day_of_month}{The variable is numeric. The day number of the month 1-31}
#'  \item{day_of_year}{The variable is integer. The day number of the year 1-366}
#'  \item{births}{The variable is numeric. The total count of births on that day over the period of the data}
#' }
#' @source \url{https://github.com/fivethirtyeight/data/tree/master/births}
#' @examples
#' \dontrun{
#' counts_us
#'}
'counts_us'



#'
#' @title The count of births of MLB players for US born players from 1925 to 2015
#' @description Data obtained from Lahman http://www.seanlahman.com/baseball-archive/statistics/
#' @format A data frame with columns:
#' \describe{
#'  \item{month_number}{The variable is integer. The numeric month of the year}
#'  \item{month_name}{The variable is character. The name of the month}
#'  \item{day_of_month}{The variable is integer. The day number of the month 1-31}
#'  \item{day_of_year}{The variable is integer. The day number of the year 1-366}
#'  \item{births}{The variable is integer. The total count of births on that day over the period of the data}
#' }
#' @source \url{https://github.com/cdalzell/Lahman}
#' @examples
#' \dontrun{
#' counts_baseball
#'}
'counts_baseball'



#'
#' @title The count of births of NBA/ABA players
#' @description Data obtained from https://www.basketball-reference.com
#' @format A data frame with columns:
#' \describe{
#'  \item{month_number}{The variable is numeric. The numeric month of the year}
#'  \item{month_name}{The variable is character. The name of the month}
#'  \item{day_of_month}{The variable is integer. The day number of the month 1-31}
#'  \item{day_of_year}{The variable is integer. The day number of the year 1-366}
#'  \item{births}{The variable is integer. The total count of births on that day over the period of the data}
#' }
#' @source \url{https://www.basketball-reference.com/friv/birthdays.fcgi?month=1&day=1}
#' @examples
#' \dontrun{
#' counts_basketball
#'}
'counts_basketball'



#'
#' @title The count of births of NFL players
#' @description Data obtained from https://www.pro-football-reference.com
#' @format A data frame with columns:
#' \describe{
#'  \item{month_number}{The variable is numeric. The numeric month of the year}
#'  \item{month_name}{The variable is character. The name of the month}
#'  \item{day_of_month}{The variable is integer. The day number of the month 1-31}
#'  \item{day_of_year}{The variable is integer. The day number of the year 1-366}
#'  \item{births}{The variable is integer. The total count of births on that day over the period of the data}
#' }
#' @source \url{https://www.pro-football-reference.com/years/1900/births.htm}
#' @examples
#' \dontrun{
#' counts_football
#'}
'counts_football'



#'
#' @title The count of births of NHL players
#' @description Data obtained from https://www.hockey-reference.com
#' @format A data frame with columns:
#' \describe{
#'  \item{month_number}{The variable is numeric. The numeric month of the year}
#'  \item{month_name}{The variable is character. The name of the month}
#'  \item{day_of_month}{The variable is integer. The day number of the month 1-31}
#'  \item{day_of_year}{The variable is integer. The day number of the year 1-366}
#'  \item{births}{The variable is integer. The total count of births on that day over the period of the data}
#' }
#' @source \url{https://www.hockey-reference.com/friv/birthdays.cgi?month=1&day=1}
#' @examples
#' \dontrun{
#' counts_hockey
#'}
'counts_hockey'



#'
#' @title The count of births of all players and US by month.
#' @description Data combined from others sources in package.
#' @format A data frame with columns:
#' \describe{
#'  \item{month_number}{The variable is numeric. The numeric month of the year}
#'  \item{month_name}{The variable is character. The name of the month}
#'  \item{day_of_month}{The variable is numeric. The day number of the month 1-31}
#'  \item{day_of_year}{The variable is integer. The day number of the year 1-366}
#'  \item{births}{The variable is numeric. The total count of births on that day over the period of the data}
#'  \item{group}{The variable is character. The professional sport or US births}
#' }
#' @source \url{https://github.com/byuidatascience/data4births}
#' @examples
#' \dontrun{
#' counts_all
#'}
'counts_all'



#'
#' @title The birth dates of MLB players
#' @description Data obtained from Lahman http://www.seanlahman.com/baseball-archive/statistics/
#' @format A data frame with columns:
#' \describe{
#'  \item{player}{The variable is character. Player's name}
#'  \item{birthday}{The variable is Date. Player's birthdate}
#'  \item{yrs}{The variable is numeric. Number of years played}
#'  \item{from}{The variable is numeric. Year started}
#'  \item{to}{The variable is numeric. Year ended}
#'  \item{month}{The variable is integer. birth month}
#'  \item{day}{The variable is integer. birth_day}
#'  \item{country}{The variable is character. birth country}
#' }
#' @source \url{https://github.com/cdalzell/Lahman}
#' @examples
#' \dontrun{
#' baseball_births
#'}
'baseball_births'



#'
#' @title The birth dates of NBA/ABA players
#' @description Data obtained from https://www.basketball-reference.com
#' @format A data frame with columns:
#' \describe{
#'  \item{player}{The variable is character. Player's name}
#'  \item{birthday}{The variable is Date. Player's birthdate}
#'  \item{yrs}{The variable is integer. Number of years played}
#' }
#' @source \url{https://www.basketball-reference.com/friv/birthdays.fcgi?month=1&day=1}
#' @examples
#' \dontrun{
#' basketball_births
#'}
'basketball_births'



#'
#' @title The birth dates of NFL players
#' @description Data obtained from https://www.pro-football-reference.com
#' @format A data frame with columns:
#' \describe{
#'  \item{player}{The variable is character. Player's name}
#'  \item{birthday}{The variable is Date. Player's birthdate}
#'  \item{yrs}{The variable is integer. Number of years played}
#'  \item{from}{The variable is integer. Year started}
#'  \item{to}{The variable is integer. Year ended}
#'  \item{pos}{The variable is character. Positions played}
#' }
#' @source \url{https://www.pro-football-reference.com/years/1900/births.htm}
#' @examples
#' \dontrun{
#' football_births
#'}
'football_births'



#'
#' @title The birth dates of NHL players
#' @description Data obtained from https://www.hockey-reference.com
#' @format A data frame with columns:
#' \describe{
#'  \item{player}{The variable is character. Player's name}
#'  \item{birthday}{The variable is Date. Player's birthdate}
#'  \item{yrs}{The variable is integer. Number of years played}
#'  \item{from}{The variable is integer. Year started}
#'  \item{to}{The variable is integer. Year ended}
#'  \item{team}{The variable is character. Teams played with}
#' }
#' @source \url{https://www.hockey-reference.com/friv/birthdays.cgi?month=1&day=1}
#' @examples
#' \dontrun{
#' hockey_births
#'}
'hockey_births'



