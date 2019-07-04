#' get_sessions
#'
#' @return tibble with session info 
#' @export
#'
get_sessions <- function() {
  if(program() == 'egsh') {
    tibble::frame_data(~Session, ~Date, ~Location, ~Time,
               1, '2019-05-14', 'S0-09', '13:30--17:00',
               2, '2019-05-16', 'S0-08', '13:30--17:00',
               3, '2019-05-21', 'S0-08', '13:30--17:00',
               4, '2019-05-23', 'S0-08', '13:00--17:00') %>%
      dplyr::mutate(Date = lubridate::ymd(Date))
    # mutate(Date = coalesce(ymd(Date), ymd(Date)[1] + weeks(0:3)),
           # Time = '13.30--16.30')
  } else if(program() == 'erim') {
    tibble::frame_data(~Session, ~Date, ~Location, ~Time,
               1, '2019-07-01', 'Polak Y1--07', '09:00--12:00',
               2, NA, 'Polak Y1--07', '13:30--16:30',
               3, '2019-07-02', 'Polak Y1--07', '09:00--12:00',
               4, NA, 'Polak Y1--07', '13:30--16:30') %>%
      dplyr::mutate(Date = coalesce(lubridate::ymd(Date), lag(lubridate::ymd(Date))))
  }
}

#' print_session_info
#'
#' @param s 
#'
#' @return character string with session info
#' @export
#'
print_session_info <- function(s) {
  with(as.data.frame(get_sessions()[s,]), 
       paste0(format(Date, '%e %b'), ', ', Time, ', ', Location))
}

#' course_title
#'
#' @return
#' @export
course_title <- function() {
  if(program() == 'egsh')
    "Data visualisation, web scraping, and text analysis in R"
  else if(program() == 'erim')
    "Introduction to data visualization, web scraping, and text analysis in R"
}


#' program
#'
#' @return
#' @export
#'
program <- function() {
  'erim' #'egsh' #'erim' 'egsh'
}
