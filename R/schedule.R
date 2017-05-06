#' get_sessions
#'
#' @return tibble with session info 
#' @export
#'
get_sessions <- function() {
  if(program() == 'egsh') {
    frame_data(~Session, ~Date, ~Location,
               1, '2017-05-08', 'Polak Y1--15',
               2, NA, 'Polak Y3--08',
               3, NA, 'Polak Y1--15',
               4, NA, 'Polak Y1--15') %>%
    mutate(Date = coalesce(ymd(Date), ymd(Date)[1] + weeks(0:3)),
           Time = '13.30--16.30')
  } else if(program() == 'erim') {
    frame_data(~Session, ~Date, ~Location,
               1, '2017-07-03', 'Location TBD',
               2, NA, 'Location TBD',
               3, '2017-07-06', 'Location TBD',
               4, NA, 'Location TBD') %>%
      mutate(Date = coalesce(ymd(Date), lag(ymd(Date))),
             Time = 'Time TBD')
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
    "Big data analysis and visualisation"
  else if(program() == 'erim')
    "Introduction to data visualization, web scraping, and text analysis in R"
}


#' program
#'
#' @return
#' @export
#'
program <- function() {
  'egsh'
}
