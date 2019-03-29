doc_test_files <- function(paths,
                       reporter = default_reporter(),
                       env = test_env(),
                       stop_on_failure = FALSE,
                       stop_on_warning = FALSE,
                       wrap = TRUE) {

  if (length(paths) == 0) {
    stop("No matching test file in dir")
  }

  results <- lapply(
      paths,
      doc_test_file,
      env = env,
      wrap = wrap
      )

  results <- testthat:::testthat_results(results)

  if (stop_on_failure && !testthat:::all_passed(results)) {
    stop("Test failures", call. = FALSE)
  }
  if (stop_on_warning && testthat:::any_warnings(results)) {
    stop("Tests generated warnings", call. = FALSE)
  }

  invisible(results)
}
