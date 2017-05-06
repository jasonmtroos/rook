#' render_html_from_Rmd
#'
#' @param file 
#' @param format 
#'
#' @return
#' @export
render_html_from_Rmd <- function(file = NULL, format = NULL) {
  if (is.null(file)) {
    file <- rstudioapi::getSourceEditorContext()$path
    message(paste('Rendering file', file))
    if (!stringr::str_detect(file, 'Rmd$')) {
      stop('Current source editor not showing an Rmd file. Switch context or set the `file` parameter.')
    }
    outdir <- dirname(path.expand(file))
  } else {
    outdir <- dirname(path.expand(file))
  }
  yaml_output <- rmarkdown::yaml_front_matter(file)$output
  if (!is.null(format)) {
    format <- names(yaml_output[stringr::str_detect(names(yaml_output), format)])
  } else {
    format <- names(yaml_output)
  }
  outtype <- rep('', length(format))
  outfiles <- rep('', length(format))
  for (i in seq_along(outtype)) {
    outtype[i] <- dplyr::case_when(stringr::str_detect(format[i], 'revealjs') ~ 'slides',
                                   stringr::str_detect(format[i], 'html') ~ 'handout')
    basename <- stringr::str_replace(file, '\\.Rmd$', '')
    outfiles[i] <- paste0(basename, '_', outtype[i], '.html')
    rmarkdown::render(file, output_file = outfiles[i], output_dir = outdir, output_format = format[i])
  }
  rstudioapi::viewer(outfiles[1])
  invisible(NULL)
}


