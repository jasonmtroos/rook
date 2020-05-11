#' render_html_from_Rmd
#'
#' @param file 
#' @param format 
#'
#' @return
#' @export
render_html_from_Rmd <- function(file = NULL, format = NULL, suppress_view = FALSE) {
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
  if(is.null(names(yaml_output)))
    names(yaml_output) <- yaml_output
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
  if (!suppress_view)
    rstudioapi::viewer(outfiles[1])
  invisible(NULL)
}

list_of_rmds <- function() {
  tibble::frame_data(~file, ~type,
                     'pre_work/pre_work.Rmd', 'html',
                     'syllabus/brief_syllabus.Rmd', 'html',
                     'overview/overview.Rmd', 'html',
                     'overview/overview.Rmd', 'revealjs',
                     'session_1/session_1.Rmd', 'html',
                     'session_1/session_1.Rmd', 'revealjs',
                     'session_2/in_class_work.Rmd', 'html',
                     'session_2/session_2.Rmd', 'html',
                     'session_2/session_2.Rmd', 'revealjs',
                     'session_3/session_3.Rmd', 'html',
                     'session_3/session_3.Rmd', 'revealjs',
                     'session_3/job_browsing.Rmd', 'html',
                     'session_4/session_4.Rmd', 'html',
                     'session_4/session_4.Rmd', 'revealjs',
                     'session_4/session_4_in_class.Rmd', 'html'
  ) %>% mutate(id = row_number())
}
special_destinations <- function() {
  tibble::frame_data(~file, ~destination,
                     'session_2/in_class_work_handout.html', '~/git_workspace/site/media/teaching/rook/session_2_in_class.html',
                     'session_3/job_browsing_handout.html', '~/git_workspace/site/media/teaching/rook/job_browsing.html',
                     'session_4/session_4_in_class_handout.html', '~/git_workspace/site/media/teaching/rook/session_4_in_class.html')
}

#' render_all
#'
#' @export
render_all <- function() {
  files <- list_of_rmds()
  plyr::d_ply(files, .variables = 'id', .fun = function(x) {
    render_html_from_Rmd(here::here(x$file), x$type, suppress_view = TRUE)
  })
}

#' Publish
#'
#' @export
publish <- function() {
  dirs <- c('0_pre_work', '1_overview', '2_intro_to_git_and_markdown', '3_dataviz', '4_tidy', '5_scraping', '6_twitter',  '7_text', 'session_2', 'session_3', 'session_4')
  plyr::a_ply(dirs, 1, function(x) {
    compiled <- list.files(paste0(here::here(x),'/'), pattern = '\\.html')
    compiled <- normalizePath(file.path(paste0(here::here(x),'/'), compiled))
    dest <- normalizePath(file.path(here::here('docs'), x))
    if (!dir.exists(dest))
      dir.create(dest)
    file.copy(from = compiled, to = dest, overwrite = TRUE)
    invisible(NULL)
    })
  file.copy(from = here::here('_index', 'index.html'),
            to = here::here('docs'))
  # system('zip -q compiled.zip -r compiled')
  # system('zip -q compiled.zip -d *.DS_Store')
  # special_destinations() %>%
  #   transmute(from = here::here(file),
  #             to = normalizePath(destination)) %>%
  #   plyr::d_ply(.variables = 'from', .fun = function(row) {
  #     with(row, file.copy(from = from, to = to, overwrite = TRUE))
  #     invisible(NULL)
  #   })
  # if(menu(choices = c('No', 'Yes'), title = 'Compile web site and push to S3?') == 2)
  #   system('bash -l -c "(cd /Users/Jason/git_workspace/site && ruhoh compile && s3_website push --site /Users/Jason/git_workspace/site/compiled)"')
}
